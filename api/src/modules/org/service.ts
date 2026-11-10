import type { z } from 'zod';
import { Errors } from '../../lib/errors.js';
import { todayIst, toDbDate } from '../../lib/dates.js';
import { prisma } from '../../lib/prisma.js';
import type { AuthUser, RequestContext } from '../../lib/context.js';
import type { Prisma } from '../../generated/prisma/client.js';
import { depotWhere } from '../access/scope.js';
import { audit } from '../audit/service.js';
import type {
  BusinessUnitCreateBody,
  BusinessUnitUpdateBody,
  DepotCreateBody,
  DepotListQuery,
  DepotUpdateBody,
  RegionCreateBody,
  RegionUpdateBody,
} from './schemas.js';

// ───────────────────────────── Business units ─────────────────────────────

const toBu = (b: { id: string; name: string; code: string; isActive: boolean }) => ({ id: b.id, name: b.name, code: b.code, isActive: b.isActive });

/** The caller's business units (the director: all, including inactive ones). */
export async function listBusinessUnits(user: AuthUser) {
  const rows = await prisma.businessUnit.findMany({
    where: user.role === 'DIRECTOR' ? {} : { id: { in: user.businessUnitIds } },
    orderBy: { code: 'asc' },
  });
  return { items: rows.map(toBu) };
}

export async function createBusinessUnit(body: z.infer<typeof BusinessUnitCreateBody>, ctx: RequestContext) {
  return prisma.$transaction(async (tx) => {
    const bu = await tx.businessUnit.create({ data: { ...body, createdById: ctx.user?.id ?? null } });
    await audit.record(tx, ctx, { action: 'businessUnit.create', entityType: 'BusinessUnit', entityId: bu.id, after: bu });
    return toBu(bu);
  });
}

/** Renaming a code does not renumber existing employee IDs (decision Q3). */
export async function updateBusinessUnit(id: string, body: z.infer<typeof BusinessUnitUpdateBody>, ctx: RequestContext) {
  return prisma.$transaction(async (tx) => {
    const before = await tx.businessUnit.findUnique({ where: { id } });
    if (!before) throw Errors.notFound('Business unit');
    const after = await tx.businessUnit.update({ where: { id }, data: body });
    await audit.record(tx, ctx, { action: 'businessUnit.update', entityType: 'BusinessUnit', entityId: id, before, after });
    return toBu(after);
  });
}

// ───────────────────────────── Regions ─────────────────────────────

export async function listRegions() {
  const rows = await prisma.region.findMany({ include: { _count: { select: { depots: { where: { deletedAt: null } } } } }, orderBy: { name: 'asc' } });
  return { items: rows.map((r) => ({ id: r.id, name: r.name, code: r.code, depotCount: r._count.depots })) };
}

export async function createRegion(body: z.infer<typeof RegionCreateBody>, ctx: RequestContext) {
  return prisma.$transaction(async (tx) => {
    const region = await tx.region.create({ data: { ...body, createdById: ctx.user?.id ?? null } });
    await audit.record(tx, ctx, { action: 'region.create', entityType: 'Region', entityId: region.id, after: region });
    return { id: region.id, name: region.name, code: region.code, depotCount: 0 };
  });
}

export async function updateRegion(id: string, body: z.infer<typeof RegionUpdateBody>, ctx: RequestContext) {
  return prisma.$transaction(async (tx) => {
    const before = await tx.region.findUnique({ where: { id } });
    if (!before) throw Errors.notFound('Region');
    const after = await tx.region.update({ where: { id }, data: body, include: { _count: { select: { depots: { where: { deletedAt: null } } } } } });
    await audit.record(tx, ctx, { action: 'region.update', entityType: 'Region', entityId: id, before, after });
    return { id: after.id, name: after.name, code: after.code, depotCount: after._count.depots };
  });
}

// ───────────────────────────── Depots ─────────────────────────────

const depotInclude = { region: { select: { name: true } }, businessUnit: { select: { code: true } } } satisfies Prisma.DepotInclude;
type DepotRow = Prisma.DepotGetPayload<{ include: typeof depotInclude }>;
const toDepotItem = (d: DepotRow) => ({
  id: d.id,
  regionId: d.regionId,
  regionName: d.region.name,
  businessUnitId: d.businessUnitId,
  businessUnitCode: d.businessUnit.code,
  name: d.name,
  code: d.code,
  address: d.address,
  state: d.state,
  lat: d.lat,
  lng: d.lng,
});

export async function listDepots(user: AuthUser, q: z.infer<typeof DepotListQuery>) {
  const rows = await prisma.depot.findMany({
    where: { AND: [depotWhere(user, q.businessUnitId), q.regionId ? { regionId: q.regionId } : {}] },
    include: depotInclude,
    orderBy: { name: 'asc' },
  });
  return { items: rows.map(toDepotItem) };
}

async function assertRefs(regionId?: string, businessUnitId?: string) {
  if (regionId && !(await prisma.region.findUnique({ where: { id: regionId } }))) throw Errors.notFound('Region');
  if (businessUnitId && !(await prisma.businessUnit.findUnique({ where: { id: businessUnitId } }))) throw Errors.notFound('Business unit');
}

export async function createDepot(body: z.infer<typeof DepotCreateBody>, ctx: RequestContext) {
  await assertRefs(body.regionId, body.businessUnitId);
  return prisma.$transaction(async (tx) => {
    const depot = await tx.depot.create({ data: { ...body, createdById: ctx.user?.id ?? null }, include: depotInclude });
    await audit.record(tx, ctx, { action: 'depot.create', entityType: 'Depot', entityId: depot.id, after: depot });
    return toDepotItem(depot);
  });
}

export async function updateDepot(id: string, body: z.infer<typeof DepotUpdateBody>, ctx: RequestContext) {
  await assertRefs(body.regionId, body.businessUnitId);
  return prisma.$transaction(async (tx) => {
    const before = await tx.depot.findFirst({ where: { id, deletedAt: null } });
    if (!before) throw Errors.notFound('Depot');
    const after = await tx.depot.update({ where: { id }, data: body, include: depotInclude });
    await audit.record(tx, ctx, { action: 'depot.update', entityType: 'Depot', entityId: id, before, after });
    return toDepotItem(after);
  });
}

/** Soft delete. Refused while any employee has a current or future job at the depot. */
export async function archiveDepot(id: string, ctx: RequestContext) {
  await prisma.$transaction(async (tx) => {
    const before = await tx.depot.findFirst({ where: { id, deletedAt: null } });
    if (!before) throw Errors.notFound('Depot');
    const today = toDbDate(todayIst());
    const inUse = await tx.employeeJob.count({ where: { depotId: id, OR: [{ effectiveTo: null }, { effectiveTo: { gt: today } }] } });
    if (inUse > 0) throw Errors.conflict('DEPOT_IN_USE', 'Employees are still assigned to this depot', { employees: inUse });
    const after = await tx.depot.update({ where: { id }, data: { deletedAt: new Date() } });
    await audit.record(tx, ctx, { action: 'depot.archive', entityType: 'Depot', entityId: id, before, after });
  });
}
