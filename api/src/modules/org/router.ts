import { ModuleRouter } from '../../lib/route.js';
import type { RouteAccess } from '../../lib/route.js';
import { IdParams } from '../../lib/schemas.js';
import * as controller from './controller.js';
import {
  BusinessUnitCreateBody,
  BusinessUnitItem,
  BusinessUnitList,
  BusinessUnitUpdateBody,
  DepotCreateBody,
  DepotItem,
  DepotList,
  DepotListQuery,
  DepotUpdateBody,
  RegionCreateBody,
  RegionItem,
  RegionList,
  RegionUpdateBody,
} from './schemas.js';

const director: RouteAccess = { roles: ['DIRECTOR'] };

export const businessUnitsRouter = new ModuleRouter('/business-units', 'Org')
  .route({
    method: 'get',
    path: '/',
    operationId: 'listBusinessUnits',
    summary: 'My business units (the director: all)',
    access: { roles: 'any' },
    response: { status: 200, description: 'Business units', schema: BusinessUnitList },
    handler: controller.listBusinessUnits,
  })
  .route({
    method: 'post',
    path: '/',
    operationId: 'createBusinessUnit',
    summary: 'Create a business unit',
    access: director,
    body: BusinessUnitCreateBody,
    response: { status: 201, description: 'Created', schema: BusinessUnitItem },
    errors: { 409: 'Code already used' },
    handler: controller.createBusinessUnit,
  })
  .route({
    method: 'patch',
    path: '/:id',
    operationId: 'updateBusinessUnit',
    summary: 'Rename, recode or deactivate a business unit',
    description: 'Changing the code does not renumber existing employee IDs.',
    access: director,
    params: IdParams,
    body: BusinessUnitUpdateBody,
    response: { status: 200, description: 'Updated', schema: BusinessUnitItem },
    errors: { 404: 'Not found', 409: 'Code already used' },
    handler: controller.updateBusinessUnit,
  });

export const regionsRouter = new ModuleRouter('/regions', 'Org')
  .route({
    method: 'get',
    path: '/',
    operationId: 'listRegions',
    summary: 'Regions (geographic grouping of depots)',
    access: { roles: 'any' },
    response: { status: 200, description: 'Regions', schema: RegionList },
    handler: controller.listRegions,
  })
  .route({
    method: 'post',
    path: '/',
    operationId: 'createRegion',
    summary: 'Create a region',
    access: director,
    body: RegionCreateBody,
    response: { status: 201, description: 'Created', schema: RegionItem },
    errors: { 409: 'Code already used' },
    handler: controller.createRegion,
  })
  .route({
    method: 'patch',
    path: '/:id',
    operationId: 'updateRegion',
    summary: 'Rename a region',
    access: director,
    params: IdParams,
    body: RegionUpdateBody,
    response: { status: 200, description: 'Updated', schema: RegionItem },
    errors: { 404: 'Not found' },
    handler: controller.updateRegion,
  });

export const depotsRouter = new ModuleRouter('/depots', 'Org')
  .route({
    method: 'get',
    path: '/',
    operationId: 'listDepots',
    summary: 'Depots of my business units',
    access: { roles: 'any' },
    query: DepotListQuery,
    response: { status: 200, description: 'Depots', schema: DepotList },
    errors: { 403: 'Not your business unit (FORBIDDEN_BUSINESS_UNIT)' },
    handler: controller.listDepots,
  })
  .route({
    method: 'post',
    path: '/',
    operationId: 'createDepot',
    summary: 'Create a depot (in one business unit)',
    access: director,
    body: DepotCreateBody,
    response: { status: 201, description: 'Created', schema: DepotItem },
    errors: { 404: 'Region or business unit not found', 409: 'Code already used' },
    handler: controller.createDepot,
  })
  .route({
    method: 'patch',
    path: '/:id',
    operationId: 'updateDepot',
    summary: 'Update a depot',
    access: director,
    params: IdParams,
    body: DepotUpdateBody,
    response: { status: 200, description: 'Updated', schema: DepotItem },
    errors: { 404: 'Not found' },
    handler: controller.updateDepot,
  })
  .route({
    method: 'delete',
    path: '/:id',
    operationId: 'archiveDepot',
    summary: 'Archive (soft-delete) a depot',
    access: director,
    params: IdParams,
    response: { status: 204, description: 'Archived' },
    errors: { 404: 'Not found', 409: 'Employees still assigned (DEPOT_IN_USE)' },
    handler: controller.archiveDepot,
  });
