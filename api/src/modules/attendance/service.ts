import type { z } from 'zod';
import { addDays, fromDbDate, istInstant, istTimeOf, todayIst, toDbDate } from '../../lib/dates.js';
import { AppError, Errors } from '../../lib/errors.js';
import { logger } from '../../lib/logger.js';
import { prisma } from '../../lib/prisma.js';
import type { Db, Tx } from '../../lib/prisma.js';
import type { AuthUser, RequestContext } from '../../lib/context.js';
import { Prisma } from '../../generated/prisma/client.js';
import type { AttendanceSource, AttendanceStatus, Role } from '../../generated/prisma/enums.js';
import { canDecide, descendantsOf, inactiveApproverEmployeeIds, primaryBusinessUnitOf, resolveApprover } from '../access/hierarchy.js';
import { businessUnitsFor, recordWhere, scopeFor } from '../access/scope.js';
import { audit } from '../audit/service.js';
import { leaveOn } from '../leave/service.js';
import { directorsOf, notify, userIdOfEmployee } from '../notifications/service.js';
import { getSetting } from '../settings/service.js';
import { personRefs } from '../users/service.js';
import type { BulkAttendanceBody, CorrectionBody, CorrectionQuery, MarksQuery, SelfMarkBody } from './schemas.js';

/**
 * Attendance (PHASE-2-FEATURES §4):
 *  - drivers / loadmen are marked by their RM and final (APPROVED);
 *  - RM, OM and HR mark themselves (PENDING_APPROVAL) and their reporting-to approves;
 *  - the director's attendance is not tracked (assumption §13.1);
 *  - one record per employee per date; after the edit window (or after approval) changes go through a
 *    correction approved by the raiser's reporting-to.
 */

/** Marks for date D are editable until 23:59 IST on D + N (attendance.editWindowDays). */
export async function editWindow(date: string, db: Db = prisma, now = new Date()) {
  const days = await getSetting('attendance.editWindowDays', db);
  const until = new Date(istInstant(addDays(date, days + 1), '00:00').getTime() - 1000);
  return { editable: date <= todayIst(now) && now <= until, until };
}

// ───────────────────────────── Mapping ─────────────────────────────

const markInclude = {
  employee: { select: { id: true, empCode: true, fullName: true, category: true, user: { select: { role: true } } } },
} satisfies Prisma.AttendanceMarkInclude;
type MarkRow = Prisma.AttendanceMarkGetPayload<{ include: typeof markInclude }>;

async function buRefs(db: Db, ids: string[]) {
  const rows = await db.businessUnit.findMany({ where: { id: { in: [...new Set(ids)] } }, select: { id: true, code: true, name: true } });
  return new Map(rows.map((b) => [b.id, b]));
}

async function userNames(db: Db, ids: (string | null)[]) {
  const rows = await db.user.findMany({ where: { id: { in: [...new Set(ids.filter((x): x is string => !!x))] } }, select: { id: true, name: true } });
  return new Map(rows.map((u) => [u.id, u.name]));
}

const employeeRef = (e: MarkRow['employee']) => ({ id: e.id, empCode: e.empCode, fullName: e.fullName, category: e.category, role: e.user?.role ?? null });

export async function toMarkItems(db: Db, user: AuthUser, rows: MarkRow[]) {
  const [bus, names, refs, inactive] = await Promise.all([
    buRefs(db, rows.map((r) => r.businessUnitId)),
    userNames(db, rows.flatMap((r) => [r.markedById, r.decidedById])),
    personRefs(db, rows.map((r) => r.approverEmployeeId)),
    inactiveApproverEmployeeIds(db, user.role),
  ]);
  return rows.map((m) => ({
    id: m.id,
    employee: employeeRef(m.employee),
    businessUnit: bus.get(m.businessUnitId)!,
    date: fromDbDate(m.date),
    status: m.status,
    approvalState: m.approvalState,
    source: m.source,
    note: m.note,
    markedAt: m.markedAt.toISOString(),
    markedByName: names.get(m.markedById) ?? 'System',
    approver: m.approverEmployeeId ? (refs.get(m.approverEmployeeId) ?? null) : null,
    decidedAt: m.decidedAt?.toISOString() ?? null,
    decidedByName: m.decidedById ? (names.get(m.decidedById) ?? null) : null,
    rejectionReason: m.rejectionReason,
    canDecide:
      m.approvalState === 'PENDING_APPROVAL' &&
      !!m.approverEmployeeId &&
      (m.approverEmployeeId === user.employeeId ||
        (m.approverRole === user.role && user.businessUnitIds.includes(m.businessUnitId) && inactive.includes(m.approverEmployeeId))),
    clientMutationId: m.clientMutationId,
  }));
}

