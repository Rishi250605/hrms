import type { z } from 'zod';
import { addDays, fromDbDate, istDateOf, istInstant, istTimeOf, minutesBetween, todayIst, toDbDate } from '../../lib/dates.js';
import { AppError, Errors } from '../../lib/errors.js';
import { prisma } from '../../lib/prisma.js';
import type { Db, Tx } from '../../lib/prisma.js';
import type { AuthUser, RequestContext } from '../../lib/context.js';
import { assertDepotAccess, visibleEmployeeIds } from '../access/scope.js';
import type { Prisma } from '../../generated/prisma/client.js';
import type { AssignmentRole, EmployeeCategory } from '../../generated/prisma/enums.js';
import { audit } from '../audit/service.js';
import { complianceFor } from '../employees/compliance.js';
import { employeeIdsAtDepot, findEmployeeInScope, getJobAsOf } from '../employees/service.js';
import { assertRouteAtDepot } from '../fleet/service.js';
import { employeesOnLeave } from '../leave/service.js';
import { getSetting } from '../settings/service.js';
import { evaluateRules, overlappingDuties, RULE_ENFORCEMENT_KEY } from './rules.js';
import type { DutySpan, RuleViolation } from './rules.js';
import type { AssignmentCreateBody, DutyCreateBody, DutyUpdateBody, RosterCopyBody, SpareQuery } from './schemas.js';

type Warning = { code: 'DUTY_HOURS_EXCEEDED' | 'MIN_REST_VIOLATED' | 'NO_WEEKLY_OFF' | 'DOCUMENT_EXPIRING'; message: string };

const employeeSelect = { select: { id: true, empCode: true, fullName: true, category: true, phone: true } } as const;
const dutyInclude = {
  route: { select: { id: true, code: true, name: true } },
  vehicle: { select: { id: true, regNo: true, type: true } },
  template: { select: { id: true, name: true } },
  assignments: { include: { employee: employeeSelect }, orderBy: { createdAt: 'asc' } },
} satisfies Prisma.DutyInclude;
type DutyRow = Prisma.DutyGetPayload<{ include: typeof dutyInclude }>;

const warningsOf = (json: unknown): Warning[] => (Array.isArray(json) ? (json as Warning[]) : []);

export function toDutyItem(d: DutyRow) {
  const dutyDate = fromDbDate(d.dutyDate);
  return {
    id: d.id,
    depotId: d.depotId,
    dutyDate,
    status: d.status,
    scheduledStart: d.scheduledStart.toISOString(),
    scheduledEnd: d.scheduledEnd.toISOString(),
    startTime: istTimeOf(d.scheduledStart),
    endTime: istTimeOf(d.scheduledEnd),
    crossesMidnight: istDateOf(d.scheduledEnd) > dutyDate,
    durationMinutes: minutesBetween(d.scheduledStart, d.scheduledEnd),
    route: d.route,
    vehicle: d.vehicle,
    template: d.template,
    notes: d.notes,
    filled: d.assignments.some((a) => a.role === 'DRIVER'),
    assignments: d.assignments.map((a) => ({
      id: a.id,
      dutyId: a.dutyId,
      role: a.role,
      isSpare: a.isSpare,
      warnings: warningsOf(a.warnings),
      employee: a.employee,
    })),
  };
}

/** Wall-clock times on a business date → [start, end) instants (end on the next day when crossing midnight). */
function dutyWindow(date: string, startTime: string, endTime: string, crossesMidnight?: boolean) {
  if (startTime === endTime) throw Errors.validation([{ path: ['endTime'], message: 'End time equals start time' }]);
  const crosses = crossesMidnight ?? endTime < startTime;
  if (!crosses && endTime < startTime) throw Errors.validation([{ path: ['crossesMidnight'], message: 'End time is before start time' }]);
  return { start: istInstant(date, startTime), end: istInstant(crosses ? addDays(date, 1) : date, endTime) };
}

async function findDutyInScope(user: AuthUser, id: string, db: Db = prisma) {
  const duty = await db.duty.findUnique({ where: { id } });
  if (!duty) throw Errors.notFound('Duty');
  try {
    await assertDepotAccess(db, user, duty.depotId);
  } catch {
    throw Errors.notFound('Duty');
  }
  return duty;
}

