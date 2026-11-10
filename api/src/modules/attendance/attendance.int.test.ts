import { randomUUID } from 'node:crypto';
import request from 'supertest';
import { beforeEach, describe, expect, it } from 'vitest';
import { createApp } from '../../app.js';
import { addDays, todayIst, toDbDate } from '../../lib/dates.js';
import { prisma } from '../../lib/prisma.js';
import { createHierarchy, createLogin, createOrgFixture, resetDb } from '../../../test/helpers.js';
import type { Hierarchy, Org } from '../../../test/helpers.js';

const app = createApp();
const api = '/api/v1';
let org: Org;
let h: Hierarchy;
const today = todayIst();

beforeEach(async () => {
  await resetDb();
  org = await createOrgFixture();
  h = await createHierarchy(org);
});

const mark = (employeeId: string, status = 'PRESENT', date = today, clientMutationId: string = randomUUID()) => ({ clientMutationId, employeeId, date, status });
const notes = (userId: string, type: string) => prisma.notification.count({ where: { recipientUserId: userId, type } });

describe('RM team marking (§4.1 drivers / loadmen)', () => {
  it('lists only the RM’s drivers and loadmen, pre-filled PRESENT', async () => {
    const res = await request(app).get(`${api}/attendance/team?date=${today}`).set(h.rm.headers);
    expect(res.status).toBe(200);
    expect(res.body.rows.map((r: { employee: { fullName: string }; suggestedStatus: string }) => [r.employee.fullName, r.suggestedStatus])).toEqual([
      ['Driver One', 'PRESENT'],
      ['Driver Two', 'PRESENT'],
      ['Loadman One', 'PRESENT'],
    ]);
    expect((await request(app).get(`${api}/attendance/team?date=${today}`).set(h.om.headers)).status).toBe(403);
  });

  it('marks are final, idempotent by clientMutationId, and refused for someone else’s driver (403)', async () => {
    const batch = { marks: [mark(h.d1.id), mark(h.l1.id, 'ABSENT')] };
    const first = await request(app).post(`${api}/attendance/team/bulk`).set(h.rm.headers).send(batch);
    expect(first.body).toMatchObject({ applied: 2, duplicates: 0, rejected: 0 });
    expect((await request(app).post(`${api}/attendance/team/bulk`).set(h.rm.headers).send(batch)).body).toMatchObject({ applied: 0, duplicates: 2 });
    const row = await prisma.attendanceMark.findFirstOrThrow({ where: { employeeId: h.d1.id } });
    expect(row).toMatchObject({ approvalState: 'APPROVED', source: 'MANAGER', businessUnitId: org.nls.id });

    const foreign = await request(app).post(`${api}/attendance/team/bulk`).set(h.rm.headers).send({ marks: [mark(h.d1.id), mark(h.d3.id)] });
    expect(foreign.status).toBe(403);
    expect(foreign.body.error.details.employeeIds).toEqual([h.d3.id]);
  });

  it('the edit window closes after 23:59 IST the next day; future dates are refused', async () => {
    const res = await request(app)
      .post(`${api}/attendance/team/bulk`)
      .set(h.rm.headers)
      .send({ marks: [mark(h.d1.id, 'PRESENT', addDays(today, -1)), mark(h.d2.id, 'PRESENT', addDays(today, -2)), mark(h.l1.id, 'PRESENT', addDays(today, 1))] });
    expect(res.status).toBe(200);
    expect(res.body.results.map((r: { outcome: string; error: { code: string } | null }) => r.error?.code ?? r.outcome)).toEqual(['APPLIED', 'EDIT_WINDOW_CLOSED', 'FUTURE_DATE']);
  });
});

