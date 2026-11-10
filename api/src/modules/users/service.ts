import type { z } from 'zod';
import { todayIst, toDbDate } from '../../lib/dates.js';
import { AppError, Errors } from '../../lib/errors.js';
import { hashPassword } from '../../lib/password.js';
import { prisma } from '../../lib/prisma.js';
import type { Db, Tx } from '../../lib/prisma.js';
import type { AuthUser, RequestContext } from '../../lib/context.js';
import type { Prisma } from '../../generated/prisma/client.js';
import type { Role } from '../../generated/prisma/enums.js';
import { reportingToOf, validateReportingLine } from '../access/hierarchy.js';
import { audit } from '../audit/service.js';
import { revokeAllSessions } from '../auth/service.js';
import { assertEmpCodeFormat } from '../employees/empcode.js';
import { notify } from '../notifications/service.js';
import type { MeResponse, ResetPasswordBody, UserCreateBody, UserListQuery, UserUpdateBody } from './schemas.js';

/** {employeeId, empCode, name, role} of each employee (role null for non-login staff). */
export async function personRefs(db: Db, employeeIds: (string | null | undefined)[]) {
  const ids = [...new Set(employeeIds.filter((x): x is string => !!x))];
  const rows = await db.employee.findMany({ where: { id: { in: ids } }, select: { id: true, empCode: true, fullName: true, user: { select: { role: true } } } });
  return new Map(rows.map((e) => [e.id, { employeeId: e.id, empCode: e.empCode, name: e.fullName, role: e.user?.role ?? null }]));
}

export async function membershipsOf(db: Db, employeeId: string, role: Role | null) {
  if (role === 'DIRECTOR') {
    const all = await db.businessUnit.findMany({ where: { isActive: true }, orderBy: { code: 'asc' } });
    return all.map((b) => ({ id: b.id, code: b.code, name: b.name, isPrimary: false }));
  }
  const rows = await db.employeeBusinessUnit.findMany({ where: { employeeId }, include: { businessUnit: true }, orderBy: { businessUnit: { code: 'asc' } } });
  return rows.map((m) => ({ id: m.businessUnitId, code: m.businessUnit.code, name: m.businessUnit.name, isPrimary: m.isPrimary }));
}

/** My Profile (PHASE-2-FEATURES §3). */
export async function getMe(authUser: AuthUser): Promise<z.infer<typeof MeResponse>> {
  const user = await prisma.user.findUnique({ where: { id: authUser.id }, include: { employee: true } });
  if (!user) throw Errors.notFound('User');
  const reportsTo = (await reportingToOf(prisma, [user.employeeId])).get(user.employeeId) ?? null;
  const refs = await personRefs(prisma, [reportsTo]);
  return {
    id: user.id,
    employeeId: user.employeeId,
    empCode: user.employee.empCode,
    name: user.name,
    phone: user.phone,
    email: user.email,
    role: user.role,
    lastLoginAt: user.lastLoginAt?.toISOString() ?? null,
    passwordChangedAt: user.passwordChangedAt?.toISOString() ?? null,
    reportingTo: reportsTo ? (refs.get(reportsTo) ?? null) : null,
    businessUnits: await membershipsOf(prisma, user.employeeId, user.role),
  };
}

// ───────────────────────────── User management (director) ─────────────────────────────

const userInclude = { employee: { select: { empCode: true } } } satisfies Prisma.UserInclude;
type UserRow = Prisma.UserGetPayload<{ include: typeof userInclude }>;

async function toUserItems(db: Db, rows: UserRow[]) {
  const reports = await reportingToOf(db, rows.map((r) => r.employeeId));
  const refs = await personRefs(db, [...reports.values()]);
  const items = [];
  for (const u of rows) {
    const to = reports.get(u.employeeId) ?? null;
    items.push({
      id: u.id,
      employeeId: u.employeeId,
      empCode: u.employee.empCode,
      name: u.name,
      phone: u.phone,
      email: u.email,
      role: u.role,
      isActive: u.isActive,
      hasPassword: u.passwordHash !== null,
      lockedUntil: u.lockedUntil && u.lockedUntil > new Date() ? u.lockedUntil.toISOString() : null,
      lastLoginAt: u.lastLoginAt?.toISOString() ?? null,
      reportingTo: to ? (refs.get(to) ?? null) : null,
      businessUnits: await membershipsOf(db, u.employeeId, u.role),
    });
  }
  return items;
}

const oneUser = async (id: string) => (await toUserItems(prisma, [await prisma.user.findUniqueOrThrow({ where: { id }, include: userInclude })]))[0]!;