// ───────────────────────────── RM: team marking ─────────────────────────────

/** Drivers / loadmen (non-login staff) reporting directly to the RM on `date`, in the RM's business units. */
async function teamOf(db: Db, user: AuthUser, date: string, businessUnitIds: string[]) {
  const direct = await descendantsOf(db, user.employeeId, 1, date);
  const ids = [...direct.keys()];
  if (ids.length === 0) return [];
  const d = toDbDate(date);
  return db.employee.findMany({
    where: {
      id: { in: ids },
      deletedAt: null,
      user: null,
      businessUnits: { some: { businessUnitId: { in: businessUnitIds } } },
      joiningDate: { lte: d },
    },
    select: {
      id: true,
      empCode: true,
      fullName: true,
      category: true,
      businessUnits: { include: { businessUnit: { select: { id: true, code: true, name: true } } }, orderBy: { isPrimary: 'desc' }, take: 1 },
      jobs: { where: { effectiveFrom: { lte: d }, OR: [{ effectiveTo: null }, { effectiveTo: { gt: d } }] }, include: { depot: { select: { id: true, code: true, name: true } } } },
    },
    orderBy: { fullName: 'asc' },
  });
}

export async function getTeamDay(user: AuthUser, date: string, businessUnitId?: string) {
  const bus = businessUnitsFor(user, businessUnitId);
  const team = await teamOf(prisma, user, date, bus);
  const ids = team.map((e) => e.id);
  const d = toDbDate(date);
  const [marks, assignments, leave, window] = await Promise.all([
    prisma.attendanceMark.findMany({ where: { employeeId: { in: ids }, date: d }, include: markInclude }),
    prisma.dutyAssignment.findMany({
      where: { employeeId: { in: ids }, duty: { dutyDate: d, status: { not: 'CANCELLED' } } },
      include: { duty: { include: { route: { select: { code: true } } } } },
    }),
    leaveOn(prisma, ids, date),
    editWindow(date),
  ]);
  const markItems = new Map((await toMarkItems(prisma, user, marks)).map((m) => [m.employee.id, m]));
  const rows = team.map((e) => {
    const l = leave.get(e.id) ?? null;
    const suggested: AttendanceStatus = l ? (l.kind === 'OD' ? 'ON_DUTY' : l.half ? 'HALF_DAY' : 'ON_LEAVE') : 'PRESENT';
    return {
      employee: { id: e.id, empCode: e.empCode, fullName: e.fullName, category: e.category, role: null },
      designation: e.jobs[0]?.designation ?? null,
      depot: e.jobs[0]?.depot ?? null,
      businessUnit: e.businessUnits[0]!.businessUnit,
      duties: assignments
        .filter((a) => a.employeeId === e.id)
        .map((a) => ({ dutyId: a.dutyId, assignmentId: a.id, startTime: istTimeOf(a.duty.scheduledStart), endTime: istTimeOf(a.duty.scheduledEnd), routeCode: a.duty.route?.code ?? null })),
      leave: l ? { leaveRequestId: l.leaveRequestId, kind: l.kind, code: l.code, half: l.half } : null,
      mark: markItems.get(e.id) ?? null,
      suggestedStatus: suggested,
    };
  });
  const marked = rows.filter((r) => r.mark).length;
  return { date, editable: window.editable, editableUntil: window.until.toISOString(), summary: { employees: rows.length, marked, pending: rows.length - marked }, rows };
}

type BulkMarkInput = z.infer<typeof BulkAttendanceBody>['marks'][number];
type BulkOutcome = { clientMutationId: string; employeeId: string; date: string; outcome: 'APPLIED' | 'DUPLICATE' | 'REJECTED'; error: { code: string; message: string } | null };

