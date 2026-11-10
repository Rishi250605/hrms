import { randomUUID } from 'node:crypto';
import type { z } from 'zod';
import { addDays, fromDbDate, todayIst, toDbDate } from '../../lib/dates.js';
import { AppError, Errors } from '../../lib/errors.js';
import { prisma } from '../../lib/prisma.js';
import type { Db } from '../../lib/prisma.js';
import type { AuthUser, RequestContext } from '../../lib/context.js';
import type { Prisma } from '../../generated/prisma/client.js';
import { canDecide, descendantsOf, inactiveApproverEmployeeIds, levelOf, primaryBusinessUnitOf, resolveApprover } from '../access/hierarchy.js';
import { businessUnitsFor, scopeFor } from '../access/scope.js';
import { audit } from '../audit/service.js';
import { assertOwnUpload, signedUrlFor } from '../employees/documents.service.js';
import { directorsOf, hrOf, notify } from '../notifications/service.js';
import { personRefs } from '../users/service.js';
import type { AllowanceApproveBody, AllowanceCreateBody, AllowanceQuery, AllowanceSummaryQuery, AllowanceTypeCreateBody, AllowanceTypeUpdateBody } from './schemas.js';

/**
 * Allowance requests (PHASE-2-FEATURES §6). Only RMs and OMs raise them:
 *  - RM for themself or for drivers / loadmen reporting to them → their OM approves;
 *  - OM for themself → their HR approves.
 * Amounts are integer paise.
 */

// ───────────────────────────── Types ─────────────────────────────

type TypeRow = Prisma.AllowanceTypeGetPayload<object>;
const toType = (t: TypeRow) => ({ id: t.id, code: t.code, name: t.name, maxAmountPaise: t.maxAmountPaise, isActive: t.isActive });

export async function listTypes() {
  return { items: (await prisma.allowanceType.findMany({ orderBy: { name: 'asc' } })).map(toType) };
}

export async function createType(body: z.infer<typeof AllowanceTypeCreateBody>, ctx: RequestContext) {
  return prisma.$transaction(async (tx) => {
    const t = await tx.allowanceType.create({ data: { ...body, createdById: ctx.user?.id ?? null } });
    await audit.record(tx, ctx, { action: 'allowanceType.create', entityType: 'AllowanceType', entityId: t.id, after: t });
    return toType(t);
  });
}

export async function updateType(id: string, body: z.infer<typeof AllowanceTypeUpdateBody>, ctx: RequestContext) {
  return prisma.$transaction(async (tx) => {
    const before = await tx.allowanceType.findUnique({ where: { id } });
    if (!before) throw Errors.notFound('Allowance type');
    const after = await tx.allowanceType.update({ where: { id }, data: body });
    await audit.record(tx, ctx, { action: 'allowanceType.update', entityType: 'AllowanceType', entityId: id, before, after });
    return toType(after);
  });
}

// ───────────────────────────── Requests ─────────────────────────────

const include = { allowanceType: { select: { id: true, code: true, name: true } } } satisfies Prisma.AllowanceRequestInclude;
type Row = Prisma.AllowanceRequestGetPayload<{ include: typeof include }>;

