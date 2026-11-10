import type { Request } from 'express';
import { contextOf } from '../../lib/context.js';
import { ModuleRouter } from '../../lib/route.js';
import type { RouteAccess, RouteInput } from '../../lib/route.js';
import { IdParams } from '../../lib/schemas.js';
import { RejectReasonBody } from '../attendance/schemas.js';
import { authUser, originOf } from '../employees/controller.js';
import {
  AllowanceApproveBody,
  AllowanceCreateBody,
  AllowanceFiles,
  AllowanceItem,
  AllowanceList,
  AllowancePage,
  AllowanceQuery,
  AllowanceSummary,
  AllowanceSummaryQuery,
  AllowanceTypeCreateBody,
  AllowanceTypeItem,
  AllowanceTypeList,
  AllowanceTypeUpdateBody,
  BatchApproveResult,
  BatchParams,
} from './schemas.js';
import * as s from './service.js';

type In<B, Q, P> = RouteInput<B, Q, P>;
const hr: RouteAccess = { roles: ['HR', 'DIRECTOR'] };

export const allowanceTypesRouter = new ModuleRouter('/allowance-types', 'Allowances')
  .route({
    method: 'get',
    path: '/',
    operationId: 'listAllowanceTypes',
    summary: 'Allowance types',
    access: { roles: 'any' },
    response: { status: 200, description: 'Types', schema: AllowanceTypeList },
    handler: () => s.listTypes(),
  })
  .route({
    method: 'post',
    path: '/',
    operationId: 'createAllowanceType',
    summary: 'Add an allowance type',
    access: hr,
    body: AllowanceTypeCreateBody,
    response: { status: 201, description: 'Created', schema: AllowanceTypeItem },
    errors: { 409: 'Code exists' },
    handler: (i: In<typeof AllowanceTypeCreateBody, undefined, undefined>, req: Request) => s.createType(i.body, contextOf(req)),
  })
  .route({
    method: 'patch',
    path: '/:id',
    operationId: 'updateAllowanceType',
    summary: 'Change, limit or deactivate an allowance type',
    access: hr,
    params: IdParams,
    body: AllowanceTypeUpdateBody,
    response: { status: 200, description: 'Updated', schema: AllowanceTypeItem },
    errors: { 404: 'Not found' },
    handler: (i: In<typeof AllowanceTypeUpdateBody, undefined, typeof IdParams>, req: Request) => s.updateType(i.params.id, i.body, contextOf(req)),
  });

export const allowancesRouter = new ModuleRouter('/allowances', 'Allowances')
  .route({
    method: 'get',
    path: '/',
    operationId: 'listAllowances',
    summary: 'Allowance requests: mine, my team, waiting for me, or all (HR / director)',
    access: { roles: 'any' },
    query: AllowanceQuery,
    response: { status: 200, description: 'Newest first', schema: AllowancePage },
    errors: { 403: 'scope=all needs HR or the director' },
    handler: (i: In<undefined, typeof AllowanceQuery, undefined>, req: Request) => s.listAllowances(authUser(req), i.query),
  })
  .route({
    method: 'get',
    path: '/summary',
    operationId: 'allowanceMonthlySummary',
    summary: 'Monthly totals per business unit',
    access: hr,
    query: AllowanceSummaryQuery,
    response: { status: 200, description: 'Totals', schema: AllowanceSummary },
    handler: (i: In<undefined, typeof AllowanceSummaryQuery, undefined>, req: Request) => s.monthlySummary(authUser(req), i.query),
  })
  .route({
    method: 'post',
    path: '/',
    operationId: 'createAllowance',
    summary: 'Raise an allowance (RM: self or team, one request per beneficiary; OM: self)',
    description: 'A comment and/or a voice note is required. Upload the voice note / receipt first with POST /uploads/presign.',
    access: { roles: ['REGIONAL_MANAGER', 'OPERATIONAL_MANAGER'] },
    body: AllowanceCreateBody,
    response: { status: 201, description: 'Created requests (same batchId)', schema: AllowanceList },
    errors: { 403: 'Beneficiary not in your team', 404: 'Type not found', 422: 'AMOUNT_ABOVE_LIMIT, FILE_NOT_UPLOADED or NO_APPROVER' },
    handler: (i: In<typeof AllowanceCreateBody, undefined, undefined>, req: Request) => s.createAllowance(authUser(req), i.body, contextOf(req)),
  })
  .route({
    method: 'post',
    path: '/batch/:batchId/approve',
    operationId: 'approveAllowanceBatch',
    summary: 'Approve a whole batch at the requested amounts',
    access: { roles: ['OPERATIONAL_MANAGER', 'HR', 'DIRECTOR'] },
    params: BatchParams,
    response: { status: 200, description: 'Approved and skipped ids', schema: BatchApproveResult },
    errors: { 404: 'Nothing to approve' },
    handler: (i: In<undefined, undefined, typeof BatchParams>, req: Request) => s.approveBatch(authUser(req), i.params.batchId, contextOf(req)),
  })
  .route({
    method: 'get',
    path: '/:id/files',
    operationId: 'getAllowanceFiles',
    summary: 'Signed URLs of the voice note and receipt (≤ 10 min, audited)',
    access: { roles: 'any' },
    params: IdParams,
    response: { status: 200, description: 'Files', schema: AllowanceFiles },
    errors: { 404: 'Not found' },
    handler: (i: In<undefined, undefined, typeof IdParams>, req: Request) => s.allowanceFiles(authUser(req), i.params.id, originOf(req), contextOf(req)),
  })
  .route({
    method: 'post',
    path: '/:id/approve',
    operationId: 'approveAllowance',
    summary: 'Approve (optionally a different amount, with a comment)',
    access: { roles: ['OPERATIONAL_MANAGER', 'HR', 'DIRECTOR'] },
    params: IdParams,
    body: AllowanceApproveBody,
    response: { status: 200, description: 'Approved', schema: AllowanceItem },
    errors: { 404: 'Not found / not yours', 409: 'Already decided' },
    handler: (i: In<typeof AllowanceApproveBody, undefined, typeof IdParams>, req: Request) => s.approveAllowance(authUser(req), i.params.id, i.body, contextOf(req)),
  })
  .route({
    method: 'post',
    path: '/:id/reject',
    operationId: 'rejectAllowance',
    summary: 'Reject (reason required)',
    access: { roles: ['OPERATIONAL_MANAGER', 'HR', 'DIRECTOR'] },
    params: IdParams,
    body: RejectReasonBody,
    response: { status: 200, description: 'Rejected', schema: AllowanceItem },
    errors: { 404: 'Not found / not yours', 409: 'Already decided' },
    handler: (i: In<typeof RejectReasonBody, undefined, typeof IdParams>, req: Request) => s.rejectAllowance(authUser(req), i.params.id, i.body.reason, contextOf(req)),
  });
