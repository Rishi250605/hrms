import { registry, z } from '../../lib/openapi.js';
import { HhMm, IsoDate, PageQuery } from '../../lib/schemas.js';
import { RequestStatusSchema } from '../attendance/schemas.js';
import { BusinessUnitRef, EmployeeCategorySchema, EmploymentTypeSchema } from '../employees/schemas.js';
import { PersonRef } from '../users/schemas.js';
import { StateCode } from '../org/schemas.js';

export const AccrualRuleSchema = registry.register(
  'AccrualRule',
  z.object({
    type: z.enum(['MONTHLY', 'ANNUAL', 'NONE']).openapi({ description: 'MONTHLY: quota/12 each month; ANNUAL: full quota once a year; NONE: no balance kept (e.g. LOP)' }),
  }),
);

export const LeaveTypeItem = registry.register(
  'LeaveTypeItem',
  z.object({
    id: z.uuid(),
    code: z.string(),
    name: z.string(),
    paid: z.boolean(),
    accrualRule: AccrualRuleSchema,
    carryForwardMax: z.number(),
    encashable: z.boolean(),
    isActive: z.boolean(),
    tracksBalance: z.boolean(),
  }),
);
export const LeaveTypeList = registry.register('LeaveTypeList', z.object({ items: z.array(LeaveTypeItem) }));
export const LeaveTypeCreateBody = registry.register(
  'LeaveTypeCreateBody',
  z.object({
    code: z
      .string()
      .trim()
      .toUpperCase()
      .regex(/^[A-Z0-9_]{1,10}$/),
    name: z.string().trim().min(2).max(60),
    paid: z.boolean(),
    accrualRule: AccrualRuleSchema,
    carryForwardMax: z.number().min(0).max(365).default(0),
    encashable: z.boolean().default(false),
  }),
);
export const LeaveTypeUpdateBody = registry.register(
  'LeaveTypeUpdateBody',
  z.object({
    name: z.string().trim().min(2).max(60).optional(),
    paid: z.boolean().optional(),
    accrualRule: AccrualRuleSchema.optional(),
    carryForwardMax: z.number().min(0).max(365).optional(),
    encashable: z.boolean().optional(),
    isActive: z.boolean().optional(),
  }),
);

export const LeavePolicyItem = registry.register(
  'LeavePolicyItem',
  z.object({
    id: z.uuid(),
    leaveTypeId: z.uuid(),
    leaveTypeCode: z.string(),
    category: EmployeeCategorySchema.nullable(),
    employmentType: EmploymentTypeSchema.nullable(),
    state: z.string().nullable(),
    annualQuota: z.number(),
  }),
);
export const LeavePolicyList = registry.register('LeavePolicyList', z.object({ items: z.array(LeavePolicyItem) }));
export const LeavePolicyBody = registry.register(
  'LeavePolicyBody',
  z.object({
    leaveTypeId: z.uuid(),
    category: EmployeeCategorySchema.nullable().default(null),
    employmentType: EmploymentTypeSchema.nullable().default(null),
    state: StateCode.nullable().default(null),
    annualQuota: z.number().min(0).max(365),
  }),
);
export const LeavePolicyUpdateBody = registry.register('LeavePolicyUpdateBody', z.object({ annualQuota: z.number().min(0).max(365) }));

export const LeaveBalanceItem = registry.register(
  'LeaveBalanceItem',
  z.object({
    leaveTypeId: z.uuid(),
    leaveTypeCode: z.string(),
    leaveTypeName: z.string(),
    year: z.number().int(),
    tracksBalance: z.boolean(),
    annualQuota: z.number().nullable().openapi({ description: 'From the matching policy; null when no policy applies' }),
    opening: z.number(),
    accrued: z.number(),
    used: z.number(),
    encashed: z.number(),
    closing: z.number(),
    pending: z.number().openapi({ description: 'Days in pending requests' }),
    available: z.number().openapi({ description: 'closing - pending' }),
  }),
);
export const LeaveBalanceList = registry.register('LeaveBalanceList', z.object({ employeeId: z.uuid(), year: z.number().int(), items: z.array(LeaveBalanceItem) }));
export const BalanceQuery = z.object({ employeeId: z.uuid(), year: z.coerce.number().int().min(2000).max(2100).optional() });

export const LeaveKindSchema = registry.register('LeaveKind', z.enum(['LEAVE', 'OD']));

export const LeaveRequestItem = registry.register(
  'LeaveRequestItem',
  z.object({
    id: z.uuid(),
    kind: LeaveKindSchema,
    employee: PersonRef,
    businessUnit: BusinessUnitRef,
    leaveType: z.object({ id: z.uuid(), code: z.string(), name: z.string() }).nullable(),
    fromDate: IsoDate,
    toDate: IsoDate,
    fromHalf: z.boolean(),
    toHalf: z.boolean(),
    days: z.number(),
    reason: z.string(),
    odLocation: z.string().nullable(),
    odPurpose: z.string().nullable(),
    odFromTime: HhMm.nullable(),
    odToTime: HhMm.nullable(),
    status: RequestStatusSchema,
    raisedByName: z.string(),
    approver: PersonRef.nullable(),
    decidedAt: z.string().datetime().nullable(),
    decidedByName: z.string().nullable(),
    rejectionReason: z.string().nullable(),
    canDecide: z.boolean(),
    canCancel: z.boolean(),
    warnings: z.array(z.string()).openapi({ description: 'e.g. INSUFFICIENT_BALANCE when the balance setting is WARN' }),
    createdAt: z.string().datetime(),
  }),
);
export const LeaveRequestPage = registry.register('LeaveRequestPage', z.object({ items: z.array(LeaveRequestItem), nextCursor: z.uuid().nullable() }));
export const LeaveRequestQuery = PageQuery.extend({
  scope: z.enum(['mine', 'team', 'approvals', 'all']).default('mine').openapi({ description: 'mine: about me; team: my reports; approvals: waiting for me; all: HR / director' }),
  status: RequestStatusSchema.optional(),
  kind: LeaveKindSchema.optional(),
  businessUnitId: z.uuid().optional(),
  employeeId: z.uuid().optional(),
  from: IsoDate.optional(),
  to: IsoDate.optional(),
});

export const LeaveRequestCreateBody = registry.register(
  'LeaveRequestCreateBody',
  z.object({
    subjectEmployeeId: z.uuid().optional().openapi({ description: 'Whose leave / OD; omit for yourself. RMs raise for their drivers / loadmen.' }),
    kind: LeaveKindSchema,
    leaveTypeId: z.uuid().optional().openapi({ description: 'Required for LEAVE' }),
    fromDate: IsoDate,
    toDate: IsoDate,
    fromHalf: z.boolean().optional().openapi({ description: 'Starts at mid-day on fromDate' }),
    toHalf: z.boolean().optional().openapi({ description: 'Ends at mid-day on toDate' }),
    reason: z.string().trim().min(3).max(500),
    odLocation: z.string().trim().min(2).max(200).optional().openapi({ description: 'Required for OD' }),
    odPurpose: z.string().trim().min(2).max(500).optional().openapi({ description: 'Required for OD' }),
    odFromTime: HhMm.optional(),
    odToTime: HhMm.optional(),
    autoApprove: z.boolean().optional().openapi({ description: 'RM raising for their driver / loadman: "Submit and approve"' }),
  }),
);