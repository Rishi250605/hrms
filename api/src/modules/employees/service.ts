import type { z } from 'zod';
import { env } from '../../config/env.js';
import { decryptField, encryptField, maskLast4 } from '../../lib/crypto.js';
import { addDays, fromDbDate, fromDbDateOrNull, todayIst, toDbDate } from '../../lib/dates.js';
import { AppError, Errors } from '../../lib/errors.js';
import { prisma } from '../../lib/prisma.js';
import type { Db, Tx } from '../../lib/prisma.js';
import type { AuthUser, RequestContext } from '../../lib/context.js';
import type { Prisma } from '../../generated/prisma/client.js';
import type { Role } from '../../generated/prisma/enums.js';
import { businessUnitsOf, descendantsOf, LEVEL_RANK, levelOf, nextLevelUp, validateReportingLine } from '../access/hierarchy.js';
import { employeeWhere, findEmployeeInScope, scopeFor } from '../access/scope.js';
import { audit } from '../audit/service.js';
import { revokeAllSessions } from '../auth/service.js';
import { membershipsOf, personRefs, setMemberships } from '../users/service.js';
import { complianceFor } from './compliance.js';
import type { ComplianceOverallT } from './compliance.js';
import { assertEmpCodeFormat, suggestEmpCode } from './empcode.js';
import type {
  BankDetailsBody,
  BusinessUnitsBody,
  EmployeeCreateBody,
  EmployeeListQuery,
  EmployeeUpdateBody,
  ExitBody,
  JobChangeBody,
  PromotionBody,
} from './schemas.js';

export { findEmployeeInScope };

const depotSelect = { select: { id: true, code: true, name: true } } as const;
const jobInclude = { depot: depotSelect } satisfies Prisma.EmployeeJobInclude;
type JobRow = Prisma.EmployeeJobGetPayload<{ include: typeof jobInclude }>;

/** Rows still in force today or starting later (effectiveTo null or after today). */
const currentOrUpcoming = (today: Date): Prisma.EmployeeJobWhereInput => ({ OR: [{ effectiveTo: null }, { effectiveTo: { gt: today } }] });

const isHrLike = (user: Pick<AuthUser, 'role'>) => user.role === 'HR' || user.role === 'DIRECTOR';

// ───────────────────────────── Effective-dated reads ─────────────────────────────

/** The job row in force on `date` (payroll, roster and attendance use only this). */
export async function getJobAsOf(employeeId: string, date: string, db: Db = prisma) {
  const d = toDbDate(date);
  return db.employeeJob.findFirst({ where: { employeeId, effectiveFrom: { lte: d }, OR: [{ effectiveTo: null }, { effectiveTo: { gt: d } }] } });
}

/** Ids of employees whose job on `date` is at `depotId`. */
export async function employeeIdsAtDepot(depotId: string, date: string, db: Db = prisma): Promise<string[]> {
  const d = toDbDate(date);
  const rows = await db.employeeJob.findMany({
    where: { depotId, effectiveFrom: { lte: d }, OR: [{ effectiveTo: null }, { effectiveTo: { gt: d } }] },
    select: { employeeId: true },
  });
  return rows.map((r) => r.employeeId);
}

// ───────────────────────────────── Queries ─────────────────────────────────

const listInclude = (today: Date) =>
  ({
    jobs: { where: currentOrUpcoming(today), include: jobInclude, orderBy: { effectiveFrom: 'asc' }, take: 1 },
    businessUnits: { where: { isPrimary: true }, include: { businessUnit: { select: { id: true, code: true, name: true } } } },
    user: { select: { role: true } },
  }) satisfies Prisma.EmployeeInclude;

type ListRow = Prisma.EmployeeGetPayload<{ include: ReturnType<typeof listInclude> }>;

