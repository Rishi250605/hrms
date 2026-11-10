import { todayIst, toDbDate } from '../../lib/dates.js';
import { AppError } from '../../lib/errors.js';
import type { Db } from '../../lib/prisma.js';
import type { Role } from '../../generated/prisma/enums.js';

/**
 * Reporting line (PHASE-2-FEATURES §1.2): DRIVER/LOADMAN (and any non-login staff) → RM → OM → HR → DIRECTOR.
 * The line lives on the effective-dated job history (EmployeeJob.reportingToEmployeeId, decision Q6).
 */
export type Level = Role | 'STAFF';

export const LEVEL_RANK: Record<Level, number> = { STAFF: 0, REGIONAL_MANAGER: 1, OPERATIONAL_MANAGER: 2, HR: 3, DIRECTOR: 4 };

export function nextLevelUp(level: Level): Role | null {
  switch (level) {
    case 'STAFF':
      return 'REGIONAL_MANAGER';
    case 'REGIONAL_MANAGER':
      return 'OPERATIONAL_MANAGER';
    case 'OPERATIONAL_MANAGER':
      return 'HR';
    case 'HR':
      return 'DIRECTOR';
    case 'DIRECTOR':
      return null;
  }
}

/** Level of an employee: the role of their login, or STAFF when they have none. */
export async function levelOf(db: Db, employeeId: string): Promise<Level> {
  const user = await db.user.findUnique({ where: { employeeId }, select: { role: true } });
  return user?.role ?? 'STAFF';
}

/** Business units of an employee (the director: all active BUs). */
export async function businessUnitsOf(db: Db, employeeId: string): Promise<{ ids: string[]; primary: string | null }> {
  const user = await db.user.findUnique({ where: { employeeId }, select: { role: true } });
  if (user?.role === 'DIRECTOR') {
    const all = await db.businessUnit.findMany({ where: { isActive: true }, select: { id: true } });
    return { ids: all.map((b) => b.id), primary: null };
  }
  const rows = await db.employeeBusinessUnit.findMany({ where: { employeeId }, select: { businessUnitId: true, isPrimary: true } });
  return { ids: rows.map((r) => r.businessUnitId), primary: rows.find((r) => r.isPrimary)?.businessUnitId ?? rows[0]?.businessUnitId ?? null };
}

/** The business unit records about this employee belong to (their primary BU; §2.2). */
export async function primaryBusinessUnitOf(db: Db, employeeId: string): Promise<string> {
  const { primary } = await businessUnitsOf(db, employeeId);
  if (!primary) throw new AppError('NO_BUSINESS_UNIT', 422, 'The employee has no business unit');
  return primary;
}

const currentJobWhere = (date: string) => {
  const d = toDbDate(date);
  return { effectiveFrom: { lte: d }, OR: [{ effectiveTo: null }, { effectiveTo: { gt: d } }] };
};

/** reportingTo of each employee on `date` (missing key = no current job row). */
export async function reportingToOf(db: Db, employeeIds: string[], date: string = todayIst()): Promise<Map<string, string | null>> {
  const rows = await db.employeeJob.findMany({
    where: { employeeId: { in: employeeIds }, ...currentJobWhere(date) },
    select: { employeeId: true, reportingToEmployeeId: true },
  });
  return new Map(rows.map((r) => [r.employeeId, r.reportingToEmployeeId]));
}

/**
 * Employees below `rootEmployeeId` in the reporting tree on `date`, up to `maxDepth` levels
 * (1 = direct reports). Returns id → depth.
 */
export async function descendantsOf(db: Db, rootEmployeeId: string, maxDepth: number, date: string = todayIst()): Promise<Map<string, number>> {
  const rows = await db.$queryRaw<{ employee_id: string; depth: number }[]>`
    WITH RECURSIVE tree AS (
      SELECT j.employee_id, 1 AS depth
        FROM employee_jobs j
       WHERE j.reporting_to_employee_id = ${rootEmployeeId}::uuid
         AND j.effective_from <= ${date}::date AND (j.effective_to IS NULL OR j.effective_to > ${date}::date)
      UNION ALL
      SELECT j.employee_id, t.depth + 1
        FROM employee_jobs j
        JOIN tree t ON j.reporting_to_employee_id = t.employee_id
       WHERE j.effective_from <= ${date}::date AND (j.effective_to IS NULL OR j.effective_to > ${date}::date)
         AND t.depth < ${maxDepth}
    )
    SELECT employee_id::text AS employee_id, min(depth)::int AS depth FROM tree GROUP BY employee_id`;
  return new Map(rows.map((r) => [r.employee_id, r.depth]));
}