async function assertVehicleFree(db: Db, vehicleId: string, depotId: string, start: Date, end: Date, exceptDutyId?: string) {
  const vehicle = await db.vehicle.findFirst({ where: { id: vehicleId, depotId, deletedAt: null } });
  if (!vehicle) throw Errors.validation([{ path: ['vehicleId'], message: 'Vehicle not found at this depot' }]);
  if (vehicle.status !== 'ACTIVE') throw Errors.conflict('VEHICLE_NOT_AVAILABLE', `Vehicle ${vehicle.regNo} is ${vehicle.status.toLowerCase().replace('_', ' ')}`);
  const clash = await db.duty.findFirst({
    where: { vehicleId, status: { not: 'CANCELLED' }, scheduledStart: { lt: end }, scheduledEnd: { gt: start }, ...(exceptDutyId ? { id: { not: exceptDutyId } } : {}) },
  });
  if (clash) throw Errors.conflict('VEHICLE_DOUBLE_BOOKED', `Vehicle ${vehicle.regNo} is already on another duty at that time`, { dutyId: clash.id });
}

// ───────────────────────────── Roster day ─────────────────────────────

export async function getRoster(user: AuthUser, depotId: string, date: string) {
  await assertDepotAccess(prisma, user, depotId);
  const [depot, duties] = await Promise.all([
    prisma.depot.findUniqueOrThrow({ where: { id: depotId }, select: { id: true, code: true, name: true } }),
    prisma.duty.findMany({ where: { depotId, dutyDate: toDbDate(date) }, include: dutyInclude, orderBy: [{ scheduledStart: 'asc' }, { id: 'asc' }] }),
  ]);
  const items = duties.map(toDutyItem);
  const active = items.filter((d) => d.status !== 'CANCELLED');
  return {
    date,
    depot,
    summary: {
      duties: active.length,
      filled: active.filter((d) => d.filled).length,
      unfilled: active.filter((d) => !d.filled).length,
      cancelled: items.length - active.length,
    },
    duties: items,
  };
}

export async function createDuty(user: AuthUser, body: z.infer<typeof DutyCreateBody>, ctx: RequestContext) {
  await assertDepotAccess(prisma, user, body.depotId);
  let { startTime, endTime, crossesMidnight, routeId } = body;
  if (body.templateId) {
    const t = await prisma.dutyTemplate.findFirst({ where: { id: body.templateId, depotId: body.depotId, deletedAt: null } });
    if (!t) throw Errors.validation([{ path: ['templateId'], message: 'Template not found at this depot' }]);
    startTime ??= t.startTime;
    endTime ??= t.endTime;
    crossesMidnight ??= t.crossesMidnight;
    routeId ??= t.routeId ?? undefined;
  }
  if (!startTime || !endTime) throw Errors.validation([{ path: ['startTime'], message: 'Give a template or start and end times' }]);
  const { start, end } = dutyWindow(body.dutyDate, startTime, endTime, crossesMidnight);
  if (routeId) await assertRouteAtDepot(prisma, routeId, body.depotId);
  if (body.vehicleId) await assertVehicleFree(prisma, body.vehicleId, body.depotId, start, end);

  const duty = await prisma.$transaction(async (tx) => {
    const created = await tx.duty.create({
      data: {
        depotId: body.depotId,
        dutyDate: toDbDate(body.dutyDate),
        templateId: body.templateId ?? null,
        routeId: routeId ?? null,
        vehicleId: body.vehicleId ?? null,
        scheduledStart: start,
        scheduledEnd: end,
        notes: body.notes ?? null,
        createdById: ctx.user?.id ?? null,
      },
      include: dutyInclude,
    });
    await audit.record(tx, ctx, { action: 'duty.create', entityType: 'Duty', entityId: created.id, after: created });
    return created;
  });
  return toDutyItem(duty);
}