async function toItems(db: Db, user: AuthUser, rows: Row[]) {
  const [refs, bus, names, inactive] = await Promise.all([
    personRefs(db, rows.flatMap((r) => [r.employeeId, r.raisedByEmployeeId, r.approverEmployeeId])),
    db.businessUnit.findMany({ where: { id: { in: rows.map((r) => r.businessUnitId) } }, select: { id: true, code: true, name: true } }),
    db.user.findMany({ where: { id: { in: rows.flatMap((r) => (r.decidedById ? [r.decidedById] : [])) } }, select: { id: true, name: true } }),
    inactiveApproverEmployeeIds(db, user.role),
  ]);
  const bu = new Map(bus.map((b) => [b.id, b]));
  const name = new Map(names.map((u) => [u.id, u.name]));
  return rows.map((r) => ({
    id: r.id,
    batchId: r.batchId,
    beneficiary: refs.get(r.employeeId)!,
    raisedBy: refs.get(r.raisedByEmployeeId)!,
    businessUnit: bu.get(r.businessUnitId)!,
    allowanceType: r.allowanceType,
    requestedAmountPaise: r.requestedAmountPaise,
    approvedAmountPaise: r.approvedAmountPaise,
    fromDate: fromDbDate(r.fromDate),
    toDate: fromDbDate(r.toDate),
    comment: r.comment,
    hasVoiceNote: r.voiceNoteKey !== null,
    hasReceipt: r.receiptKey !== null,
    status: r.status,
    approver: refs.get(r.approverEmployeeId) ?? null,
    decidedAt: r.decidedAt?.toISOString() ?? null,
    decidedByName: r.decidedById ? (name.get(r.decidedById) ?? null) : null,
    decisionComment: r.decisionComment,
    rejectionReason: r.rejectionReason,
    canDecide:
      r.status === 'PENDING' &&
      (r.approverEmployeeId === user.employeeId || (r.approverRole === user.role && user.businessUnitIds.includes(r.businessUnitId) && inactive.includes(r.approverEmployeeId))),
    createdAt: r.createdAt.toISOString(),
  }));
}

const rupees = (paise: number) => `₹${(paise / 100).toLocaleString('en-IN', { maximumFractionDigits: 2 })}`;

export async function createAllowance(user: AuthUser, body: z.infer<typeof AllowanceCreateBody>, ctx: RequestContext) {
  if (user.role !== 'REGIONAL_MANAGER' && user.role !== 'OPERATIONAL_MANAGER') throw Errors.forbidden('Only regional and operational managers raise allowances');
  const toDate = body.toDate ?? body.fromDate;
  if (toDate < body.fromDate) throw Errors.validation([{ path: ['toDate'], message: 'To date is before from date' }]);
  if (body.fromDate > addDays(todayIst(), 31)) throw Errors.validation([{ path: ['fromDate'], message: 'Too far in the future' }]);
  if (!body.comment && !body.voiceNoteKey) throw Errors.validation([{ path: ['comment'], message: 'Add a comment or a voice note' }]);
  const type = await prisma.allowanceType.findUnique({ where: { id: body.allowanceTypeId } });
  if (!type || !type.isActive) throw Errors.notFound('Allowance type');
  if (type.maxAmountPaise !== null && body.amountPaise > type.maxAmountPaise) {
    throw new AppError('AMOUNT_ABOVE_LIMIT', 422, `${type.name} is limited to ${rupees(type.maxAmountPaise)} per request`, { maxAmountPaise: type.maxAmountPaise });
  }
  if (body.voiceNoteKey) await assertOwnUpload(user.employeeId, 'voice-note', body.voiceNoteKey);
  if (body.receiptKey) await assertOwnUpload(user.employeeId, 'receipt', body.receiptKey);

  // Beneficiaries: myself, or (RM) drivers / loadmen reporting directly to me.
  let beneficiaries = [user.employeeId];
  if (body.beneficiaryEmployeeIds?.length) {
    beneficiaries = [...new Set(body.beneficiaryEmployeeIds)];
    const others = beneficiaries.filter((b) => b !== user.employeeId);
    if (others.length) {
      if (user.role !== 'REGIONAL_MANAGER') throw Errors.forbidden('Operational managers raise allowances only for themselves');
      const direct = await descendantsOf(prisma, user.employeeId, 1);
      for (const b of others) {
        if (!direct.has(b) || (await levelOf(prisma, b)) !== 'STAFF') throw new AppError('FORBIDDEN', 403, 'You can raise allowances only for drivers and loadmen reporting to you', { employeeId: b });
      }
    }
  }
  const myBu = user.primaryBusinessUnitId ?? (await primaryBusinessUnitOf(prisma, user.employeeId));
  const approver = await resolveApprover(prisma, user.employeeId, myBu);
  const batchId = randomUUID();

  const created = await prisma.$transaction(async (tx) => {
    const rows = [];
    for (const employeeId of beneficiaries) {
      const businessUnitId = employeeId === user.employeeId ? myBu : await primaryBusinessUnitOf(tx, employeeId);
      if (!user.businessUnitIds.includes(businessUnitId)) throw new AppError('FORBIDDEN_BUSINESS_UNIT', 403, 'The beneficiary is in another business unit');
      const r = await tx.allowanceRequest.create({
        data: {
          batchId,
          employeeId,
          raisedByEmployeeId: user.employeeId,
          raisedById: user.id,
          businessUnitId,
          allowanceTypeId: type.id,
          requestedAmountPaise: body.amountPaise,
          fromDate: toDbDate(body.fromDate),
          toDate: toDbDate(toDate),
          comment: body.comment ?? null,
          voiceNoteKey: body.voiceNoteKey ?? null,
          receiptKey: body.receiptKey ?? null,
          approverEmployeeId: approver.employeeId,
          approverRole: approver.role,
        },
        include,
      });
      await audit.record(tx, ctx, { action: 'allowance.create', entityType: 'AllowanceRequest', entityId: r.id, after: r });
      rows.push(r);
    }
    return rows;
  });

  // §10: RM submissions → their OM + HR; OM submissions → their HR.
  const recipients = [approver.userId, ...(user.role === 'REGIONAL_MANAGER' ? await hrOf(prisma, myBu) : []), ...(approver.fallback ? await directorsOf(prisma) : [])];
  const who = created.length === 1 ? (created[0]!.employeeId === user.employeeId ? 'self' : '1 team member') : `${created.length} team members`;
  await notify(
    recipients,
    {
      type: 'ALLOWANCE_SUBMITTED',
      title: 'Allowance to approve',
      body: `${user.name}: ${type.name} ${rupees(body.amountPaise)} for ${who}`,
      entityType: 'ALLOWANCE',
      entityId: created[0]!.id,
      businessUnitId: myBu,
    },
    user.id,
  );
  return { items: await toItems(prisma, user, created) };
}