async function toListItems(db: Db, rows: ListRow[]) {
  const compliance = await complianceFor(db, rows);
  const refs = await personRefs(db, rows.map((r) => r.jobs[0]?.reportingToEmployeeId));
  return rows.map((r) => toListItem(r, compliance.get(r.id)?.overall ?? 'OK', refs));
}

function toListItem(r: ListRow, compliance: ComplianceOverallT, refs: Awaited<ReturnType<typeof personRefs>>) {
  const job = r.jobs[0];
  return {
    id: r.id,
    empCode: r.empCode,
    fullName: r.fullName,
    phone: r.phone,
    category: r.category,
    role: r.user?.role ?? null,
    employmentType: r.employmentType,
    status: r.status,
    designation: job?.designation ?? null,
    depot: job?.depot ?? null,
    businessUnit: r.businessUnits[0]?.businessUnit ?? null,
    reportingTo: job?.reportingToEmployeeId ? (refs.get(job.reportingToEmployeeId) ?? null) : null,
    compliance,
  };
}

export async function listEmployees(user: AuthUser, q: z.infer<typeof EmployeeListQuery>) {
  const today = toDbDate(todayIst());
  const scope = await scopeFor(prisma, user, 'employees', q.businessUnitId);
  const and: Prisma.EmployeeWhereInput[] = [employeeWhere(user, scope)];
  and.push(q.status ? { status: q.status } : { status: { not: 'EXITED' } });
  if (q.category) and.push({ category: q.category });
  if (q.role) and.push({ user: { role: q.role } });
  if (q.staffOnly) and.push({ user: null });
  if (q.depotId) and.push({ jobs: { some: { AND: [{ depotId: q.depotId }, currentOrUpcoming(today)] } } });
  if (q.reportingToEmployeeId) and.push({ jobs: { some: { AND: [{ reportingToEmployeeId: q.reportingToEmployeeId }, currentOrUpcoming(today)] } } });
  if (q.q) {
    and.push({
      OR: [
        { fullName: { contains: q.q, mode: 'insensitive' } },
        { empCode: { contains: q.q, mode: 'insensitive' } },
        { phone: { contains: q.q.replace(/\s/g, '') } },
      ],
    });
  }

  // Compliance is computed, not stored, so its filter is applied while scanning pages (bounded).
  const items: ReturnType<typeof toListItem>[] = [];
  let cursor = q.cursor;
  for (let scans = 1; ; scans++) {
    const rows = await prisma.employee.findMany({
      where: { AND: and },
      include: listInclude(today),
      orderBy: [{ fullName: 'asc' }, { id: 'asc' }],
      take: q.limit + 1,
      ...(cursor ? { cursor: { id: cursor }, skip: 1 } : {}),
    });
    const hasMore = rows.length > q.limit;
    const pageRows = hasMore ? rows.slice(0, q.limit) : rows;
    const mapped = await toListItems(prisma, pageRows);
    for (const [i, item] of mapped.entries()) {
      if (q.compliance && item.compliance !== q.compliance) continue;
      items.push(item);
      if (items.length === q.limit) {
        const lastOverall = !hasMore && i === pageRows.length - 1;
        return { items, nextCursor: lastOverall ? null : item.id };
      }
    }
    if (!hasMore) return { items, nextCursor: null };
    cursor = pageRows[pageRows.length - 1]!.id;
    if (scans >= 20) return { items, nextCursor: cursor };
  }
}

export async function getEmployee(user: AuthUser, id: string) {
  await findEmployeeInScope(prisma, user, id);
  return employeeDetail(prisma, user, id);
}

