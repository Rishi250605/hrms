import type { z } from 'zod';
import { Errors } from '../../lib/errors.js';
import { prisma } from '../../lib/prisma.js';
import type { Db } from '../../lib/prisma.js';
import type { AuthUser, RequestContext } from '../../lib/context.js';
import { assertDepotAccess, depotWhere } from '../access/scope.js';
import type { Prisma } from '../../generated/prisma/client.js';
import { audit } from '../audit/service.js';
import type {
  DutyTemplateCreateBody,
  DutyTemplateUpdateBody,
  FleetListQuery,
  RouteCreateBody,
  RouteUpdateBody,
  VehicleCreateBody,
  VehicleUpdateBody,
} from './schemas.js';

const depotSelect = { depot: { select: { id: true, code: true, name: true } } } as const;
type Q = z.infer<typeof FleetListQuery>;

const scoped = (user: AuthUser, q: Q) => ({ depot: depotWhere(user, q.businessUnitId), ...(q.depotId ? { depotId: q.depotId } : {}) });

// ───────────────────────────── Vehicles ─────────────────────────────

type VehicleRow = Prisma.VehicleGetPayload<{ include: typeof depotSelect }>;
const toVehicle = (v: VehicleRow) => ({ id: v.id, regNo: v.regNo, type: v.type, capacity: v.capacity, status: v.status, depot: v.depot });

export async function listVehicles(user: AuthUser, q: Q) {
  const rows = await prisma.vehicle.findMany({
    where: { ...scoped(user, q), deletedAt: null, ...(q.includeInactive ? {} : { status: { not: 'RETIRED' } }) },
    include: depotSelect,
    orderBy: { regNo: 'asc' },
  });
  return { items: rows.map(toVehicle) };
}

async function findInScope<T>(user: AuthUser, find: () => Promise<(T & { depotId: string }) | null>, entity: string): Promise<T & { depotId: string }> {
  const row = await find();
  if (!row) throw Errors.notFound(entity);
  try {
    await assertDepotAccess(prisma, user, row.depotId);
  } catch {
    throw Errors.notFound(entity);
  }
  return row;
}

export async function createVehicle(user: AuthUser, body: z.infer<typeof VehicleCreateBody>, ctx: RequestContext) {
  await assertDepotAccess(prisma, user, body.depotId);
  return prisma.$transaction(async (tx) => {
    const v = await tx.vehicle.create({ data: { ...body, capacity: body.capacity ?? null, createdById: ctx.user?.id ?? null }, include: depotSelect });
    await audit.record(tx, ctx, { action: 'vehicle.create', entityType: 'Vehicle', entityId: v.id, after: v });
    return toVehicle(v);
  });
}

export async function updateVehicle(user: AuthUser, id: string, body: z.infer<typeof VehicleUpdateBody>, ctx: RequestContext) {
  await findInScope(user, () => prisma.vehicle.findFirst({ where: { id, deletedAt: null } }), 'Vehicle');
  if (body.depotId) await assertDepotAccess(prisma, user, body.depotId);
  return prisma.$transaction(async (tx) => {
    const before = await tx.vehicle.findUniqueOrThrow({ where: { id } });
    const after = await tx.vehicle.update({ where: { id }, data: body, include: depotSelect });
    await audit.record(tx, ctx, { action: 'vehicle.update', entityType: 'Vehicle', entityId: id, before, after });
    return toVehicle(after);
  });
}

// ───────────────────────────── Routes ─────────────────────────────

type RouteRow = Prisma.RouteGetPayload<{ include: typeof depotSelect }>;
const toRoute = (r: RouteRow) => ({
  id: r.id,
  code: r.code,
  name: r.name,
  origin: r.origin,
  destination: r.destination,
  distanceKm: r.distanceKm,
  standardMinutes: r.standardMinutes,
  depot: r.depot,
  archived: r.deletedAt !== null,
});

export async function listRoutes(user: AuthUser, q: Q) {
  const rows = await prisma.route.findMany({
    where: { ...scoped(user, q), ...(q.includeInactive ? {} : { deletedAt: null }) },
    include: depotSelect,
    orderBy: { code: 'asc' },
  });
  return { items: rows.map(toRoute) };
}

export async function createRoute(user: AuthUser, body: z.infer<typeof RouteCreateBody>, ctx: RequestContext) {
  await assertDepotAccess(prisma, user, body.depotId);
  return prisma.$transaction(async (tx) => {
    const r = await tx.route.create({ data: { ...body, distanceKm: body.distanceKm ?? null, createdById: ctx.user?.id ?? null }, include: depotSelect });
    await audit.record(tx, ctx, { action: 'route.create', entityType: 'Route', entityId: r.id, after: r });
    return toRoute(r);
  });
}