describe('self-marking with hierarchical approval (§4.1, §4.4)', () => {
  it('RM → their OM approves; other RMs, HR and the director do not see it', async () => {
    const self = await request(app).post(`${api}/attendance/self`).set(h.rm.headers).send({ date: today, status: 'PRESENT' });
    expect(self.status).toBe(201);
    expect(self.body).toMatchObject({ approvalState: 'PENDING_APPROVAL', approver: { employeeId: h.om.employeeId } });
    expect(await notes(h.om.user.id, 'ATTENDANCE_SUBMITTED')).toBe(1);

    expect((await request(app).get(`${api}/attendance/approvals`).set(h.om.headers)).body.items).toHaveLength(1);
    expect((await request(app).get(`${api}/attendance/approvals`).set(h.hr.headers)).body.items).toHaveLength(0);
    expect((await request(app).get(`${api}/attendance/approvals`).set(h.omMod.headers)).body.items).toHaveLength(0);
    expect((await request(app).post(`${api}/attendance/${self.body.id}/approve`).set(h.hr.headers)).status).toBe(404);
    expect((await request(app).post(`${api}/attendance/${self.body.id}/approve`).set(h.rm2.headers)).status).toBe(403);

    const ok = await request(app).post(`${api}/attendance/${self.body.id}/approve`).set(h.om.headers);
    expect(ok.body.approvalState).toBe('APPROVED');
    expect(await notes(h.rm.user.id, 'ATTENDANCE_APPROVED')).toBe(1);
    expect(await prisma.auditLog.count({ where: { action: 'attendance.approve', entityId: self.body.id } })).toBe(1);
    // An approved day changes only through a correction.
    expect((await request(app).post(`${api}/attendance/self`).set(h.rm.headers).send({ date: today, status: 'ABSENT' })).body.error.code).toBe('ALREADY_APPROVED');
  });

  it('OM → HR, HR → director; the director is not tracked', async () => {
    const om = await request(app).post(`${api}/attendance/self`).set(h.om.headers).send({ date: today, status: 'PRESENT' });
    expect(om.body.approver.employeeId).toBe(h.hr.employeeId);
    expect((await request(app).get(`${api}/attendance/approvals`).set(h.hr.headers)).body.items.map((m: { id: string }) => m.id)).toEqual([om.body.id]);
    const hr = await request(app).post(`${api}/attendance/self`).set(h.hr.headers).send({ date: today, status: 'PRESENT' });
    expect(hr.body.approver.employeeId).toBe(h.director.employeeId);
    expect((await request(app).get(`${api}/attendance/approvals`).set(h.director.headers)).body.items.map((m: { id: string }) => m.id)).toEqual([hr.body.id]);
    expect((await request(app).post(`${api}/attendance/self`).set(h.director.headers).send({ date: today, status: 'PRESENT' })).status).toBe(403);
  });

  it('reject needs a reason; the rejected mark can be resubmitted; bulk approve', async () => {
    const m = await request(app).post(`${api}/attendance/self`).set(h.rm.headers).send({ date: today, status: 'PRESENT' });
    expect((await request(app).post(`${api}/attendance/${m.body.id}/reject`).set(h.om.headers).send({ reason: '' })).status).toBe(400);
    const rej = await request(app).post(`${api}/attendance/${m.body.id}/reject`).set(h.om.headers).send({ reason: 'You were on leave' });
    expect(rej.body).toMatchObject({ approvalState: 'REJECTED', rejectionReason: 'You were on leave' });
    expect(await notes(h.rm.user.id, 'ATTENDANCE_REJECTED')).toBe(1);
    const again = await request(app).post(`${api}/attendance/self`).set(h.rm.headers).send({ date: today, status: 'HALF_DAY' });
    expect(again.body.approvalState).toBe('PENDING_APPROVAL');
    const m2 = await request(app).post(`${api}/attendance/self`).set(h.rm2.headers).send({ date: today, status: 'PRESENT' });
    const bulk = await request(app).post(`${api}/attendance/approvals/bulk-approve`).set(h.om.headers).send({ ids: [again.body.id, m2.body.id] });
    expect(bulk.body.approved.sort()).toEqual([again.body.id, m2.body.id].sort());
  });

  it('an inactive approver’s queue falls to a same-role colleague in the BU, and the director is told', async () => {
    const om2 = await createLogin({ role: 'OPERATIONAL_MANAGER', businessUnitIds: [org.nls.id], depotId: org.pune.id, reportsTo: h.hr.employeeId });
    await prisma.user.update({ where: { id: h.om.user.id }, data: { isActive: false } });
    const m = await request(app).post(`${api}/attendance/self`).set(h.rm.headers).send({ date: today, status: 'PRESENT' });
    expect(m.body.approver.employeeId).toBe(om2.employeeId);
    expect(await notes(h.director.user.id, 'ATTENDANCE_SUBMITTED')).toBe(1);
    expect((await request(app).post(`${api}/attendance/${m.body.id}/approve`).set(om2.headers)).status).toBe(200);
  });
});

describe('corrections and read-only views', () => {
  it('after the window an RM raises a correction for their driver; their OM approves; the mark changes', async () => {
    const old = addDays(today, -3);
    await prisma.attendanceMark.create({
      data: { employeeId: h.d1.id, businessUnitId: org.nls.id, date: toDbDate(old), status: 'ABSENT', approvalState: 'APPROVED', source: 'MANAGER', markedById: h.rm.user.id, markedAt: new Date() },
    });
    expect((await request(app).post(`${api}/attendance/corrections`).set(h.rm.headers).send({ employeeId: h.d1.id, date: today, status: 'PRESENT', reason: 'typo fix' })).body.error.code).toBe('EDIT_WINDOW_OPEN');
    expect((await request(app).post(`${api}/attendance/corrections`).set(h.rm2.headers).send({ employeeId: h.d1.id, date: old, status: 'PRESENT', reason: 'not mine' })).status).toBe(404);
    const c = await request(app).post(`${api}/attendance/corrections`).set(h.rm.headers).send({ employeeId: h.d1.id, date: old, status: 'PRESENT', reason: 'Was on duty' });
    expect(c.status).toBe(201);
    expect(c.body).toMatchObject({ fromStatus: 'ABSENT', toStatus: 'PRESENT', status: 'PENDING', approver: { employeeId: h.om.employeeId } });
    expect((await request(app).get(`${api}/attendance/corrections?scope=approvals`).set(h.om.headers)).body.items).toHaveLength(1);
    expect((await request(app).post(`${api}/attendance/corrections/${c.body.id}/approve`).set(h.om.headers)).body.status).toBe('APPROVED');
    expect((await prisma.attendanceMark.findFirstOrThrow({ where: { employeeId: h.d1.id } })).status).toBe('PRESENT');
  });

  it('read-only marks follow §11: OM sees RMs’ teams, RM only their own, HR all in BUs', async () => {
    await request(app).post(`${api}/attendance/team/bulk`).set(h.rm.headers).send({ marks: [mark(h.d1.id)] });
    await request(app).post(`${api}/attendance/team/bulk`).set(h.rmMod.headers).send({ marks: [mark(h.d5.id)] });
    const q = `${api}/attendance/marks?from=${today}&to=${today}`;
    expect((await request(app).get(q).set(h.om.headers)).body.items).toHaveLength(1);
    expect((await request(app).get(q).set(h.rm2.headers)).body.items).toHaveLength(0);
    expect((await request(app).get(q).set(h.hr.headers)).body.items).toHaveLength(1);
    expect((await request(app).get(q).set(h.director.headers)).body.items).toHaveLength(2);
  });
});
