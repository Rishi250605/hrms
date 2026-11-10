import request from 'supertest';
import { beforeEach, describe, expect, it } from 'vitest';
import { createApp } from '../../app.js';
import { runLeaveAccrual } from '../../jobs/leave.js';
import { addDays, todayIst } from '../../lib/dates.js';
import { prisma } from '../../lib/prisma.js';
import { createHierarchy, createOrgFixture, resetDb } from '../../../test/helpers.js';
import type { Headers, Hierarchy, Org } from '../../../test/helpers.js';
import { leaveDays } from './service.js';

const app = createApp();
const api = '/api/v1';
let org: Org;
let h: Hierarchy;
let cl: { id: string };
const year = Number(todayIst().slice(0, 4));
const from = (() => {
  const d = addDays(todayIst(), 7);
  return d.slice(0, 4) === String(year) ? d : `${year}-12-20`;
})();

beforeEach(async () => {
  await resetDb();
  org = await createOrgFixture();
  h = await createHierarchy(org);
  cl = await prisma.leaveType.create({ data: { code: 'CL', name: 'Casual', paid: true, accrualRule: { type: 'MONTHLY' } } });
  await prisma.leavePolicy.create({ data: { leaveTypeId: cl.id, annualQuota: 12 } });
});

async function withBalance(employeeId: string, days: number) {
  await prisma.leaveBalance.create({ data: { employeeId, leaveTypeId: cl.id, year, accrued: days, closing: days } });
}
const raise = (headers: Headers, body: Record<string, unknown>) =>
  request(app).post(`${api}/leave-requests`).set(headers).send({ kind: 'LEAVE', leaveTypeId: cl.id, fromDate: from, toDate: from, reason: 'Family function', ...body });
const notes = (userId: string, type: string) => prisma.notification.count({ where: { recipientUserId: userId, type } });

describe('leave day count', () => {
  it('counts calendar days with half days at either end', () => {
    expect(leaveDays('2026-11-10', '2026-11-12', false, false)).toBe(3);
    expect(leaveDays('2026-11-10', '2026-11-12', true, true)).toBe(2);
    expect(leaveDays('2026-11-10', '2026-11-10', true, false)).toBe(0.5);
  });
});

describe('routing (§5.1)', () => {
  it('RM raises for their driver and approves in one step: attendance ON_LEAVE, balance used, HR notified', async () => {
    await withBalance(h.d1.id, 3);
    const res = await raise(h.rm.headers, { subjectEmployeeId: h.d1.id, toDate: addDays(from, 1), autoApprove: true });
    expect(res.status).toBe(201);
    expect(res.body).toMatchObject({ status: 'APPROVED', days: 2, approver: { employeeId: h.rm.employeeId } });
    const marks = await prisma.attendanceMark.findMany({ where: { employeeId: h.d1.id }, orderBy: { date: 'asc' } });
    expect(marks.map((m) => [m.status, m.approvalState, m.source])).toEqual([
      ['ON_LEAVE', 'APPROVED', 'SYSTEM'],
      ['ON_LEAVE', 'APPROVED', 'SYSTEM'],
    ]);
    expect(Number((await prisma.leaveBalance.findFirstOrThrow({ where: { employeeId: h.d1.id } })).used)).toBe(2);
    expect(await notes(h.hr.user.id, 'LEAVE_APPROVED')).toBe(1);
    expect(await notes(h.hrMod.user.id, 'LEAVE_APPROVED')).toBe(0);
  });

  it('saved as pending, the RM approves later from the approvals list', async () => {
    await withBalance(h.d1.id, 3);
    const res = await raise(h.rm.headers, { subjectEmployeeId: h.d1.id });
    expect(res.body.status).toBe('PENDING');
    const list = await request(app).get(`${api}/leave-requests?scope=approvals`).set(h.rm.headers);
    expect(list.body.items.map((r: { id: string }) => r.id)).toEqual([res.body.id]);
    expect((await request(app).post(`${api}/leave-requests/${res.body.id}/approve`).set(h.rm.headers)).body.status).toBe('APPROVED');
  });

  it('an RM cannot raise for another RM’s driver or approve in one step for themself', async () => {
    expect((await raise(h.rm.headers, { subjectEmployeeId: h.d3.id })).status).toBe(404);
    await withBalance(h.rm.employeeId, 3);
    expect((await raise(h.rm.headers, { autoApprove: true })).status).toBe(403);
  });

  it('RM self → OM approves (HR notified); OM self → HR; HR self → director', async () => {
    for (const p of [h.rm, h.om, h.hr]) await withBalance(p.employeeId, 5);
    const rm = await raise(h.rm.headers, {});
    expect(rm.body.approver.employeeId).toBe(h.om.employeeId);
    expect(await notes(h.om.user.id, 'LEAVE_SUBMITTED')).toBe(1);
    expect(await notes(h.hr.user.id, 'LEAVE_SUBMITTED')).toBe(1);
    expect((await request(app).post(`${api}/leave-requests/${rm.body.id}/approve`).set(h.hr.headers)).status).toBe(404);
    expect((await request(app).post(`${api}/leave-requests/${rm.body.id}/approve`).set(h.om.headers)).body.status).toBe('APPROVED');
    expect(await notes(h.rm.user.id, 'LEAVE_APPROVED')).toBe(1);

    const om = await raise(h.om.headers, {});
    expect(om.body.approver.employeeId).toBe(h.hr.employeeId);
    const hr = await raise(h.hr.headers, {});
    expect(hr.body.approver.employeeId).toBe(h.director.employeeId);
    expect(await notes(h.director.user.id, 'LEAVE_SUBMITTED')).toBe(1);
    const rej = await request(app).post(`${api}/leave-requests/${hr.body.id}/reject`).set(h.director.headers).send({ reason: 'Audit week' });
    expect(rej.body).toMatchObject({ status: 'REJECTED', rejectionReason: 'Audit week' });
  });
});

