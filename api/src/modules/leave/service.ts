import type { z } from 'zod';
import { addDays, dateRange, diffDays, fromDbDate, todayIst, toDbDate } from '../../lib/dates.js';
import { AppError, Errors } from '../../lib/errors.js';
import { prisma } from '../../lib/prisma.js';
import type { Db, Tx } from '../../lib/prisma.js';
import type { AuthUser, RequestContext } from '../../lib/context.js';
import type { Prisma } from '../../generated/prisma/client.js';
import type { EmployeeCategory, EmploymentType, LeaveKind } from '../../generated/prisma/enums.js';
import { canDecide, descendantsOf, inactiveApproverEmployeeIds, LEVEL_RANK, levelOf, primaryBusinessUnitOf, resolveApprover } from '../access/hierarchy.js';
import type { Level } from '../access/hierarchy.js';
import { businessUnitsFor, findEmployeeInScope, recordWhere, scopeFor } from '../access/scope.js';
import { upsertMark } from '../attendance/service.js';
import { audit } from '../audit/service.js';
import { getJobAsOf } from '../employees/service.js';
import { directorsOf, hrOf, notify, userIdOfEmployee } from '../notifications/service.js';
import { getSetting } from '../settings/service.js';
import { personRefs } from '../users/service.js';
import { AccrualRuleSchema } from './schemas.js';
import type {
  BalanceQuery,
  LeavePolicyBody,
  LeavePolicyUpdateBody,
  LeaveRequestCreateBody,
  LeaveRequestQuery,
  LeaveTypeCreateBody,
  LeaveTypeUpdateBody,
} from './schemas.js';

const num = (d: Prisma.Decimal | number | null | undefined) => (d === null || d === undefined ? 0 : Number(d));
const round2 = (n: number) => Math.round(n * 100) / 100;

type LeaveTypeRow = Prisma.LeaveTypeGetPayload<object>;
export const accrualOf = (t: Pick<LeaveTypeRow, 'accrualRule'>) => AccrualRuleSchema.catch({ type: 'NONE' }).parse(t.accrualRule);
/** A balance is kept for every type except NONE (e.g. loss of pay). */
export const tracksBalance = (t: Pick<LeaveTypeRow, 'accrualRule'>) => accrualOf(t).type !== 'NONE';

const toType = (t: LeaveTypeRow) => ({
  id: t.id,
  code: t.code,
  name: t.name,
  paid: t.paid,
  accrualRule: accrualOf(t),
  carryForwardMax: num(t.carryForwardMax),
  encashable: t.encashable,
  isActive: t.isActive,
  tracksBalance: tracksBalance(t),
});

// ───────────────────────────── Types & policies (HR / director) ─────────────────────────────

export async function listTypes() {
  return { items: (await prisma.leaveType.findMany({ orderBy: { code: 'asc' } })).map(toType) };
}

export async function createType(body: z.infer<typeof LeaveTypeCreateBody>, ctx: RequestContext) {
  return prisma.$transaction(async (tx) => {
    const t = await tx.leaveType.create({ data: { ...body, createdById: ctx.user?.id ?? null } });
    await audit.record(tx, ctx, { action: 'leaveType.create', entityType: 'LeaveType', entityId: t.id, after: t });
    return toType(t);
  });
}

export async function updateType(id: string, body: z.infer<typeof LeaveTypeUpdateBody>, ctx: RequestContext) {
  return prisma.$transaction(async (tx) => {
    const before = await tx.leaveType.findUnique({ where: { id } });
    if (!before) throw Errors.notFound('Leave type');
    const after = await tx.leaveType.update({ where: { id }, data: body });
    await audit.record(tx, ctx, { action: 'leaveType.update', entityType: 'LeaveType', entityId: id, before, after });
    return toType(after);
  });
}

type PolicyRow = Prisma.LeavePolicyGetPayload<{ include: { leaveType: { select: { code: true } } } }>;
const toPolicy = (p: PolicyRow) => ({
  id: p.id,
  leaveTypeId: p.leaveTypeId,
  leaveTypeCode: p.leaveType.code,
  category: p.category,
  employmentType: p.employmentType,
  state: p.state,
  annualQuota: num(p.annualQuota),
});

export async function listPolicies() {
  const rows = await prisma.leavePolicy.findMany({ include: { leaveType: { select: { code: true } } }, orderBy: [{ leaveTypeId: 'asc' }, { createdAt: 'asc' }] });
  return { items: rows.map(toPolicy) };
}

