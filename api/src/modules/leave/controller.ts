import type { Request } from 'express';
import { contextOf } from '../../lib/context.js';
import type { RouteInput } from '../../lib/route.js';
import type { IdParams } from '../../lib/schemas.js';
import type { RejectReasonBody } from '../attendance/schemas.js';
import { authUser } from '../employees/controller.js';
import type {
  BalanceQuery,
  LeavePolicyBody,
  LeavePolicyUpdateBody,
  LeaveRequestCreateBody,
  LeaveRequestQuery,
  LeaveTypeCreateBody,
  LeaveTypeUpdateBody,
} from './schemas.js';
import * as s from './service.js';

type In<B, Q, P> = RouteInput<B, Q, P>;

export const listTypes = () => s.listTypes();
export const createType = (i: In<typeof LeaveTypeCreateBody, undefined, undefined>, req: Request) => s.createType(i.body, contextOf(req));
export const updateType = (i: In<typeof LeaveTypeUpdateBody, undefined, typeof IdParams>, req: Request) => s.updateType(i.params.id, i.body, contextOf(req));

export const listPolicies = () => s.listPolicies();
export const createPolicy = (i: In<typeof LeavePolicyBody, undefined, undefined>, req: Request) => s.createPolicy(i.body, contextOf(req));
export const updatePolicy = (i: In<typeof LeavePolicyUpdateBody, undefined, typeof IdParams>, req: Request) => s.updatePolicy(i.params.id, i.body, contextOf(req));
export const deletePolicy = (i: In<undefined, undefined, typeof IdParams>, req: Request) => s.deletePolicy(i.params.id, contextOf(req));

export const balances = (i: In<undefined, typeof BalanceQuery, undefined>, req: Request) => s.getBalances(authUser(req), i.query);
export const listRequests = (i: In<undefined, typeof LeaveRequestQuery, undefined>, req: Request) => s.listRequests(authUser(req), i.query);
export const createRequest = (i: In<typeof LeaveRequestCreateBody, undefined, undefined>, req: Request) => s.createRequest(authUser(req), i.body, contextOf(req));
export const approve = (i: In<undefined, undefined, typeof IdParams>, req: Request) => s.approveRequest(authUser(req), i.params.id, contextOf(req));
export const reject = (i: In<typeof RejectReasonBody, undefined, typeof IdParams>, req: Request) => s.rejectRequest(authUser(req), i.params.id, i.body.reason, contextOf(req));
export const cancel = (i: In<undefined, undefined, typeof IdParams>, req: Request) => s.cancelRequest(authUser(req), i.params.id, contextOf(req));
