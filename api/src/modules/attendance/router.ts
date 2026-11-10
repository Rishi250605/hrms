import { ModuleRouter } from '../../lib/route.js';
import { IdParams } from '../../lib/schemas.js';
import * as c from './controller.js';
import {
  ApprovalListQuery,
  AttendanceMarkItem,
  AttendanceMarkList,
  BulkApproveBody,
  BulkApproveResult,
  BulkAttendanceBody,
  BulkAttendanceResult,
  CorrectionBody,
  CorrectionItem,
  CorrectionList,
  CorrectionQuery,
  MarksQuery,
  RejectReasonBody,
  SelfMarkBody,
  SelfQuery,
  TeamDay,
  TeamQuery,
} from './schemas.js';

export const attendanceRouter = new ModuleRouter('/attendance', 'Attendance')
  .route({
    method: 'get',
    path: '/team',
    operationId: 'getTeamAttendance',
    summary: "RM: the day's drivers and loadmen, pre-filled PRESENT (leave / OD pre-filled from approved requests)",
    access: { roles: ['REGIONAL_MANAGER'] },
    query: TeamQuery,
    response: { status: 200, description: 'Team day', schema: TeamDay },
    errors: { 403: 'Not your business unit' },
    handler: c.team,
  })
  .route({
    method: 'post',
    path: '/team/bulk',
    operationId: 'markTeamAttendance',
    summary: 'RM: mark drivers / loadmen (final; idempotent by clientMutationId)',
    description:
      'Each mark is applied independently: APPLIED, DUPLICATE (replay) or REJECTED (EDIT_WINDOW_CLOSED, FUTURE_DATE, INVALID_ASSIGNMENT, CLIENT_ID_REUSED). ' +
      'Any employee who does not report to the RM refuses the whole request with 403.',
    access: { roles: ['REGIONAL_MANAGER'] },
    body: BulkAttendanceBody,
    response: { status: 200, description: 'Per-mark results', schema: BulkAttendanceResult },
    errors: { 403: 'Employee not in your team' },
    handler: c.teamBulk,
  })
  .route({
    method: 'post',
    path: '/self',
    operationId: 'markSelfAttendance',
    summary: 'Mark my own attendance (goes to my reporting manager for approval)',
    access: { roles: ['REGIONAL_MANAGER', 'OPERATIONAL_MANAGER', 'HR'] },
    body: SelfMarkBody,
    response: { status: 201, description: 'Pending approval', schema: AttendanceMarkItem },
    errors: { 409: 'Already approved (ALREADY_APPROVED)', 422: 'FUTURE_DATE, EDIT_WINDOW_CLOSED or NO_APPROVER' },
    handler: c.markSelf,
  })
  .route({
    method: 'get',
    path: '/self',
    operationId: 'listSelfAttendance',
    summary: 'My own attendance marks',
    access: { roles: 'any' },
    query: SelfQuery,
    response: { status: 200, description: 'Newest first', schema: AttendanceMarkList },
    handler: c.listSelf,
  })
  .route({
    method: 'get',
    path: '/approvals',
    operationId: 'listAttendanceApprovals',
    summary: 'Self-marks of my direct reports (OM: RMs, HR: OMs, director: HR)',
    access: { roles: ['OPERATIONAL_MANAGER', 'HR', 'DIRECTOR'] },
    query: ApprovalListQuery,
    response: { status: 200, description: 'Marks', schema: AttendanceMarkList },
    handler: c.approvals,
  })
  .route({
    method: 'post',
    path: '/approvals/bulk-approve',
    operationId: 'bulkApproveAttendance',
    summary: 'Approve several pending self-marks',
    access: { roles: ['OPERATIONAL_MANAGER', 'HR', 'DIRECTOR'] },
    body: BulkApproveBody,
    response: { status: 200, description: 'Approved and skipped ids', schema: BulkApproveResult },
    handler: c.bulkApprove,
  })
  .route({
    method: 'get',
    path: '/marks',
    operationId: 'listAttendanceMarks',
    summary: 'Attendance marks in my scope (read-only)',
    access: { roles: 'any' },
    query: MarksQuery,
    response: { status: 200, description: 'Marks', schema: AttendanceMarkList },
    handler: c.marks,
  })
  .route({
    method: 'post',
    path: '/corrections',
    operationId: 'requestAttendanceCorrection',
    summary: 'Change a mark after the edit window or after approval (approved by my reporting manager)',
    access: { roles: ['REGIONAL_MANAGER', 'OPERATIONAL_MANAGER', 'HR'] },
    body: CorrectionBody,
    response: { status: 201, description: 'Correction raised', schema: CorrectionItem },
    errors: { 404: 'Employee not in your team', 409: 'EDIT_WINDOW_OPEN or CORRECTION_PENDING', 422: 'NO_APPROVER' },
    handler: c.createCorrection,
  })
  .route({
    method: 'get',
    path: '/corrections',
    operationId: 'listAttendanceCorrections',
    summary: 'Corrections I raised (scope=mine) or that wait for me (scope=approvals)',
    access: { roles: 'any' },
    query: CorrectionQuery,
    response: { status: 200, description: 'Corrections', schema: CorrectionList },
    handler: c.listCorrections,
  })
  .route({
    method: 'post',
    path: '/corrections/:id/approve',
    operationId: 'approveAttendanceCorrection',
    summary: 'Approve a correction (applies the mark)',
    access: { roles: ['OPERATIONAL_MANAGER', 'HR', 'DIRECTOR'] },
    params: IdParams,
    response: { status: 200, description: 'Approved', schema: CorrectionItem },
    errors: { 404: 'Not found / not yours', 409: 'Already decided' },
    handler: c.approveCorrection,
  })
  .route({
    method: 'post',
    path: '/corrections/:id/reject',
    operationId: 'rejectAttendanceCorrection',
    summary: 'Reject a correction (reason required)',
    access: { roles: ['OPERATIONAL_MANAGER', 'HR', 'DIRECTOR'] },
    params: IdParams,
    body: RejectReasonBody,
    response: { status: 200, description: 'Rejected', schema: CorrectionItem },
    errors: { 404: 'Not found / not yours', 409: 'Already decided' },
    handler: c.rejectCorrection,
  })
  .route({
    method: 'post',
    path: '/:id/approve',
    operationId: 'approveAttendance',
    summary: 'Approve a self-mark of a direct report',
    access: { roles: ['OPERATIONAL_MANAGER', 'HR', 'DIRECTOR'] },
    params: IdParams,
    response: { status: 200, description: 'Approved', schema: AttendanceMarkItem },
    errors: { 404: 'Not found / not yours', 409: 'Already decided' },
    handler: c.approve,
  })
  .route({
    method: 'post',
    path: '/:id/reject',
    operationId: 'rejectAttendance',
    summary: 'Reject a self-mark (reason required); it can be corrected and resubmitted',
    access: { roles: ['OPERATIONAL_MANAGER', 'HR', 'DIRECTOR'] },
    params: IdParams,
    body: RejectReasonBody,
    response: { status: 200, description: 'Rejected', schema: AttendanceMarkItem },
    errors: { 404: 'Not found / not yours', 409: 'Already decided' },
    handler: c.reject,
  });