export async function createPolicy(body: z.infer<typeof LeavePolicyBody>, ctx: RequestContext) {
  if (!(await prisma.leaveType.findUnique({ where: { id: body.leaveTypeId } }))) throw Errors.notFound('Leave type');
  const dup = await prisma.leavePolicy.findFirst({ where: { leaveTypeId: body.leaveTypeId, category: body.category, employmentType: body.employmentType, state: body.state } });
  if (dup) throw Errors.conflict('POLICY_EXISTS', 'A policy with the same filters exists; change its quota instead');
  return prisma.$transaction(async (tx) => {
    const p = await tx.leavePolicy.create({ data: { ...body, createdById: ctx.user?.id ?? null }, include: { leaveType: { select: { code: true } } } });
    await audit.record(tx, ctx, { action: 'leavePolicy.create', entityType: 'LeavePolicy', entityId: p.id, after: p });
    return toPolicy(p);
  });
}

export async function updatePolicy(id: string, body: z.infer<typeof LeavePolicyUpdateBody>, ctx: RequestContext) {
  return prisma.$transaction(async (tx) => {
    const before = await tx.leavePolicy.findUnique({ where: { id } });
    if (!before) throw Errors.notFound('Leave policy');
    const after = await tx.leavePolicy.update({ where: { id }, data: body, include: { leaveType: { select: { code: true } } } });
    await audit.record(tx, ctx, { action: 'leavePolicy.update', entityType: 'LeavePolicy', entityId: id, before, after });
    return toPolicy(after);
  });
}

export async function deletePolicy(id: string, ctx: RequestContext) {
  await prisma.$transaction(async (tx) => {
    const before = await tx.leavePolicy.findUnique({ where: { id } });
    if (!before) throw Errors.notFound('Leave policy');
    await tx.leavePolicy.delete({ where: { id } });
    await audit.record(tx, ctx, { action: 'leavePolicy.delete', entityType: 'LeavePolicy', entityId: id, before });
  });
}

export interface PolicySubject {
  category: EmployeeCategory;
  employmentType: EmploymentType;
  state: string | null;
}

/** Most specific matching policy (null filters match anything; more non-null filters = more specific). */
export function matchPolicy<P extends { category: EmployeeCategory | null; employmentType: EmploymentType | null; state: string | null }>(policies: P[], subject: PolicySubject): P | null {
  const specificity = (p: P) => Number(p.category !== null) + Number(p.employmentType !== null) + Number(p.state !== null);
  return (
    policies
      .filter(
        (p) =>
          (p.category === null || p.category === subject.category) &&
          (p.employmentType === null || p.employmentType === subject.employmentType) &&
          (p.state === null || p.state === subject.state),
      )
      .sort((a, b) => specificity(b) - specificity(a))[0] ?? null
  );
}

/** Policy subject of an employee on a date (state from the depot of their job then). */
export async function subjectOf(db: Db, employee: { id: string; category: EmployeeCategory; employmentType: EmploymentType }, date: string) {
  const job = await getJobAsOf(employee.id, date, db);
  const depot = job ? await db.depot.findUnique({ where: { id: job.depotId }, select: { state: true } }) : null;
  return { subject: { category: employee.category, employmentType: employee.employmentType, state: depot?.state ?? null }, job };
}

// ───────────────────────────── Balances ─────────────────────────────

/** The balance row of a year, created on first use with the carry-forward from the previous year (audited). */
export async function ensureBalance(db: Db, employeeId: string, leaveType: LeaveTypeRow, year: number, ctx: RequestContext) {
  const existing = await db.leaveBalance.findUnique({ where: { employeeId_leaveTypeId_year: { employeeId, leaveTypeId: leaveType.id, year } } });
  if (existing) return existing;
  const prev = await db.leaveBalance.findUnique({ where: { employeeId_leaveTypeId_year: { employeeId, leaveTypeId: leaveType.id, year: year - 1 } } });
  const opening = prev ? Math.max(0, Math.min(num(prev.closing), num(leaveType.carryForwardMax))) : 0;
  const row = await db.leaveBalance.upsert({
    where: { employeeId_leaveTypeId_year: { employeeId, leaveTypeId: leaveType.id, year } },
    create: { employeeId, leaveTypeId: leaveType.id, year, opening, closing: opening },
    update: {},
  });
  await audit.record(db, ctx, { action: 'leaveBalance.open', entityType: 'LeaveBalance', entityId: row.id, after: { ...row, carriedFrom: prev?.id ?? null } });
  return row;
}