/**
 * RM marks drivers / loadmen (final, no approval). Idempotent by clientMutationId; each mark is applied and
 * reported independently so one bad mark never blocks an offline batch. Marks for employees who do not report
 * to the RM (or are outside their business units) refuse the whole request with 403 (§4.4).
 */
export async function bulkTeamMark(user: AuthUser, body: z.infer<typeof BulkAttendanceBody>, ctx: RequestContext) {
  const today = todayIst();
  const teamByDate = new Map<string, Map<string, string>>(); // date → employeeId → businessUnitId
  for (const date of new Set(body.marks.map((m) => m.date))) {
    const team = await teamOf(prisma, user, date, user.businessUnitIds);
    teamByDate.set(date, new Map(team.map((e) => [e.id, e.businessUnits[0]!.businessUnitId])));
  }
  const foreign = body.marks.filter((m) => !teamByDate.get(m.date)!.has(m.employeeId)).map((m) => m.employeeId);
  if (foreign.length > 0) {
    throw new AppError('FORBIDDEN', 403, 'You can only mark attendance for drivers and loadmen who report to you', { employeeIds: [...new Set(foreign)] });
  }

  const windows = new Map<string, boolean>();
  const results: BulkOutcome[] = [];
  for (const m of body.marks) {
    const base = { clientMutationId: m.clientMutationId, employeeId: m.employeeId, date: m.date };
    const reject = (code: string, message: string): BulkOutcome => ({ ...base, outcome: 'REJECTED', error: { code, message } });
    const replay = await prisma.attendanceMark.findUnique({ where: { clientMutationId: m.clientMutationId } });
    if (replay) {
      results.push(replay.employeeId === m.employeeId && fromDbDate(replay.date) === m.date ? { ...base, outcome: 'DUPLICATE', error: null } : reject('CLIENT_ID_REUSED', 'This clientMutationId was used for another mark'));
      continue;
    }
    if (m.date > today) {
      results.push(reject('FUTURE_DATE', 'Attendance cannot be marked for a future date'));
      continue;
    }
    if (!windows.has(m.date)) windows.set(m.date, (await editWindow(m.date)).editable);
    if (!windows.get(m.date)) {
      results.push(reject('EDIT_WINDOW_CLOSED', 'The edit window has closed; raise an attendance correction'));
      continue;
    }
    try {
      await prisma.$transaction((tx) => writeTeamMark(tx, user, m, teamByDate.get(m.date)!.get(m.employeeId)!, ctx));
      results.push({ ...base, outcome: 'APPLIED', error: null });
    } catch (err) {
      if (err instanceof Prisma.PrismaClientKnownRequestError && err.code === 'P2002') {
        results.push({ ...base, outcome: 'DUPLICATE', error: null });
      } else if (err instanceof AppError) {
        results.push(reject(err.code, err.message));
      } else {
        throw err;
      }
    }
  }
  return {
    applied: results.filter((r) => r.outcome === 'APPLIED').length,
    duplicates: results.filter((r) => r.outcome === 'DUPLICATE').length,
    rejected: results.filter((r) => r.outcome === 'REJECTED').length,
    results,
  };
}

async function writeTeamMark(tx: Tx, user: AuthUser, m: BulkMarkInput, businessUnitId: string, ctx: RequestContext) {
  if (m.dutyAssignmentId) {
    const a = await tx.dutyAssignment.findUnique({ where: { id: m.dutyAssignmentId }, include: { duty: { select: { dutyDate: true } } } });
    if (!a || a.employeeId !== m.employeeId || fromDbDate(a.duty.dutyDate) !== m.date) throw new AppError('INVALID_ASSIGNMENT', 422, 'The duty assignment does not match the employee and date');
  }
  await upsertMark(
    tx,
    {
      employeeId: m.employeeId,
      businessUnitId,
      date: m.date,
      status: m.status,
      approvalState: 'APPROVED',
      source: 'MANAGER',
      note: m.note ?? null,
      dutyAssignmentId: m.dutyAssignmentId ?? null,
      clientMutationId: m.clientMutationId,
      markedById: user.id,
      approver: null,
    },
    ctx,
    'attendance.mark',
  );
}