export async function updateDuty(user: AuthUser, id: string, body: z.infer<typeof DutyUpdateBody>, ctx: RequestContext) {
  const before = await findDutyInScope(user, id);
  const date = fromDbDate(before.dutyDate);
  let start = before.scheduledStart;
  let end = before.scheduledEnd;
  if (body.startTime || body.endTime || body.crossesMidnight !== undefined) {
    ({ start, end } = dutyWindow(date, body.startTime ?? istTimeOf(before.scheduledStart), body.endTime ?? istTimeOf(before.scheduledEnd), body.crossesMidnight));
  }
  if (body.status === 'COMPLETED' && date > todayIst()) throw Errors.conflict('DUTY_IN_FUTURE', 'A future duty cannot be completed');
  if (body.routeId) await assertRouteAtDepot(prisma, body.routeId, before.depotId);
  const vehicleId = body.vehicleId !== undefined ? body.vehicleId : before.vehicleId;
  if (vehicleId && (body.vehicleId || start !== before.scheduledStart || end !== before.scheduledEnd) && body.status !== 'CANCELLED') {
    await assertVehicleFree(prisma, vehicleId, before.depotId, start, end, id);
  }
  const duty = await prisma.$transaction(async (tx) => {
    const after = await tx.duty.update({
      where: { id },
      data: {
        scheduledStart: start,
        scheduledEnd: end,
        ...(body.routeId !== undefined ? { routeId: body.routeId } : {}),
        ...(body.vehicleId !== undefined ? { vehicleId: body.vehicleId } : {}),
        ...(body.status ? { status: body.status } : {}),
        ...(body.notes !== undefined ? { notes: body.notes } : {}),
      },
      include: dutyInclude,
    });
    await audit.record(tx, ctx, { action: 'duty.update', entityType: 'Duty', entityId: id, before, after });
    return after;
  });
  return toDutyItem(duty);
}

// ───────────────────────────── Assignment checks ─────────────────────────────

async function loadRules(db: Db) {
  const [maxDutyMinutesPerDay, minRestMinutes, maxConsecutiveWorkDays, enforcement, roleCategories] = await Promise.all([
    getSetting('roster.maxDutyMinutesPerDay', db),
    getSetting('roster.minRestMinutes', db),
    getSetting('roster.maxConsecutiveWorkDays', db),
    getSetting('roster.enforcement', db),
    getSetting('roster.roleCategories', db),
  ]);
  return { limits: { maxDutyMinutesPerDay, minRestMinutes, maxConsecutiveWorkDays }, enforcement, roleCategories };
}
type Rules = Awaited<ReturnType<typeof loadRules>>;

/** The employee's non-cancelled duties within ±8 days of `date` (enough for the 7-day weekly-off window). */
async function dutySpans(db: Db, employeeIds: string[], date: string): Promise<Map<string, (DutySpan & { minutes: number })[]>> {
  const rows = await db.dutyAssignment.findMany({
    where: {
      employeeId: { in: employeeIds },
      duty: { status: { not: 'CANCELLED' }, dutyDate: { gte: toDbDate(addDays(date, -8)), lte: toDbDate(addDays(date, 8)) } },
    },
    select: { employeeId: true, duty: { select: { id: true, dutyDate: true, scheduledStart: true, scheduledEnd: true } } },
  });
  const map = new Map<string, (DutySpan & { minutes: number })[]>();
  for (const r of rows) {
    const span = {
      id: r.duty.id,
      dutyDate: fromDbDate(r.duty.dutyDate),
      start: r.duty.scheduledStart,
      end: r.duty.scheduledEnd,
      minutes: minutesBetween(r.duty.scheduledStart, r.duty.scheduledEnd),
    };
    map.set(r.employeeId, [...(map.get(r.employeeId) ?? []), span]);
  }
  return map;
}

const allowedFor = (rules: Rules, role: AssignmentRole): EmployeeCategory[] => rules.roleCategories[role] ?? [];

interface AssignCheck {
  error: AppError | null;
  warnings: Warning[];
}

/**
 * Every rule for putting `employeeId` on `duty` as `role` (CLAUDE.md §7). Hard failures come back as
 * an AppError (409); rule breaches set to WARN come back as warnings.
 */
