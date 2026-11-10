import type { Request } from 'express';
import { contextOf } from '../../lib/context.js';
import { Errors } from '../../lib/errors.js';
import type { RouteInput } from '../../lib/route.js';
import type { IdParams } from '../../lib/schemas.js';
import type {
  BusinessUnitCreateBody,
  BusinessUnitUpdateBody,
  DepotCreateBody,
  DepotListQuery,
  DepotUpdateBody,
  RegionCreateBody,
  RegionUpdateBody,
} from './schemas.js';
import * as service from './service.js';

const authUser = (req: Request) => {
  if (!req.user) throw Errors.unauthenticated();
  return req.user;
};

export const listBusinessUnits = (_i: unknown, req: Request) => service.listBusinessUnits(authUser(req));
export const createBusinessUnit = (i: RouteInput<typeof BusinessUnitCreateBody, undefined, undefined>, req: Request) =>
  service.createBusinessUnit(i.body, contextOf(req));
export const updateBusinessUnit = (i: RouteInput<typeof BusinessUnitUpdateBody, undefined, typeof IdParams>, req: Request) =>
  service.updateBusinessUnit(i.params.id, i.body, contextOf(req));

export const listRegions = () => service.listRegions();
export const createRegion = (i: RouteInput<typeof RegionCreateBody, undefined, undefined>, req: Request) => service.createRegion(i.body, contextOf(req));
export const updateRegion = (i: RouteInput<typeof RegionUpdateBody, undefined, typeof IdParams>, req: Request) =>
  service.updateRegion(i.params.id, i.body, contextOf(req));

export const listDepots = (i: RouteInput<undefined, typeof DepotListQuery, undefined>, req: Request) => service.listDepots(authUser(req), i.query);
export const createDepot = (i: RouteInput<typeof DepotCreateBody, undefined, undefined>, req: Request) => service.createDepot(i.body, contextOf(req));
export const updateDepot = (i: RouteInput<typeof DepotUpdateBody, undefined, typeof IdParams>, req: Request) =>
  service.updateDepot(i.params.id, i.body, contextOf(req));
export const archiveDepot = (i: RouteInput<undefined, undefined, typeof IdParams>, req: Request) => service.archiveDepot(i.params.id, contextOf(req));