/** Logins in the caller's business units (directors: all). HR uses it to pick reporting managers. */
export async function listUsers(user: AuthUser, q: z.infer<typeof UserListQuery>) {
  if (q.businessUnitId && !user.businessUnitIds.includes(q.businessUnitId)) {
    throw new AppError('FORBIDDEN_BUSINESS_UNIT', 403, 'You do not belong to this business unit');
  }
  const and: Prisma.UserWhereInput[] = [];
  if (!q.includeInactive) and.push({ isActive: true });
  if (q.role) and.push({ role: q.role });
  if (q.q) and.push({ OR: [{ name: { contains: q.q, mode: 'insensitive' } }, { employee: { empCode: { contains: q.q, mode: 'insensitive' } } }] });
  const bus = q.businessUnitId ? [q.businessUnitId] : user.role === 'DIRECTOR' ? null : user.businessUnitIds;
  if (bus) and.push({ OR: [{ role: 'DIRECTOR' }, { employee: { businessUnits: { some: { businessUnitId: { in: bus } } } } }] });
  const rows = await prisma.user.findMany({
    where: { AND: and },
    include: userInclude,
    orderBy: [{ name: 'asc' }, { id: 'asc' }],
    take: q.limit + 1,
    ...(q.cursor ? { cursor: { id: q.cursor }, skip: 1 } : {}),
  });
  const hasMore = rows.length > q.limit;
  const page = hasMore ? rows.slice(0, q.limit) : rows;
  return { items: await toUserItems(prisma, page), nextCursor: hasMore ? (page[page.length - 1]?.id ?? null) : null };
}

/** Validates and writes BU memberships (§2.1): at least one, exactly one primary. */
export async function setMemberships(tx: Tx, employeeId: string, businessUnitIds: string[], primary: string | null, ctx: RequestContext) {
  const ids = [...new Set(businessUnitIds)];
  const found = await tx.businessUnit.count({ where: { id: { in: ids }, isActive: true } });
  if (found !== ids.length) throw Errors.notFound('Business unit');
  if (ids.length > 0 && (!primary || !ids.includes(primary))) {
    throw Errors.validation([{ path: ['primaryBusinessUnitId'], message: 'Choose one of the business units as primary' }]);
  }
  const before = await tx.employeeBusinessUnit.findMany({ where: { employeeId } });
  await tx.employeeBusinessUnit.deleteMany({ where: { employeeId } });
  await tx.employeeBusinessUnit.createMany({
    data: ids.map((businessUnitId) => ({ employeeId, businessUnitId, isPrimary: businessUnitId === primary, createdById: ctx.user?.id ?? null })),
  });
  await audit.record(tx, ctx, { action: 'employee.businessUnits.set', entityType: 'Employee', entityId: employeeId, before, after: { businessUnitIds: ids, primary } });
}

/** Creates a login (and, unless existingEmployeeId is given, the employee record) — PHASE-2-FEATURES §1.3. */
export async function createUser(body: z.infer<typeof UserCreateBody>, ctx: RequestContext) {
  const isDirector = body.role === 'DIRECTOR';
  const buIds = isDirector ? [] : [...new Set(body.businessUnitIds ?? [])];
  if (!isDirector && buIds.length === 0) throw Errors.validation([{ path: ['businessUnitIds'], message: 'At least one business unit is required' }]);
  const primary = isDirector ? null : (body.primaryBusinessUnitId ?? (buIds.length === 1 ? buIds[0]! : null));
  await validateReportingLine(prisma, { level: body.role, businessUnitIds: buIds, employeeId: body.existingEmployeeId }, body.reportingToEmployeeId);
  const passwordHash = await hashPassword(body.password);

  const userId = await prisma.$transaction(async (tx) => {
    let employeeId = body.existingEmployeeId;
    let name = body.fullName;
    if (employeeId) {
      const existing = await tx.employee.findFirst({ where: { id: employeeId, deletedAt: null }, include: { user: true } });
      if (!existing) throw Errors.notFound('Employee');
      if (existing.user) throw Errors.conflict('ALREADY_HAS_LOGIN', 'This employee already has a login');
      if (existing.status === 'EXITED') throw Errors.conflict('EMPLOYEE_EXITED', 'The employee has exited');
      name ??= existing.fullName;
      await setMemberships(tx, employeeId, buIds, primary, ctx);
      // The reporting line changes with the new role: close the job row and open one from today.
      const open = await tx.employeeJob.findFirst({ where: { employeeId, effectiveTo: null } });
      if (open && (open.reportingToEmployeeId ?? null) !== (body.reportingToEmployeeId ?? null)) {
        const today = toDbDate(todayIst());
        if (open.effectiveFrom < today) {
          await tx.employeeJob.update({ where: { id: open.id }, data: { effectiveTo: today } });
          await tx.employeeJob.create({
            data: {
              employeeId,
              depotId: open.depotId,
              designation: body.designation ?? open.designation,
              grade: open.grade,
              reportingToEmployeeId: body.reportingToEmployeeId ?? null,
              effectiveFrom: today,
              changeReason: 'Login granted',
              createdById: ctx.user?.id ?? null,
            },
          });
        } else {
          await tx.employeeJob.update({ where: { id: open.id }, data: { reportingToEmployeeId: body.reportingToEmployeeId ?? null } });
        }
      }
    } else {
      if (!body.empCode || !body.fullName) throw Errors.validation([{ path: ['empCode'], message: 'Employee ID and full name are required for a new employee' }]);
      if (!body.depotId) throw Errors.validation([{ path: ['depotId'], message: 'A base depot is required' }]);
      await assertEmpCodeFormat(tx, body.empCode, primary);
      const depot = await tx.depot.findFirst({ where: { id: body.depotId, deletedAt: null } });
      if (!depot) throw Errors.notFound('Depot');
      if (!isDirector && !buIds.includes(depot.businessUnitId)) {
        throw Errors.validation([{ path: ['depotId'], message: "The depot must belong to one of the user's business units" }]);
      }
      const joining = body.joiningDate ?? todayIst();
      const employee = await tx.employee.create({
        data: { empCode: body.empCode, fullName: body.fullName, phone: body.phone, joiningDate: toDbDate(joining), category: 'OFFICE', employmentType: 'PERMANENT', createdById: ctx.user?.id ?? null },
      });
      employeeId = employee.id;
      await tx.employeeJob.create({
        data: {
          employeeId,
          depotId: depot.id,
          designation: body.designation ?? body.role.replace(/_/g, ' ').toLowerCase(),
          reportingToEmployeeId: body.reportingToEmployeeId ?? null,
          effectiveFrom: toDbDate(joining),
          changeReason: 'Joining',
          createdById: ctx.user?.id ?? null,
        },
      });
      if (!isDirector) await setMemberships(tx, employeeId, buIds, primary, ctx);
      await audit.record(tx, ctx, { action: 'employee.create', entityType: 'Employee', entityId: employeeId, after: employee });
    }
    const user = await tx.user.create({
      data: { name: name!, phone: body.phone, email: body.email ?? null, role: body.role, employeeId, passwordHash, passwordChangedAt: new Date(), createdById: ctx.user?.id ?? null },
    });
    await audit.record(tx, ctx, { action: 'user.create', entityType: 'User', entityId: user.id, after: user });
    return user.id;
  });
  return oneUser(userId);
}

