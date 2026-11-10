import { jwtVerify, SignJWT, errors as joseErrors } from 'jose';
import { env } from '../config/env.js';
import { Errors } from './errors.js';
import type { Role } from '../generated/prisma/enums.js';

const secret = new TextEncoder().encode(env.JWT_ACCESS_SECRET);
const ALG = 'HS256';

export interface AccessTokenClaims {
  sub: string;
  role: Role;
  /** Refresh-token family (login session) this access token was issued under. */
  sid: string;
}

export async function signAccessToken(claims: AccessTokenClaims): Promise<{ token: string; expiresAt: Date }> {
  const nowSec = Math.floor(Date.now() / 1000);
  const exp = nowSec + env.JWT_ACCESS_TTL_SECONDS;
  const token = await new SignJWT({ role: claims.role, sid: claims.sid })
    .setProtectedHeader({ alg: ALG, typ: 'JWT' })
    .setSubject(claims.sub)
    .setIssuer(env.JWT_ISSUER)
    .setAudience(env.JWT_AUDIENCE)
    .setIssuedAt(nowSec)
    .setExpirationTime(exp)
    .sign(secret);
  return { token, expiresAt: new Date(exp * 1000) };
}

export async function verifyAccessToken(token: string): Promise<AccessTokenClaims> {
  try {
    const { payload } = await jwtVerify(token, secret, {
      algorithms: [ALG],
      issuer: env.JWT_ISSUER,
      audience: env.JWT_AUDIENCE,
    });
    if (typeof payload.sub !== 'string' || typeof payload.role !== 'string' || typeof payload.sid !== 'string') {
      throw Errors.invalidToken();
    }
    return { sub: payload.sub, role: payload.role as Role, sid: payload.sid };
  } catch (err) {
    if (err instanceof joseErrors.JOSEError) throw Errors.invalidToken();
    throw err;
  }
}