async function lockAllowance(db: Db, id: string) {
  await db.$queryRaw`SELECT id FROM allowance_requests WHERE id = ${id}::uuid FOR UPDATE`;
  const r = await db.allowanceRequest.findUnique({ where: { id } });
  if (!r) throw Errors.notFound('Allowance request');
  return r;
}

async function notifyDecision(user: AuthUser, rows: Row[], decision: 'APPROVED' | 'REJECTED', note?: string) {
  const first = rows[0];
  if (!first) return;
  const raiser = await prisma.user.findUnique({ where: { employeeId: first.raisedByEmployeeId }, select: { id: true, role: true } });
  const recipients = [raiser?.id, ...(raiser?.role === 'REGIONAL_MANAGER' ? await hrOf(prisma, first.businessUnitId) : [])];
  const total = rows.reduce((s, r) => s + (decision === 'APPROVED' ? (r.approvedAmountPaise ?? r.requestedAmountPaise) : r.requestedAmountPaise), 0);
  await notify(
    recipients,
    {
      type: decision === 'APPROVED' ? 'ALLOWANCE_APPROVED' : 'ALLOWANCE_REJECTED',
      title: decision === 'APPROVED' ? 'Allowance approved' : 'Allowance rejected',
      body: `${first.allowanceType.name} ${rupees(total)}${rows.length > 1 ? ` (${rows.length} people)` : ''}${note ? ` — ${note}` : ''}`,
      entityType: 'ALLOWANCE',
      entityId: first.id,
      businessUnitId: first.businessUnitId,
    },
    user.id,
  );
}

