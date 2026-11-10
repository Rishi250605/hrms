import type { Request } from 'express';
import { contextOf } from '../../lib/context.js';
import { ModuleRouter } from '../../lib/route.js';
import type { RouteInput } from '../../lib/route.js';
import { authUser, originOf } from '../employees/controller.js';
import { dashboard } from './dashboard.js';
import { exportAttendance } from './export.js';
import { AttendanceExportQuery, AttendanceReport, AttendanceReportQuery, Dashboard, DashboardQuery, ReportFile } from './schemas.js';
import { attendanceReport } from './service.js';

type In<B, Q, P> = RouteInput<B, Q, P>;

export const reportsRouter = new ModuleRouter('/reports', 'Reports')
  .route({
    method: 'get',
    path: '/attendance',
    operationId: 'attendanceReport',
    summary: 'Attendance muster and per-employee summary (scoped by §11)',
    access: { roles: 'any' },
    query: AttendanceReportQuery,
    response: { status: 200, description: 'Muster grid + summary', schema: AttendanceReport },
    errors: { 403: 'Business unit not yours' },
    handler: (i: In<undefined, typeof AttendanceReportQuery, undefined>, req: Request) => attendanceReport(authUser(req), i.query),
  })
  .route({
    method: 'get',
    path: '/attendance/export',
    operationId: 'exportAttendanceReport',
    summary: 'Excel (muster + summary sheets) or PDF (landscape muster) download',
    description: 'Generated server-side and returned as a signed URL (≤ 10 min). Every export is audit-logged.',
    access: { roles: 'any' },
    query: AttendanceExportQuery,
    response: { status: 200, description: 'Signed URL', schema: ReportFile },
    errors: { 403: 'Business unit not yours' },
    handler: (i: In<undefined, typeof AttendanceExportQuery, undefined>, req: Request) => exportAttendance(authUser(req), i.query, originOf(req), contextOf(req)),
  })
  .route({
    method: 'get',
    path: '/dashboard',
    operationId: 'getDashboard',
    summary: 'Home screen cards per business unit and my pending items',
    access: { roles: 'any' },
    query: DashboardQuery,
    response: { status: 200, description: 'Dashboard', schema: Dashboard },
    errors: { 403: 'Business unit not yours' },
    handler: (i: In<undefined, typeof DashboardQuery, undefined>, req: Request) => dashboard(authUser(req), i.query.businessUnitId),
  });