/** Applies deltas, keeps closing = opening + accrued - used - encashed, and audits the movement with its reason. */
export async function adjustBalance(tx: Tx, balanceId: string, delta: { accrued?: number; used?: number }, ctx: RequestContext, reason: string) {
  const b = await tx.leaveBalance.findUniqueOrThrow({ where: { id: balanceId } });
  const accrued = round2(num(b.accrued) + (delta.accrued ?? 0));
  const used = round2(num(b.used) + (delta.used ?? 0));
  const after = await tx.leaveBalance.update({ where: { id: balanceId }, data: { accrued, used, closing: round2(num(b.opening) + accrued - used - num(b.encashed)) } });
  await audit.record(tx, ctx, { action: 'leaveBalance.adjust', entityType: 'LeaveBalance', entityId: balanceId, before: b, after: { ...after, delta, reason } });
  return after;
}

async function pendingDays(db: Db, employeeId: string, leaveTypeId: string, year: number) {
  const agg = await db.leaveRequest.aggregate({
    _sum: { days: true },
    where: { employeeId, leaveTypeId, kind: 'LEAVE', status: 'PENDING', fromDate: { gte: toDbDate(`${year}-01-01`), lte: toDbDate(`${year}-12-31`) } },
  });
  return num(agg._sum.days);
}

export async function getBalances(user: AuthUser, q: z.infer<typeof BalanceQuery>) {
  const employee = await findEmployeeInScope(prisma, user, q.employeeId, 'leave');
  const year = q.year ?? Number(todayIst().slice(0, 4));
  const [types, policies, rows] = await Promise.all([
    prisma.leaveType.findMany({ where: { isActive: true }, orderBy: { code: 'asc' } }),
    prisma.leavePolicy.findMany(),
    prisma.leaveBalance.findMany({ where: { employeeId: employee.id, year } }),
  ]);
  const { subject } = await subjectOf(prisma, employee, `${year}-12-31` < todayIst() ? `${year}-12-31` : todayIst());
  const items = [];
  for (const t of types) {
    const policy = matchPolicy(policies.filter((p) => p.leaveTypeId === t.id), subject);
    if (!policy) continue;
    const b = rows.find((r) => r.leaveTypeId === t.id);
    const pending = await pendingDays(prisma, employee.id, t.id, year);
    const closing = num(b?.closing);
    items.push({
      leaveTypeId: t.id,
      leaveTypeCode: t.code,
      leaveTypeName: t.name,
      year,
      tracksBalance: tracksBalance(t),
      annualQuota: num(policy.annualQuota),
      opening: num(b?.opening),
      accrued: num(b?.accrued),
      used: num(b?.used),
      encashed: num(b?.encashed),
      closing,
      pending,
      available: round2(closing - pending),
    });
  }
  return { employeeId: employee.id, year, items };
}

// ───────────────────────────── Requests (leave & OD) ─────────────────────────────

/**
 * Calendar days, minus half days at either end.
 * TODO(business): should weekly offs / holidays inside a leave be excluded (sandwich rule)?
 */
export function leaveDays(from: string, to: string, fromHalf: boolean, toHalf: boolean): number {
  if (to < from) return 0;
  if (from === to) return fromHalf || toHalf ? (fromHalf && toHalf ? 0 : 0.5) : 1;
  return diffDays(from, to) + 1 - (fromHalf ? 0.5 : 0) - (toHalf ? 0.5 : 0);
}

const requestInclude = { leaveType: { select: { id: true, code: true, name: true } } } satisfies Prisma.LeaveRequestInclude;
type RequestRow = Prisma.LeaveRequestGetPayload<{ include: typeof requestInclude }>;
const isHrLike = (u: Pick<AuthUser, 'role'>) => u.role === 'HR' || u.role === 'DIRECTOR';

