import type { z } from 'zod';
import { addDays, dateRange, diffDays, fromDbDate, todayIst, toDbDate } from '../../lib/dates.js';
import { Errors } from '../../lib/errors.js';
import { prisma } from '../../lib/prisma.js';
import type { AuthUser } from '../../lib/context.js';
import type { Prisma } from '../../generated/prisma/client.js';
import type { AttendanceStatus } from '../../generated/prisma/enums.js';
import { employeeWhere, scopeFor } from '../access/scope.js';
import type { AttendanceReport, AttendanceReportQuery } from './schemas.js';
import { MAX_REPORT_DAYS } from './schemas.js';

/**
 * Attendance muster + summary (PHASE-2-FEATURES §9.1). Scope = §11 "Reports": RM self + team,
 * OM self + RMs + RMs' teams, HR / director everyone in their business units.
 */

export const STATUS_CODE: Record<AttendanceStatus, string> = {
  PRESENT: 'P',
  ABSENT: 'A',
  HALF_DAY: 'HD',
  ON_LEAVE: 'L',
  ON_DUTY: 'OD',
  WEEKLY_OFF: 'WO',
  HOLIDAY: 'H',
};
export const LEGEND = [
  { code: 'P', label: 'Present' },
  { code: 'A', label: 'Absent' },
  { code: 'HD', label: 'Half day' },
  { code: 'L', label: 'Leave' },
  { code: 'OD', label: 'On duty' },
  { code: 'WO', label: 'Weekly off' },
  { code: 'H', label: 'Holiday' },
  { code: '*', label: 'Pending approval' },
  { code: '!', label: 'Rejected' },
];

export type Report = z.infer<typeof AttendanceReport>;
type Query = z.infer<typeof AttendanceReportQuery>;
type Summary = Report['rows'][number]['summary'];

export function resolveRange(q: Pick<Query, 'from' | 'to'>) {
  const from = q.from ?? `${todayIst().slice(0, 7)}-01`;
  const to = q.to ?? addDays(`${addDays(`${from.slice(0, 7)}-28`, 4).slice(0, 7)}-01`, -1);
  if (to < from) throw Errors.validation([{ path: ['to'], message: 'To date is before from date' }]);
  if (diffDays(from, to) + 1 > MAX_REPORT_DAYS) throw Errors.validation([{ path: ['to'], message: `At most ${MAX_REPORT_DAYS} days per report` }]);
  return { from, to };
}

function groupWhere(role: Query['role']): Prisma.EmployeeWhereInput {
  switch (role) {
    case 'DRIVER':
    case 'LOADMAN':
      return { category: role, user: null };
    case undefined:
      return {};
    default:
      return { user: { role } };
  }
}

export async function attendanceReport(user: AuthUser, q: Query): Promise<Report> {
  const { from, to } = resolveRange(q);
  const scope = await scopeFor(prisma, user, 'reports', q.businessUnitId);
  const today = todayIst();

  const employees = await prisma.employee.findMany({
    where: {
      AND: [
        employeeWhere(user, scope),
        // A manager in several BUs has their own records in their primary one (assumption §13.2).
        { businessUnits: { some: { businessUnitId: { in: scope.businessUnitIds }, isPrimary: true } } },
        groupWhere(q.role),
        q.employeeId ? { id: q.employeeId } : {},
        // Director's own attendance is not tracked (assumption §13.1).
        { NOT: { user: { role: 'DIRECTOR' } } },
        { joiningDate: { lte: toDbDate(to) } },
        { OR: [{ exitDate: null }, { exitDate: { gte: toDbDate(from) } }] },
      ],
    },
    select: {
      id: true,
      empCode: true,
      fullName: true,
      category: true,
      joiningDate: true,
      exitDate: true,
      user: { select: { role: true } },
      businessUnits: { where: { isPrimary: true }, select: { businessUnit: { select: { code: true } } } },
    },
    orderBy: [{ fullName: 'asc' }, { empCode: 'asc' }],
  });

  const marks = await prisma.attendanceMark.findMany({
    where: {
      employeeId: { in: employees.map((e) => e.id) },
      businessUnitId: { in: scope.businessUnitIds },
      date: { gte: toDbDate(from), lte: toDbDate(to) },
      ...(q.status ? { status: q.status } : {}),
      ...(q.approvalState ? { approvalState: q.approvalState } : {}),
    },
    select: { employeeId: true, date: true, status: true, approvalState: true },
  });
  const byEmployee = new Map<string, Map<string, (typeof marks)[number]>>();
  for (const m of marks) {
    const map = byEmployee.get(m.employeeId) ?? new Map();
    map.set(fromDbDate(m.date), m);
    byEmployee.set(m.employeeId, map);
  }

  const days = dateRange(from, to);
  const filtered = Boolean(q.status || q.approvalState);
  const rows: Report['rows'] = [];
  for (const e of employees) {
    const own = byEmployee.get(e.id) ?? new Map();
    if (filtered && own.size === 0) continue;
    const joined = fromDbDate(e.joiningDate);
    const exited = e.exitDate ? fromDbDate(e.exitDate) : null;
    const s: Summary = { present: 0, absent: 0, halfDay: 0, leave: 0, onDuty: 0, weeklyOff: 0, holiday: 0, pending: 0, rejected: 0, notMarked: 0 };
    const codes = days.map((d) => {
      const m = own.get(d);
      if (!m) {
        if (!filtered && d <= today && d >= joined && (!exited || d <= exited)) s.notMarked += 1;
        return '';
      }
      const code = STATUS_CODE[m.status as AttendanceStatus];
      if (m.approvalState === 'PENDING_APPROVAL') {
        s.pending += 1;
        return `${code}*`;
      }
      if (m.approvalState === 'REJECTED') {
        s.rejected += 1;
        return `${code}!`;
      }
      const key = ({ PRESENT: 'present', ABSENT: 'absent', HALF_DAY: 'halfDay', ON_LEAVE: 'leave', ON_DUTY: 'onDuty', WEEKLY_OFF: 'weeklyOff', HOLIDAY: 'holiday' } as const)[
        m.status as AttendanceStatus
      ];
      s[key] += 1;
      return code;
    });
    rows.push({
      employee: { employeeId: e.id, empCode: e.empCode, name: e.fullName, role: e.user?.role ?? null, category: e.category },
      businessUnitCode: e.businessUnits[0]?.businessUnit.code ?? null,
      codes,
      summary: s,
    });
  }

  const businessUnits = await prisma.businessUnit.findMany({ where: { id: { in: scope.businessUnitIds } }, select: { id: true, code: true, name: true }, orderBy: { code: 'asc' } });
  return { from, to, days, businessUnits, legend: LEGEND, rows, generatedAt: new Date().toISOString() };
}
