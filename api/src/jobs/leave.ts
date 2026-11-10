import { systemContext } from '../lib/context.js';
import { todayIst, toDbDate } from '../lib/dates.js';
import { logger } from '../lib/logger.js';
import { prisma } from '../lib/prisma.js';
import { accrualOf, adjustBalance, ensureBalance, matchPolicy, subjectOf } from '../modules/leave/service.js';

const ctx = systemContext('job:leave-accrual');

/**
 * Monthly leave accrual (CLAUDE.md §7), run on the 1st (IST) for the month that starts:
 *  - MONTHLY types credit annualQuota / 12 for the month;
 *  - ANNUAL types credit the full annualQuota once per calendar year (on the first run of the year).
 * The quota comes from the employee's most specific LeavePolicy. Idempotent via LeaveAccrualLog.
 * TODO(business): proration for mid-month joiners, accrual during unpaid leave / suspension, rounding rule.
 */
export async function runLeaveAccrual(now = new Date()): Promise<{ credited: number }> {
  const today = todayIst(now);
  const month = today.slice(0, 7);
  const year = Number(today.slice(0, 4));
  const [types, policies] = await Promise.all([prisma.leaveType.findMany({ where: { isActive: true } }), prisma.leavePolicy.findMany()]);
  const accruing = types.filter((t) => accrualOf(t).type !== 'NONE');
  if (accruing.length === 0) return { credited: 0 };

  const employees = await prisma.employee.findMany({
    where: { deletedAt: null, status: { in: ['ACTIVE', 'ON_NOTICE'] }, joiningDate: { lte: toDbDate(today) } },
    select: { id: true, category: true, employmentType: true },
  });
  let credited = 0;
  for (const e of employees) {
    const { subject, job } = await subjectOf(prisma, e, today);
    if (!job) continue;
    for (const t of accruing) {
      const policy = matchPolicy(policies.filter((p) => p.leaveTypeId === t.id), subject);
      if (!policy) continue;
      const rule = accrualOf(t);
      const period = rule.type === 'MONTHLY' ? month : String(year);
      const days = rule.type === 'MONTHLY' ? Math.round((Number(policy.annualQuota) / 12) * 100) / 100 : Number(policy.annualQuota);
      if (days <= 0) continue;
      const done = await prisma.$transaction(async (tx) => {
        const exists = await tx.leaveAccrualLog.findUnique({ where: { employeeId_leaveTypeId_period: { employeeId: e.id, leaveTypeId: t.id, period } } });
        if (exists) return false;
        await tx.leaveAccrualLog.create({ data: { employeeId: e.id, leaveTypeId: t.id, period, days } });
        const balance = await ensureBalance(tx, e.id, t, year, ctx);
        await adjustBalance(tx, balance.id, { accrued: days }, ctx, `accrual ${period}`);
        return true;
      });
      if (done) credited += 1;
    }
  }
  logger.info({ credited, month }, 'Leave accrual finished');
  return { credited };
}
