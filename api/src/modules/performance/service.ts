import type { z } from 'zod';
import { addDays, dayOfWeek, fromDbDate, todayIst, toDbDate } from '../../lib/dates.js';
import { AppError, Errors } from '../../lib/errors.js';
import { prisma } from '../../lib/prisma.js';
import type { Db } from '../../lib/prisma.js';
import type { AuthUser, RequestContext } from '../../lib/context.js';
import type { Prisma } from '../../generated/prisma/client.js';
import type { Role } from '../../generated/prisma/enums.js';
import { businessUnitsFor } from '../access/scope.js';
import { audit } from '../audit/service.js';
import { notify, userIdOfEmployee } from '../notifications/service.js';
import { personRefs } from '../users/service.js';
import type {
  PerformanceMetricCreateBody,
  PerformanceMetricUpdateBody,
  PerformancePeopleQuery,
  PerformanceRatingCreateBody,
  PerformanceWeekBody,
} from './schemas.js';

/**
 * Performance (decision 2026-11-25): login users (RM / OM / HR) are rated 1–5 with a comment by HR or the
 * director at any time (every rating is kept); the director enters per-person weekly values for a
 * configurable list of metrics (seeded: Mileage, Employee count, Maintenance). Everyone sees their own on
 * My Profile. Records use the subject's primary business unit.
 *
 * Visibility: self; HR every rated person whose primary BU is one of theirs; the director everyone.
 * TODO(business): should an OM see their RMs' ratings / weekly values (and an HR rate other HRs)?
 * TODO(business): should HR also enter weekly values (today director only)?
 */

const RATED_ROLES: Role[] = ['REGIONAL_MANAGER', 'OPERATIONAL_MANAGER', 'HR'];

/** Monday (IST) of the week containing `date`. */
export function weekStartOf(date: string): string {
  return addDays(date, -((dayOfWeek(date) + 6) % 7));
}

// ───────────────────────────── Metrics ─────────────────────────────

type MetricRow = Prisma.PerformanceMetricGetPayload<object>;
const toMetric = (m: MetricRow) => ({ id: m.id, code: m.code, name: m.name, unit: m.unit, sortOrder: m.sortOrder, isActive: m.isActive });
const metricOrder: Prisma.PerformanceMetricOrderByWithRelationInput[] = [{ sortOrder: 'asc' }, { name: 'asc' }];

export async function listMetrics() {
  return { items: (await prisma.performanceMetric.findMany({ orderBy: metricOrder })).map(toMetric) };
}

export async function createMetric(body: z.infer<typeof PerformanceMetricCreateBody>, ctx: RequestContext) {
  return prisma.$transaction(async (tx) => {
    if (await tx.performanceMetric.findUnique({ where: { code: body.code } })) throw Errors.conflict('CODE_EXISTS', 'A metric with this code exists');
    const m = await tx.performanceMetric.create({ data: { ...body, unit: body.unit ?? null, createdById: ctx.user?.id ?? null } });
    await audit.record(tx, ctx, { action: 'performanceMetric.create', entityType: 'PerformanceMetric', entityId: m.id, after: m });
    return toMetric(m);
  });
}

export async function updateMetric(id: string, body: z.infer<typeof PerformanceMetricUpdateBody>, ctx: RequestContext) {
  return prisma.$transaction(async (tx) => {
    const before = await tx.performanceMetric.findUnique({ where: { id } });
    if (!before) throw Errors.notFound('Metric');
    const after = await tx.performanceMetric.update({ where: { id }, data: body });
    await audit.record(tx, ctx, { action: 'performanceMetric.update', entityType: 'PerformanceMetric', entityId: id, before, after });
    return toMetric(after);
  });
}

// ───────────────────────────── Subjects and permissions ─────────────────────────────

interface Subject {
  employeeId: string;
  role: Role;
  businessUnitId: string;
}

async function subjectOf(db: Db, employeeId: string): Promise<Subject | null> {
  const u = await db.user.findUnique({
    where: { employeeId },
    select: { role: true, employee: { select: { deletedAt: true, businessUnits: { select: { businessUnitId: true, isPrimary: true } } } } },
  });
  if (!u || !RATED_ROLES.includes(u.role) || u.employee.deletedAt) return null;
  const bus = u.employee.businessUnits;
  const primary = bus.find((b) => b.isPrimary)?.businessUnitId ?? bus[0]?.businessUnitId;
  return primary ? { employeeId, role: u.role, businessUnitId: primary } : null;
}

const canView = (user: AuthUser, s: Subject) =>
  s.employeeId === user.employeeId || user.role === 'DIRECTOR' || (user.role === 'HR' && user.businessUnitIds.includes(s.businessUnitId));

const canRate = (user: AuthUser, s: Subject) =>
  s.employeeId !== user.employeeId &&
  (user.role === 'DIRECTOR' || (user.role === 'HR' && s.role !== 'HR' && user.businessUnitIds.includes(s.businessUnitId)));