async function toRequestItems(db: Db, user: AuthUser, rows: RequestRow[], warnings: string[] = []) {
  const [refs, bus, users, inactive] = await Promise.all([
    personRefs(db, rows.flatMap((r) => [r.employeeId, r.approverEmployeeId])),
    db.businessUnit.findMany({ where: { id: { in: rows.map((r) => r.businessUnitId) } }, select: { id: true, code: true, name: true } }),
    db.user.findMany({ where: { id: { in: rows.flatMap((r) => [r.raisedById, r.decidedById].filter((x): x is string => !!x)) } }, select: { id: true, name: true } }),
    inactiveApproverEmployeeIds(db, user.role),
  ]);
  const bu = new Map(bus.map((b) => [b.id, b]));
  const name = new Map(users.map((u) => [u.id, u.name]));
  return rows.map((r) => {
    const mayDecide = r.approverEmployeeId === user.employeeId || (r.approverRole === user.role && user.businessUnitIds.includes(r.businessUnitId) && inactive.includes(r.approverEmployeeId));
    return {
      id: r.id,
      kind: r.kind,
      employee: refs.get(r.employeeId)!,
      businessUnit: bu.get(r.businessUnitId)!,
      leaveType: r.leaveType,
      fromDate: fromDbDate(r.fromDate),
      toDate: fromDbDate(r.toDate),
      fromHalf: r.fromHalf,
      toHalf: r.toHalf,
      days: num(r.days),
      reason: r.reason,
      odLocation: r.odLocation,
      odPurpose: r.odPurpose,
      odFromTime: r.odFromTime,
      odToTime: r.odToTime,
      status: r.status,
      raisedByName: name.get(r.raisedById) ?? 'Unknown',
      approver: refs.get(r.approverEmployeeId) ?? null,
      decidedAt: r.decidedAt?.toISOString() ?? null,
      decidedByName: r.decidedById ? (name.get(r.decidedById) ?? null) : null,
      rejectionReason: r.rejectionReason,
      canDecide: r.status === 'PENDING' && mayDecide,
      canCancel: (r.status === 'PENDING' && (r.raisedById === user.id || r.employeeId === user.employeeId)) || (r.status === 'APPROVED' && (mayDecide || isHrLike(user))),
      warnings,
      createdAt: r.createdAt.toISOString(),
    };
  });
}

const KIND_LABEL: Record<LeaveKind, string> = { LEAVE: 'Leave', OD: 'OD' };

/**
 * Raise leave / OD (PHASE-2-FEATURES §5.1):
 *  - for yourself (RM / OM / HR) → your reporting-to approves;
 *  - an RM for a driver / loadman reporting to them → the same RM approves (now with autoApprove, or later);
 *  - HR / director may raise for anyone in scope and back-date beyond the edit window.
 */