export async function updateRoute(user: AuthUser, id: string, body: z.infer<typeof RouteUpdateBody>, ctx: RequestContext) {
  await findInScope(user, () => prisma.route.findUnique({ where: { id } }), 'Route');
  const { archived, ...rest } = body;
  return prisma.$transaction(async (tx) => {
    const before = await tx.route.findUniqueOrThrow({ where: { id } });
    const data: Prisma.RouteUpdateInput = { ...rest };
    if (archived !== undefined) data.deletedAt = archived ? (before.deletedAt ?? new Date()) : null;
    const after = await tx.route.update({ where: { id }, data, include: depotSelect });
    await audit.record(tx, ctx, { action: 'route.update', entityType: 'Route', entityId: id, before, after });
    return toRoute(after);
  });
}

// ───────────────────────────── Duty templates ─────────────────────────────

const templateInclude = { ...depotSelect, route: { select: { id: true, code: true, name: true } } } as const;
type TemplateRow = Prisma.DutyTemplateGetPayload<{ include: typeof templateInclude }>;
const toTemplate = (t: TemplateRow) => ({
  id: t.id,
  name: t.name,
  startTime: t.startTime,
  endTime: t.endTime,
  crossesMidnight: t.crossesMidnight,
  route: t.route,
  depot: t.depot,
  archived: t.deletedAt !== null,
});

/** A route used by a duty or template must belong to the same depot and not be archived. */
export async function assertRouteAtDepot(db: Db, routeId: string, depotId: string) {
  const route = await db.route.findFirst({ where: { id: routeId, depotId, deletedAt: null } });
  if (!route) throw Errors.validation([{ path: ['routeId'], message: 'Route not found at this depot' }]);
  return route;
}

export async function listTemplates(user: AuthUser, q: Q) {
  const rows = await prisma.dutyTemplate.findMany({
    where: { ...scoped(user, q), ...(q.includeInactive ? {} : { deletedAt: null }) },
    include: templateInclude,
    orderBy: [{ startTime: 'asc' }, { name: 'asc' }],
  });
  return { items: rows.map(toTemplate) };
}

export async function createTemplate(user: AuthUser, body: z.infer<typeof DutyTemplateCreateBody>, ctx: RequestContext) {
  await assertDepotAccess(prisma, user, body.depotId);
  if (body.routeId) await assertRouteAtDepot(prisma, body.routeId, body.depotId);
  if (body.startTime === body.endTime) throw Errors.validation([{ path: ['endTime'], message: 'End time equals start time' }]);
  const crossesMidnight = body.crossesMidnight ?? body.endTime < body.startTime;
  if (!crossesMidnight && body.endTime < body.startTime) {
    throw Errors.validation([{ path: ['crossesMidnight'], message: 'End time is before start time' }]);
  }
  return prisma.$transaction(async (tx) => {
    const t = await tx.dutyTemplate.create({
      data: { ...body, crossesMidnight, routeId: body.routeId ?? null, createdById: ctx.user?.id ?? null },
      include: templateInclude,
    });
    await audit.record(tx, ctx, { action: 'dutyTemplate.create', entityType: 'DutyTemplate', entityId: t.id, after: t });
    return toTemplate(t);
  });
}

export async function updateTemplate(user: AuthUser, id: string, body: z.infer<typeof DutyTemplateUpdateBody>, ctx: RequestContext) {
  const existing = await findInScope(user, () => prisma.dutyTemplate.findUnique({ where: { id } }), 'Duty template');
  if (body.routeId) await assertRouteAtDepot(prisma, body.routeId, existing.depotId);
  const { archived, ...rest } = body;
  return prisma.$transaction(async (tx) => {
    const before = await tx.dutyTemplate.findUniqueOrThrow({ where: { id } });
    const start = rest.startTime ?? before.startTime;
    const end = rest.endTime ?? before.endTime;
    const crossesMidnight = rest.crossesMidnight ?? end < start;
    if (start === end || (!crossesMidnight && end < start)) throw Errors.validation([{ path: ['endTime'], message: 'Invalid start/end times' }]);
    const data: Prisma.DutyTemplateUncheckedUpdateInput = { ...rest, crossesMidnight };
    if (archived !== undefined) data.deletedAt = archived ? (before.deletedAt ?? new Date()) : null;
    const after = await tx.dutyTemplate.update({ where: { id }, data, include: templateInclude });
    await audit.record(tx, ctx, { action: 'dutyTemplate.update', entityType: 'DutyTemplate', entityId: id, before, after });
    return toTemplate(after);
  });
}
