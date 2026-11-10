import { registry, z } from '../../lib/openapi.js';

const Code = z
  .string()
  .trim()
  .toUpperCase()
  .regex(/^[A-Z0-9_-]{2,16}$/, '2-16 letters, digits, - or _');

/** Business-unit codes prefix employee IDs (NLS001), so letters only. */
const BuCode = z
  .string()
  .trim()
  .toUpperCase()
  .regex(/^[A-Z]{2,8}$/, '2-8 letters');

export const StateCode = z
  .string()
  .trim()
  .toUpperCase()
  .regex(/^[A-Z]{2}$/, 'Two-letter state code, e.g. MH')
  .openapi({ example: 'MH' });

export const BusinessUnitItem = registry.register(
  'BusinessUnitItem',
  z.object({ id: z.uuid(), name: z.string(), code: z.string(), isActive: z.boolean() }),
);
export const BusinessUnitList = registry.register('BusinessUnitList', z.object({ items: z.array(BusinessUnitItem) }));
export const BusinessUnitCreateBody = registry.register('BusinessUnitCreateBody', z.object({ name: z.string().trim().min(2).max(100), code: BuCode }));
export const BusinessUnitUpdateBody = registry.register(
  'BusinessUnitUpdateBody',
  z.object({ name: z.string().trim().min(2).max(100).optional(), code: BuCode.optional(), isActive: z.boolean().optional() }),
);

export const RegionItem = registry.register('RegionItem', z.object({ id: z.uuid(), name: z.string(), code: z.string(), depotCount: z.number().int() }));

export const DepotItem = registry.register(
  'DepotItem',
  z.object({
    id: z.uuid(),
    regionId: z.uuid(),
    regionName: z.string(),
    businessUnitId: z.uuid(),
    businessUnitCode: z.string(),
    name: z.string(),
    code: z.string(),
    address: z.string().nullable(),
    state: z.string(),
    lat: z.number().nullable(),
    lng: z.number().nullable(),
  }),
);

export const RegionList = registry.register('RegionList', z.object({ items: z.array(RegionItem) }));
export const DepotList = registry.register('DepotList', z.object({ items: z.array(DepotItem) }));

export const RegionCreateBody = registry.register('RegionCreateBody', z.object({ name: z.string().trim().min(2).max(100), code: Code }));
export const RegionUpdateBody = registry.register('RegionUpdateBody', z.object({ name: z.string().trim().min(2).max(100) }));

export const DepotCreateBody = registry.register(
  'DepotCreateBody',
  z.object({
    regionId: z.uuid(),
    businessUnitId: z.uuid(),
    name: z.string().trim().min(2).max(100),
    code: Code,
    address: z.string().trim().max(500).optional(),
    state: StateCode,
    lat: z.number().min(-90).max(90).optional(),
    lng: z.number().min(-180).max(180).optional(),
  }),
);

export const DepotUpdateBody = registry.register(
  'DepotUpdateBody',
  z.object({
    regionId: z.uuid().optional(),
    businessUnitId: z.uuid().optional(),
    name: z.string().trim().min(2).max(100).optional(),
    address: z.string().trim().max(500).nullable().optional(),
    state: StateCode.optional(),
    lat: z.number().min(-90).max(90).nullable().optional(),
    lng: z.number().min(-180).max(180).nullable().optional(),
  }),
);

export const DepotListQuery = z.object({ businessUnitId: z.uuid().optional(), regionId: z.uuid().optional() });