export async function createRequest(user: AuthUser, body: z.infer<typeof LeaveRequestCreateBody>, ctx: RequestContext) {
  const subjectId = body.subjectEmployeeId ?? user.employeeId;
  const self = subjectId === user.employeeId;
  if (self && user.role === 'DIRECTOR') throw new AppError('NOT_TRACKED', 422, "The director's leave is not tracked");
  const subject = await findEmployeeInScope(prisma, user, subjectId, 'leave');
  const subjectLevel: Level = await levelOf(prisma, subjectId);
  if (!self) {
    const direct = await descendantsOf(prisma, user.employeeId, 1);
    const isMyStaff = user.role === 'REGIONAL_MANAGER' && subjectLevel === 'STAFF' && direct.has(subjectId);
    if (!isMyStaff && !isHrLike(user)) throw Errors.forbidden('You can raise leave only for yourself or for drivers / loadmen reporting to you');
    if (isHrLike(user) && LEVEL_RANK[subjectLevel] >= LEVEL_RANK[user.role]) throw Errors.forbidden('Raise it for yourself or for someone below you');
  }
  if (subject.status === 'EXITED' || subject.status === 'SUSPENDED') throw Errors.conflict('EMPLOYEE_NOT_AVAILABLE', `The employee is ${subject.status.toLowerCase()}`);
  if (body.toDate < body.fromDate) throw Errors.validation([{ path: ['toDate'], message: 'To date is before from date' }]);
  if (body.fromDate.slice(0, 4) !== body.toDate.slice(0, 4)) {
    // TODO(business): split leave across calendar years against both years' balances.
    throw new AppError('LEAVE_SPANS_YEARS', 422, 'Raise separate requests for each calendar year');
  }
  const windowDays = await getSetting('attendance.editWindowDays');
  if (!isHrLike(user) && body.fromDate < addDays(todayIst(), -windowDays)) {
    throw new AppError('BEFORE_EDIT_WINDOW', 422, 'Only HR or the director can raise leave / OD this far back');
  }
  const fromHalf = body.fromHalf ?? false;
  const toHalf = body.toHalf ?? false;
  const days = leaveDays(body.fromDate, body.toDate, fromHalf, toHalf);
  if (days <= 0) throw Errors.validation([{ path: ['toHalf'], message: 'The request has no days' }]);

  let leaveType: LeaveTypeRow | null = null;
  if (body.kind === 'LEAVE') {
    if (!body.leaveTypeId) throw Errors.validation([{ path: ['leaveTypeId'], message: 'Choose a leave type' }]);
    leaveType = await prisma.leaveType.findUnique({ where: { id: body.leaveTypeId } });
    if (!leaveType || !leaveType.isActive) throw Errors.notFound('Leave type');
    const { subject: policySubject } = await subjectOf(prisma, subject, body.fromDate);
    const policy = matchPolicy(await prisma.leavePolicy.findMany({ where: { leaveTypeId: leaveType.id } }), policySubject);
    if (!policy) throw new AppError('LEAVE_NOT_APPLICABLE', 422, `${leaveType.name} does not apply to this employee`);
  } else if (!body.odLocation || !body.odPurpose) {
    throw Errors.validation([{ path: ['odLocation'], message: 'Location and purpose are required for OD' }]);
  }

  const businessUnitId = await primaryBusinessUnitOf(prisma, subjectId);
  const approver = await resolveApprover(prisma, subjectId, businessUnitId, body.fromDate);
  const autoApprove = body.autoApprove === true && approver.employeeId === user.employeeId;
  if (body.autoApprove && !autoApprove) throw Errors.forbidden('Only the approver can submit and approve in one step');
  const year = Number(body.fromDate.slice(0, 4));
  const warnings: string[] = [];

  const request = await prisma.$transaction(async (tx) => {
    await tx.$queryRaw`SELECT id FROM employees WHERE id = ${subjectId}::uuid FOR UPDATE`;
    const overlap = await tx.leaveRequest.findFirst({
      where: { employeeId: subjectId, status: { in: ['PENDING', 'APPROVED'] }, fromDate: { lte: toDbDate(body.toDate) }, toDate: { gte: toDbDate(body.fromDate) } },
    });
    if (overlap) {
      throw Errors.conflict('LEAVE_OVERLAP', 'There is already leave or OD on some of these dates', {
        leaveRequestId: overlap.id,
        fromDate: fromDbDate(overlap.fromDate),
        toDate: fromDbDate(overlap.toDate),
      });
    }
    if (leaveType && tracksBalance(leaveType)) {
      const balance = await ensureBalance(tx, subjectId, leaveType, year, ctx);
      const available = round2(num(balance.closing) - (await pendingDays(tx, subjectId, leaveType.id, year)));
      if (available < days) {
        if ((await getSetting('leave.balanceEnforcement', tx)) === 'BLOCK') {
          throw Errors.conflict('INSUFFICIENT_BALANCE', `Only ${available} day(s) of ${leaveType.name} available`, { available, requested: days });
        }
        warnings.push('INSUFFICIENT_BALANCE');
      }
    }
    const created = await tx.leaveRequest.create({
      data: {
        employeeId: subjectId,
        businessUnitId,
        kind: body.kind,
        leaveTypeId: leaveType?.id ?? null,
        fromDate: toDbDate(body.fromDate),
        toDate: toDbDate(body.toDate),
        fromHalf,
        toHalf,
        days,
        reason: body.reason,
        odLocation: body.kind === 'OD' ? (body.odLocation ?? null) : null,
        odPurpose: body.kind === 'OD' ? (body.odPurpose ?? null) : null,
        odFromTime: body.kind === 'OD' ? (body.odFromTime ?? null) : null,
        odToTime: body.kind === 'OD' ? (body.odToTime ?? null) : null,
        raisedById: user.id,
        approverEmployeeId: approver.employeeId,
        approverRole: approver.role,
      },
    });
    await audit.record(tx, ctx, { action: 'leaveRequest.create', entityType: 'LeaveRequest', entityId: created.id, after: created });
    if (autoApprove) await applyApproval(tx, created.id, user, ctx);
    return tx.leaveRequest.findUniqueOrThrow({ where: { id: created.id }, include: requestInclude });
  });

  // Notifications (§10).
  const label = `${subject.fullName} (${subject.empCode}) · ${KIND_LABEL[body.kind]}${leaveType ? ` ${leaveType.code}` : ''} · ${body.fromDate === body.toDate ? body.fromDate : `${body.fromDate} to ${body.toDate}`}`;
  const notice = { entityType: 'LEAVE', entityId: request.id, businessUnitId };
  if (autoApprove) {
    await notify(await hrOf(prisma, businessUnitId), { ...notice, type: 'LEAVE_APPROVED', title: `${KIND_LABEL[body.kind]} approved`, body: label }, user.id);
  } else {
    const recipients = [approver.userId];
    if (subjectLevel === 'REGIONAL_MANAGER') recipients.push(...(await hrOf(prisma, businessUnitId)));
    if (approver.fallback) recipients.push(...(await directorsOf(prisma)));
    await notify(recipients, { ...notice, type: 'LEAVE_SUBMITTED', title: `${KIND_LABEL[body.kind]} to approve`, body: label }, user.id);
  }
  return (await toRequestItems(prisma, user, [request], warnings))[0]!;
}

