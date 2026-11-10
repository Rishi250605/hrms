import type { RequestHandler } from 'express';
import { Errors } from '../lib/errors.js';
import { verifyAccessToken } from '../lib/jwt.js';
import { prisma } from '../lib/prisma.js';
import type { AuthUser } from '../lib/context.js';
import type { Db } from '../lib/prisma.js';

/** Loads the auth view of a user (role, employee, business units). Null if missing or inactive. */
export async function loadAuthUser(db: Db, userId: string): Promise<AuthUser | null> {
  const user = await db.user.findUnique({
    where: { id: userId },
    include: { employee: { include: { businessUnits: { include: { businessUnit: { select: { isActive: true } } } } } } },
  });
  if (!user || !user.isActive) return null;
  let businessUnitIds: string[];
  let primary: string | null;
  if (user.role === 'DIRECTOR') {
    businessUnitIds = (await db.businessUnit.findMany({ where: { isActive: true }, select: { id: true }, orderBy: { code: 'asc' } })).map((b) => b.id);
    primary = null;
  } else {
    const memberships = user.employee.businessUnits.filter((m) => m.businessUnit.isActive);
    businessUnitIds = memberships.map((m) => m.businessUnitId);
    primary = memberships.find((m) => m.isPrimary)?.businessUnitId ?? businessUnitIds[0] ?? null;
  }
  return {
    id: user.id,
    name: user.name,
    phone: user.phone,
    role: user.role,
    employeeId: user.employeeId,
    empCode: user.employee.empCode,
    businessUnitIds,
    primaryBusinessUnitId: primary,
  };
}

/**
 * Verifies the bearer access token, then loads the user, their employee and business units from the
 * database so that deactivation and membership changes take effect immediately.
 */
export const authenticate: RequestHandler = async (req, _res, next) => {
  const header = req.get('authorization');
  if (!header?.startsWith('Bearer ')) throw Errors.unauthenticated();
  const claims = await verifyAccessToken(header.slice('Bearer '.length).trim());
  const user = await loadAuthUser(prisma, claims.sub);
  if (!user) throw Errors.invalidToken();
  req.user = user;
  next();
};