/** Approve, optionally a different amount (then a comment is required and both amounts are kept). */
export async function approveAllowance(user: AuthUser, id: string, body: z.infer<typeof AllowanceApproveBody>, ctx: RequestContext) {
  if (body.approvedAmountPaise !== undefined && !body.comment) throw Errors.validation([{ path: ['comment'], message: 'Explain the changed amount' }]);
  await prisma.$transaction(async (tx) => {
    const r = await lockAllowance(tx, id);
    if (!(await canDecide(tx, user, r))) throw Errors.notFound('Allowance request');
    if (r.status !== 'PENDING') throw Errors.conflict('ALREADY_DECIDED', `The request is already ${r.status.toLowerCase()}`);
    const after = await tx.allowanceRequest.update({
      where: { id },
      data: {
        status: 'APPROVED',
        approvedAmountPaise: body.approvedAmountPaise ?? r.requestedAmountPaise,
        decisionComment: body.comment ?? null,
        decidedById: user.id,
        decidedAt: new Date(),
      },
    });
    await audit.record(tx, ctx, { action: 'allowance.approve', entityType: 'AllowanceRequest', entityId: id, before: r, after });
  });
  const row = await prisma.allowanceRequest.findUniqueOrThrow({ where: { id }, include });
  await notifyDecision(user, [row], 'APPROVED', body.comment);
  return (await toItems(prisma, user, [row]))[0]!;
}

export async function rejectAllowance(user: AuthUser, id: string, reason: string, ctx: RequestContext) {
  await prisma.$transaction(async (tx) => {
    const r = await lockAllowance(tx, id);
    if (!(await canDecide(tx, user, r))) throw Errors.notFound('Allowance request');
    if (r.status !== 'PENDING') throw Errors.conflict('ALREADY_DECIDED', `The request is already ${r.status.toLowerCase()}`);
    const after = await tx.allowanceRequest.update({ where: { id }, data: { status: 'REJECTED', rejectionReason: reason, decidedById: user.id, decidedAt: new Date() } });
    await audit.record(tx, ctx, { action: 'allowance.reject', entityType: 'AllowanceRequest', entityId: id, before: r, after });
  });
  const row = await prisma.allowanceRequest.findUniqueOrThrow({ where: { id }, include });
  await notifyDecision(user, [row], 'REJECTED', reason);
  return (await toItems(prisma, user, [row]))[0]!;
}

/** Approves every pending request of a batch routed to the caller (requested amounts). */
export async function approveBatch(user: AuthUser, batchId: string, ctx: RequestContext) {
  const rows = await prisma.allowanceRequest.findMany({ where: { batchId, status: 'PENDING' } });
  if (rows.length === 0) throw Errors.notFound('Batch');
  const approved: string[] = [];
  const skipped: string[] = [];
  for (const r of rows) {
    const ok = await prisma.$transaction(async (tx) => {
      const locked = await lockAllowance(tx, r.id);
      if (locked.status !== 'PENDING' || !(await canDecide(tx, user, locked))) return false;
      const after = await tx.allowanceRequest.update({
        where: { id: r.id },
        data: { status: 'APPROVED', approvedAmountPaise: locked.requestedAmountPaise, decidedById: user.id, decidedAt: new Date() },
      });
      await audit.record(tx, ctx, { action: 'allowance.approve', entityType: 'AllowanceRequest', entityId: r.id, before: locked, after: { ...after, batch: true } });
      return true;
    });
    (ok ? approved : skipped).push(r.id);
  }
  if (approved.length === 0) throw Errors.notFound('Batch');
  await notifyDecision(user, await prisma.allowanceRequest.findMany({ where: { id: { in: approved } }, include }), 'APPROVED');
  return { approved, skipped };
}

/** Visibility (§11 Allowances): RM self + own team; OM self + their RMs' requests; HR / director all in BUs. */
async function visibleWhere(user: AuthUser, businessUnitId?: string): Promise<Prisma.AllowanceRequestWhereInput> {
  const scope = await scopeFor(prisma, user, 'allowances', businessUnitId);
  if (!scope.employeeIds) return { businessUnitId: { in: scope.businessUnitIds } };
  const ids = scope.employeeIds;
  return { businessUnitId: { in: scope.businessUnitIds }, OR: [{ employeeId: { in: ids } }, { raisedByEmployeeId: { in: ids } }] };
}

