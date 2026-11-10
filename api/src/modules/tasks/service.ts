import { randomUUID } from 'node:crypto';
import type { z } from 'zod';
import { addDays, fromDbDate, todayIst, toDbDate } from '../../lib/dates.js';
import { AppError, Errors } from '../../lib/errors.js';
import { prisma } from '../../lib/prisma.js';
import type { Db } from '../../lib/prisma.js';
import type { AuthUser, RequestContext } from '../../lib/context.js';
import type { Prisma } from '../../generated/prisma/client.js';
import { descendantsOf } from '../access/hierarchy.js';
import { businessUnitsFor } from '../access/scope.js';
import { audit } from '../audit/service.js';
import { hrOf, notify, userIdOfEmployee } from '../notifications/service.js';
import { personRefs } from '../users/service.js';
import type { TaskCreateBody, TaskQuery, TaskSubmitBody } from './schemas.js';

/**
 * Daily tasks (PHASE-2-FEATURES §8): an OM allots tasks to RMs reporting to them; the RM submits
 * Completed / Not done once; the OM may reopen. Visibility (§11): RM assigned to them, OM allotted by
 * them, HR / director all in their business units.
 */

/** TODO(business): how far ahead an OM may allot tasks. */
const MAX_DAYS_AHEAD = 60;

type Row = Prisma.TaskGetPayload<object>;

async function toItems(db: Db, user: AuthUser, rows: Row[]) {
  const today = todayIst();
  const [refs, bus] = await Promise.all([
    personRefs(db, rows.flatMap((r) => [r.allottedByEmployeeId, r.assigneeEmployeeId])),
    db.businessUnit.findMany({ where: { id: { in: rows.map((r) => r.businessUnitId) } }, select: { id: true, code: true, name: true } }),
  ]);
  const bu = new Map(bus.map((b) => [b.id, b]));
  return rows.map((r) => {
    const date = fromDbDate(r.date);
    return {
      id: r.id,
      groupId: r.groupId,
      date,
      businessUnit: bu.get(r.businessUnitId)!,
      title: r.title,
      details: r.details,
      priority: r.priority,
      allottedBy: refs.get(r.allottedByEmployeeId)!,
      assignee: refs.get(r.assigneeEmployeeId)!,
      status: r.status,
      overdue: r.status === 'PENDING' && date < today,
      reason: r.reason,
      comment: r.comment,
      submittedAt: r.submittedAt?.toISOString() ?? null,
      reopenedAt: r.reopenedAt?.toISOString() ?? null,
      reopenComment: r.reopenComment,
      reopenCount: r.reopenCount,
      canSubmit: r.status === 'PENDING' && r.assigneeEmployeeId === user.employeeId,
      canReopen: r.status !== 'PENDING' && r.allottedByEmployeeId === user.employeeId,
      createdAt: r.createdAt.toISOString(),
    };
  });
}

export async function createTasks(user: AuthUser, body: z.infer<typeof TaskCreateBody>, ctx: RequestContext) {
  const today = todayIst();
  const date = body.date ?? today;
  if (date < today) throw Errors.validation([{ path: ['date'], message: 'Tasks cannot be allotted for a past date' }]);
  if (date > addDays(today, MAX_DAYS_AHEAD)) throw Errors.validation([{ path: ['date'], message: `At most ${MAX_DAYS_AHEAD} days ahead` }]);
  businessUnitsFor(user, body.businessUnitId);

  const assignees = [...new Set(body.assigneeEmployeeIds)];
  const direct = await descendantsOf(prisma, user.employeeId, 1);
  const rms = await prisma.user.findMany({
    where: {
      employeeId: { in: assignees.filter((a) => direct.has(a)) },
      role: 'REGIONAL_MANAGER',
      isActive: true,
      employee: { businessUnits: { some: { businessUnitId: body.businessUnitId } } },
    },
    select: { id: true, employeeId: true },
  });
  const ok = new Map(rms.map((u) => [u.employeeId, u.id]));
  const bad = assignees.filter((a) => !ok.has(a));
  if (bad.length) throw new AppError('FORBIDDEN', 403, 'Tasks can be allotted only to active RMs reporting to you in this business unit', { employeeIds: bad });

  const groupId = randomUUID();
  const created = await prisma.$transaction(async (tx) => {
    const rows: Row[] = [];
    for (const assigneeEmployeeId of assignees) {
      const t = await tx.task.create({
        data: {
          groupId,
          date: toDbDate(date),
          businessUnitId: body.businessUnitId,
          title: body.title,
          details: body.details ?? null,
          priority: body.priority ?? 'NORMAL',
          allottedByEmployeeId: user.employeeId,
          allottedById: user.id,
          assigneeEmployeeId,
        },
      });
      await audit.record(tx, ctx, { action: 'task.create', entityType: 'Task', entityId: t.id, after: t });
      rows.push(t);
    }
    return rows;
  });
  for (const t of created) {
    await notify(
      [ok.get(t.assigneeEmployeeId)],
      {
        type: 'TASK_ALLOTTED',
        title: body.priority === 'HIGH' ? 'High-priority task' : 'New task',
        body: `${body.title} — ${date === today ? 'today' : date}`,
        entityType: 'TASK',
        entityId: t.id,
        businessUnitId: t.businessUnitId,
      },
      user.id,
    );
  }
  return { items: await toItems(prisma, user, created) };
}

