import { randomUUID } from 'node:crypto';
import request from 'supertest';
import { beforeAll, describe, expect, it } from 'vitest';
import { createApp } from '../../app.js';
import { dateRange, toDbDate } from '../../lib/dates.js';
import { prisma } from '../../lib/prisma.js';
import { createHierarchy, createOrgFixture, resetDb } from '../../../test/helpers.js';
import type { Hierarchy, Org } from '../../../test/helpers.js';

/**
 * Load test (PHASE-2-FEATURES §12 M8): attendance report for 1,000 employees × 31 days.
 * Run with `npm run test:perf` (its own vitest project; not part of `npm test`).
 * Budgets are generous for a developer laptop; the timings are printed for docs/phase-2-summary.md.
 */
const STAFF = 1000;
const MONTH = '2026-10';
const DAYS = dateRange(`${MONTH}-01`, `${MONTH}-31`);
const BUDGET_MS = { json: 3000, dashboard: 3000, xlsx: 15000, pdf: 20000 };
const STATUSES = ['PRESENT', 'PRESENT', 'PRESENT', 'PRESENT', 'PRESENT', 'ABSENT', 'HALF_DAY', 'ON_LEAVE', 'ON_DUTY', 'WEEKLY_OFF'] as const;

const app = createApp();
const api = '/api/v1';
let org: Org;
let h: Hierarchy;
const timings: Record<string, number> = {};

async function timed<T>(label: string, fn: () => Promise<T>): Promise<T> {
  const start = performance.now();
  const out = await fn();
  timings[label] = Math.round(performance.now() - start);
  return out;
}

beforeAll(async () => {
  await resetDb();
  org = await createOrgFixture();
  h = await createHierarchy(org);
  // 1,000 drivers / loadmen reporting to one RM, so the RM path (reporting-tree CTE) is loaded too.
  const staff = Array.from({ length: STAFF }, (_, i) => ({
    id: randomUUID(),
    empCode: `NLS${String(5000 + i)}`,
    fullName: `Load Test ${String(i).padStart(4, '0')}`,
    phone: `+9197${String(i).padStart(8, '0')}`,
    category: i % 5 === 0 ? ('LOADMAN' as const) : ('DRIVER' as const),
    employmentType: 'PERMANENT' as const,
    joiningDate: toDbDate('2025-01-01'),
  }));
  await prisma.employee.createMany({ data: staff });
  await prisma.employeeBusinessUnit.createMany({ data: staff.map((s) => ({ employeeId: s.id, businessUnitId: org.nls.id, isPrimary: true })) });
  await prisma.employeeJob.createMany({
    data: staff.map((s) => ({ employeeId: s.id, depotId: org.pune.id, designation: 'Driver', reportingToEmployeeId: h.rm.employeeId, effectiveFrom: toDbDate('2025-01-01') })),
  });
  const marks = staff.flatMap((s, i) =>
    DAYS.map((d, j) => ({
      employeeId: s.id,
      businessUnitId: org.nls.id,
      date: toDbDate(d),
      status: STATUSES[(i + j) % STATUSES.length]!,
      approvalState: 'APPROVED' as const,
      source: 'MANAGER' as const,
      markedById: h.rm.user.id,
      markedAt: new Date(),
    })),
  );
  for (let i = 0; i < marks.length; i += 5000) await prisma.attendanceMark.createMany({ data: marks.slice(i, i + 5000) });
  expect(await prisma.attendanceMark.count()).toBe(STAFF * DAYS.length);
}, 300_000);

describe(`attendance report at ${STAFF} employees × ${DAYS.length} days`, () => {
  it('JSON muster for HR and for the RM (hierarchy path) within budget', async () => {
    const hr = await timed('json.hr', () => request(app).get(`${api}/reports/attendance?from=${MONTH}-01&to=${MONTH}-31`).set(h.hr.headers));
    expect(hr.status).toBe(200);
    expect(hr.body.rows.length).toBeGreaterThanOrEqual(STAFF);
    const rm = await timed('json.rm', () => request(app).get(`${api}/reports/attendance?from=${MONTH}-01&to=${MONTH}-31`).set(h.rm.headers));
    expect(rm.body.rows.length).toBe(STAFF + 4); // + RM self, d1, d2, l1
    expect(timings['json.hr']).toBeLessThan(BUDGET_MS.json);
    expect(timings['json.rm']).toBeLessThan(BUDGET_MS.json);
  });

  it('Excel and PDF exports within budget', async () => {
    const q = `from=${MONTH}-01&to=${MONTH}-31&businessUnitId=${org.nls.id}`;
    const xlsx = await timed('xlsx', () => request(app).get(`${api}/reports/attendance/export?format=xlsx&${q}`).set(h.hr.headers));
    expect(xlsx.status).toBe(200);
    const pdf = await timed('pdf', () => request(app).get(`${api}/reports/attendance/export?format=pdf&${q}`).set(h.hr.headers));
    expect(pdf.status).toBe(200);
    expect(timings.xlsx).toBeLessThan(BUDGET_MS.xlsx);
    expect(timings.pdf).toBeLessThan(BUDGET_MS.pdf);
  });

  it('director dashboard within budget', async () => {
    const res = await timed('dashboard', () => request(app).get(`${api}/reports/dashboard`).set(h.director.headers));
    expect(res.status).toBe(200);
    expect(timings.dashboard).toBeLessThan(BUDGET_MS.dashboard);
    // eslint-disable-next-line no-console -- the timings are the point of this test
    console.log(`[perf] ${STAFF}×${DAYS.length} attendance report timings (ms):`, JSON.stringify(timings));
  });
});
