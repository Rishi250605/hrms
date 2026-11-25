/**
 * One-off go-live reset: removes every demo / test record and keeps only
 *   - the director's login and employee record (with a NEW random password, printed once),
 *   - reference data: business units, document requirements, leave types + policies, allowance types,
 *     performance metrics and settings.
 * Everything else (other logins and employees, depots, regions, fleet, roster, attendance, leave,
 * allowances, payslips, tasks, ratings, notifications, sessions, the audit log) is deleted.
 *
 * Dry run (read-only, prints counts):   npx tsx scripts/go-live-reset.ts
 * Execute (irreversible):               CONFIRM_RESET=<director emp code> npx tsx scripts/go-live-reset.ts
 *
 * Uses DATABASE_URL. Files already uploaded to storage (documents, payslips, voice notes) are not deleted.
 */
import 'dotenv/config';
import { randomInt } from 'node:crypto';
import { prisma } from '../src/lib/prisma.js';
import { systemContext } from '../src/lib/context.js';
import { hashPassword } from '../src/lib/password.js';
import { audit } from '../src/modules/audit/service.js';

/** Wiped completely, in one TRUNCATE (no CASCADE: Postgres refuses if a kept table still references one). */
const WIPE = [
  'refresh_tokens',
  'device_tokens',
  'notifications',
  'audit_logs',
  'document_alerts',
  'documents',
  'duty_assignments',
  'duties',
  'duty_templates',
  'routes',
  'vehicles',
  'attendance_corrections',
  'attendance_marks',
  'leave_accrual_logs',
  'leave_balances',
  'leave_requests',
  'allowance_requests',
  'payslip_versions',
  'payslips',
  'tasks',
  'performance_ratings',
  'performance_metric_values',
] as const;
/** Emptied after the people they reference are gone. */
const WIPE_AFTER = ['depots', 'regions'] as const;

function newPassword(): string {
  const sets = ['ABCDEFGHJKLMNPQRSTUVWXYZ', 'abcdefghijkmnpqrstuvwxyz', '23456789', '@#%&*!'];
  const all = sets.join('');
  const chars = [...sets.map((s) => s[randomInt(s.length)]!), ...Array.from({ length: 10 }, () => all[randomInt(all.length)]!)];
  for (let i = chars.length - 1; i > 0; i--) {
    const j = randomInt(i + 1);
    [chars[i], chars[j]] = [chars[j]!, chars[i]!];
  }
  return chars.join('');
}

async function counts() {
  const tables = [...WIPE, ...WIPE_AFTER, 'users', 'employees', 'employee_jobs', 'employee_business_units'];
  const out: Record<string, number> = {};
  for (const t of tables) out[t] = Number((await prisma.$queryRawUnsafe<{ n: bigint }[]>(`SELECT count(*) AS n FROM "${t}"`))[0]!.n);
  return out;
}

async function main() {
  const host = new URL(process.env.DATABASE_URL ?? 'postgresql://unknown').host;
  const directors = await prisma.user.findMany({ where: { role: 'DIRECTOR' }, include: { employee: { select: { id: true, empCode: true, fullName: true } } } });
  if (directors.length !== 1) throw new Error(`Expected exactly one director, found ${directors.length}`);
  const director = directors[0]!;
  const empCode = director.employee.empCode;
  console.log(`Database: ${host}`);
  console.log(`Director kept: ${empCode} (${director.employee.fullName})`);
  console.log('Rows now:', await counts());

  if (process.env.CONFIRM_RESET !== empCode) {
    console.log(`\nDry run only. To execute: CONFIRM_RESET=${empCode} npx tsx scripts/go-live-reset.ts`);
    return;
  }

  const password = newPassword();
  const passwordHash = await hashPassword(password);
  const keepEmployee = director.employeeId;
  await prisma.$transaction(
    async (tx) => {
      await tx.$executeRawUnsafe(`TRUNCATE TABLE ${WIPE.map((t) => `"${t}"`).join(', ')}`);
      await tx.employeeJob.deleteMany({ where: { NOT: { employeeId: keepEmployee } } });
      await tx.employeeJob.updateMany({ where: { employeeId: keepEmployee }, data: { reportingToEmployeeId: null } });
      await tx.employeeBusinessUnit.deleteMany({ where: { NOT: { employeeId: keepEmployee } } });
      await tx.user.deleteMany({ where: { NOT: { id: director.id } } });
      await tx.employee.deleteMany({ where: { NOT: { id: keepEmployee } } });
      // The director's own job rows (if any) point at a depot; they go with the demo depots.
      await tx.employeeJob.deleteMany({ where: { employeeId: keepEmployee } });
      // DELETE, not TRUNCATE: Postgres refuses to truncate a table that any foreign key points at, even from empty tables.
      await tx.depot.deleteMany({});
      await tx.region.deleteMany({});
      await tx.user.update({
        where: { id: director.id },
        data: { passwordHash, passwordChangedAt: new Date(), failedLoginCount: 0, failedWindowStartedAt: null, lockedUntil: null, isActive: true },
      });
      // Starter weekly metrics (same as prisma/seed.ts) when none exist yet.
      if ((await tx.performanceMetric.count()) === 0) {
        await tx.performanceMetric.createMany({
          data: [
            { code: 'MILEAGE', name: 'Mileage', unit: 'km/l', sortOrder: 10 },
            { code: 'EMPLOYEE_COUNT', name: 'Employee count', unit: 'count', sortOrder: 20 },
            { code: 'MAINTENANCE', name: 'Maintenance', unit: null, sortOrder: 30 },
          ],
        });
      }
      // audit: first entry of the fresh log.
      await audit.record(tx, systemContext('go-live-reset'), {
        action: 'system.goLiveReset',
        entityType: 'System',
        entityId: 'go-live',
        after: { keptDirector: empCode, wiped: [...WIPE, ...WIPE_AFTER, 'other users / employees'] },
      });
    },
    { timeout: 120_000 },
  );
  console.log('Rows after:', await counts());
  console.log(`\nDone. Director login: ${empCode} / ${password}`);
  console.log('Store this password safely; it is not saved anywhere else.');
}

main()
  .catch((err: unknown) => {
    console.error(err);
    process.exitCode = 1;
  })
  .finally(() => prisma.$disconnect());