async function checkAssignment(
  db: Db,
  duty: { id: string; depotId: string; dutyDate: Date; scheduledStart: Date; scheduledEnd: Date; status: string },
  employee: { id: string; status: string; category: EmployeeCategory },
  role: AssignmentRole,
  rules: Rules,
): Promise<AssignCheck> {
  const date = fromDbDate(duty.dutyDate);
  const fail = (code: string, message: string, details?: unknown): AssignCheck => ({ error: Errors.conflict(code, message, details), warnings: [] });

  if (duty.status === 'CANCELLED' || duty.status === 'COMPLETED') return fail('DUTY_CLOSED', `The duty is ${duty.status.toLowerCase()}`);
  if (employee.status === 'EXITED' || employee.status === 'SUSPENDED') return fail('EMPLOYEE_NOT_AVAILABLE', `The employee is ${employee.status.toLowerCase()}`);
  const job = await getJobAsOf(employee.id, date, db);
  // TODO(business): may an employee be borrowed from another depot for a duty?
  if (!job || job.depotId !== duty.depotId) return fail('EMPLOYEE_NOT_IN_DEPOT', 'The employee does not work at this depot on that date');
  if (!allowedFor(rules, role).includes(employee.category)) {
    return fail('ROLE_NOT_ALLOWED', `A ${employee.category.toLowerCase().replace('_', ' ')} cannot be assigned as ${role.toLowerCase().replace('_', ' ')}`);
  }
  if ((await employeesOnLeave(db, [employee.id], date)).has(employee.id)) return fail('EMPLOYEE_ON_LEAVE', 'The employee is on approved leave that day');

  const compliance = (await complianceFor(db, [employee], date)).get(employee.id)!;
  if (!compliance.rosterable) {
    return fail('DOCUMENT_INVALID', 'Required documents are missing, unverified or expired on the duty date', {
      failing: compliance.items.filter((i) => i.state !== 'VALID' && i.state !== 'EXPIRING'),
    });
  }

  const candidate: DutySpan = { id: duty.id, dutyDate: date, start: duty.scheduledStart, end: duty.scheduledEnd };
  const others = (await dutySpans(db, [employee.id], date)).get(employee.id) ?? [];
  const clash = overlappingDuties(candidate, others);
  if (clash.length > 0) return fail('EMPLOYEE_DOUBLE_BOOKED', 'The employee is already on another duty at that time', { dutyIds: clash.map((c) => c.id) });

  const violations = evaluateRules(candidate, others, rules.limits);
  const blocking = violations.filter((v) => rules.enforcement[RULE_ENFORCEMENT_KEY[v.code]] === 'BLOCK');
  if (blocking.length > 0) return fail('ROSTER_RULE_VIOLATION', blocking.map((v) => v.message).join('; '), { violations: blocking });

  const warnings: Warning[] = violations.map((v: RuleViolation) => ({ code: v.code, message: v.message }));
  for (const item of compliance.items.filter((i) => i.state === 'EXPIRING')) {
    warnings.push({ code: 'DOCUMENT_EXPIRING', message: `${item.type.replace(/_/g, ' ').toLowerCase()} expires on ${item.expiryDate}` });
  }
  return { error: null, warnings };
}

async function lockEmployee(tx: Tx, id: string) {
  await tx.$queryRaw`SELECT id FROM employees WHERE id = ${id}::uuid FOR UPDATE`;
}

export async function addAssignment(user: AuthUser, dutyId: string, body: z.infer<typeof AssignmentCreateBody>, ctx: RequestContext) {
  const duty = await findDutyInScope(user, dutyId);
  await findEmployeeInScope(prisma, user, body.employeeId, 'roster');
  const rules = await loadRules(prisma);

  const result = await prisma.$transaction(async (tx) => {
    // Serialise assignments per employee so two managers cannot double-book them concurrently.
    await lockEmployee(tx, body.employeeId);
    const employee = await tx.employee.findUniqueOrThrow({ where: { id: body.employeeId } });
    if (await tx.dutyAssignment.findUnique({ where: { dutyId_employeeId: { dutyId, employeeId: body.employeeId } } })) {
      throw Errors.conflict('ALREADY_ASSIGNED', 'The employee is already on this duty');
    }
    const check = await checkAssignment(tx, duty, employee, body.role, rules);
    if (check.error) return { ok: false as const, error: check.error };
    const created = await tx.dutyAssignment.create({
      data: {
        dutyId,
        employeeId: body.employeeId,
        role: body.role,
        isSpare: body.isSpare,
        warnings: check.warnings as unknown as Prisma.InputJsonValue,
        createdById: ctx.user?.id ?? null,
      },
      include: { employee: employeeSelect },
    });
    await audit.record(tx, ctx, { action: 'dutyAssignment.create', entityType: 'DutyAssignment', entityId: created.id, after: created });
    return { ok: true as const, created, warnings: check.warnings };
  });

  if (!result.ok) {
    // Suggest spares from the same depot pool alongside a document failure (CLAUDE.md §7).
    if (result.error.code === 'DOCUMENT_INVALID') {
      const spares = await getSpares(user, { depotId: duty.depotId, date: fromDbDate(duty.dutyDate), role: body.role, dutyId });
      throw new AppError(result.error.code, 409, result.error.message, { ...(result.error.details as object), spares: spares.items.slice(0, 5) });
    }
    throw result.error;
  }
  const fresh = await prisma.duty.findUniqueOrThrow({ where: { id: dutyId }, include: dutyInclude });
  const item = toDutyItem(fresh);
  return { assignment: item.assignments.find((a) => a.id === result.created.id)!, warnings: result.warnings, duty: item };
}