export async function employeeDetail(db: Db, user: Pick<AuthUser, 'role'>, id: string) {
  const today = todayIst();
  const e = await db.employee.findUniqueOrThrow({
    where: { id },
    include: { ...listInclude(toDbDate(today)), jobs: { include: jobInclude, orderBy: { effectiveFrom: 'desc' } } },
  });
  const current =
    e.jobs.find((j) => fromDbDate(j.effectiveFrom) <= today && (!j.effectiveTo || fromDbDate(j.effectiveTo) > today)) ??
    [...e.jobs].reverse().find((j) => fromDbDate(j.effectiveFrom) > today) ??
    null;
  const refs = await personRefs(db, e.jobs.map((j) => j.reportingToEmployeeId));
  const toJob = (j: JobRow) => ({
    id: j.id,
    depot: j.depot,
    designation: j.designation,
    grade: j.grade,
    reportingTo: j.reportingToEmployeeId ? (refs.get(j.reportingToEmployeeId) ?? null) : null,
    effectiveFrom: fromDbDate(j.effectiveFrom),
    effectiveTo: fromDbDateOrNull(j.effectiveTo),
    changeReason: j.changeReason,
  });
  const compliance = (await complianceFor(db, [e], today)).get(e.id)!;
  const hr = isHrLike(user);
  return {
    id: e.id,
    empCode: e.empCode,
    fullName: e.fullName,
    phone: e.phone,
    altPhone: e.altPhone,
    category: e.category,
    role: e.user?.role ?? null,
    employmentType: e.employmentType,
    status: e.status,
    designation: current?.designation ?? null,
    depot: current?.depot ?? null,
    businessUnit: e.businessUnits[0]?.businessUnit ?? null,
    reportingTo: current?.reportingToEmployeeId ? (refs.get(current.reportingToEmployeeId) ?? null) : null,
    dob: fromDbDateOrNull(e.dob),
    gender: e.gender,
    joiningDate: fromDbDate(e.joiningDate),
    exitDate: fromDbDateOrNull(e.exitDate),
    exitReason: e.exitReason,
    contractorName: e.contractorName,
    uan: e.uan,
    esicNo: e.esicNo,
    aadhaarLast4: e.aadhaarLast4,
    panMasked: hr && e.panLast4 ? `XXXXXX${e.panLast4}` : null,
    hasBankDetails: hr && e.bankAccountEncrypted !== null,
    preferredChannel: e.preferredChannel,
    hasPhoto: e.photoKey !== null,
    hasLogin: e.user !== null,
    businessUnits: await membershipsOf(db, e.id, e.user?.role ?? null),
    currentJob: current ? toJob(current) : null,
    jobs: e.jobs.map(toJob),
    compliance,
  };
}

export async function nextEmpCode(user: AuthUser, businessUnitId: string) {
  if (!user.businessUnitIds.includes(businessUnitId)) throw new AppError('FORBIDDEN_BUSINESS_UNIT', 403, 'You do not belong to this business unit');
  const bu = await prisma.businessUnit.findUnique({ where: { id: businessUnitId } });
  if (!bu) throw Errors.notFound('Business unit');
  return { empCode: await suggestEmpCode(prisma, bu.code) };
}

// ───────────────────────────────── Writes ─────────────────────────────────

const encrypt = (value: string) => encryptField(value, env.DATA_ENCRYPTION_KEY);

/** The depot must exist and belong to one of `businessUnitIds`. */
async function assertDepotInBusinessUnits(db: Db, depotId: string, businessUnitIds: string[]) {
  const depot = await db.depot.findFirst({ where: { id: depotId, deletedAt: null } });
  if (!depot) throw Errors.notFound('Depot');
  if (!businessUnitIds.includes(depot.businessUnitId)) {
    throw Errors.validation([{ path: ['depotId'], message: "The depot belongs to another business unit" }]);
  }
  return depot;
}