/** Dates fully covered by the request (half days keep the employee partly available). */
function fullDays(r: { fromDate: Date; toDate: Date; fromHalf: boolean; toHalf: boolean }): string[] {
  const from = fromDbDate(r.fromDate);
  const to = fromDbDate(r.toDate);
  return dateRange(from, to).filter((d) => !(d === from && r.fromHalf) && !(d === to && r.toHalf));
}

/**
 * Approval effects (§5.1): balance deducted; attendance set to ON_LEAVE / HALF_DAY / ON_DUTY for every date
 * (already approved); the employee is taken off roster duties on fully covered days.
 */
async function applyApproval(tx: Tx, id: string, decider: AuthUser, ctx: RequestContext) {
  const r = await tx.leaveRequest.findUniqueOrThrow({ where: { id }, include: { leaveType: true } });
  await tx.leaveRequest.update({ where: { id }, data: { status: 'APPROVED', decidedById: decider.id, decidedAt: new Date() } });
  if (r.leaveType && tracksBalance(r.leaveType)) {
    const balance = await ensureBalance(tx, r.employeeId, r.leaveType, r.fromDate.getUTCFullYear(), ctx);
    await adjustBalance(tx, balance.id, { used: num(r.days) }, ctx, `leave ${id} approved`);
  }
  const full = new Set(fullDays(r));
  for (const date of dateRange(fromDbDate(r.fromDate), fromDbDate(r.toDate))) {
    await upsertMark(
      tx,
      {
        employeeId: r.employeeId,
        businessUnitId: r.businessUnitId,
        date,
        status: r.kind === 'OD' ? 'ON_DUTY' : full.has(date) ? 'ON_LEAVE' : 'HALF_DAY',
        approvalState: 'APPROVED',
        source: 'SYSTEM',
        note: `${KIND_LABEL[r.kind]} approved`,
        leaveRequestId: r.id,
        markedById: decider.id,
        approver: { employeeId: r.approverEmployeeId, role: r.approverRole },
        decidedById: decider.id,
      },
      ctx,
      'attendance.fromLeave',
    );
  }
  const assignments = full.size
    ? await tx.dutyAssignment.findMany({ where: { employeeId: r.employeeId, duty: { dutyDate: { in: [...full].map(toDbDate) }, status: { in: ['PLANNED', 'CONFIRMED'] } } } })
    : [];
  for (const a of assignments) {
    await tx.dutyAssignment.delete({ where: { id: a.id } });
    await audit.record(tx, ctx, { action: 'dutyAssignment.delete', entityType: 'DutyAssignment', entityId: a.id, before: { ...a, reason: 'leave approved' } });
  }
  await audit.record(tx, ctx, { action: 'leaveRequest.approve', entityType: 'LeaveRequest', entityId: id, before: r, after: { status: 'APPROVED' } });
}

async function notifyDecision(r: RequestRow, decision: 'APPROVED' | 'REJECTED' | 'CANCELLED', actor: AuthUser, reason?: string) {
  const subjectLevel = await levelOf(prisma, r.employeeId);
  const recipients = [r.raisedById, await userIdOfEmployee(prisma, r.employeeId)];
  if (subjectLevel === 'STAFF' || subjectLevel === 'REGIONAL_MANAGER') recipients.push(...(await hrOf(prisma, r.businessUnitId)));
  const subject = (await personRefs(prisma, [r.employeeId])).get(r.employeeId)!;
  await notify(
    recipients,
    {
      type: decision === 'APPROVED' ? 'LEAVE_APPROVED' : decision === 'REJECTED' ? 'LEAVE_REJECTED' : 'LEAVE_CANCELLED',
      title: `${KIND_LABEL[r.kind]} ${decision.toLowerCase()}`,
      body: `${subject.name} (${subject.empCode}) · ${fromDbDate(r.fromDate)}${r.toDate.getTime() !== r.fromDate.getTime() ? ` to ${fromDbDate(r.toDate)}` : ''}${reason ? ` — ${reason}` : ''}`,
      entityType: 'LEAVE',
      entityId: r.id,
      businessUnitId: r.businessUnitId,
    },
    actor.id,
  );
}

