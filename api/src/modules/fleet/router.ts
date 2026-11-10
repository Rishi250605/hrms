import { ModuleRouter } from '../../lib/route.js';
import type { RouteAccess } from '../../lib/route.js';
import { IdParams } from '../../lib/schemas.js';
import * as c from './controller.js';
import {
  DutyTemplateCreateBody,
  DutyTemplateItem,
  DutyTemplateList,
  DutyTemplateUpdateBody,
  FleetListQuery,
  RouteCreateBody,
  RouteItem,
  RouteList,
  RouteUpdateBody,
  VehicleCreateBody,
  VehicleItem,
  VehicleList,
  VehicleUpdateBody,
} from './schemas.js';

/** Fleet master data is maintained by any manager within their depot scope. TODO(business): confirm who may edit it. */
const editors: RouteAccess = { roles: 'any' };

export const vehiclesRouter = new ModuleRouter('/vehicles', 'Fleet')
  .route({
    method: 'get',
    path: '/',
    operationId: 'listVehicles',
    summary: 'Vehicles in my scope',
    access: { roles: 'any' },
    query: FleetListQuery,
    response: { status: 200, description: 'Vehicles', schema: VehicleList },
    handler: c.listVehicles,
  })
  .route({
    method: 'post',
    path: '/',
    operationId: 'createVehicle',
    summary: 'Add a vehicle',
    access: editors,
    body: VehicleCreateBody,
    response: { status: 201, description: 'Created', schema: VehicleItem },
    errors: { 404: 'Depot not found / out of scope', 409: 'Registration already exists' },
    handler: c.createVehicle,
  })
  .route({
    method: 'patch',
    path: '/:id',
    operationId: 'updateVehicle',
    summary: 'Update a vehicle (status, depot, …)',
    access: editors,
    params: IdParams,
    body: VehicleUpdateBody,
    response: { status: 200, description: 'Updated', schema: VehicleItem },
    errors: { 404: 'Not found' },
    handler: c.updateVehicle,
  });

export const routesRouter = new ModuleRouter('/routes', 'Fleet')
  .route({
    method: 'get',
    path: '/',
    operationId: 'listRoutes',
    summary: 'Routes in my scope',
    access: { roles: 'any' },
    query: FleetListQuery,
    response: { status: 200, description: 'Routes', schema: RouteList },
    handler: c.listRoutes,
  })
  .route({
    method: 'post',
    path: '/',
    operationId: 'createRoute',
    summary: 'Add a route',
    access: editors,
    body: RouteCreateBody,
    response: { status: 201, description: 'Created', schema: RouteItem },
    errors: { 404: 'Depot not found / out of scope', 409: 'Code already exists' },
    handler: c.createRoute,
  })
  .route({
    method: 'patch',
    path: '/:id',
    operationId: 'updateRoute',
    summary: 'Update or archive a route',
    access: editors,
    params: IdParams,
    body: RouteUpdateBody,
    response: { status: 200, description: 'Updated', schema: RouteItem },
    errors: { 404: 'Not found' },
    handler: c.updateRoute,
  });

export const dutyTemplatesRouter = new ModuleRouter('/duty-templates', 'Fleet')
  .route({
    method: 'get',
    path: '/',
    operationId: 'listDutyTemplates',
    summary: 'Duty templates (shifts) in my scope',
    access: { roles: 'any' },
    query: FleetListQuery,
    response: { status: 200, description: 'Templates', schema: DutyTemplateList },
    handler: c.listTemplates,
  })
  .route({
    method: 'post',
    path: '/',
    operationId: 'createDutyTemplate',
    summary: 'Add a duty template',
    access: editors,
    body: DutyTemplateCreateBody,
    response: { status: 201, description: 'Created', schema: DutyTemplateItem },
    errors: { 404: 'Depot not found / out of scope' },
    handler: c.createTemplate,
  })
  .route({
    method: 'patch',
    path: '/:id',
    operationId: 'updateDutyTemplate',
    summary: 'Update or archive a duty template',
    access: editors,
    params: IdParams,
    body: DutyTemplateUpdateBody,
    response: { status: 200, description: 'Updated', schema: DutyTemplateItem },
    errors: { 404: 'Not found' },
    handler: c.updateTemplate,
  });