interface MarkWrite {
  employeeId: string;
  businessUnitId: string;
  date: string;
  status: AttendanceStatus;
  approvalState: 'PENDING_APPROVAL' | 'APPROVED';
  source: AttendanceSource;
  note: string | null;
  dutyAssignmentId?: string | null;
  leaveRequestId?: string | null;
  clientMutationId?: string | null;
  markedById: string;
  approver: { employeeId: string; role: Role } | null;
  decidedById?: string | null;
}

export async function upsertMark(tx: Tx, w: MarkWrite, ctx: RequestContext, action: string) {
  const where = { employeeId_date: { employeeId: w.employeeId, date: toDbDate(w.date) } };
  const before = await tx.attendanceMark.findUnique({ where });
  const now = new Date();
  const data = {
    businessUnitId: w.businessUnitId,
    status: w.status,
    approvalState: w.approvalState,
    source: w.source,
    note: w.note,
    dutyAssignmentId: w.dutyAssignmentId ?? null,
    leaveRequestId: w.leaveRequestId ?? null,
    clientMutationId: w.clientMutationId ?? null,
    markedById: w.markedById,
    markedAt: now,
    approverEmployeeId: w.approver?.employeeId ?? null,
    approverRole: w.approver?.role ?? null,
    decidedById: w.approvalState === 'APPROVED' ? (w.decidedById ?? null) : null,
    decidedAt: w.approvalState === 'APPROVED' && w.decidedById ? now : null,
    rejectionReason: null,
  };
  const after = await tx.attendanceMark.upsert({ where, create: { employeeId: w.employeeId, date: toDbDate(w.date), ...data }, update: data });
  await audit.record(tx, ctx, { action, entityType: 'AttendanceMark', entityId: after.id, before, after });
  return after;
}

// ───────────────────────────── Self-marking ─────────────────────────────

const LEVEL_TYPE: Record<Role, string> = { REGIONAL_MANAGER: 'RM', OPERATIONAL_MANAGER: 'OM', HR: 'HR', DIRECTOR: 'Director' };

/** RM / OM / HR mark their own attendance; it waits for their reporting-to (§4.1). */
export async function markSelf(user: AuthUser, body: z.infer<typeof SelfMarkBody>, ctx: RequestContext) {
  if (user.role === 'DIRECTOR') throw new AppError('NOT_TRACKED', 422, "The director's attendance is not tracked");
  if (body.date > todayIst()) throw new AppError('FUTURE_DATE', 422, 'You cannot mark attendance for a future date');
  if (!(await editWindow(body.date)).editable) throw new AppError('EDIT_WINDOW_CLOSED', 422, 'The edit window has closed; raise an attendance correction');
  const businessUnitId = user.primaryBusinessUnitId ?? (await primaryBusinessUnitOf(prisma, user.employeeId));
  const approver = await resolveApprover(prisma, user.employeeId, businessUnitId, body.date);

  const mark = await prisma.$transaction(async (tx) => {
    const existing = await tx.attendanceMark.findUnique({ where: { employeeId_date: { employeeId: user.employeeId, date: toDbDate(body.date) } } });
    if (existing?.approvalState === 'APPROVED') throw Errors.conflict('ALREADY_APPROVED', 'This day is already approved; raise a correction to change it');
    return upsertMark(
      tx,
      { employeeId: user.employeeId, businessUnitId, date: body.date, status: body.status, approvalState: 'PENDING_APPROVAL', source: 'SELF', note: body.note ?? null, markedById: user.id, approver },
      ctx,
      'attendance.self.mark',
    );
  });
  await notify(
    [approver.userId, ...(approver.fallback ? await directorsOf(prisma) : [])],
    {
      type: 'ATTENDANCE_SUBMITTED',
      title: `${LEVEL_TYPE[user.role]} attendance to approve`,
      body: `${user.name} (${user.empCode}) · ${body.date}: ${body.status.replace(/_/g, ' ').toLowerCase()}`,
      entityType: 'ATTENDANCE',
      entityId: mark.id,
      businessUnitId,
    },
    user.id,
  );
  return (await toMarkItems(prisma, user, [await prisma.attendanceMark.findUniqueOrThrow({ where: { id: mark.id }, include: markInclude })]))[0]!;
}

export async function listSelf(user: AuthUser, from: string, to: string) {
  const rows = await prisma.attendanceMark.findMany({
    where: { employeeId: user.employeeId, date: { gte: toDbDate(from), lte: toDbDate(to) } },
    include: markInclude,
    orderBy: { date: 'desc' },
  });
  return { items: await toMarkItems(prisma, user, rows) };
}