/** Reject an invalid reporting line with 422 INVALID_REPORTING_LINE (§1.2). */
export async function validateReportingLine(
  db: Db,
  subject: { level: Level; businessUnitIds: string[]; employeeId?: string },
  reportingToEmployeeId: string | null | undefined,
): Promise<void> {
  const invalid = (message: string) => new AppError('INVALID_REPORTING_LINE', 422, message);
  const expected = nextLevelUp(subject.level);
  if (expected === null) {
    if (reportingToEmployeeId) throw invalid('The director does not report to anyone');
    return;
  }
  if (!reportingToEmployeeId) throw invalid(`A reporting manager (${expected.toLowerCase().replace(/_/g, ' ')}) is required`);
  if (reportingToEmployeeId === subject.employeeId) throw invalid('An employee cannot report to themself');
  const target = await db.user.findUnique({ where: { employeeId: reportingToEmployeeId }, select: { role: true, isActive: true } });
  if (!target || !target.isActive || target.role !== expected) {
    throw invalid(`The reporting manager must be an active ${expected.toLowerCase().replace(/_/g, ' ')}`);
  }
  if (expected === 'DIRECTOR') return;
  const targetBus = await businessUnitsOf(db, reportingToEmployeeId);
  if (!subject.businessUnitIds.some((b) => targetBus.ids.includes(b))) {
    throw invalid('The reporting manager must share a business unit with the employee');
  }
}

export interface Approver {
  employeeId: string;
  userId: string;
  role: Role;
  /** True when the reporting-to user was inactive and a same-role user of the BU was chosen (§1.2). */
  fallback: boolean;
}

/**
 * Approver for a request about `subjectEmployeeId` in `businessUnitId`: their reporting-to user, or — if that
 * user is inactive or missing — any active user with the same role sharing the business unit.
 */
export async function resolveApprover(db: Db, subjectEmployeeId: string, businessUnitId: string, date: string = todayIst()): Promise<Approver> {
  const level = await levelOf(db, subjectEmployeeId);
  const role = nextLevelUp(level);
  if (!role) throw new AppError('NO_APPROVER', 422, 'Nobody approves requests about the director');
  const reportsTo = (await reportingToOf(db, [subjectEmployeeId], date)).get(subjectEmployeeId) ?? null;
  if (reportsTo) {
    const u = await db.user.findUnique({ where: { employeeId: reportsTo }, select: { id: true, role: true, isActive: true } });
    if (u?.isActive && u.role === role) return { employeeId: reportsTo, userId: u.id, role, fallback: false };
  }
  const backup = await db.user.findFirst({
    where: {
      role,
      isActive: true,
      ...(role === 'DIRECTOR' ? {} : { employee: { businessUnits: { some: { businessUnitId } } } }),
    },
    orderBy: { createdAt: 'asc' },
    select: { id: true, employeeId: true },
  });
  if (!backup) throw new AppError('NO_APPROVER', 422, `No active ${role.toLowerCase().replace(/_/g, ' ')} can approve this`);
  return { employeeId: backup.employeeId, userId: backup.id, role, fallback: true };
}

/** Employee ids of inactive users with `role` (their pending approvals fall to same-role colleagues). */
export async function inactiveApproverEmployeeIds(db: Db, role: Role): Promise<string[]> {
  const rows = await db.user.findMany({ where: { role, isActive: false }, select: { employeeId: true } });
  return rows.map((r) => r.employeeId);
}

/** May `user` decide a request routed to (approverEmployeeId, approverRole) in `businessUnitId`? */
export async function canDecide(
  db: Db,
  user: { employeeId: string; role: Role; businessUnitIds: string[] },
  record: { approverEmployeeId: string | null; approverRole: Role | null; businessUnitId: string },
): Promise<boolean> {
  if (!record.approverEmployeeId) return false;
  if (record.approverEmployeeId === user.employeeId) return true;
  if (record.approverRole !== user.role || !user.businessUnitIds.includes(record.businessUnitId)) return false;
  const approver = await db.user.findUnique({ where: { employeeId: record.approverEmployeeId }, select: { isActive: true } });
  return approver !== null && !approver.isActive;
}
