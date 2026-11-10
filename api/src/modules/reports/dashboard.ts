import type { z } from 'zod';
import { todayIst, toDbDate, addDays } from '../../lib/dates.js';
import { prisma } from '../../lib/prisma.js';
import type { AuthUser } from '../../lib/context.js';
import type { Prisma } from '../../generated/prisma/client.js';
import { businessUnitsFor, visibleEmployeeIds } from '../access/scope.js';
import { routedTo } from '../attendance/service.js';
import { completionByOm } from '../tasks/service.js';
import type { Dashboard } from './schemas.js';

/**
 * Home screen data (§9.2). Per business unit: today's attendance, pending approvals, this month's
 * allowances and today's task completion per OM — all limited to what the viewer may see (§11 Reports).
 * `me` holds the viewer's own to-do counts.
 */

type Card = z.infer<typeof Dashboard>['businessUnits'][number];

const pct = (n: number, d: number) => (d > 0 ? Math.round((n / d) * 1000) / 10 : 0);

export async function dashboard(user: AuthUser, businessUnitId?: string): Promise<z.infer<typeof Dashboard>> {
  const today = todayIst();
  const month = today.slice(0, 7);
  const monthStart = toDbDate(`${month}-01`);
  const nextMonth = toDbDate(`${addDays(`${month}-28`, 4).slice(0, 7)}-01`);
  const bus = businessUnitsFor(user, businessUnitId);
  const visible = await visibleEmployeeIds(prisma, user, 'reports');
  const subject = (field: string) => (visible ? { [field]: { in: visible } } : {});

  const units = await prisma.businessUnit.findMany({ where: { id: { in: bus } }, select: { id: true, code: true, name: true }, orderBy: { code: 'asc' } });
  const cards: Card[] = [];
  for (const bu of units) {
    // Headcount: active people whose primary BU this is (the director is not tracked).
    const people = await prisma.employee.findMany({
      where: {
        deletedAt: null,
        status: { in: ['ACTIVE', 'ON_NOTICE'] },
        joiningDate: { lte: toDbDate(today) },
        businessUnits: { some: { businessUnitId: bu.id, isPrimary: true } },
        NOT: { user: { role: 'DIRECTOR' } },
        ...subject('id'),
      },
      select: { id: true },
    });
    const ids = people.map((p) => p.id);
    const marks = await prisma.attendanceMark.groupBy({
      by: ['status', 'approvalState'],
      where: { businessUnitId: bu.id, date: toDbDate(today), employeeId: { in: ids } },
      _count: { _all: true },
    });
    const count = (status: string) => marks.filter((m) => m.status === status && m.approvalState === 'APPROVED').reduce((s, m) => s + m._count._all, 0);
    const pendingApproval = marks.filter((m) => m.approvalState === 'PENDING_APPROVAL').reduce((s, m) => s + m._count._all, 0);
    const marked = marks.filter((m) => m.approvalState !== 'REJECTED').reduce((s, m) => s + m._count._all, 0);
    const t = {
      headcount: ids.length,
      present: count('PRESENT'),
      absent: count('ABSENT'),
      halfDay: count('HALF_DAY'),
      onLeave: count('ON_LEAVE'),
      onDuty: count('ON_DUTY'),
      weeklyOff: count('WEEKLY_OFF') + count('HOLIDAY'),
      notMarked: Math.max(0, ids.length - marked),
      pendingApproval,
      presentPct: 0,
    };
    // TODO(business): confirm the present-% formula.
    t.presentPct = pct(t.present + t.onDuty + t.halfDay / 2, t.headcount - t.onLeave - t.weeklyOff);

    const inBu = { businessUnitId: bu.id };
    const [attendance, corrections, leave, allowances, money] = await Promise.all([
      prisma.attendanceMark.count({ where: { ...inBu, approvalState: 'PENDING_APPROVAL', ...subject('employeeId') } }),
      prisma.attendanceCorrection.count({ where: { ...inBu, status: 'PENDING', ...subject('employeeId') } }),
      prisma.leaveRequest.count({ where: { ...inBu, status: 'PENDING', ...subject('employeeId') } }),
      prisma.allowanceRequest.count({ where: { ...inBu, status: 'PENDING', ...allowanceSubject(visible) } }),
      prisma.allowanceRequest.groupBy({
        by: ['status'],
        where: { ...inBu, fromDate: { gte: monthStart, lt: nextMonth }, status: { notIn: ['CANCELLED', 'REJECTED'] }, ...allowanceSubject(visible) },
        _sum: { requestedAmountPaise: true, approvedAmountPaise: true },
      }),
    ]);
    const tasksToday = user.role === 'REGIONAL_MANAGER' ? [] : (await completionByOm([bu.id], today)).filter((r) => user.role !== 'OPERATIONAL_MANAGER' || r.om.employeeId === user.employeeId);
    cards.push({
      businessUnit: bu,
      today: t,
      pendingApprovals: { attendance, corrections, leave, allowances },
      allowancesThisMonth: {
        requestedPaise: money.reduce((s, r) => s + (r._sum.requestedAmountPaise ?? 0), 0),
        approvedPaise: money.filter((r) => r.status === 'APPROVED').reduce((s, r) => s + (r._sum.approvedAmountPaise ?? 0), 0),
      },
      tasksToday,
    });
  }

  // The viewer's own to-dos.
  const mine = await routedTo(prisma, user, businessUnitId);
  const [attendance, corrections, leave, allowances, tasksOpen, tasksOverdue, myMark, unread] = await Promise.all([
    prisma.attendanceMark.count({ where: { ...mine, approvalState: 'PENDING_APPROVAL', source: 'SELF' } }),
    prisma.attendanceCorrection.count({ where: { ...mine, status: 'PENDING' } }),
    prisma.leaveRequest.count({ where: { ...mine, status: 'PENDING' } }),
    prisma.allowanceRequest.count({ where: { ...mine, status: 'PENDING' } }),
    prisma.task.count({ where: { businessUnitId: { in: bus }, assigneeEmployeeId: user.employeeId, status: 'PENDING' } }),
    prisma.task.count({ where: { businessUnitId: { in: bus }, assigneeEmployeeId: user.employeeId, status: 'PENDING', date: { lt: toDbDate(today) } } }),
    prisma.attendanceMark.findUnique({ where: { employeeId_date: { employeeId: user.employeeId, date: toDbDate(today) } }, select: { status: true, approvalState: true } }),
    prisma.notification.count({ where: { recipientUserId: user.id, readAt: null, ...(businessUnitId ? { businessUnitId } : {}) } }),
  ]);
  return {
    date: today,
    month,
    businessUnits: cards,
    me: { pendingApprovals: { attendance, corrections, leave, allowances }, tasksOpen, tasksOverdue, myAttendanceToday: myMark, unreadNotifications: unread },
  };
}

/** Allowances are visible by beneficiary or raiser (§11). */
function allowanceSubject(visible: string[] | null): Prisma.AllowanceRequestWhereInput {
  return visible ? { OR: [{ employeeId: { in: visible } }, { raisedByEmployeeId: { in: visible } }] } : {};
}
