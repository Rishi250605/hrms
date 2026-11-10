import type { Request } from 'express';
import { contextOf } from '../../lib/context.js';
import type { RouteInput } from '../../lib/route.js';
import type { IdParams } from '../../lib/schemas.js';
import { authUser } from '../employees/controller.js';
import type {
  ApprovalListQuery,
  BulkApproveBody,
  BulkAttendanceBody,
  CorrectionBody,
  CorrectionQuery,
  MarksQuery,
  RejectReasonBody,
  SelfMarkBody,
  SelfQuery,
  TeamQuery,
} from './schemas.js';
import * as s from './service.js';

type In<B, Q, P> = RouteInput<B, Q, P>;

export const team = (i: In<undefined, typeof TeamQuery, undefined>, req: Request) => s.getTeamDay(authUser(req), i.query.date, i.query.businessUnitId);
export const teamBulk = (i: In<typeof BulkAttendanceBody, undefined, undefined>, req: Request) => s.bulkTeamMark(authUser(req), i.body, contextOf(req));
export const markSelf = (i: In<typeof SelfMarkBody, undefined, undefined>, req: Request) => s.markSelf(authUser(req), i.body, contextOf(req));
export const listSelf = (i: In<undefined, typeof SelfQuery, undefined>, req: Request) => s.listSelf(authUser(req), i.query.from, i.query.to);
export const approvals = (i: In<undefined, typeof ApprovalListQuery, undefined>, req: Request) => s.listApprovals(authUser(req), i.query.state, i.query.businessUnitId);
export const approve = (i: In<undefined, undefined, typeof IdParams>, req: Request) => s.approveMark(authUser(req), i.params.id, contextOf(req));
export const reject = (i: In<typeof RejectReasonBody, undefined, typeof IdParams>, req: Request) => s.rejectMark(authUser(req), i.params.id, i.body.reason, contextOf(req));
export const bulkApprove = (i: In<typeof BulkApproveBody, undefined, undefined>, req: Request) => s.bulkApprove(authUser(req), i.body.ids, contextOf(req));
export const marks = (i: In<undefined, typeof MarksQuery, undefined>, req: Request) => s.listMarks(authUser(req), i.query);
export const createCorrection = (i: In<typeof CorrectionBody, undefined, undefined>, req: Request) => s.requestCorrection(authUser(req), i.body, contextOf(req));
export const listCorrections = (i: In<undefined, typeof CorrectionQuery, undefined>, req: Request) => s.listCorrections(authUser(req), i.query);
export const approveCorrection = (i: In<undefined, undefined, typeof IdParams>, req: Request) => s.approveCorrection(authUser(req), i.params.id, contextOf(req));
export const rejectCorrection = (i: In<typeof RejectReasonBody, undefined, typeof IdParams>, req: Request) =>
  s.rejectCorrection(authUser(req), i.params.id, i.body.reason, contextOf(req));