export async function removeAssignment(user: AuthUser, assignmentId: string, ctx: RequestContext) {
  const a = await prisma.dutyAssignment.findUnique({ where: { id: assignmentId } });
  if (!a) throw Errors.notFound('Assignment');
  const duty = await findDutyInScope(user, a.dutyId).catch(() => {
    throw Errors.notFound('Assignment');
  });
  if (duty.status === 'COMPLETED') throw Errors.conflict('DUTY_CLOSED', 'The duty is completed');
  await prisma.$transaction(async (tx) => {
    await tx.dutyAssignment.delete({ where: { id: assignmentId } });
    await audit.record(tx, ctx, { action: 'dutyAssignment.delete', entityType: 'DutyAssignment', entityId: assignmentId, before: a });
  });
}

// ───────────────────────────── Spares ─────────────────────────────

/**
 * Employees of the depot pool who could take a duty on `date` as `role`: right category, active, documents
 * valid on the date, not on leave and (with dutyId) free at that time. Least-worked first.
 */
export async function getSpares(user: AuthUser, q: z.infer<typeof SpareQuery>) {
  await assertDepotAccess(prisma, user, q.depotId);
  const rules = await loadRules(prisma);
  const duty = q.dutyId ? await findDutyInScope(user, q.dutyId) : null;
  if (duty && duty.depotId !== q.depotId) throw Errors.validation([{ path: ['dutyId'], message: 'Duty is at another depot' }]);

  // Only staff the user may roster (RM: their team; OM: their RMs' teams; HR / director: everyone).
  const visible = await visibleEmployeeIds(prisma, user, 'roster', q.date);
  const ids = (await employeeIdsAtDepot(q.depotId, q.date)).filter((id) => !visible || visible.includes(id));
  const employees = await prisma.employee.findMany({
    where: { id: { in: ids }, deletedAt: null, status: { in: ['ACTIVE', 'ON_NOTICE'] }, category: { in: allowedFor(rules, q.role) } },
    select: { id: true, empCode: true, fullName: true, category: true, phone: true, jobs: { orderBy: { effectiveFrom: 'desc' }, take: 1, select: { designation: true } } },
  });
  const [compliance, onLeave, spans] = await Promise.all([
    complianceFor(prisma, employees, q.date),
    employeesOnLeave(prisma, employees.map((e) => e.id), q.date),
    dutySpans(prisma, employees.map((e) => e.id), q.date),
  ]);
  const candidate: DutySpan | null = duty ? { id: duty.id, dutyDate: q.date, start: duty.scheduledStart, end: duty.scheduledEnd } : null;

  const items = employees.flatMap((e) => {
    const c = compliance.get(e.id)!;
    if (!c.rosterable || onLeave.has(e.id)) return [];
    const mine = spans.get(e.id) ?? [];
    if (candidate && (mine.some((s) => s.id === candidate.id) || overlappingDuties(candidate, mine).length > 0)) return [];
    const dutiesOnDate = mine.filter((s) => s.dutyDate === q.date).length;
    if (!candidate && dutiesOnDate > 0) return [];
    const minutes = mine.filter((s) => s.dutyDate >= addDays(q.date, -7) && s.dutyDate < q.date).reduce((sum, s) => sum + s.minutes, 0);
    const warnings = candidate ? evaluateRules(candidate, mine, rules.limits).map((v) => ({ code: v.code, message: v.message })) : [];
    const { jobs, ...employee } = e;
    return [{ employee, designation: jobs[0]?.designation ?? null, compliance: c.overall, dutyMinutesLast7Days: minutes, dutiesOnDate, warnings }];
  });
  items.sort(
    (a, b) =>
      a.dutiesOnDate - b.dutiesOnDate ||
      a.warnings.length - b.warnings.length ||
      a.dutyMinutesLast7Days - b.dutyMinutesLast7Days ||
      a.employee.fullName.localeCompare(b.employee.fullName),
  );
  return { items };
}