async function lockRequest(tx: Tx, id: string) {
  await tx.$queryRaw`SELECT id FROM leave_requests WHERE id = ${id}::uuid FOR UPDATE`;
  const r = await tx.leaveRequest.findUnique({ where: { id } });
  if (!r) throw Errors.notFound('Leave request');
  return r;
}

export async function approveRequest(user: AuthUser, id: string, ctx: RequestContext) {
  await prisma.$transaction(async (tx) => {
    const r = await lockRequest(tx, id);
    if (!(await canDecide(tx, user, r))) throw Errors.notFound('Leave request');
    if (r.status !== 'PENDING') throw Errors.conflict('ALREADY_DECIDED', `The request is already ${r.status.toLowerCase()}`);
    await applyApproval(tx, id, user, ctx);
  });
  const row = await prisma.leaveRequest.findUniqueOrThrow({ where: { id }, include: requestInclude });
  await notifyDecision(row, 'APPROVED', user);
  return (await toRequestItems(prisma, user, [row]))[0]!;
}

export async function rejectRequest(user: AuthUser, id: string, reason: string, ctx: RequestContext) {
  await prisma.$transaction(async (tx) => {
    const r = await lockRequest(tx, id);
    if (!(await canDecide(tx, user, r))) throw Errors.notFound('Leave request');
    if (r.status !== 'PENDING') throw Errors.conflict('ALREADY_DECIDED', `The request is already ${r.status.toLowerCase()}`);
    const after = await tx.leaveRequest.update({ where: { id }, data: { status: 'REJECTED', decidedById: user.id, decidedAt: new Date(), rejectionReason: reason } });
    await audit.record(tx, ctx, { action: 'leaveRequest.reject', entityType: 'LeaveRequest', entityId: id, before: r, after });
  });
  const row = await prisma.leaveRequest.findUniqueOrThrow({ where: { id }, include: requestInclude });
  await notifyDecision(row, 'REJECTED', user, reason);
  return (await toRequestItems(prisma, user, [row]))[0]!;
}

/**
 * Cancel: the requester (or the subject) while pending; after approval only the approver (or HR / director),
 * which restores the balance and removes the attendance marks set from it (§5.1).
 */
export async function cancelRequest(user: AuthUser, id: string, ctx: RequestContext) {
  const wasApproved = await prisma.$transaction(async (tx) => {
    const r = await lockRequest(tx, id);
    if (!(await canAccessLeave(tx, user, r))) throw Errors.notFound('Leave request');
    if (r.status === 'PENDING') {
      if (r.raisedById !== user.id && r.employeeId !== user.employeeId && !isHrLike(user)) throw Errors.forbidden('Only the requester can withdraw it');
    } else if (r.status === 'APPROVED') {
      if (!(await canDecide(tx, user, r)) && !isHrLike(user)) throw Errors.forbidden('Only the approver can cancel an approved request');
      const type = r.leaveTypeId ? await tx.leaveType.findUnique({ where: { id: r.leaveTypeId } }) : null;
      if (type && tracksBalance(type)) {
        const balance = await ensureBalance(tx, r.employeeId, type, r.fromDate.getUTCFullYear(), ctx);
        await adjustBalance(tx, balance.id, { used: -num(r.days) }, ctx, `leave ${id} cancelled after approval`);
      }
      const marks = await tx.attendanceMark.findMany({ where: { leaveRequestId: id, source: 'SYSTEM' } });
      await tx.attendanceMark.deleteMany({ where: { id: { in: marks.map((m) => m.id) } } });
      for (const m of marks) await audit.record(tx, ctx, { action: 'attendance.fromLeave.remove', entityType: 'AttendanceMark', entityId: m.id, before: m });
    } else {
      throw Errors.conflict('ALREADY_DECIDED', `The request is already ${r.status.toLowerCase()}`);
    }
    const after = await tx.leaveRequest.update({ where: { id }, data: { status: 'CANCELLED', cancelledById: user.id, cancelledAt: new Date() } });
    await audit.record(tx, ctx, { action: 'leaveRequest.cancel', entityType: 'LeaveRequest', entityId: id, before: r, after });
    return r.status === 'APPROVED';
  });
  const row = await prisma.leaveRequest.findUniqueOrThrow({ where: { id }, include: requestInclude });
  if (wasApproved) await notifyDecision(row, 'CANCELLED', user);
  return (await toRequestItems(prisma, user, [row]))[0]!;
}