// ───────────────────────────── Approvals ─────────────────────────────

/** Where-clause for records routed to the user (directly, or as a backup for an inactive same-role approver). */
export async function routedTo(db: Db, user: AuthUser, businessUnitId?: string | null) {
  const bus = businessUnitsFor(user, businessUnitId);
  const inactive = await inactiveApproverEmployeeIds(db, user.role);
  return {
    businessUnitId: { in: bus },
    OR: [{ approverEmployeeId: user.employeeId }, ...(inactive.length ? [{ approverRole: user.role, approverEmployeeId: { in: inactive } }] : [])],
  };
}

export async function listApprovals(user: AuthUser, state: 'PENDING_APPROVAL' | 'APPROVED' | 'REJECTED', businessUnitId?: string) {
  const rows = await prisma.attendanceMark.findMany({
    where: { ...(await routedTo(prisma, user, businessUnitId)), approvalState: state, source: 'SELF' },
    include: markInclude,
    orderBy: [{ date: 'desc' }, { markedAt: 'asc' }],
    take: 500,
  });
  return { items: await toMarkItems(prisma, user, rows) };
}

async function decideMark(user: AuthUser, id: string, decision: 'APPROVED' | 'REJECTED', reason: string | null, ctx: RequestContext) {
  const mark = await prisma.$transaction(async (tx) => {
    await tx.$queryRaw`SELECT id FROM attendance_marks WHERE id = ${id}::uuid FOR UPDATE`;
    const before = await tx.attendanceMark.findUnique({ where: { id } });
    if (!before || !(await canDecide(tx, user, before))) throw Errors.notFound('Attendance mark');
    if (before.approvalState !== 'PENDING_APPROVAL') throw Errors.conflict('ALREADY_DECIDED', `This mark is already ${before.approvalState.toLowerCase()}`);
    const after = await tx.attendanceMark.update({
      where: { id },
      data: { approvalState: decision, decidedById: user.id, decidedAt: new Date(), rejectionReason: decision === 'REJECTED' ? reason : null },
    });
    await audit.record(tx, ctx, { action: decision === 'APPROVED' ? 'attendance.approve' : 'attendance.reject', entityType: 'AttendanceMark', entityId: id, before, after });
    return after;
  });
  await notify([await userIdOfEmployee(prisma, mark.employeeId)], {
    type: decision === 'APPROVED' ? 'ATTENDANCE_APPROVED' : 'ATTENDANCE_REJECTED',
    title: decision === 'APPROVED' ? 'Attendance approved' : 'Attendance rejected',
    body: `${fromDbDate(mark.date)}: ${mark.status.replace(/_/g, ' ').toLowerCase()}${reason ? ` — ${reason}` : ''}`,
    entityType: 'ATTENDANCE',
    entityId: mark.id,
    businessUnitId: mark.businessUnitId,
  });
  return (await toMarkItems(prisma, user, [await prisma.attendanceMark.findUniqueOrThrow({ where: { id }, include: markInclude })]))[0]!;
}

export const approveMark = (user: AuthUser, id: string, ctx: RequestContext) => decideMark(user, id, 'APPROVED', null, ctx);
export const rejectMark = (user: AuthUser, id: string, reason: string, ctx: RequestContext) => decideMark(user, id, 'REJECTED', reason, ctx);

export async function bulkApprove(user: AuthUser, ids: string[], ctx: RequestContext) {
  const approved: string[] = [];
  const skipped: { id: string; reason: string }[] = [];
  for (const id of [...new Set(ids)]) {
    try {
      await approveMark(user, id, ctx);
      approved.push(id);
    } catch (err) {
      skipped.push({ id, reason: err instanceof AppError ? err.code : 'ERROR' });
      if (!(err instanceof AppError)) logger.error({ err, id }, 'bulk approve failed');
    }
  }
  return { approved, skipped };
}

// ───────────────────────────── Read-only views ─────────────────────────────