export async function listAllowances(user: AuthUser, q: z.infer<typeof AllowanceQuery>) {
  const and: Prisma.AllowanceRequestWhereInput[] = [];
  if (q.scope === 'mine') {
    and.push({ businessUnitId: { in: businessUnitsFor(user, q.businessUnitId) }, OR: [{ raisedByEmployeeId: user.employeeId }, { employeeId: user.employeeId }] });
  } else if (q.scope === 'approvals') {
    const inactive = await inactiveApproverEmployeeIds(prisma, user.role);
    and.push({
      businessUnitId: { in: businessUnitsFor(user, q.businessUnitId) },
      OR: [{ approverEmployeeId: user.employeeId }, ...(inactive.length ? [{ approverRole: user.role, approverEmployeeId: { in: inactive } }] : [])],
    });
    if (!q.status) and.push({ status: 'PENDING' });
  } else {
    if (q.scope === 'all' && user.role !== 'HR' && user.role !== 'DIRECTOR') throw Errors.forbidden('Only HR and the director can see all allowances');
    and.push(await visibleWhere(user, q.businessUnitId));
    if (q.scope === 'team') and.push({ employeeId: { not: user.employeeId } });
  }
  if (q.status) and.push({ status: q.status });
  if (q.batchId) and.push({ batchId: q.batchId });
  if (q.from) and.push({ toDate: { gte: toDbDate(q.from) } });
  if (q.to) and.push({ fromDate: { lte: toDbDate(q.to) } });
  const rows = await prisma.allowanceRequest.findMany({
    where: { AND: and },
    include,
    orderBy: [{ createdAt: 'desc' }, { id: 'desc' }],
    take: q.limit + 1,
    ...(q.cursor ? { cursor: { id: q.cursor }, skip: 1 } : {}),
  });
  const hasMore = rows.length > q.limit;
  const page = hasMore ? rows.slice(0, q.limit) : rows;
  return { items: await toItems(prisma, user, page), nextCursor: hasMore ? (page[page.length - 1]?.id ?? null) : null };
}

/** Signed URLs (≤ 10 min) for the voice note and receipt, for anyone who can see the request. */
export async function allowanceFiles(user: AuthUser, id: string, origin: string, ctx: RequestContext) {
  const r = await prisma.allowanceRequest.findUnique({ where: { id } });
  if (!r) throw Errors.notFound('Allowance request');
  const visible = (await prisma.allowanceRequest.count({ where: { AND: [{ id }, await visibleWhere(user)] } })) > 0 || (await canDecide(prisma, user, r));
  if (!visible) throw Errors.notFound('Allowance request');
  await audit.record(prisma, ctx, { action: 'allowance.files.read', entityType: 'AllowanceRequest', entityId: id });
  return {
    voiceNote: r.voiceNoteKey ? await signedUrlFor(r.voiceNoteKey, origin) : null,
    receipt: r.receiptKey ? await signedUrlFor(r.receiptKey, origin) : null,
  };
}

/** HR / director: monthly totals per business unit (§6.3). */
export async function monthlySummary(user: AuthUser, q: z.infer<typeof AllowanceSummaryQuery>) {
  const bus = businessUnitsFor(user, q.businessUnitId);
  const start = toDbDate(`${q.month}-01`);
  const end = toDbDate(addDays(`${q.month}-28`, 4).slice(0, 7) + '-01');
  const rows = await prisma.allowanceRequest.groupBy({
    by: ['businessUnitId', 'status'],
    where: { businessUnitId: { in: bus }, fromDate: { gte: start, lt: end }, status: { not: 'CANCELLED' } },
    _sum: { requestedAmountPaise: true, approvedAmountPaise: true },
    _count: { _all: true },
  });
  const units = await prisma.businessUnit.findMany({ where: { id: { in: bus } }, select: { id: true, code: true, name: true }, orderBy: { code: 'asc' } });
  return {
    month: q.month,
    items: units.map((b) => {
      const mine = rows.filter((r) => r.businessUnitId === b.id);
      return {
        businessUnit: b,
        requests: mine.reduce((s, r) => s + r._count._all, 0),
        pending: mine.filter((r) => r.status === 'PENDING').reduce((s, r) => s + r._count._all, 0),
        requestedPaise: mine.reduce((s, r) => s + (r._sum.requestedAmountPaise ?? 0), 0),
        approvedPaise: mine.filter((r) => r.status === 'APPROVED').reduce((s, r) => s + (r._sum.approvedAmountPaise ?? 0), 0),
      };
    }),
  };
}