/** HR / director onboard non-login staff (§11 "User management: HR — driver/loadman records only"). */
export async function createEmployee(user: AuthUser, body: z.infer<typeof EmployeeCreateBody>, ctx: RequestContext) {
  if (!user.businessUnitIds.includes(body.businessUnitId)) throw new AppError('FORBIDDEN_BUSINESS_UNIT', 403, 'You do not belong to this business unit');
  await assertDepotInBusinessUnits(prisma, body.job.depotId, [body.businessUnitId]);
  await validateReportingLine(prisma, { level: 'STAFF', businessUnitIds: [body.businessUnitId] }, body.job.reportingToEmployeeId);
  if ((body.bankAccount === undefined) !== (body.ifsc === undefined)) throw Errors.validation([{ path: ['ifsc'], message: 'Bank account and IFSC go together' }]);
  if (body.employmentType === 'CONTRACT' && !body.contractorName) throw Errors.validation([{ path: ['contractorName'], message: 'Required for contract employees' }]);

  const id = await prisma.$transaction(async (tx) => {
    await assertEmpCodeFormat(tx, body.empCode, body.businessUnitId);
    const employee = await tx.employee.create({
      data: {
        empCode: body.empCode,
        fullName: body.fullName,
        phone: body.phone,
        altPhone: body.altPhone ?? null,
        dob: body.dob ? toDbDate(body.dob) : null,
        gender: body.gender ?? null,
        joiningDate: toDbDate(body.joiningDate),
        category: body.category,
        employmentType: body.employmentType,
        contractorName: body.contractorName ?? null,
        preferredChannel: body.preferredChannel ?? 'WHATSAPP',
        uan: body.uan ?? null,
        esicNo: body.esicNo ?? null,
        panEncrypted: body.pan ? encrypt(body.pan) : null,
        panLast4: body.pan ? body.pan.slice(-4) : null,
        aadhaarLast4: body.aadhaarLast4 ?? null,
        bankAccountEncrypted: body.bankAccount ? encrypt(body.bankAccount) : null,
        bankAccountLast4: body.bankAccount ? body.bankAccount.slice(-4) : null,
        ifsc: body.ifsc ?? null,
        createdById: ctx.user?.id ?? null,
      },
    });
    await tx.employeeBusinessUnit.create({ data: { employeeId: employee.id, businessUnitId: body.businessUnitId, isPrimary: true, createdById: ctx.user?.id ?? null } });
    const job = await tx.employeeJob.create({
      data: {
        employeeId: employee.id,
        depotId: body.job.depotId,
        designation: body.job.designation,
        grade: body.job.grade ?? null,
        reportingToEmployeeId: body.job.reportingToEmployeeId,
        effectiveFrom: toDbDate(body.joiningDate),
        changeReason: 'Joining',
        createdById: ctx.user?.id ?? null,
      },
    });
    await audit.record(tx, ctx, { action: 'employee.create', entityType: 'Employee', entityId: employee.id, after: employee });
    await audit.record(tx, ctx, { action: 'employeeJob.create', entityType: 'EmployeeJob', entityId: job.id, after: job });
    return employee.id;
  });
  return employeeDetail(prisma, user, id);
}

/** HR may only manage non-login staff; the director manages everyone (§11). */
async function assertCanManage(db: Db, user: AuthUser, employeeId: string) {
  if (user.role === 'DIRECTOR') return;
  if ((await levelOf(db, employeeId)) !== 'STAFF') throw Errors.forbidden('Only the director can change a manager’s record');
}

export async function updateEmployee(user: AuthUser, id: string, body: z.infer<typeof EmployeeUpdateBody>, ctx: RequestContext) {
  await findEmployeeInScope(prisma, user, id);
  await assertCanManage(prisma, user, id);
  await prisma.$transaction(async (tx) => {
    const before = await tx.employee.findUniqueOrThrow({ where: { id } });
    if (body.status && (before.status === 'EXITED' || before.status === 'ON_NOTICE')) {
      throw Errors.conflict('EMPLOYEE_EXITING', 'Status of an exiting or exited employee cannot be changed here');
    }
    const { pan, dob, ...rest } = body;
    const data: Prisma.EmployeeUpdateInput = { ...rest };
    if (dob !== undefined) data.dob = dob ? toDbDate(dob) : null;
    if (pan !== undefined) {
      data.panEncrypted = pan ? encrypt(pan) : null;
      data.panLast4 = pan ? pan.slice(-4) : null;
    }
    const after = await tx.employee.update({ where: { id }, data });
    await audit.record(tx, ctx, { action: 'employee.update', entityType: 'Employee', entityId: id, before, after });
  });
  return employeeDetail(prisma, user, id);
}