/** Marks in the caller's scope (§11: RM self + team, OM self + RMs + their teams, HR / director all). */
export async function listMarks(user: AuthUser, q: z.infer<typeof MarksQuery>) {
  if (q.to < q.from) throw Errors.validation([{ path: ['to'], message: 'to is before from' }]);
  const scope = await scopeFor(prisma, user, 'attendance', q.businessUnitId);
  const rows = await prisma.attendanceMark.findMany({
    where: { ...recordWhere(scope), date: { gte: toDbDate(q.from), lte: toDbDate(q.to) }, ...(q.employeeId ? { employeeId: q.employeeId } : {}) },
    include: markInclude,
    orderBy: [{ date: 'desc' }, { employee: { fullName: 'asc' } }],
    take: 2000,
  });
  return { items: await toMarkItems(prisma, user, rows) };
}

// ───────────────────────────── Corrections ─────────────────────────────

type CorrectionRow = Prisma.AttendanceCorrectionGetPayload<object>;

async function toCorrectionItems(db: Db, user: AuthUser, rows: CorrectionRow[]) {
  const employees = await db.employee.findMany({
    where: { id: { in: rows.map((r) => r.employeeId) } },
    select: { id: true, empCode: true, fullName: true, category: true, user: { select: { role: true } } },
  });
  const emp = new Map(employees.map((e) => [e.id, employeeRef(e)]));
  const [bus, names, refs, inactive] = await Promise.all([
    buRefs(db, rows.map((r) => r.businessUnitId)),
    userNames(db, rows.map((r) => r.raisedById)),
    personRefs(db, rows.map((r) => r.approverEmployeeId)),
    inactiveApproverEmployeeIds(db, user.role),
  ]);
  return rows.map((c) => ({
    id: c.id,
    employee: emp.get(c.employeeId)!,
    businessUnit: bus.get(c.businessUnitId)!,
    date: fromDbDate(c.date),
    fromStatus: c.fromStatus,
    toStatus: c.toStatus,
    reason: c.reason,
    status: c.status,
    raisedByName: names.get(c.raisedById) ?? 'Unknown',
    approver: refs.get(c.approverEmployeeId) ?? null,
    decidedAt: c.decidedAt?.toISOString() ?? null,
    rejectionReason: c.rejectionReason,
    canDecide:
      c.status === 'PENDING' &&
      (c.approverEmployeeId === user.employeeId || (c.approverRole === user.role && user.businessUnitIds.includes(c.businessUnitId) && inactive.includes(c.approverEmployeeId))),
    createdAt: c.createdAt.toISOString(),
  }));
}

/**
 * A change after the edit window, or to an approved self-mark (§4.1). Raised by the person themself or (RM) for
 * a driver / loadman reporting to them; approved by the raiser's reporting-to (the next role up).
 */
export async function requestCorrection(user: AuthUser, body: z.infer<typeof CorrectionBody>, ctx: RequestContext) {
  if (body.date > todayIst()) throw Errors.validation([{ path: ['date'], message: 'Future date' }]);
  const self = body.employeeId === user.employeeId;
  if (!self) {
    const team = await teamOf(prisma, user, body.date, user.businessUnitIds);
    if (!team.some((e) => e.id === body.employeeId)) throw Errors.notFound('Employee');
  } else if (user.role === 'DIRECTOR') {
    throw new AppError('NOT_TRACKED', 422, "The director's attendance is not tracked");
  }
  const current = await prisma.attendanceMark.findUnique({ where: { employeeId_date: { employeeId: body.employeeId, date: toDbDate(body.date) } } });
  const open = (await editWindow(body.date)).editable;
  if (open && !(self && current?.approvalState === 'APPROVED')) {
    throw Errors.conflict('EDIT_WINDOW_OPEN', 'The edit window is still open; change the mark directly');
  }
  const businessUnitId = await primaryBusinessUnitOf(prisma, body.employeeId);
  const approver = await resolveApprover(prisma, user.employeeId, businessUnitId, body.date);
  const correction = await prisma.$transaction(async (tx) => {
    const pending = await tx.attendanceCorrection.findFirst({ where: { employeeId: body.employeeId, date: toDbDate(body.date), status: 'PENDING' } });
    if (pending) throw Errors.conflict('CORRECTION_PENDING', 'A correction for this day is already pending', { correctionId: pending.id });
    const c = await tx.attendanceCorrection.create({
      data: {
        employeeId: body.employeeId,
        businessUnitId,
        date: toDbDate(body.date),
        fromStatus: current?.status ?? null,
        toStatus: body.status,
        note: body.note ?? null,
        reason: body.reason,
        raisedById: user.id,
        approverEmployeeId: approver.employeeId,
        approverRole: approver.role,
      },
    });
    await audit.record(tx, ctx, { action: 'attendanceCorrection.create', entityType: 'AttendanceCorrection', entityId: c.id, after: c });
    return c;
  });
  await notify(
    [approver.userId, ...(approver.fallback ? await directorsOf(prisma) : [])],
    {
      type: 'CORRECTION_SUBMITTED',
      title: 'Attendance correction to approve',
      body: `${body.date}: ${current?.status ?? 'unmarked'} → ${body.status} — ${body.reason}`,
      entityType: 'CORRECTION',
      entityId: correction.id,
      businessUnitId,
    },
    user.id,
  );
  return (await toCorrectionItems(prisma, user, [correction]))[0]!;
}