const canEnterMetrics = (user: AuthUser, s: Subject) => user.role === 'DIRECTOR' && s.employeeId !== user.employeeId;

/** The subject if the user may see them, else 404 (out-of-scope ids look missing). */
async function visibleSubject(user: AuthUser, employeeId: string): Promise<Subject> {
  const s = await subjectOf(prisma, employeeId);
  if (!s || !canView(user, s)) throw Errors.notFound('Person');
  return s;
}

// ───────────────────────────── Read ─────────────────────────────

type RatingRow = Prisma.PerformanceRatingGetPayload<object>;

async function toRatings(db: Db, rows: RatingRow[]) {
  const refs = await personRefs(db, rows.map((r) => r.ratedByEmployeeId));
  return rows.map((r) => ({ id: r.id, rating: r.rating, comment: r.comment, ratedBy: refs.get(r.ratedByEmployeeId)!, createdAt: r.createdAt.toISOString() }));
}

async function businessUnitRefs(db: Db, ids: string[]) {
  const rows = await db.businessUnit.findMany({ where: { id: { in: [...new Set(ids)] } }, select: { id: true, code: true, name: true } });
  return new Map(rows.map((b) => [b.id, b]));
}

export async function getSummary(user: AuthUser, employeeId: string, weeks: number) {
  const s = await visibleSubject(user, employeeId);
  const fromWeek = addDays(weekStartOf(todayIst()), -7 * (weeks - 1));
  const [ratingRows, valueRows, metrics, refs, bus] = await Promise.all([
    prisma.performanceRating.findMany({ where: { employeeId }, orderBy: [{ createdAt: 'desc' }, { id: 'desc' }], take: 50 }),
    prisma.performanceMetricValue.findMany({ where: { employeeId, weekStart: { gte: toDbDate(fromWeek) } }, orderBy: { weekStart: 'desc' } }),
    prisma.performanceMetric.findMany({ orderBy: metricOrder }),
    personRefs(prisma, [employeeId]),
    businessUnitRefs(prisma, [s.businessUnitId]),
  ]);
  const ratings = await toRatings(prisma, ratingRows);

  const byWeek = new Map<string, Map<string, number>>();
  for (const v of valueRows) {
    const w = fromDbDate(v.weekStart);
    if (!byWeek.has(w)) byWeek.set(w, new Map());
    byWeek.get(w)!.set(v.metricId, Number(v.value));
  }
  const weekList = [...byWeek].map(([weekStart, values]) => ({
    weekStart,
    // Active metrics always; an inactive one only where it still has a value.
    values: metrics
      .filter((m) => m.isActive || values.has(m.id))
      .map((m) => ({ metricId: m.id, code: m.code, name: m.name, unit: m.unit, value: values.get(m.id) ?? null })),
  }));

  return {
    person: refs.get(employeeId)!,
    businessUnit: bus.get(s.businessUnitId)!,
    latestRating: ratings[0] ?? null,
    ratings,
    weeks: weekList,
    canRate: canRate(user, s),
    canEnterMetrics: canEnterMetrics(user, s),
  };
}

/** HR / director: the people they can see (active RM / OM / HR logins), with their latest rating. */
export async function listPeople(user: AuthUser, q: z.infer<typeof PerformancePeopleQuery>) {
  if (user.role !== 'HR' && user.role !== 'DIRECTOR') throw Errors.forbidden('Only HR and the director can list ratings');
  const buIds = businessUnitsFor(user, q.businessUnitId);
  const users = await prisma.user.findMany({
    where: {
      role: { in: RATED_ROLES },
      isActive: true,
      employee: { deletedAt: null, businessUnits: { some: { isPrimary: true, businessUnitId: { in: buIds } } } },
    },
    select: { role: true, employeeId: true, employee: { select: { fullName: true, businessUnits: { where: { isPrimary: true }, select: { businessUnitId: true } } } } },
    orderBy: { employee: { fullName: 'asc' } },
  });
  const subjects: Subject[] = users.map((u) => ({ employeeId: u.employeeId, role: u.role, businessUnitId: u.employee.businessUnits[0]!.businessUnitId }));
  const ids = subjects.map((s) => s.employeeId);
  const [latest, weeks, refs, bus] = await Promise.all([
    prisma.performanceRating.findMany({ where: { employeeId: { in: ids } }, orderBy: [{ employeeId: 'asc' }, { createdAt: 'desc' }, { id: 'desc' }], distinct: ['employeeId'] }),
    prisma.performanceMetricValue.groupBy({ by: ['employeeId'], where: { employeeId: { in: ids } }, _max: { weekStart: true } }),
    personRefs(prisma, ids),
    businessUnitRefs(prisma, subjects.map((s) => s.businessUnitId)),
  ]);
  const ratingOf = new Map((await toRatings(prisma, latest)).map((r, i) => [latest[i]!.employeeId, r]));
  const weekOf = new Map(weeks.map((w) => [w.employeeId, w._max.weekStart]));
  return {
    items: subjects.map((s) => {
      const w = weekOf.get(s.employeeId);
      return {
        person: refs.get(s.employeeId)!,
        businessUnit: bus.get(s.businessUnitId)!,
        latestRating: ratingOf.get(s.employeeId) ?? null,
        lastWeekStart: w ? fromDbDate(w) : null,
        canRate: canRate(user, s),
        canEnterMetrics: canEnterMetrics(user, s),
      };
    }),
  };
}

