import { registry, z } from '../../lib/openapi.js';
import { HhMm, IsoDate } from '../../lib/schemas.js';
import { AssignmentRole, DutyStatus } from '../../generated/prisma/enums.js';
import { ComplianceItem, ComplianceOverall, DepotSummary, EmployeeCategorySchema } from '../employees/schemas.js';

export const DutyStatusSchema = registry.register('DutyStatus', z.enum(DutyStatus));
export const AssignmentRoleSchema = registry.register('AssignmentRole', z.enum(AssignmentRole));

export const RosterWarning = registry.register(
  'RosterWarning',
  z.object({
    code: z.enum(['DUTY_HOURS_EXCEEDED', 'MIN_REST_VIOLATED', 'NO_WEEKLY_OFF', 'DOCUMENT_EXPIRING']),
    message: z.string(),
  }),
);

export const RosterEmployee = registry.register(
  'RosterEmployee',
  z.object({ id: z.uuid(), empCode: z.string(), fullName: z.string(), category: EmployeeCategorySchema, phone: z.string() }),
);

export const AssignmentItem = registry.register(
  'AssignmentItem',
  z.object({
    id: z.uuid(),
    dutyId: z.uuid(),
    role: AssignmentRoleSchema,
    isSpare: z.boolean(),
    warnings: z.array(RosterWarning).openapi({ description: 'Warnings accepted when the assignment was made' }),
    employee: RosterEmployee,
  }),
);

export const DutyItem = registry.register(
  'DutyItem',
  z.object({
    id: z.uuid(),
    depotId: z.uuid(),
    dutyDate: IsoDate,
    status: DutyStatusSchema,
    scheduledStart: z.string().datetime(),
    scheduledEnd: z.string().datetime(),
    startTime: HhMm,
    endTime: HhMm,
    crossesMidnight: z.boolean(),
    durationMinutes: z.number().int(),
    route: z.object({ id: z.uuid(), code: z.string(), name: z.string() }).nullable(),
    vehicle: z.object({ id: z.uuid(), regNo: z.string(), type: z.string() }).nullable(),
    template: z.object({ id: z.uuid(), name: z.string() }).nullable(),
    notes: z.string().nullable(),
    /** True when a driver is assigned. TODO(business): required crew per duty. */
    filled: z.boolean(),
    assignments: z.array(AssignmentItem),
  }),
);

export const RosterDay = registry.register(
  'RosterDay',
  z.object({
    date: IsoDate,
    depot: DepotSummary,
    summary: z.object({ duties: z.number().int(), filled: z.number().int(), unfilled: z.number().int(), cancelled: z.number().int() }),
    duties: z.array(DutyItem),
  }),
);

export const RosterQuery = z.object({ depotId: z.uuid(), date: IsoDate });

export const DutyCreateBody = registry.register(
  'DutyCreateBody',
  z.object({
    depotId: z.uuid(),
    dutyDate: IsoDate,
    templateId: z.uuid().optional().openapi({ description: 'Takes times (and the default route) from the template' }),
    startTime: HhMm.optional(),
    endTime: HhMm.optional(),
    crossesMidnight: z.boolean().optional(),
    routeId: z.uuid().optional(),
    vehicleId: z.uuid().optional(),
    notes: z.string().trim().max(500).optional(),
  }),
);

export const DutyUpdateBody = registry.register(
  'DutyUpdateBody',
  z.object({
    startTime: HhMm.optional(),
    endTime: HhMm.optional(),
    crossesMidnight: z.boolean().optional(),
    routeId: z.uuid().nullable().optional(),
    vehicleId: z.uuid().nullable().optional(),
    status: DutyStatusSchema.optional(),
    notes: z.string().trim().max(500).nullable().optional(),
  }),
);

export const AssignmentCreateBody = registry.register(
  'AssignmentCreateBody',
  z.object({
    employeeId: z.uuid(),
    role: AssignmentRoleSchema,
    isSpare: z.boolean().default(false),
  }),
);

export const AssignmentResult = registry.register(
  'AssignmentResult',
  z.object({ assignment: AssignmentItem, warnings: z.array(RosterWarning), duty: DutyItem }),
);

export const SpareItem = registry.register(
  'SpareItem',
  z.object({
    employee: RosterEmployee,
    designation: z.string().nullable(),
    compliance: ComplianceOverall,
    dutyMinutesLast7Days: z.number().int(),
    dutiesOnDate: z.number().int(),
    warnings: z.array(RosterWarning).openapi({ description: 'Rule warnings if assigned to dutyId (empty when dutyId is not given)' }),
  }),
);
export const SpareList = registry.register('SpareList', z.object({ items: z.array(SpareItem) }));
export const SpareQuery = z.object({
  depotId: z.uuid(),
  date: IsoDate,
  role: AssignmentRoleSchema.default('DRIVER'),
  dutyId: z.uuid().optional().openapi({ description: 'Exclude employees whose duties overlap this one, and compute warnings for it' }),
});

export const RosterCopyBody = registry.register(
  'RosterCopyBody',
  z.object({
    depotId: z.uuid(),
    fromDate: IsoDate,
    toDate: IsoDate,
    days: z.number().int().min(1).max(7).default(1).openapi({ description: '1 = copy a day, 7 = copy a week' }),
    includeAssignments: z.boolean().default(true),
  }),
);

export const RosterCopyResult = registry.register(
  'RosterCopyResult',
  z.object({
    createdDuties: z.number().int(),
    existingDuties: z.number().int().openapi({ description: 'Source duties already present on the target day (not copied twice)' }),
    copiedAssignments: z.number().int(),
    skipped: z.array(
      z.object({
        date: IsoDate,
        employeeId: z.uuid(),
        employeeName: z.string(),
        reason: z.string().openapi({ description: 'Error code, e.g. DOCUMENT_INVALID, EMPLOYEE_ON_LEAVE, ROSTER_RULE_VIOLATION' }),
      }),
    ),
  }),
);

/** 409 DOCUMENT_INVALID details. */
export const DocumentInvalidDetails = registry.register(
  'DocumentInvalidDetails',
  z.object({ failing: z.array(ComplianceItem), spares: z.array(SpareItem) }),
);