export async function updateUser(id: string, body: z.infer<typeof UserUpdateBody>, ctx: RequestContext) {
  if (ctx.user?.id === id && body.isActive === false) throw Errors.conflict('SELF_LOCKOUT', 'You cannot deactivate yourself');
  await prisma.$transaction(async (tx) => {
    const before = await tx.user.findUnique({ where: { id } });
    if (!before) throw Errors.notFound('User');
    const after = await tx.user.update({ where: { id }, data: body });
    if (body.name) await tx.employee.update({ where: { id: before.employeeId }, data: { fullName: body.name } });
    if (body.isActive === false) await revokeAllSessions(tx, id);
    const action = body.isActive === false ? 'user.deactivate' : body.isActive === true ? 'user.reactivate' : 'user.update';
    await audit.record(tx, ctx, { action, entityType: 'User', entityId: id, before, after });
  });
  return oneUser(id);
}

/** Director sets a new password: revokes every session and clears any lockout (§1.3). */
export async function resetPassword(id: string, body: z.infer<typeof ResetPasswordBody>, ctx: RequestContext) {
  const hash = await hashPassword(body.password);
  const user = await prisma.$transaction(async (tx) => {
    const before = await tx.user.findUnique({ where: { id } });
    if (!before) throw Errors.notFound('User');
    const u = await tx.user.update({
      where: { id },
      data: { passwordHash: hash, passwordChangedAt: new Date(), failedLoginCount: 0, failedWindowStartedAt: null, lockedUntil: null },
    });
    await revokeAllSessions(tx, id);
    await audit.record(tx, ctx, { action: 'user.password.reset', entityType: 'User', entityId: id });
    return u;
  });
  const bu = await prisma.employeeBusinessUnit.findFirst({ where: { employeeId: user.employeeId }, orderBy: { isPrimary: 'desc' } });
  const businessUnitId = bu?.businessUnitId ?? (await prisma.businessUnit.findFirst({ orderBy: { code: 'asc' } }))?.id;
  if (businessUnitId) {
    await notify([id], { type: 'PASSWORD_RESET', title: 'Password reset', body: 'Your password was reset by the director.', entityType: 'USER', entityId: id, businessUnitId });
  }
  return oneUser(id);
}

export async function unlockUser(id: string, ctx: RequestContext) {
  await prisma.$transaction(async (tx) => {
    const before = await tx.user.findUnique({ where: { id } });
    if (!before) throw Errors.notFound('User');
    await tx.user.update({ where: { id }, data: { lockedUntil: null, failedLoginCount: 0, failedWindowStartedAt: null } });
    await audit.record(tx, ctx, { action: 'user.unlock', entityType: 'User', entityId: id, before: { lockedUntil: before.lockedUntil } });
  });
  return oneUser(id);
}
