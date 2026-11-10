import ExcelJS from 'exceljs';
import request from 'supertest';
import { beforeEach, describe, expect, it } from 'vitest';
import { createApp } from '../../app.js';
import { addDays, todayIst, toDbDate } from '../../lib/dates.js';
import { prisma } from '../../lib/prisma.js';
import type { AttendanceStatus } from '../../generated/prisma/enums.js';
import { createHierarchy, createOrgFixture, resetDb } from '../../../test/helpers.js';
import type { Hierarchy, Login, Org } from '../../../test/helpers.js';

const app = createApp();
const api = '/api/v1';
let org: Org;
let h: Hierarchy;
const today = todayIst();
const yesterday = addDays(today, -1);
const from = addDays(today, -2);

async function mark(employeeId: string, businessUnitId: string, date: string, status: AttendanceStatus, by: Login, pending = false) {
  await prisma.attendanceMark.create({
    data: {
      employeeId,
      businessUnitId,
      date: toDbDate(date),
      status,
      approvalState: pending ? 'PENDING_APPROVAL' : 'APPROVED',
      source: pending ? 'SELF' : 'MANAGER',
      markedById: by.user.id,
      markedAt: new Date(),
      ...(pending ? { approverEmployeeId: h.om.employeeId, approverRole: 'OPERATIONAL_MANAGER' as const } : {}),
    },
  });
}

beforeEach(async () => {
  await resetDb();
  org = await createOrgFixture();
  h = await createHierarchy(org);
  await mark(h.d1.id, org.nls.id, yesterday, 'PRESENT', h.rm);
  await mark(h.d1.id, org.nls.id, today, 'ABSENT', h.rm);
  await mark(h.d2.id, org.nls.id, today, 'HALF_DAY', h.rm);
  await mark(h.d3.id, org.nls.id, today, 'PRESENT', h.rm2);
  await mark(h.d4.id, org.bms.id, today, 'ON_LEAVE', h.rmBms);
  await mark(h.d5.id, org.mod.id, today, 'PRESENT', h.rmMod);
  await mark(h.rm.employeeId, org.nls.id, today, 'PRESENT', h.rm, true);
});

const report = async (who: Login, extra = '') => {
  const res = await request(app).get(`${api}/reports/attendance?from=${from}&to=${today}${extra}`).set(who.headers);
  expect(res.status, `${who.empCode} ${extra}`).toBe(200);
  return res.body as { rows: { employee: { employeeId: string }; codes: string[]; summary: Record<string, number> }[]; days: string[] };
};
const people = (r: Awaited<ReturnType<typeof report>>) => r.rows.map((x) => x.employee.employeeId).sort();

describe('attendance report (§9.1)', () => {
  it('muster codes and summary per employee', async () => {
    const r = await report(h.rm);
    expect(r.days).toEqual([from, yesterday, today]);
    const d1 = r.rows.find((x) => x.employee.employeeId === h.d1.id)!;
    expect(d1.codes).toEqual(['', 'P', 'A']);
    expect(d1.summary).toMatchObject({ present: 1, absent: 1, notMarked: 1 });
    const self = r.rows.find((x) => x.employee.employeeId === h.rm.employeeId)!;
    expect(self.codes[2]).toBe('P*');
    expect(self.summary).toMatchObject({ present: 0, pending: 1 });
  });

  it('visibility (§11 Reports): RM self + team; OM self + RMs + RMs’ teams; HR all in BUs; director all', async () => {
    expect(people(await report(h.rm))).toEqual([h.rm.employeeId, h.d1.id, h.d2.id, h.l1.id].sort());
    expect(people(await report(h.rm2))).toEqual([h.rm2.employeeId, h.d3.id].sort());
    const om = people(await report(h.om));
    expect(om).toEqual([h.om.employeeId, h.rm.employeeId, h.rm2.employeeId, h.rmBms.employeeId, h.d1.id, h.d2.id, h.l1.id, h.d3.id, h.d4.id].sort());
    expect(people(await report(h.om, `&businessUnitId=${org.bms.id}`))).toEqual([h.rmBms.employeeId, h.d4.id].sort());
    expect((await request(app).get(`${api}/reports/attendance?businessUnitId=${org.mod.id}`).set(h.om.headers)).status).toBe(403);
    const hr = people(await report(h.hr));
    expect(hr).toContain(h.hr.employeeId);
    expect(hr).not.toContain(h.d5.id);
    expect(hr).not.toContain(h.director.employeeId);
    expect(people(await report(h.hrMod))).toEqual([h.hrMod.employeeId, h.omMod.employeeId, h.rmMod.employeeId, h.d5.id].sort());
    const all = people(await report(h.director));
    expect(all).toHaveLength(14);
    expect(all).not.toContain(h.director.employeeId);
  });

  it('filters: role group, status, employee; range limits', async () => {
    expect(people(await report(h.hr, '&role=LOADMAN'))).toEqual([h.l1.id]);
    expect(people(await report(h.hr, '&role=REGIONAL_MANAGER'))).toEqual([h.rm.employeeId, h.rm2.employeeId, h.rmBms.employeeId].sort());
    const absent = await report(h.hr, '&status=ABSENT');
    expect(people(absent)).toEqual([h.d1.id]);
    expect(absent.rows[0]!.codes).toEqual(['', '', 'A']);
    expect(people(await report(h.hr, '&approvalState=PENDING_APPROVAL'))).toEqual([h.rm.employeeId]);
    expect(people(await report(h.rm, `&employeeId=${h.d2.id}`))).toEqual([h.d2.id]);
    expect(people(await report(h.rm, `&employeeId=${h.d3.id}`))).toEqual([]);
    expect((await request(app).get(`${api}/reports/attendance?from=${today}&to=${yesterday}`).set(h.hr.headers)).status).toBe(400);
    expect((await request(app).get(`${api}/reports/attendance?from=${addDays(today, -70)}&to=${today}`).set(h.hr.headers)).status).toBe(400);
    const month = await request(app).get(`${api}/reports/attendance`).set(h.hr.headers);
    expect(month.body.from).toBe(`${today.slice(0, 7)}-01`);
    expect(month.body.days.length).toBeGreaterThanOrEqual(28);
  });

  it('Excel and PDF downloads: signed URL, real files, audited', async () => {
    const xlsx = await request(app).get(`${api}/reports/attendance/export?format=xlsx&from=${from}&to=${today}`).set(h.rm.headers);
    expect(xlsx.status).toBe(200);
    expect(xlsx.body.fileName).toMatch(/^attendance-NLS-.*\.xlsx$/);
    const file = await request(app)
      .get(new URL(xlsx.body.url).pathname + new URL(xlsx.body.url).search)
      .responseType('blob');
    expect(file.status).toBe(200);
    const wb = new ExcelJS.Workbook();
    await wb.xlsx.load(file.body as never);
    expect(wb.worksheets.map((w) => w.name)).toEqual(['Muster', 'Summary']);
    expect(wb.getWorksheet('Muster')!.rowCount).toBe(5 + 4);

    const pdf = await request(app).get(`${api}/reports/attendance/export?format=pdf&from=${from}&to=${today}`).set(h.director.headers);
    expect(pdf.status).toBe(200);
    const pdfFile = await request(app)
      .get(new URL(pdf.body.url).pathname + new URL(pdf.body.url).search)
      .responseType('blob');
    expect((pdfFile.body as Buffer).subarray(0, 5).toString()).toBe('%PDF-');
    expect(await prisma.auditLog.count({ where: { action: 'report.attendance.export' } })).toBe(2);
  });
});

