import type { Request } from 'express';
import { contextOf } from '../../lib/context.js';
import type { RouteInput } from '../../lib/route.js';
import type { IdParams } from '../../lib/schemas.js';
import { authUser } from '../employees/controller.js';
import type {
  DutyTemplateCreateBody,
  DutyTemplateUpdateBody,
  FleetListQuery,
  RouteCreateBody,
  RouteUpdateBody,
  VehicleCreateBody,
  VehicleUpdateBody,
} from './schemas.js';
import * as s from './service.js';

type In<B, Q, P> = RouteInput<B, Q, P>;
type List = In<undefined, typeof FleetListQuery, undefined>;

export const listVehicles = (i: List, req: Request) => s.listVehicles(authUser(req), i.query);
export const createVehicle = (i: In<typeof VehicleCreateBody, undefined, undefined>, req: Request) => s.createVehicle(authUser(req), i.body, contextOf(req));
export const updateVehicle = (i: In<typeof VehicleUpdateBody, undefined, typeof IdParams>, req: Request) =>
  s.updateVehicle(authUser(req), i.params.id, i.body, contextOf(req));

export const listRoutes = (i: List, req: Request) => s.listRoutes(authUser(req), i.query);
export const createRoute = (i: In<typeof RouteCreateBody, undefined, undefined>, req: Request) => s.createRoute(authUser(req), i.body, contextOf(req));
export const updateRoute = (i: In<typeof RouteUpdateBody, undefined, typeof IdParams>, req: Request) =>
  s.updateRoute(authUser(req), i.params.id, i.body, contextOf(req));

export const listTemplates = (i: List, req: Request) => s.listTemplates(authUser(req), i.query);
export const createTemplate = (i: In<typeof DutyTemplateCreateBody, undefined, undefined>, req: Request) =>
  s.createTemplate(authUser(req), i.body, contextOf(req));
export const updateTemplate = (i: In<typeof DutyTemplateUpdateBody, undefined, typeof IdParams>, req: Request) =>
  s.updateTemplate(authUser(req), i.params.id, i.body, contextOf(req));
