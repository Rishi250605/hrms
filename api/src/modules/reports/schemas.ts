import { registry, z } from '../../lib/openapi.js';
import { IsoDate } from '../../lib/schemas.js';
import { ApprovalStateSchema, AttendanceStatusSchema } from '../attendance/schemas.js';
import { SignedUrlResponse } from '../employees/documents.schemas.js';
import { BusinessUnitRef } from '../employees/schemas.js';
import { PersonRef } from '../users/schemas.js';

/** TODO(business): longest report range. */
export const MAX_REPORT_DAYS = 62;

export const ReportGroupSchema = registry.register('ReportGroup', z.enum(['DRIVER', 'LOADMAN', 'REGIONAL_MANAGER', 'OPERATIONAL_MANAGER', 'HR']));

export const AttendanceReportQuery = z.object({
  businessUnitId: z.uuid().optional(),
  from: IsoDate.optional().openapi({ description: 'Default: first day of the current month' }),
  to: IsoDate.optional().openapi({ description: 'Default: last day of the month of `from`' }),
  role: ReportGroupSchema.optional().openapi({ description: 'Drivers, loadmen, or managers of one role' }),
  employeeId: z.uuid().optional(),
  status: AttendanceStatusSchema.optional().openapi({ description: 'Only days with this status (and people who have one)' }),
  approvalState: ApprovalStateSchema.optional().openapi({ description: 'Only days in this approval state (and people who have one)' }),
});
export const AttendanceExportQuery = AttendanceReportQuery.extend({ format: z.enum(['xlsx', 'pdf']) });

export const ReportSummary = registry.register(
  'AttendanceReportSummary',
  z.object({
    present: z.number().int(),
    absent: z.number().int(),
    halfDay: z.number().int(),
    leave: z.number().int(),
    onDuty: z.number().int(),
    weeklyOff: z.number().int(),
    holiday: z.number().int(),
    pending: z.number().int().openapi({ description: 'Self-marks waiting for approval' }),
    rejected: z.number().int(),
    notMarked: z.number().int().openapi({ description: 'Past days (from joining) with no mark' }),
  }),
);

export const AttendanceReport = registry.register(
  'AttendanceReport',
  z.object({
    from: IsoDate,
    to: IsoDate,
    days: z.array(IsoDate),
    businessUnits: z.array(BusinessUnitRef),
    legend: z.array(z.object({ code: z.string(), label: z.string() })),
    rows: z.array(
      z.object({
        employee: PersonRef.extend({ category: z.string() }),
        businessUnitCode: z.string().nullable(),
        codes: z.array(z.string()).openapi({ description: 'One per day: P, A, HD, L, OD, WO, H; suffix * = pending approval, ! = rejected; empty = no mark' }),
        summary: ReportSummary,
      }),
    ),
    generatedAt: z.string().datetime(),
  }),
);

export const ReportFile = registry.register('ReportFile', SignedUrlResponse.extend({ fileName: z.string(), contentType: z.string() }));

export const DashboardQuery = z.object({ businessUnitId: z.uuid().optional() });

const TodayCard = z.object({
  headcount: z.number().int(),
  present: z.number().int(),
  absent: z.number().int(),
  halfDay: z.number().int(),
  onLeave: z.number().int(),
  onDuty: z.number().int(),
  weeklyOff: z.number().int(),
  notMarked: z.number().int(),
  pendingApproval: z.number().int(),
  presentPct: z.number().openapi({ description: '(present + onDuty + ½ halfDay) / (headcount − leave − weekly off) × 100' }),
});
const Pending = z.object({ attendance: z.number().int(), corrections: z.number().int(), leave: z.number().int(), allowances: z.number().int() });

export const Dashboard = registry.register(
  'Dashboard',
  z.object({
    date: IsoDate,
    month: z.string(),
    businessUnits: z.array(
      z.object({
        businessUnit: BusinessUnitRef,
        today: TodayCard,
        pendingApprovals: Pending.openapi({ description: 'Pending in this BU within what you can see' }),
        allowancesThisMonth: z.object({ requestedPaise: z.number().int(), approvedPaise: z.number().int() }),
        tasksToday: z.array(z.object({ om: PersonRef, total: z.number().int(), completed: z.number().int(), notDone: z.number().int(), pending: z.number().int() })),
      }),
    ),
    me: z.object({
      pendingApprovals: Pending.openapi({ description: 'Waiting for my decision' }),
      tasksOpen: z.number().int(),
      tasksOverdue: z.number().int(),
      myAttendanceToday: z.object({ status: AttendanceStatusSchema, approvalState: ApprovalStateSchema }).nullable(),
      unreadNotifications: z.number().int(),
    }),
  }),
);
