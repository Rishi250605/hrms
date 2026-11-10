import { registry, z } from '../../lib/openapi.js';
import { HhMm, IsoDate, PageQuery } from '../../lib/schemas.js';
import { ApprovalState, AttendanceSource, AttendanceStatus, RequestStatus } from '../../generated/prisma/enums.js';
import { BusinessUnitRef, DepotSummary, EmployeeCategorySchema } from '../employees/schemas.js';
import { PersonRef, RoleSchema } from '../users/schemas.js';

export const AttendanceStatusSchema = registry.register('AttendanceStatus', z.enum(AttendanceStatus));
export const AttendanceSourceSchema = registry.register('AttendanceSource', z.enum(AttendanceSource));
export const ApprovalStateSchema = registry.register('ApprovalState', z.enum(ApprovalState));
export const RequestStatusSchema = registry.register('RequestStatus', z.enum(RequestStatus));

export const AttendanceEmployee = registry.register(
  'AttendanceEmployee',
  z.object({ id: z.uuid(), empCode: z.string(), fullName: z.string(), category: EmployeeCategorySchema, role: RoleSchema.nullable() }),
);

export const AttendanceMarkItem = registry.register(
  'AttendanceMarkItem',
  z.object({
    id: z.uuid(),
    employee: AttendanceEmployee,
    businessUnit: BusinessUnitRef,
    date: IsoDate,
    status: AttendanceStatusSchema,
    approvalState: ApprovalStateSchema,
    source: AttendanceSourceSchema,
    note: z.string().nullable(),
    markedAt: z.string().datetime(),
    markedByName: z.string(),
    approver: PersonRef.nullable(),
    decidedAt: z.string().datetime().nullable(),
    decidedByName: z.string().nullable(),
    rejectionReason: z.string().nullable(),
    canDecide: z.boolean().openapi({ description: 'True when the caller may approve / reject it' }),
    clientMutationId: z.string().nullable(),
  }),
);
export const AttendanceMarkList = registry.register('AttendanceMarkList', z.object({ items: z.array(AttendanceMarkItem) }));

export const TeamRow = registry.register(
  'TeamAttendanceRow',
  z.object({
    employee: AttendanceEmployee,
    designation: z.string().nullable(),
    depot: DepotSummary.nullable(),
    businessUnit: BusinessUnitRef,
    duties: z.array(z.object({ dutyId: z.uuid(), assignmentId: z.uuid(), startTime: HhMm, endTime: HhMm, routeCode: z.string().nullable() })),
    leave: z
      .object({ leaveRequestId: z.uuid(), kind: z.enum(['LEAVE', 'OD']), code: z.string().nullable(), half: z.boolean() })
      .nullable()
      .openapi({ description: 'Approved leave or OD covering the date' }),
    mark: AttendanceMarkItem.nullable(),
    /** Pre-fill: ON_LEAVE / HALF_DAY / ON_DUTY from approved leave or OD, otherwise PRESENT (§4.2). */
    suggestedStatus: AttendanceStatusSchema,
  }),
);

export const TeamDay = registry.register(
  'TeamAttendanceDay',
  z.object({
    date: IsoDate,
    editable: z.boolean().openapi({ description: 'False once the edit window closed (use a correction)' }),
    editableUntil: z.string().datetime(),
    summary: z.object({ employees: z.number().int(), marked: z.number().int(), pending: z.number().int() }),
    rows: z.array(TeamRow),
  }),
);
export const TeamQuery = z.object({ date: IsoDate, businessUnitId: z.uuid().optional() });

export const BulkMark = registry.register(
  'BulkMark',
  z.object({
    clientMutationId: z.string().min(8).max(64).openapi({ description: 'Client-generated id (UUID); replays of the same id are no-ops' }),
    employeeId: z.uuid(),
    date: IsoDate,
    status: AttendanceStatusSchema,
    dutyAssignmentId: z.uuid().optional(),
    note: z.string().trim().max(300).optional(),
  }),
);
export const BulkAttendanceBody = registry.register('BulkAttendanceBody', z.object({ marks: z.array(BulkMark).min(1).max(500) }));

export const BulkResultItem = registry.register(
  'BulkResultItem',
  z.object({
    clientMutationId: z.string(),
    employeeId: z.uuid(),
    date: IsoDate,
    outcome: z.enum(['APPLIED', 'DUPLICATE', 'REJECTED']),
    error: z.object({ code: z.string(), message: z.string() }).nullable(),
  }),
);
export const BulkAttendanceResult = registry.register(
  'BulkAttendanceResult',
  z.object({ applied: z.number().int(), duplicates: z.number().int(), rejected: z.number().int(), results: z.array(BulkResultItem) }),
);

export const SelfMarkBody = registry.register(
  'SelfMarkBody',
  z.object({
    date: IsoDate,
    status: z.enum(['PRESENT', 'ABSENT', 'HALF_DAY', 'ON_DUTY', 'WEEKLY_OFF', 'HOLIDAY']).openapi({ description: 'Leave comes from an approved leave request' }),
    note: z.string().trim().max(300).optional(),
  }),
);
export const SelfQuery = z.object({ from: IsoDate, to: IsoDate });

export const ApprovalListQuery = z.object({
  state: ApprovalStateSchema.default('PENDING_APPROVAL'),
  businessUnitId: z.uuid().optional(),
});
export const RejectReasonBody = registry.register('RejectReasonBody', z.object({ reason: z.string().trim().min(3).max(500) }));
export const BulkApproveBody = registry.register('BulkApproveBody', z.object({ ids: z.array(z.uuid()).min(1).max(200) }));
export const BulkApproveResult = registry.register(
  'BulkApproveResult',
  z.object({ approved: z.array(z.uuid()), skipped: z.array(z.object({ id: z.uuid(), reason: z.string() })) }),
);

export const MarksQuery = PageQuery.omit({ cursor: true, limit: true }).extend({
  from: IsoDate,
  to: IsoDate,
  businessUnitId: z.uuid().optional(),
  employeeId: z.uuid().optional(),
});

export const CorrectionBody = registry.register(
  'CorrectionBody',
  z.object({
    employeeId: z.uuid().openapi({ description: 'Yourself, or (RM) one of your drivers / loadmen' }),
    date: IsoDate,
    status: AttendanceStatusSchema,
    note: z.string().trim().max(300).optional(),
    reason: z.string().trim().min(3).max(500),
  }),
);

export const CorrectionItem = registry.register(
  'CorrectionItem',
  z.object({
    id: z.uuid(),
    employee: AttendanceEmployee,
    businessUnit: BusinessUnitRef,
    date: IsoDate,
    fromStatus: AttendanceStatusSchema.nullable(),
    toStatus: AttendanceStatusSchema,
    reason: z.string(),
    status: RequestStatusSchema,
    raisedByName: z.string(),
    approver: PersonRef.nullable(),
    decidedAt: z.string().datetime().nullable(),
    rejectionReason: z.string().nullable(),
    canDecide: z.boolean(),
    createdAt: z.string().datetime(),
  }),
);
export const CorrectionList = registry.register('CorrectionList', z.object({ items: z.array(CorrectionItem) }));
export const CorrectionQuery = z.object({
  scope: z.enum(['mine', 'approvals']).default('mine'),
  status: RequestStatusSchema.optional(),
  businessUnitId: z.uuid().optional(),
});