/** Serialises concurrent job changes for one employee. */
async function lockEmployee(tx: Tx, id: string) {
  await tx.$queryRaw`SELECT id FROM employees WHERE id = ${id}::uuid FOR UPDATE`;
}

interface JobChange {
  effectiveFrom: string;
  depotId?: string | undefined;
  designation?: string | undefined;
  grade?: string | null | undefined;
  reportingToEmployeeId?: string | undefined;
  reason: string;
}

/**
 * Effective-dated job change: close the open row at `effectiveFrom` and insert a new open row carrying over
 * unchanged fields, in one transaction. Past rows are never edited (CLAUDE.md §5).
 */
async function applyJobChange(tx: Tx, employeeId: string, change: JobChange, level: Role | 'STAFF', ctx: RequestContext) {
  await lockEmployee(tx, employeeId);
  const employee = await tx.employee.findUniqueOrThrow({ where: { id: employeeId } });
  if (employee.status === 'EXITED') throw Errors.conflict('EMPLOYEE_EXITED', 'The employee has exited');
  const open = await tx.employeeJob.findFirst({ where: { employeeId, effectiveTo: null } });
  if (!open) throw Errors.conflict('NO_OPEN_JOB', 'The employee has no open job row (exit recorded)');
  const from = toDbDate(change.effectiveFrom);
  if (from <= open.effectiveFrom) {
    throw Errors.conflict('JOB_CHANGE_BEFORE_CURRENT', 'A job change must start after the current job row starts', { currentEffectiveFrom: fromDbDate(open.effectiveFrom) });
  }
  const bus = await businessUnitsOf(tx, employeeId);
  const depotId = change.depotId ?? open.depotId;
  if (change.depotId) {
    const depot = await tx.depot.findFirst({ where: { id: depotId, deletedAt: null } });
    if (!depot) throw Errors.notFound('Depot');
    if (level === 'STAFF' && !bus.ids.includes(depot.businessUnitId)) {
      // Staff belong to exactly one BU: moving to another BU's depot moves their membership too.
      await setMemberships(tx, employeeId, [depot.businessUnitId], depot.businessUnitId, ctx);
      bus.ids = [depot.businessUnitId];
    } else if (level !== 'STAFF' && level !== 'DIRECTOR' && !bus.ids.includes(depot.businessUnitId)) {
      throw Errors.validation([{ path: ['depotId'], message: 'The depot must be in one of the employee’s business units' }]);
    }
  }
  const reportingTo = change.reportingToEmployeeId ?? open.reportingToEmployeeId;
  await validateReportingLine(tx, { level, businessUnitIds: bus.ids, employeeId }, reportingTo);

  const closed = await tx.employeeJob.update({ where: { id: open.id }, data: { effectiveTo: from } });
  const created = await tx.employeeJob.create({
    data: {
      employeeId,
      depotId,
      designation: change.designation ?? open.designation,
      grade: change.grade !== undefined ? change.grade : open.grade,
      reportingToEmployeeId: reportingTo,
      effectiveFrom: from,
      changeReason: change.reason,
      createdById: ctx.user?.id ?? null,
    },
  });
  await audit.record(tx, ctx, { action: 'employeeJob.close', entityType: 'EmployeeJob', entityId: open.id, before: open, after: closed });
  await audit.record(tx, ctx, { action: 'employeeJob.create', entityType: 'EmployeeJob', entityId: created.id, after: created });
}

