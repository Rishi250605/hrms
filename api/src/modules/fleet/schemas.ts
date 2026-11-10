import { registry, z } from '../../lib/openapi.js';
import { HhMm, QueryBool } from '../../lib/schemas.js';
import { VehicleStatus } from '../../generated/prisma/enums.js';
import { DepotSummary } from '../employees/schemas.js';

export const VehicleStatusSchema = registry.register('VehicleStatus', z.enum(VehicleStatus));

export const FleetListQuery = z.object({
  businessUnitId: z.uuid().optional(),
  depotId: z.uuid().optional(),
  includeInactive: QueryBool.optional().openapi({ description: 'Include retired vehicles / archived routes and templates' }),
});

export const VehicleItem = registry.register(
  'VehicleItem',
  z.object({ id: z.uuid(), regNo: z.string(), type: z.string(), capacity: z.number().int().nullable(), status: VehicleStatusSchema, depot: DepotSummary }),
);
export const VehicleList = registry.register('VehicleList', z.object({ items: z.array(VehicleItem) }));
export const VehicleCreateBody = registry.register(
  'VehicleCreateBody',
  z.object({
    regNo: z
      .string()
      .trim()
      .toUpperCase()
      .transform((s) => s.replace(/[\s-]/g, ''))
      .pipe(z.string().regex(/^[A-Z]{2}\d{1,2}[A-Z]{0,3}\d{1,4}$|^\d{2}BH\d{4}[A-Z]{1,2}$/, 'Invalid registration number'))
      .openapi({ type: 'string', example: 'MH12AB1234' }),
    type: z.string().trim().min(2).max(40),
    capacity: z.number().int().positive().max(200).optional(),
    depotId: z.uuid(),
  }),
);
export const VehicleUpdateBody = registry.register(
  'VehicleUpdateBody',
  z.object({
    type: z.string().trim().min(2).max(40).optional(),
    capacity: z.number().int().positive().max(200).nullable().optional(),
    depotId: z.uuid().optional(),
    status: VehicleStatusSchema.optional(),
  }),
);

export const RouteItem = registry.register(
  'RouteItem',
  z.object({
    id: z.uuid(),
    code: z.string(),
    name: z.string(),
    origin: z.string(),
    destination: z.string(),
    distanceKm: z.number().nullable(),
    standardMinutes: z.number().int(),
    depot: DepotSummary,
    archived: z.boolean(),
  }),
);
export const RouteList = registry.register('RouteList', z.object({ items: z.array(RouteItem) }));
export const RouteCreateBody = registry.register(
  'RouteCreateBody',
  z.object({
    code: z
      .string()
      .trim()
      .toUpperCase()
      .regex(/^[A-Z0-9-]{1,20}$/),
    name: z.string().trim().min(2).max(120),
    origin: z.string().trim().min(2).max(120),
    destination: z.string().trim().min(2).max(120),
    distanceKm: z.number().positive().max(5000).optional(),
    standardMinutes: z.number().int().positive().max(48 * 60),
    depotId: z.uuid(),
  }),
);
export const RouteUpdateBody = registry.register(
  'RouteUpdateBody',
  z.object({
    name: z.string().trim().min(2).max(120).optional(),
    origin: z.string().trim().min(2).max(120).optional(),
    destination: z.string().trim().min(2).max(120).optional(),
    distanceKm: z.number().positive().max(5000).nullable().optional(),
    standardMinutes: z.number().int().positive().max(48 * 60).optional(),
    archived: z.boolean().optional(),
  }),
);

export const DutyTemplateItem = registry.register(
  'DutyTemplateItem',
  z.object({
    id: z.uuid(),
    name: z.string(),
    startTime: HhMm,
    endTime: HhMm,
    crossesMidnight: z.boolean(),
    route: z.object({ id: z.uuid(), code: z.string(), name: z.string() }).nullable(),
    depot: DepotSummary,
    archived: z.boolean(),
  }),
);
export const DutyTemplateList = registry.register('DutyTemplateList', z.object({ items: z.array(DutyTemplateItem) }));
export const DutyTemplateCreateBody = registry.register(
  'DutyTemplateCreateBody',
  z.object({
    depotId: z.uuid(),
    name: z.string().trim().min(2).max(80),
    startTime: HhMm,
    endTime: HhMm,
    crossesMidnight: z.boolean().optional().openapi({ description: 'Defaults to true when endTime <= startTime' }),
    routeId: z.uuid().optional(),
  }),
);
export const DutyTemplateUpdateBody = registry.register(
  'DutyTemplateUpdateBody',
  z.object({
    name: z.string().trim().min(2).max(80).optional(),
    startTime: HhMm.optional(),
    endTime: HhMm.optional(),
    crossesMidnight: z.boolean().optional(),
    routeId: z.uuid().nullable().optional(),
    archived: z.boolean().optional(),
  }),
);