// ───────────────────────────── Write ─────────────────────────────

export async function rate(user: AuthUser, employeeId: string, body: z.infer<typeof PerformanceRatingCreateBody>, ctx: RequestContext) {
  const s = await visibleSubject(user, employeeId);
  if (!canRate(user, s)) throw Errors.forbidden(s.employeeId === user.employeeId ? 'You cannot rate yourself' : 'You cannot rate this person');
  const row = await prisma.$transaction(async (tx) => {
    const r = await tx.performanceRating.create({
      data: { employeeId, businessUnitId: s.businessUnitId, rating: body.rating, comment: body.comment || null, ratedByEmployeeId: user.employeeId, ratedById: user.id },
    });
    await audit.record(tx, ctx, { action: 'performanceRating.create', entityType: 'PerformanceRating', entityId: r.id, after: r });
    return r;
  });
  await notify(
    [await userIdOfEmployee(prisma, employeeId)],
    {
      type: 'PERFORMANCE_RATED',
      title: 'New performance rating',
      body: `${'★'.repeat(body.rating)}${'☆'.repeat(5 - body.rating)}${body.comment ? ` — ${body.comment}` : ''}`,
      entityType: 'PERFORMANCE',
      entityId: employeeId,
      businessUnitId: s.businessUnitId,
    },
    user.id,
  );
  return (await toRatings(prisma, [row]))[0]!;
}

export async function putWeek(user: AuthUser, employeeId: string, weekStart: string, body: z.infer<typeof PerformanceWeekBody>, ctx: RequestContext, weeks = 12) {
  const s = await visibleSubject(user, employeeId);
  if (!canEnterMetrics(user, s)) throw Errors.forbidden('Only the director enters weekly values');
  if (dayOfWeek(weekStart) !== 1) throw Errors.validation([{ path: ['weekStart'], message: 'weekStart must be a Monday' }]);
  if (weekStart > weekStartOf(todayIst())) throw Errors.validation([{ path: ['weekStart'], message: 'Values cannot be entered for a future week' }]);
  const metricIds = [...new Set(body.values.map((v) => v.metricId))];
  if (metricIds.length !== body.values.length) throw Errors.validation([{ path: ['values'], message: 'Each metric at most once' }]);
  const metrics = await prisma.performanceMetric.findMany({ where: { id: { in: metricIds } } });
  const known = new Map(metrics.map((m) => [m.id, m]));
  const unknown = metricIds.filter((id) => !known.has(id));
  if (unknown.length) throw new AppError('UNKNOWN_METRIC', 422, 'Unknown metric', { metricIds: unknown });
  const inactive = body.values.filter((v) => v.value !== null && !known.get(v.metricId)!.isActive).map((v) => v.metricId);
  if (inactive.length) throw new AppError('METRIC_INACTIVE', 422, 'The metric is no longer active', { metricIds: inactive });

  const week = toDbDate(weekStart);
  await prisma.$transaction(async (tx) => {
    for (const v of body.values) {
      const key = { employeeId_metricId_weekStart: { employeeId, metricId: v.metricId, weekStart: week } };
      const before = await tx.performanceMetricValue.findUnique({ where: key });
      if (v.value === null) {
        if (!before) continue;
        await tx.performanceMetricValue.delete({ where: key });
        await audit.record(tx, ctx, { action: 'performanceMetricValue.delete', entityType: 'PerformanceMetricValue', entityId: before.id, before });
        continue;
      }
      if (before && Number(before.value) === v.value) continue;
      const after = await tx.performanceMetricValue.upsert({
        where: key,
        create: { employeeId, businessUnitId: s.businessUnitId, metricId: v.metricId, weekStart: week, value: v.value, enteredById: user.id },
        update: { value: v.value, enteredById: user.id },
      });
      await audit.record(tx, ctx, { action: before ? 'performanceMetricValue.update' : 'performanceMetricValue.create', entityType: 'PerformanceMetricValue', entityId: after.id, before, after });
    }
  });
  await notify(
    [await userIdOfEmployee(prisma, employeeId)],
    { type: 'PERFORMANCE_WEEK', title: 'Weekly performance updated', body: `Week of ${weekStart}`, entityType: 'PERFORMANCE', entityId: employeeId, businessUnitId: s.businessUnitId },
    user.id,
  );
  return getSummary(user, employeeId, weeks);
}