async function canAccessLeave(db: Db, user: AuthUser, r: { employeeId: string; businessUnitId: string; raisedById: string; approverEmployeeId: string; approverRole: AuthUser['role'] }) {
  if (r.raisedById === user.id || (await canDecide(db, user, r))) return true;
  const scope = await scopeFor(db, user, 'leave');
  return scope.businessUnitIds.includes(r.businessUnitId) && (scope.employeeIds === null || scope.employeeIds.includes(r.employeeId));
}

export async function listRequests(user: AuthUser, q: z.infer<typeof LeaveRequestQuery>) {
  const and: Prisma.LeaveRequestWhereInput[] = [];
  if (q.scope === 'mine') {
    and.push({ employeeId: user.employeeId, businessUnitId: { in: businessUnitsFor(user, q.businessUnitId) } });
  } else if (q.scope === 'approvals') {
    const routed = await routedToMe(user, q.businessUnitId);
    and.push(routed, q.status ? {} : { status: 'PENDING' });
  } else {
    if (q.scope === 'all' && !isHrLike(user)) throw Errors.forbidden('Only HR and the director can see all requests');
    const scope = await scopeFor(prisma, user, 'leave', q.businessUnitId);
    and.push(recordWhere(scope) as Prisma.LeaveRequestWhereInput);
    if (q.scope === 'team') and.push({ employeeId: { not: user.employeeId } });
  }
  if (q.status) and.push({ status: q.status });
  if (q.kind) and.push({ kind: q.kind });
  if (q.employeeId) and.push({ employeeId: q.employeeId });
  if (q.from) and.push({ toDate: { gte: toDbDate(q.from) } });
  if (q.to) and.push({ fromDate: { lte: toDbDate(q.to) } });
  const rows = await prisma.leaveRequest.findMany({
    where: { AND: and },
    include: requestInclude,
    orderBy: [{ createdAt: 'desc' }, { id: 'desc' }],
    take: q.limit + 1,
    ...(q.cursor ? { cursor: { id: q.cursor }, skip: 1 } : {}),
  });
  const hasMore = rows.length > q.limit;
  const page = hasMore ? rows.slice(0, q.limit) : rows;
  return { items: await toRequestItems(prisma, user, page), nextCursor: hasMore ? (page[page.length - 1]?.id ?? null) : null };
}

async function routedToMe(user: AuthUser, businessUnitId?: string): Promise<Prisma.LeaveRequestWhereInput> {
  const inactive = await inactiveApproverEmployeeIds(prisma, user.role);
  return {
    businessUnitId: { in: businessUnitsFor(user, businessUnitId) },
    OR: [{ approverEmployeeId: user.employeeId }, ...(inactive.length ? [{ approverRole: user.role, approverEmployeeId: { in: inactive } }] : [])],
  };
}

// ───────────────────────── Availability (roster + attendance) ─────────────────────────

/** Approved leave / OD on `date` per employee: half = only part of the day. */
export async function leaveOn(db: Db, employeeIds: string[], date: string) {
  const map = new Map<string, { leaveRequestId: string; kind: LeaveKind; half: boolean; code: string | null }>();
  if (employeeIds.length === 0) return map;
  const d = toDbDate(date);
  const rows = await db.leaveRequest.findMany({
    where: { employeeId: { in: employeeIds }, status: 'APPROVED', fromDate: { lte: d }, toDate: { gte: d } },
    include: { leaveType: { select: { code: true } } },
  });
  for (const r of rows) {
    const half = (fromDbDate(r.fromDate) === date && r.fromHalf) || (fromDbDate(r.toDate) === date && r.toHalf);
    map.set(r.employeeId, { leaveRequestId: r.id, kind: r.kind, half, code: r.leaveType?.code ?? null });
  }
  return map;
}

/** Employees on approved full-day leave or OD on `date` — they cannot be rostered. */
export async function employeesOnLeave(db: Db, employeeIds: string[], date: string): Promise<Set<string>> {
  const leave = await leaveOn(db, employeeIds, date);
  return new Set([...leave].filter(([, l]) => !l.half).map(([id]) => id));
}