export async function listCorrections(user: AuthUser, q: z.infer<typeof CorrectionQuery>) {
  const where: Prisma.AttendanceCorrectionWhereInput =
    q.scope === 'approvals'
      ? { ...(await routedTo(prisma, user, q.businessUnitId)), ...(q.status ? { status: q.status } : { status: 'PENDING' }) }
      : { raisedById: user.id, businessUnitId: { in: businessUnitsFor(user, q.businessUnitId) }, ...(q.status ? { status: q.status } : {}) };
  const rows = await prisma.attendanceCorrection.findMany({ where, orderBy: { createdAt: 'desc' }, take: 500 });
  return { items: await toCorrectionItems(prisma, user, rows) };
}

async function decideCorrection(user: AuthUser, id: string, decision: 'APPROVED' | 'REJECTED', reason: string | null, ctx: RequestContext) {
  const c = await prisma.$transaction(async (tx) => {
    await tx.$queryRaw`SELECT id FROM attendance_corrections WHERE id = ${id}::uuid FOR UPDATE`;
    const before = await tx.attendanceCorrection.findUnique({ where: { id } });
    if (!before || !(await canDecide(tx, user, before))) throw Errors.notFound('Correction');
    if (before.status !== 'PENDING') throw Errors.conflict('ALREADY_DECIDED', `This correction is already ${before.status.toLowerCase()}`);
    const after = await tx.attendanceCorrection.update({
      where: { id },
      data: { status: decision, decidedById: user.id, decidedAt: new Date(), rejectionReason: decision === 'REJECTED' ? reason : null },
    });
    if (decision === 'APPROVED') {
      await upsertMark(
        tx,
        {
          employeeId: before.employeeId,
          businessUnitId: before.businessUnitId,
          date: fromDbDate(before.date),
          status: before.toStatus,
          approvalState: 'APPROVED',
          source: 'SYSTEM',
          note: before.note ?? `Correction: ${before.reason}`,
          markedById: before.raisedById,
          approver: { employeeId: before.approverEmployeeId, role: before.approverRole },
          decidedById: user.id,
        },
        ctx,
        'attendance.correction.apply',
      );
    }
    await audit.record(tx, ctx, { action: decision === 'APPROVED' ? 'attendanceCorrection.approve' : 'attendanceCorrection.reject', entityType: 'AttendanceCorrection', entityId: id, before, after });
    return after;
  });
  await notify([c.raisedById], {
    type: decision === 'APPROVED' ? 'CORRECTION_APPROVED' : 'CORRECTION_REJECTED',
    title: decision === 'APPROVED' ? 'Correction approved' : 'Correction rejected',
    body: `${fromDbDate(c.date)}: ${c.toStatus.replace(/_/g, ' ').toLowerCase()}${reason ? ` — ${reason}` : ''}`,
    entityType: 'CORRECTION',
    entityId: c.id,
    businessUnitId: c.businessUnitId,
  });
  return (await toCorrectionItems(prisma, user, [c]))[0]!;
}

export const approveCorrection = (user: AuthUser, id: string, ctx: RequestContext) => decideCorrection(user, id, 'APPROVED', null, ctx);
export const rejectCorrection = (user: AuthUser, id: string, reason: string, ctx: RequestContext) => decideCorrection(user, id, 'REJECTED', reason, ctx);

