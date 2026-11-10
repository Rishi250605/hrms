import { randomUUID } from 'node:crypto';
import { env } from '../../config/env.js';
import { hmacHash, randomToken } from '../../lib/crypto.js';
import { AppError } from '../../lib/errors.js';
import { signAccessToken } from '../../lib/jwt.js';
import { logger } from '../../lib/logger.js';
import { dummyPasswordHash, verifyPassword } from '../../lib/password.js';
import { prisma } from '../../lib/prisma.js';
import type { Db } from '../../lib/prisma.js';
import type { RequestContext } from '../../lib/context.js';
import type { Role } from '../../generated/prisma/enums.js';
import { audit } from '../audit/service.js';

export interface TokenPairResult {
  accessToken: string;
  accessTokenExpiresAt: string;
  refreshToken: string;
  refreshTokenExpiresAt: string;
  tokenType: 'Bearer';
}

const hashRefreshToken = (token: string) => hmacHash(`rt:${token}`, env.TOKEN_HASH_PEPPER);

const invalidLogin = () => new AppError('INVALID_CREDENTIALS', 401, 'Invalid employee ID or password');
const locked = (until: Date) => {
  const minutes = Math.max(1, Math.ceil((until.getTime() - Date.now()) / 60_000));
  return new AppError('ACCOUNT_LOCKED', 423, `Account locked, try again in ${minutes} minute${minutes === 1 ? '' : 's'} or contact your Director`, {
    lockedUntil: until.toISOString(),
    minutes,
  });
};
const invalidRefresh = () => new AppError('INVALID_REFRESH_TOKEN', 401, 'Session expired, please sign in again');

/**
 * Employee ID + password login (PHASE-2-FEATURES §1.3). Unknown IDs, users without a password and inactive
 * users all get the same 401. After LOGIN_MAX_FAILED_ATTEMPTS failures inside the window the account is
 * locked for LOGIN_LOCK_MINUTES (423 ACCOUNT_LOCKED); the director can unlock it.
 */
export async function login(empCode: string, password: string, ctx: RequestContext): Promise<TokenPairResult> {
  const user = await prisma.user.findFirst({
    where: { employee: { empCode: { equals: empCode, mode: 'insensitive' } } },
    select: { id: true, role: true, isActive: true, passwordHash: true, failedLoginCount: true, failedWindowStartedAt: true, lockedUntil: true },
  });
  const now = new Date();
  if (!user || !user.isActive || !user.passwordHash) {
    await verifyPassword(await dummyPasswordHash(), password); // same timing as a real check
    throw invalidLogin();
  }
  if (user.lockedUntil && user.lockedUntil > now) throw locked(user.lockedUntil);

  if (!(await verifyPassword(user.passwordHash, password))) {
    const windowMs = env.LOGIN_FAILURE_WINDOW_MINUTES * 60_000;
    const freshWindow = !user.failedWindowStartedAt || now.getTime() - user.failedWindowStartedAt.getTime() > windowMs;
    const count = freshWindow ? 1 : user.failedLoginCount + 1;
    const lockUntil = count >= env.LOGIN_MAX_FAILED_ATTEMPTS ? new Date(now.getTime() + env.LOGIN_LOCK_MINUTES * 60_000) : null;
    await prisma.$transaction(async (tx) => {
      await tx.user.update({
        where: { id: user.id },
        data: {
          failedLoginCount: lockUntil ? 0 : count,
          failedWindowStartedAt: lockUntil ? null : freshWindow ? now : user.failedWindowStartedAt,
          lockedUntil: lockUntil,
        },
      });
      if (lockUntil) await audit.record(tx, ctx, { actorUserId: user.id, action: 'auth.locked', entityType: 'User', entityId: user.id, after: { lockedUntil: lockUntil } });
    });
    if (lockUntil) throw locked(lockUntil);
    throw invalidLogin();
  }

  return prisma.$transaction(async (tx) => {
    await tx.user.update({ where: { id: user.id }, data: { lastLoginAt: now, failedLoginCount: 0, failedWindowStartedAt: null, lockedUntil: null } });
    const { tokens } = await issueTokens(tx, { id: user.id, role: user.role }, randomUUID(), ctx);
    await audit.record(tx, ctx, { actorUserId: user.id, action: 'auth.login', entityType: 'User', entityId: user.id, after: { lastLoginAt: now } });
    return tokens;
  });
}

/**
 * Rotates a refresh token. Presenting a token that was already rotated or revoked is treated as theft:
 * the whole token family (login session) is revoked.
 */
export async function refresh(refreshToken: string, ctx: RequestContext): Promise<TokenPairResult> {
  const row = await prisma.refreshToken.findUnique({
    where: { tokenHash: hashRefreshToken(refreshToken) },
    include: { user: { select: { id: true, role: true, isActive: true } } },
  });
  if (!row) throw invalidRefresh();

  if (row.revokedAt || row.replacedById) {
    await revokeFamily(prisma, row.familyId);
    logger.warn({ familyId: row.familyId, userId: row.userId, requestId: ctx.requestId }, 'Refresh token reuse detected; session revoked');
    throw invalidRefresh();
  }
  if (row.expiresAt.getTime() <= Date.now() || !row.user.isActive) {
    await revokeFamily(prisma, row.familyId);
    throw invalidRefresh();
  }

  return prisma.$transaction(async (tx) => {
    const { tokens, refreshTokenId } = await issueTokens(tx, row.user, row.familyId, ctx);
    const rotated = await tx.refreshToken.updateMany({
      where: { id: row.id, revokedAt: null, replacedById: null },
      data: { revokedAt: new Date(), replacedById: refreshTokenId },
    });
    if (rotated.count !== 1) throw invalidRefresh();
    return tokens;
  });
}

/** Revokes the session (token family) the refresh token belongs to. Idempotent. */
export async function logout(refreshToken: string): Promise<void> {
  const row = await prisma.refreshToken.findUnique({ where: { tokenHash: hashRefreshToken(refreshToken) }, select: { familyId: true } });
  if (row) await revokeFamily(prisma, row.familyId);
}

async function revokeFamily(db: Db, familyId: string): Promise<void> {
  await db.refreshToken.updateMany({ where: { familyId, revokedAt: null }, data: { revokedAt: new Date() } });
}

/** Ends every session of a user (password reset, deactivation). */
export async function revokeAllSessions(db: Db, userId: string): Promise<void> {
  await db.refreshToken.updateMany({ where: { userId, revokedAt: null }, data: { revokedAt: new Date() } });
}

async function issueTokens(db: Db, user: { id: string; role: Role }, familyId: string, ctx: RequestContext): Promise<{ tokens: TokenPairResult; refreshTokenId: string }> {
  const refreshToken = randomToken(32);
  const refreshExpiresAt = new Date(Date.now() + env.REFRESH_TOKEN_TTL_DAYS * 24 * 60 * 60 * 1000);
  const row = await db.refreshToken.create({
    select: { id: true },
    data: {
      userId: user.id,
      familyId,
      tokenHash: hashRefreshToken(refreshToken),
      expiresAt: refreshExpiresAt,
      userAgent: ctx.userAgent?.slice(0, 255) ?? null,
      ip: ctx.ip,
    },
  });
  const access = await signAccessToken({ sub: user.id, role: user.role, sid: familyId });
  return {
    refreshTokenId: row.id,
    tokens: {
      accessToken: access.token,
      accessTokenExpiresAt: access.expiresAt.toISOString(),
      refreshToken,
      refreshTokenExpiresAt: refreshExpiresAt.toISOString(),
      tokenType: 'Bearer',
    },
  };
}