// ───────────────────────────── Copy day / week ─────────────────────────────

/**
 * Copies duties of `days` days starting `fromDate` to the same weekday offsets from `toDate`. A source duty
 * already copied (same template, route and start time on the target day) is not duplicated. Assignments go
 * through the full assignment checks; failures are reported, never forced.
 */
export async function copyRoster(user: AuthUser, body: z.infer<typeof RosterCopyBody>, ctx: RequestContext) {
  await assertDepotAccess(prisma, user, body.depotId);
  if (body.toDate < addDays(body.fromDate, body.days)) {
    throw Errors.validation([{ path: ['toDate'], message: 'Target days must start after the source days end' }]);
  }
  const rules = await loadRules(prisma);
  const result = { createdDuties: 0, existingDuties: 0, copiedAssignments: 0, skipped: [] as { date: string; employeeId: string; employeeName: string; reason: string }[] };

  for (let i = 0; i < body.days; i++) {
    const from = addDays(body.fromDate, i);
    const to = addDays(body.toDate, i);
    const shiftMs = toDbDate(to).getTime() - toDbDate(from).getTime();
    const sources = await prisma.duty.findMany({
      where: { depotId: body.depotId, dutyDate: toDbDate(from), status: { not: 'CANCELLED' } },
      include: { assignments: { include: { employee: true } } },
      orderBy: { scheduledStart: 'asc' },
    });
    for (const src of sources) {
      const start = new Date(src.scheduledStart.getTime() + shiftMs);
      const end = new Date(src.scheduledEnd.getTime() + shiftMs);
      const existing = await prisma.duty.findFirst({
        where: { depotId: body.depotId, dutyDate: toDbDate(to), scheduledStart: start, templateId: src.templateId, routeId: src.routeId, status: { not: 'CANCELLED' } },
      });
      if (existing) {
        result.existingDuties += 1;
        continue;
      }
      // Keep the vehicle only if it is still active and free.
      let vehicleId = src.vehicleId;
      if (vehicleId) {
        try {
          await assertVehicleFree(prisma, vehicleId, body.depotId, start, end);
        } catch {
          vehicleId = null;
        }
      }
      const duty = await prisma.$transaction(async (tx) => {
        const created = await tx.duty.create({
          data: {
            depotId: body.depotId,
            dutyDate: toDbDate(to),
            templateId: src.templateId,
            routeId: src.routeId,
            vehicleId,
            scheduledStart: start,
            scheduledEnd: end,
            notes: src.notes,
            createdById: ctx.user?.id ?? null,
          },
        });
        await audit.record(tx, ctx, { action: 'duty.create', entityType: 'Duty', entityId: created.id, after: { ...created, copiedFrom: src.id } });
        return created;
      });
      result.createdDuties += 1;
      if (!body.includeAssignments) continue;

      for (const a of src.assignments) {
        const outcome = await prisma.$transaction(async (tx) => {
          await lockEmployee(tx, a.employeeId);
          const employee = await tx.employee.findUniqueOrThrow({ where: { id: a.employeeId } });
          const check = await checkAssignment(tx, duty, employee, a.role, rules);
          if (check.error) return check.error.code;
          const created = await tx.dutyAssignment.create({
            data: {
              dutyId: duty.id,
              employeeId: a.employeeId,
              role: a.role,
              isSpare: a.isSpare,
              warnings: check.warnings as unknown as Prisma.InputJsonValue,
              createdById: ctx.user?.id ?? null,
            },
          });
          await audit.record(tx, ctx, { action: 'dutyAssignment.create', entityType: 'DutyAssignment', entityId: created.id, after: created });
          return null;
        });
        if (outcome) result.skipped.push({ date: to, employeeId: a.employeeId, employeeName: a.employee.fullName, reason: outcome });
        else result.copiedAssignments += 1;
      }
    }
  }
  return result;
}
