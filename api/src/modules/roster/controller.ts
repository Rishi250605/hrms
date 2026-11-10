import type { Request } from 'express';
import { contextOf } from '../../lib/context.js';
import type { RouteInput } from '../../lib/route.js';
import type { IdParams } from '../../lib/schemas.js';
import { authUser } from '../employees/controller.js';
import type { AssignmentCreateBody, DutyCreateBody, DutyUpdateBody, RosterCopyBody, RosterQuery, SpareQuery } from './schemas.js';
import * as s from './service.js';

type In<B, Q, P> = RouteInput<B, Q, P>;

export const getRoster = (i: In<undefined, typeof RosterQuery, undefined>, req: Request) => s.getRoster(authUser(req), i.query.depotId, i.query.date);
export const spares = (i: In<undefined, typeof SpareQuery, undefined>, req: Request) => s.getSpares(authUser(req), i.query);
export const copy = (i: In<typeof RosterCopyBody, undefined, undefined>, req: Request) => s.copyRoster(authUser(req), i.body, contextOf(req));
export const createDuty = (i: In<typeof DutyCreateBody, undefined, undefined>, req: Request) => s.createDuty(authUser(req), i.body, contextOf(req));
export const updateDuty = (i: In<typeof DutyUpdateBody, undefined, typeof IdParams>, req: Request) =>
  s.updateDuty(authUser(req), i.params.id, i.body, contextOf(req));
export const addAssignment = (i: In<typeof AssignmentCreateBody, undefined, typeof IdParams>, req: Request) =>
  s.addAssignment(authUser(req), i.params.id, i.body, contextOf(req));
export const removeAssignment = (i: In<undefined, undefined, typeof IdParams>, req: Request) => s.removeAssignment(authUser(req), i.params.id, contextOf(req));