async function lockTask(db: Db, id: string) {
  await db.$queryRaw`SELECT id FROM tasks WHERE id = ${id}::uuid FOR UPDATE`;
  return db.task.findUnique({ where: { id } });
}

export async function submitTask(user: AuthUser, id: string, body: z.infer<typeof TaskSubmitBody>, ctx: RequestContext) {
  if (body.status === 'NOT_DONE' && !body.reason) throw Errors.validation([{ path: ['reason'], message: 'Give a reason when the task was not done' }]);
  const after = await prisma.$transaction(async (tx) => {
    const t = await lockTask(tx, id);
    if (!t || t.assigneeEmployeeId !== user.employeeId || !user.businessUnitIds.includes(t.businessUnitId)) throw Errors.notFound('Task');
    if (t.status !== 'PENDING') throw Errors.conflict('ALREADY_SUBMITTED', 'The task is already submitted; ask your OM to reopen it');
    const updated = await tx.task.update({
      where: { id },
      data: { status: body.status, reason: body.status === 'NOT_DONE' ? body.reason! : (body.reason ?? null), comment: body.comment ?? null, submittedAt: new Date() },
    });
    await audit.record(tx, ctx, { action: 'task.submit', entityType: 'Task', entityId: id, before: t, after: updated });
    return updated;
  });
  // §10: OM and HR.
  await notify(
    [await userIdOfEmployee(prisma, after.allottedByEmployeeId), ...(await hrOf(prisma, after.businessUnitId))],
    {
      type: 'TASK_SUBMITTED',
      title: after.status === 'COMPLETED' ? 'Task completed' : 'Task not done',
      body: `${user.name}: ${after.title}${after.status === 'NOT_DONE' ? ` — ${after.reason}` : ''}`,
      entityType: 'TASK',
      entityId: id,
      businessUnitId: after.businessUnitId,
    },
    user.id,
  );
  return (await toItems(prisma, user, [after]))[0]!;
}

export async function reopenTask(user: AuthUser, id: string, comment: string, ctx: RequestContext) {
  const after = await prisma.$transaction(async (tx) => {
    const t = await lockTask(tx, id);
    if (!t || t.allottedByEmployeeId !== user.employeeId || !user.businessUnitIds.includes(t.businessUnitId)) throw Errors.notFound('Task');
    if (t.status === 'PENDING') throw Errors.conflict('NOT_SUBMITTED', 'The task has not been submitted yet');
    const updated = await tx.task.update({
      where: { id },
      data: { status: 'PENDING', submittedAt: null, reopenedAt: new Date(), reopenComment: comment, reopenCount: { increment: 1 } },
    });
    await audit.record(tx, ctx, { action: 'task.reopen', entityType: 'Task', entityId: id, before: t, after: updated });
    return updated;
  });
  await notify(
    [await userIdOfEmployee(prisma, after.assigneeEmployeeId)],
    { type: 'TASK_REOPENED', title: 'Task reopened', body: `${after.title} — ${comment}`, entityType: 'TASK', entityId: id, businessUnitId: after.businessUnitId },
    user.id,
  );
  return (await toItems(prisma, user, [after]))[0]!;
}