describe('dashboard (§9.2)', () => {
  it('director: a card per business unit with today, pending approvals, allowances and tasks', async () => {
    const batta = await prisma.allowanceType.create({ data: { code: 'BATTA', name: 'Batta' } });
    await request(app).post(`${api}/allowances`).set(h.rm.headers).send({ allowanceTypeId: batta.id, amountPaise: 25_000, fromDate: today, comment: 'Trip' });
    await request(app).post(`${api}/tasks`).set(h.om.headers).send({ businessUnitId: org.nls.id, title: 'Inspect trucks', assigneeEmployeeIds: [h.rm.employeeId, h.rm2.employeeId] });
    const res = await request(app).get(`${api}/reports/dashboard`).set(h.director.headers);
    expect(res.status).toBe(200);
    expect(res.body.businessUnits.map((c: { businessUnit: { code: string } }) => c.businessUnit.code)).toEqual(['BMS', 'NLS', 'MOD'].sort());
    const nls = res.body.businessUnits.find((c: { businessUnit: { code: string } }) => c.businessUnit.code === 'NLS');
    // NLS primary: hr, om, rm, rm2, d1, d2, l1, d3.
    expect(nls.today).toMatchObject({ headcount: 8, present: 1, absent: 1, halfDay: 1, pendingApproval: 1, notMarked: 4 });
    expect(nls.pendingApprovals).toMatchObject({ attendance: 1, allowances: 1 });
    expect(nls.allowancesThisMonth).toEqual({ requestedPaise: 25_000, approvedPaise: 0 });
    expect(nls.tasksToday).toEqual([expect.objectContaining({ om: expect.objectContaining({ employeeId: h.om.employeeId }), total: 2, pending: 2 })]);
  });

  it('RM: only their team; OM: their own approvals in `me`', async () => {
    const rm = await request(app).get(`${api}/reports/dashboard`).set(h.rm.headers);
    expect(rm.body.businessUnits).toHaveLength(1);
    expect(rm.body.businessUnits[0].today).toMatchObject({ headcount: 4, absent: 1, halfDay: 1, pendingApproval: 1 });
    expect(rm.body.businessUnits[0].tasksToday).toEqual([]);
    expect(rm.body.me.myAttendanceToday).toEqual({ status: 'PRESENT', approvalState: 'PENDING_APPROVAL' });
    const om = await request(app).get(`${api}/reports/dashboard?businessUnitId=${org.nls.id}`).set(h.om.headers);
    expect(om.body.me.pendingApprovals.attendance).toBe(1);
    expect(om.body.businessUnits.map((c: { businessUnit: { code: string } }) => c.businessUnit.code)).toEqual(['NLS']);
    expect((await request(app).get(`${api}/reports/dashboard?businessUnitId=${org.mod.id}`).set(h.om.headers)).status).toBe(403);
  });
});
