import { ModuleRouter } from '../../lib/route.js';
import type { RouteAccess } from '../../lib/route.js';
import { IdParams } from '../../lib/schemas.js';
import { RejectReasonBody } from '../attendance/schemas.js';
import * as c from './controller.js';
import {
  BalanceQuery,
  LeaveBalanceList,
  LeavePolicyBody,
  LeavePolicyItem,
  LeavePolicyList,
  LeavePolicyUpdateBody,
  LeaveRequestCreateBody,
  LeaveRequestItem,
  LeaveRequestPage,
  LeaveRequestQuery,
  LeaveTypeCreateBody,
  LeaveTypeItem,
  LeaveTypeList,
  LeaveTypeUpdateBody,
} from './schemas.js';

const hr: RouteAccess = { roles: ['HR', 'DIRECTOR'] };

export const leaveTypesRouter = new ModuleRouter('/leave-types', 'Leave')
  .route({
    method: 'get',
    path: '/',
    operationId: 'listLeaveTypes',
    summary: 'Leave types',
    access: { roles: 'any' },
    response: { status: 200, description: 'Types', schema: LeaveTypeList },
    handler: c.listTypes,
  })
  .route({
    method: 'post',
    path: '/',
    operationId: 'createLeaveType',
    summary: 'Add a leave type',
    access: hr,
    body: LeaveTypeCreateBody,
    response: { status: 201, description: 'Created', schema: LeaveTypeItem },
    errors: { 409: 'Code exists' },
    handler: c.createType,
  })
  .route({
    method: 'patch',
    path: '/:id',
    operationId: 'updateLeaveType',
    summary: 'Change or deactivate a leave type',
    access: hr,
    params: IdParams,
    body: LeaveTypeUpdateBody,
    response: { status: 200, description: 'Updated', schema: LeaveTypeItem },
    errors: { 404: 'Not found' },
    handler: c.updateType,
  });

export const leavePoliciesRouter = new ModuleRouter('/leave-policies', 'Leave')
  .route({
    method: 'get',
    path: '/',
    operationId: 'listLeavePolicies',
    summary: 'Leave policies (quota per type and employee filter)',
    access: { roles: 'any' },
    response: { status: 200, description: 'Policies', schema: LeavePolicyList },
    handler: c.listPolicies,
  })
  .route({
    method: 'post',
    path: '/',
    operationId: 'createLeavePolicy',
    summary: 'Add a leave policy',
    access: hr,
    body: LeavePolicyBody,
    response: { status: 201, description: 'Created', schema: LeavePolicyItem },
    errors: { 404: 'Leave type not found', 409: 'Same filters exist (POLICY_EXISTS)' },
    handler: c.createPolicy,
  })
  .route({
    method: 'put',
    path: '/:id',
    operationId: 'updateLeavePolicy',
    summary: 'Change the quota of a policy',
    access: hr,
    params: IdParams,
    body: LeavePolicyUpdateBody,
    response: { status: 200, description: 'Updated', schema: LeavePolicyItem },
    errors: { 404: 'Not found' },
    handler: c.updatePolicy,
  })
  .route({
    method: 'delete',
    path: '/:id',
    operationId: 'deleteLeavePolicy',
    summary: 'Remove a policy',
    access: hr,
    params: IdParams,
    response: { status: 204, description: 'Removed' },
    errors: { 404: 'Not found' },
    handler: c.deletePolicy,
  });

export const leaveBalancesRouter = new ModuleRouter('/leave-balances', 'Leave').route({
  method: 'get',
  path: '/',
  operationId: 'getLeaveBalances',
  summary: "An employee's leave balances for a year (applicable types only)",
  access: { roles: 'any' },
  query: BalanceQuery,
  response: { status: 200, description: 'Balances', schema: LeaveBalanceList },
  errors: { 404: 'Employee not found / out of scope' },
  handler: c.balances,
});

export const leaveRequestsRouter = new ModuleRouter('/leave-requests', 'Leave')
  .route({
    method: 'get',
    path: '/',
    operationId: 'listLeaveRequests',
    summary: 'Leave and OD requests: mine, my team, waiting for me, or all (HR / director)',
    access: { roles: 'any' },
    query: LeaveRequestQuery,
    response: { status: 200, description: 'Newest first', schema: LeaveRequestPage },
    errors: { 403: 'scope=all needs HR or the director' },
    handler: c.listRequests,
  })
  .route({
    method: 'post',
    path: '/',
    operationId: 'createLeaveRequest',
    summary: 'Raise leave or OD (for myself, or as an RM for my driver / loadman)',
    description: 'Routed to the subject’s reporting manager. An RM raising for their driver / loadman may approve at once (autoApprove).',
    access: { roles: 'any' },
    body: LeaveRequestCreateBody,
    response: { status: 201, description: 'Created (PENDING, or APPROVED with autoApprove)', schema: LeaveRequestItem },
    errors: {
      403: 'Not your team',
      404: 'Employee or leave type not found',
      409: 'LEAVE_OVERLAP or INSUFFICIENT_BALANCE',
      422: 'LEAVE_NOT_APPLICABLE, LEAVE_SPANS_YEARS, BEFORE_EDIT_WINDOW, NO_APPROVER or NOT_TRACKED',
    },
    handler: c.createRequest,
  })
  .route({
    method: 'post',
    path: '/:id/approve',
    operationId: 'approveLeaveRequest',
    summary: 'Approve (sets attendance and deducts the balance)',
    access: { roles: 'any' },
    params: IdParams,
    response: { status: 200, description: 'Approved', schema: LeaveRequestItem },
    errors: { 404: 'Not found / not yours', 409: 'Already decided' },
    handler: c.approve,
  })
  .route({
    method: 'post',
    path: '/:id/reject',
    operationId: 'rejectLeaveRequest',
    summary: 'Reject (reason required)',
    access: { roles: 'any' },
    params: IdParams,
    body: RejectReasonBody,
    response: { status: 200, description: 'Rejected', schema: LeaveRequestItem },
    errors: { 404: 'Not found / not yours', 409: 'Already decided' },
    handler: c.reject,
  })
  .route({
    method: 'post',
    path: '/:id/cancel',
    operationId: 'cancelLeaveRequest',
    summary: 'Withdraw while pending (requester), or cancel an approved request (approver / HR)',
    access: { roles: 'any' },
    params: IdParams,
    response: { status: 200, description: 'Cancelled', schema: LeaveRequestItem },
    errors: { 403: 'Not allowed', 404: 'Not found', 409: 'Already decided' },
    handler: c.cancel,
  });