export async function listTasks(user: AuthUser, q: z.infer<typeof TaskQuery>) {
  const today = toDbDate(todayIst());
  const and: Prisma.TaskWhereInput[] = [{ businessUnitId: { in: businessUnitsFor(user, q.businessUnitId) } }];
  if (q.scope === 'assigned') and.push({ assigneeEmployeeId: user.employeeId });
  else if (q.scope === 'allotted') and.push({ allottedByEmployeeId: user.employeeId });
  else if (user.role !== 'HR' && user.role !== 'DIRECTOR') throw Errors.forbidden('Only HR and the director can see all tasks');
  if (q.state === 'open') and.push({ status: 'PENDING' });
  if (q.state === 'submitted') and.push({ status: { in: ['COMPLETED', 'NOT_DONE'] } });
  if (q.status) and.push({ status: q.status });
  if (q.overdue === true) and.push({ status: 'PENDING', date: { lt: today } });
  if (q.overdue === false) and.push({ NOT: { status: 'PENDING', date: { lt: today } } });
  if (q.date) and.push({ date: toDbDate(q.date) });
  if (q.from) and.push({ date: { gte: toDbDate(q.from) } });
  if (q.to) and.push({ date: { lte: toDbDate(q.to) } });
  if (q.assigneeEmployeeId) and.push({ assigneeEmployeeId: q.assigneeEmployeeId });
  if (q.allottedByEmployeeId) and.push({ allottedByEmployeeId: q.allottedByEmployeeId });
  // Open lists read oldest (overdue) first; submitted history newest first.
  const dir = q.state === 'open' ? 'asc' : 'desc';
  const rows = await prisma.task.findMany({
    where: { AND: and },
    orderBy: [{ date: dir }, { priority: 'desc' }, { createdAt: 'asc' }, { id: 'asc' }],
    take: q.limit + 1,
    ...(q.cursor ? { cursor: { id: q.cursor }, skip: 1 } : {}),
  });
  const hasMore = rows.length > q.limit;
  const page = hasMore ? rows.slice(0, q.limit) : rows;
  return { items: await toItems(prisma, user, page), nextCursor: hasMore ? (page[page.length - 1]?.id ?? null) : null };
}

export async function getTask(user: AuthUser, id: string) {
  const t = await prisma.task.findUnique({ where: { id } });
  const visible =
    t &&
    user.businessUnitIds.includes(t.businessUnitId) &&
    (user.role === 'HR' || user.role === 'DIRECTOR' || t.assigneeEmployeeId === user.employeeId || t.allottedByEmployeeId === user.employeeId);
  if (!visible) throw Errors.notFound('Task');
  return (await toItems(prisma, user, [t]))[0]!;
}

/** Today's completion per OM in a set of BUs (director dashboard §9.2). */
export async function completionByOm(businessUnitIds: string[], date: string) {
  const rows = await prisma.task.groupBy({
    by: ['allottedByEmployeeId', 'status'],
    where: { businessUnitId: { in: businessUnitIds }, date: toDbDate(date) },
    _count: { _all: true },
  });
  const refs = await personRefs(prisma, rows.map((r) => r.allottedByEmployeeId));
  const byOm = new Map<string, { total: number; completed: number; notDone: number; pending: number }>();
  for (const r of rows) {
    const s = byOm.get(r.allottedByEmployeeId) ?? { total: 0, completed: 0, notDone: 0, pending: 0 };
    s.total += r._count._all;
    if (r.status === 'COMPLETED') s.completed += r._count._all;
    else if (r.status === 'NOT_DONE') s.notDone += r._count._all;
    else s.pending += r._count._all;
    byOm.set(r.allottedByEmployeeId, s);
  }
  return [...byOm].map(([id, s]) => ({ om: refs.get(id)!, ...s })).sort((a, b) => a.om.name.localeCompare(b.om.name));
}
