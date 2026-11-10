import { todayIst } from '../../lib/dates.js';
import { AppError, Errors } from '../../lib/errors.js';
import type { AuthUser } from '../../lib/context.js';
import type { Db } from '../../lib/prisma.js';
import type { Prisma } from '../../generated/prisma/client.js';
import type { Role } from '../../generated/prisma/enums.js';
import { descendantsOf } from './hierarchy.js';

/**
 * Data scope (PHASE-2-FEATURES §2.3 + §11). A user may see a record only if
 *  1. its business unit is one of the user's (directors: all), and
 *  2. its subject is the user or below them in the reporting tree, as deep as the feature allows.
 * Every service builds its `where` from `scopeFor()`; single records are checked with `canAccess()`.
 */
export type Feature = 'employees' | 'documents' | 'roster' | 'attendance' | 'leave' | 'allowances' | 'payslips' | 'tasks' | 'reports';

/** How many levels below themselves a role sees per feature; null = everyone in their BUs. */
const DEPTH: Record<Role, Record<Feature, number> | null> = {
  REGIONAL_MANAGER: { employees: 1, documents: 1, roster: 1, attendance: 1, leave: 1, allowances: 1, payslips: 1, tasks: 1, reports: 1 },
  // §11: OM reads their RMs' teams too (depth 2) except payslips (their RMs only, assumption §13.3).
  OPERATIONAL_MANAGER: { employees: 2, documents: 2, roster: 2, attendance: 2, leave: 2, allowances: 2, payslips: 1, tasks: 1, reports: 2 },
  HR: null,
  DIRECTOR: null,
};

export interface Scope {
  businessUnitIds: string[];
  /** null = no hierarchy restriction (HR, director). Always includes the user themself otherwise. */
  employeeIds: string[] | null;
}

/** The business units a request may cover: the requested one (must be the user's) or all of the user's. */
export function businessUnitsFor(user: Pick<AuthUser, 'businessUnitIds'>, requested?: string | null): string[] {
  if (!requested) return user.businessUnitIds;
  if (!user.businessUnitIds.includes(requested)) throw new AppError('FORBIDDEN_BUSINESS_UNIT', 403, 'You do not belong to this business unit');
  return [requested];
}

export async function visibleEmployeeIds(db: Db, user: AuthUser, feature: Feature, date: string = todayIst()): Promise<string[] | null> {
  const depth = DEPTH[user.role]?.[feature];
  if (depth === undefined) return null;
  const below = await descendantsOf(db, user.employeeId, depth, date);
  return [user.employeeId, ...below.keys()];
}

export async function scopeFor(db: Db, user: AuthUser, feature: Feature, businessUnitId?: string | null): Promise<Scope> {
  return { businessUnitIds: businessUnitsFor(user, businessUnitId), employeeIds: await visibleEmployeeIds(db, user, feature) };
}

/** `where` for records that carry `businessUnitId` and a subject employee column. */
export function recordWhere(scope: Scope, subjectField = 'employeeId'): Record<string, unknown> {
  return {
    businessUnitId: { in: scope.businessUnitIds },
    ...(scope.employeeIds ? { [subjectField]: { in: scope.employeeIds } } : {}),
  };
}

/** `where` for employees: a member of one of the BUs (the director's own record has none) and visible in the tree. */
export function employeeWhere(user: AuthUser, scope: Scope): Prisma.EmployeeWhereInput {
  const inBu: Prisma.EmployeeWhereInput = { businessUnits: { some: { businessUnitId: { in: scope.businessUnitIds } } } };
  return {
    AND: [
      { deletedAt: null },
      user.role === 'DIRECTOR' ? { OR: [inBu, { id: user.employeeId }] } : inBu,
      scope.employeeIds ? { id: { in: scope.employeeIds } } : {},
    ],
  };
}

/** Single-record check: BU match and hierarchy match (§2.3). */
export async function canAccess(db: Db, user: AuthUser, subjectEmployeeId: string, businessUnitId: string | null, feature: Feature): Promise<boolean> {
  if (businessUnitId !== null && !user.businessUnitIds.includes(businessUnitId)) return false;
  const ids = await visibleEmployeeIds(db, user, feature);
  return ids === null || ids.includes(subjectEmployeeId);
}

/** 404 when out of scope, so other units' ids are indistinguishable from missing ones. */
export async function assertAccess(db: Db, user: AuthUser, subjectEmployeeId: string, businessUnitId: string | null, feature: Feature, entity: string) {
  if (!(await canAccess(db, user, subjectEmployeeId, businessUnitId, feature))) throw Errors.notFound(entity);
}

/** An employee visible to the user (any of their BUs + hierarchy), or 404. */
export async function findEmployeeInScope(db: Db, user: AuthUser, employeeId: string, feature: Feature = 'employees') {
  const scope = await scopeFor(db, user, feature);
  const employee = await db.employee.findFirst({ where: { AND: [{ id: employeeId }, employeeWhere(user, scope)] } });
  if (!employee) throw Errors.notFound('Employee');
  return employee;
}

// ───────────── Depot-owned master data (fleet, roster): BU through the depot ─────────────

export function depotWhere(user: Pick<AuthUser, 'businessUnitIds'>, businessUnitId?: string | null): Prisma.DepotWhereInput {
  return { deletedAt: null, businessUnitId: { in: businessUnitsFor(user, businessUnitId) } };
}

export async function canAccessDepot(db: Db, user: Pick<AuthUser, 'businessUnitIds'>, depotId: string): Promise<boolean> {
  return (await db.depot.findFirst({ where: { AND: [{ id: depotId }, depotWhere(user)] }, select: { id: true } })) !== null;
}

export async function assertDepotAccess(db: Db, user: Pick<AuthUser, 'businessUnitIds'>, depotId: string): Promise<void> {
  if (!(await canAccessDepot(db, user, depotId))) throw Errors.notFound('Depot');
}

/** Depot ids of the user's business units (for depot-owned tables). */
export async function depotIdsFor(db: Db, user: Pick<AuthUser, 'businessUnitIds'>, businessUnitId?: string | null): Promise<string[]> {
  return (await db.depot.findMany({ where: depotWhere(user, businessUnitId), select: { id: true } })).map((d) => d.id);
}