export async function changeJob(user: AuthUser, id: string, body: z.infer<typeof JobChangeBody>, ctx: RequestContext) {
  await findEmployeeInScope(prisma, user, id);
  await assertCanManage(prisma, user, id);
  const level = await levelOf(prisma, id);
  await prisma.$transaction((tx) => applyJobChange(tx, id, body, level, ctx));
  return employeeDetail(prisma, user, id);
}

/**
 * Promotion (decision Q1): the only way a login's role changes. Records a job change with the new reporting
 * line and returns direct reports whose line is no longer valid, so HR can reassign them.
 */
export async function promote(user: AuthUser, id: string, body: z.infer<typeof PromotionBody>, ctx: RequestContext) {
  await findEmployeeInScope(prisma, user, id);
  const login = await prisma.user.findUnique({ where: { employeeId: id } });
  if (!login) throw Errors.conflict('NO_LOGIN', 'Only employees with a login can be promoted; the director creates logins');
  if (login.role === 'DIRECTOR') throw Errors.forbidden('The director’s role cannot be changed');
  if (login.role === body.role) throw Errors.conflict('SAME_ROLE', 'The employee already has this role');
  if (user.role === 'HR' && body.role === 'HR' && login.employeeId === user.employeeId) throw Errors.forbidden('You cannot change your own role');

  await prisma.$transaction(async (tx) => {
    const before = await tx.user.findUniqueOrThrow({ where: { id: login.id } });
    await tx.user.update({ where: { id: login.id }, data: { role: body.role } });
    await applyJobChange(
      tx,
      id,
      { effectiveFrom: body.effectiveFrom, designation: body.designation, reportingToEmployeeId: body.reportingToEmployeeId, reason: `Promotion: ${body.reason}` },
      body.role,
      ctx,
    );
    await audit.record(tx, ctx, { action: 'user.promote', entityType: 'User', entityId: login.id, before: { role: before.role }, after: { role: body.role, effectiveFrom: body.effectiveFrom } });
  });
  // TODO(business): a future-dated promotion changes the login role immediately; confirm whether it should wait.

  // Direct reports must be exactly one level below the new role.
  const direct = await descendantsOf(prisma, id, 1, body.effectiveFrom);
  const invalid: string[] = [];
  for (const childId of direct.keys()) {
    const childLevel = await levelOf(prisma, childId);
    if (nextLevelUp(childLevel) !== body.role || LEVEL_RANK[childLevel] >= LEVEL_RANK[body.role]) invalid.push(childId);
  }
  const refs = await personRefs(prisma, invalid);
  return { employee: await employeeDetail(prisma, user, id), reportsNeedingReassignment: invalid.map((i) => refs.get(i)!).filter(Boolean) };
}

/** Business-unit membership (§2.1): staff exactly one; managers one or more with one primary. */
export async function setBusinessUnits(user: AuthUser, id: string, body: z.infer<typeof BusinessUnitsBody>, ctx: RequestContext) {
  await findEmployeeInScope(prisma, user, id);
  await assertCanManage(prisma, user, id);
  const level = await levelOf(prisma, id);
  if (level === 'DIRECTOR') throw Errors.conflict('DIRECTOR_HAS_ALL', 'The director belongs to every business unit');
  if (level === 'STAFF' && new Set(body.businessUnitIds).size !== 1) {
    throw Errors.validation([{ path: ['businessUnitIds'], message: 'Drivers and loadmen belong to exactly one business unit' }]);
  }
  for (const bu of body.businessUnitIds) {
    if (!user.businessUnitIds.includes(bu)) throw new AppError('FORBIDDEN_BUSINESS_UNIT', 403, 'You do not belong to this business unit');
  }
  await prisma.$transaction((tx) => setMemberships(tx, id, body.businessUnitIds, body.primaryBusinessUnitId, ctx));
  return employeeDetail(prisma, user, id);
}

