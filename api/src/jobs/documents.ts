import { addDays, diffDays, fromDbDate, todayIst, toDbDate } from '../lib/dates.js';
import { systemContext } from '../lib/context.js';
import { logger } from '../lib/logger.js';
import { prisma } from '../lib/prisma.js';
import { audit } from '../modules/audit/service.js';
import { deactivateLogin } from '../modules/employees/service.js';
import { hrOf, notify, userIdOfEmployee } from '../modules/notifications/service.js';
import { getSetting } from '../modules/settings/service.js';

const ctx = systemContext('job:document-expiry');
const label = (type: string) => type.replace(/_/g, ' ').toLowerCase();

/**
 * Nightly:
 *  1. documents whose expiryDate < today become EXPIRED;
 *  2. alerts at N days before expiry (`documents.expiryAlertDays`, default 30/15/7/1) go to the employee's
 *     reporting manager (their RM) and to HR of the employee's business unit. Each (document, threshold) is
 *     alerted once; if the job missed a night only the nearest threshold is sent. Renewed documents and exited
 *     employees are skipped. One digest per recipient and business unit.
 */
export async function runDocumentExpiry(now = new Date()): Promise<{ expired: number; alerted: number }> {
  const today = todayIst(now);

  const toExpire = await prisma.document.findMany({ where: { status: { in: ['VERIFIED', 'PENDING_VERIFICATION'] }, expiryDate: { lt: toDbDate(today) } } });
  for (const doc of toExpire) {
    await prisma.$transaction(async (tx) => {
      const after = await tx.document.update({ where: { id: doc.id }, data: { status: 'EXPIRED' } });
      await audit.record(tx, ctx, { action: 'document.expire', entityType: 'Document', entityId: doc.id, before: doc, after });
    });
  }

  const thresholds = [...new Set(await getSetting('documents.expiryAlertDays'))].sort((a, b) => a - b);
  const maxDays = thresholds[thresholds.length - 1] ?? 0;
  const candidates = await prisma.document.findMany({
    where: {
      status: { in: ['VERIFIED', 'PENDING_VERIFICATION'] },
      expiryDate: { gte: toDbDate(today), lte: toDbDate(addDays(today, maxDays)) },
      employee: { deletedAt: null, status: { not: 'EXITED' } },
    },
    include: {
      alerts: { select: { thresholdDays: true } },
      employee: {
        select: {
          id: true,
          fullName: true,
          empCode: true,
          businessUnits: { orderBy: { isPrimary: 'desc' }, take: 1, select: { businessUnitId: true } },
          jobs: { where: { OR: [{ effectiveTo: null }, { effectiveTo: { gt: toDbDate(today) } }] }, orderBy: { effectiveFrom: 'asc' }, take: 1 },
        },
      },
    },
  });
  if (candidates.length === 0) return { expired: toExpire.length, alerted: 0 };

  const siblings = await prisma.document.findMany({
    where: { employeeId: { in: [...new Set(candidates.map((c) => c.employeeId))] }, status: { not: 'REJECTED' } },
    select: { id: true, employeeId: true, type: true, expiryDate: true },
  });

  /** `${userId}|${businessUnitId}` → lines */
  const digest = new Map<string, string[]>();
  const add = (userId: string, bu: string, line: string) => digest.set(`${userId}|${bu}`, [...(digest.get(`${userId}|${bu}`) ?? []), line]);
  let alerted = 0;

  for (const doc of candidates) {
    const renewed = siblings.some((s) => s.id !== doc.id && s.employeeId === doc.employeeId && s.type === doc.type && (!s.expiryDate || s.expiryDate > doc.expiryDate!));
    if (renewed) continue;
    const daysLeft = diffDays(today, fromDbDate(doc.expiryDate!));
    const threshold = thresholds.find((t) => daysLeft <= t);
    if (threshold === undefined || doc.alerts.some((a) => a.thresholdDays === threshold)) continue;
    const bu = doc.employee.businessUnits[0]?.businessUnitId;
    if (!bu) continue;

    const passed = thresholds.filter((t) => t >= threshold && !doc.alerts.some((a) => a.thresholdDays === t));
    await prisma.documentAlert.createMany({ data: passed.map((t) => ({ documentId: doc.id, thresholdDays: t })), skipDuplicates: true });
    alerted += 1;

    const line = `${doc.employee.fullName} (${doc.employee.empCode}): ${label(doc.type)} ${daysLeft === 0 ? 'expires today' : `expires in ${daysLeft} day${daysLeft === 1 ? '' : 's'}`}`;
    const rm = await userIdOfEmployee(prisma, doc.employee.jobs[0]?.reportingToEmployeeId);
    if (rm) add(rm, bu, line);
    for (const hr of await hrOf(prisma, bu)) add(hr, bu, line);
  }

  for (const [key, lines] of digest) {
    const [userId, bu] = key.split('|') as [string, string];
    await notify([userId], {
      type: 'DOCUMENTS_EXPIRING',
      title: lines.length === 1 ? 'Document expiring' : `${lines.length} documents expiring`,
      body: lines.length === 1 ? lines[0]! : `${lines.slice(0, 3).join('; ')}${lines.length > 3 ? ` and ${lines.length - 3} more` : ''}`,
      entityType: 'DOCUMENT',
      businessUnitId: bu,
    });
  }

  const result = { expired: toExpire.length, alerted };
  logger.info(result, 'Document expiry job finished');
  return result;
}

/** Employees ON_NOTICE whose exit date has passed become EXITED; their login (if any) is deactivated. */
export async function runEmployeeExits(now = new Date()): Promise<{ exited: number }> {
  const today = toDbDate(todayIst(now));
  const due = await prisma.employee.findMany({ where: { status: 'ON_NOTICE', exitDate: { lt: today } } });
  const jobCtx = systemContext('job:employee-exits');
  for (const e of due) {
    await prisma.$transaction(async (tx) => {
      const after = await tx.employee.update({ where: { id: e.id }, data: { status: 'EXITED' } });
      await deactivateLogin(tx, e.id, jobCtx);
      await audit.record(tx, jobCtx, { action: 'employee.exited', entityType: 'Employee', entityId: e.id, before: e, after });
    });
  }
  return { exited: due.length };
}
