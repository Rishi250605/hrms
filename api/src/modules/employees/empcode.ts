import { AppError } from '../../lib/errors.js';
import type { Db } from '../../lib/prisma.js';

/**
 * Employee IDs (decision Q3): the code of the employee's business unit followed by at least three digits,
 * e.g. NLS001, AERO002. HR assigns them; the app suggests the next free number. Codes are never renumbered
 * when a BU code changes or an employee moves. The director's own ID (no BU) only needs the letters+digits shape.
 */
export const EMP_CODE_PATTERN = /^([A-Z]{2,8})(\d{3,})$/;

export async function assertEmpCodeFormat(db: Db, empCode: string, primaryBusinessUnitId: string | null): Promise<void> {
  const m = EMP_CODE_PATTERN.exec(empCode);
  const bad = (message: string) => new AppError('INVALID_EMP_CODE', 422, message);
  if (!m) throw bad('Employee ID must be the business-unit code followed by digits, e.g. NLS001');
  if (primaryBusinessUnitId) {
    const bu = await db.businessUnit.findUnique({ where: { id: primaryBusinessUnitId }, select: { code: true } });
    if (bu && m[1] !== bu.code) throw bad(`Employee ID must start with ${bu.code} (the employee's business unit)`);
  }
  const clash = await db.employee.findFirst({ where: { empCode: { equals: empCode, mode: 'insensitive' } }, select: { id: true } });
  if (clash) throw new AppError('EMP_CODE_TAKEN', 409, `Employee ID ${empCode} is already used`);
}

/** Next free number for a BU code: highest existing NLS### + 1, zero-padded to 3 digits. */
export async function suggestEmpCode(db: Db, buCode: string): Promise<string> {
  const rows = await db.employee.findMany({ where: { empCode: { startsWith: buCode, mode: 'insensitive' } }, select: { empCode: true } });
  let max = 0;
  for (const r of rows) {
    const m = EMP_CODE_PATTERN.exec(r.empCode.toUpperCase());
    if (m && m[1] === buCode) max = Math.max(max, Number(m[2]));
  }
  return `${buCode}${String(max + 1).padStart(3, '0')}`;
}