/** Records an exit: closes the open job row after the last working day; the login is deactivated once exited. */
export async function exitEmployee(user: AuthUser, id: string, body: z.infer<typeof ExitBody>, ctx: RequestContext) {
  await findEmployeeInScope(prisma, user, id);
  await assertCanManage(prisma, user, id);
  await prisma.$transaction(async (tx) => {
    await lockEmployee(tx, id);
    const before = await tx.employee.findUniqueOrThrow({ where: { id } });
    if (before.status === 'EXITED' || before.exitDate) throw Errors.conflict('EMPLOYEE_EXITED', 'An exit is already recorded');
    if (body.exitDate < fromDbDate(before.joiningDate)) throw Errors.validation([{ path: ['exitDate'], message: 'Exit date is before the joining date' }]);
    const open = await tx.employeeJob.findFirst({ where: { employeeId: id, effectiveTo: null } });
    const endExclusive = toDbDate(addDays(body.exitDate, 1));
    if (open) {
      if (endExclusive <= open.effectiveFrom) {
        throw Errors.conflict('JOB_CHANGE_BEFORE_CURRENT', 'Exit date is before the current job row starts', { currentEffectiveFrom: fromDbDate(open.effectiveFrom) });
      }
      const closed = await tx.employeeJob.update({ where: { id: open.id }, data: { effectiveTo: endExclusive } });
      await audit.record(tx, ctx, { action: 'employeeJob.close', entityType: 'EmployeeJob', entityId: open.id, before: open, after: closed });
    }
    const exited = body.exitDate < todayIst();
    const after = await tx.employee.update({ where: { id }, data: { exitDate: toDbDate(body.exitDate), exitReason: body.reason, status: exited ? 'EXITED' : 'ON_NOTICE' } });
    if (exited) await deactivateLogin(tx, id, ctx);
    await audit.record(tx, ctx, { action: 'employee.exit', entityType: 'Employee', entityId: id, before, after });
  });
  return employeeDetail(prisma, user, id);
}

/** Exited employees cannot sign in. */
export async function deactivateLogin(tx: Tx, employeeId: string, ctx: RequestContext) {
  const login = await tx.user.findUnique({ where: { employeeId } });
  if (!login || !login.isActive) return;
  await tx.user.update({ where: { id: login.id }, data: { isActive: false } });
  await revokeAllSessions(tx, login.id);
  await audit.record(tx, ctx, { action: 'user.deactivate', entityType: 'User', entityId: login.id, after: { reason: 'exit' } });
}

/** Pay data: HR / director only, masked, and every read is audited. */
export async function getBankDetails(user: AuthUser, id: string, ctx: RequestContext) {
  const e = await findEmployeeInScope(prisma, user, id);
  await audit.record(prisma, ctx, { action: 'employee.bankDetails.read', entityType: 'Employee', entityId: id });
  return { accountMasked: e.bankAccountLast4 ? maskLast4(`00000000${e.bankAccountLast4}`) : null, ifsc: e.ifsc };
}

export async function setBankDetails(user: AuthUser, id: string, body: z.infer<typeof BankDetailsBody>, ctx: RequestContext) {
  await findEmployeeInScope(prisma, user, id);
  return prisma.$transaction(async (tx) => {
    const before = await tx.employee.findUniqueOrThrow({ where: { id }, select: { bankAccountLast4: true, ifsc: true } });
    const after = await tx.employee.update({
      where: { id },
      data: { bankAccountEncrypted: encrypt(body.bankAccount), bankAccountLast4: body.bankAccount.slice(-4), ifsc: body.ifsc },
      select: { bankAccountLast4: true, ifsc: true },
    });
    await audit.record(tx, ctx, { action: 'employee.bankDetails.update', entityType: 'Employee', entityId: id, before, after });
    return { accountMasked: maskLast4(`00000000${body.bankAccount.slice(-4)}`), ifsc: body.ifsc };
  });
}

/** Full account number — only for a bank-file export. */
export function decryptBankAccount(encrypted: string): string {
  return decryptField(encrypted, env.DATA_ENCRYPTION_KEY);
}