describe('OD, validation and cancellation', () => {
  it('OD needs location and purpose and sets ON_DUTY when approved', async () => {
    expect((await raise(h.rm.headers, { subjectEmployeeId: h.d1.id, kind: 'OD', leaveTypeId: undefined })).status).toBe(400);
    const od = await raise(h.rm.headers, { subjectEmployeeId: h.d1.id, kind: 'OD', leaveTypeId: undefined, odLocation: 'Client site, Nashik', odPurpose: 'Loading', autoApprove: true });
    expect(od.body).toMatchObject({ kind: 'OD', status: 'APPROVED', odLocation: 'Client site, Nashik' });
    expect((await prisma.attendanceMark.findFirstOrThrow({ where: { employeeId: h.d1.id } })).status).toBe('ON_DUTY');
  });

  it('refuses overlaps and short balances (setting BLOCK); WARN lets it through with a warning', async () => {
    await withBalance(h.d1.id, 1);
    expect((await raise(h.rm.headers, { subjectEmployeeId: h.d1.id, toDate: addDays(from, 2) })).body.error.code).toBe('INSUFFICIENT_BALANCE');
    await raise(h.rm.headers, { subjectEmployeeId: h.d1.id });
    expect((await raise(h.rm.headers, { subjectEmployeeId: h.d1.id })).body.error.code).toBe('LEAVE_OVERLAP');
    await request(app).put(`${api}/settings/leave.balanceEnforcement`).set(h.hr.headers).send({ value: 'WARN' });
    const warned = await raise(h.rm.headers, { subjectEmployeeId: h.d2.id, toDate: addDays(from, 2) });
    expect(warned.body.warnings).toEqual(['INSUFFICIENT_BALANCE']);
  });

  it('cancelling an approved request (approver) restores the balance and removes its attendance marks', async () => {
    await withBalance(h.d1.id, 3);
    const r = await raise(h.rm.headers, { subjectEmployeeId: h.d1.id, autoApprove: true });
    const res = await request(app).post(`${api}/leave-requests/${r.body.id}/cancel`).set(h.rm.headers);
    expect(res.body.status).toBe('CANCELLED');
    expect(await prisma.attendanceMark.count({ where: { employeeId: h.d1.id } })).toBe(0);
    expect(Number((await prisma.leaveBalance.findFirstOrThrow({ where: { employeeId: h.d1.id } })).used)).toBe(0);
  });
});

describe('visibility (§11 Leave/OD)', () => {
  it('RM: self + team; OM: self + RMs + their teams; HR all in BUs; scope=all only HR / director', async () => {
    await withBalance(h.d1.id, 3);
    await withBalance(h.d4.id, 3);
    await withBalance(h.d5.id, 3);
    await raise(h.rm.headers, { subjectEmployeeId: h.d1.id });
    await raise(h.rmBms.headers, { subjectEmployeeId: h.d4.id });
    await raise(h.rmMod.headers, { subjectEmployeeId: h.d5.id });
    const count = async (headers: Headers, scope: string) => (await request(app).get(`${api}/leave-requests?scope=${scope}`).set(headers)).body.items?.length;
    expect(await count(h.rm.headers, 'team')).toBe(1);
    expect(await count(h.rm2.headers, 'team')).toBe(0);
    expect(await count(h.om.headers, 'team')).toBe(2);
    expect(await count(h.hr.headers, 'all')).toBe(2);
    expect(await count(h.director.headers, 'all')).toBe(3);
    expect((await request(app).get(`${api}/leave-requests?scope=all`).set(h.om.headers)).status).toBe(403);
  });
});

describe('accrual job', () => {
  it('credits quota/12 once per month', async () => {
    expect((await runLeaveAccrual()).credited).toBeGreaterThan(0);
    const again = await runLeaveAccrual();
    expect(again.credited).toBe(0);
    expect(Number((await prisma.leaveBalance.findFirstOrThrow({ where: { employeeId: h.d1.id } })).closing)).toBe(1);
  });
});
