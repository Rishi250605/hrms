import request from 'supertest';
import { beforeEach, describe, expect, it } from 'vitest';
import { createApp } from '../../app.js';
import { addDays, todayIst, toDbDate } from '../../lib/dates.js';
import { prisma } from '../../lib/prisma.js';
import { createHierarchy, createOrgFixture, resetDb } from '../../../test/helpers.js';
import type { Headers, Hierarchy, Login, Org } from '../../../test/helpers.js';

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

const allot = (headers: Headers, body: Record<string, unknown>) =>
  request(app)
    .post(`${api}/tasks`)
    .set(headers)
    .send({ businessUnitId: org.nls.id, title: 'Check tyre pressure of all trucks', ...body });
const submit = (who: Login, id: string, body: Record<string, unknown>) => request(app).post(`${api}/tasks/${id}/submit`).set(who.headers).send(body);
const notes = (u: Login, type: string) => prisma.notification.count({ where: { recipientUserId: u.user.id, type } });
const titles = async (who: Login, query: string) => {
  const res = await request(app).get(`${api}/tasks?${query}`).set(who.headers);
  expect(res.status, `${who.empCode} ${query}`).toBe(200);
  return (res.body.items as { id: string }[]).map((t) => t.id).sort();
};

describe('allotment (§8.1)', () => {
  it('OM allots to two of their RMs: one task each, same group, today by default, RMs notified', async () => {
    const res = await allot(h.om.headers, { assigneeEmployeeIds: [h.rm.employeeId, h.rm2.employeeId], priority: 'HIGH', details: 'Before the 6am run' });
    expect(res.status).toBe(201);
    expect(res.body.items).toHaveLength(2);
    expect(res.body.items[0]).toMatchObject({ date: today, status: 'PENDING', priority: 'HIGH', overdue: false, allottedBy: { employeeId: h.om.employeeId }, businessUnit: { code: 'NLS' } });
    expect(res.body.items[0].groupId).toBe(res.body.items[1].groupId);
    expect([await notes(h.rm, 'TASK_ALLOTTED'), await notes(h.rm2, 'TASK_ALLOTTED'), await notes(h.rmBms, 'TASK_ALLOTTED')]).toEqual([1, 1, 0]);
  });

  it('only OMs, only their own RMs, only in a shared business unit, not in the past', async () => {
    // rmBms is the OM's RM but not in NLS.
    expect((await allot(h.om.headers, { assigneeEmployeeIds: [h.rmBms.employeeId] })).status).toBe(403);
    expect((await allot(h.om.headers, { businessUnitId: org.bms.id, assigneeEmployeeIds: [h.rmBms.employeeId] })).status).toBe(201);
    expect((await allot(h.om.headers, { assigneeEmployeeIds: [h.rmMod.employeeId] })).status).toBe(403);
    expect((await allot(h.omMod.headers, { businessUnitId: org.mod.id, assigneeEmployeeIds: [h.rm.employeeId] })).status).toBe(403);
    expect((await allot(h.omMod.headers, { assigneeEmployeeIds: [h.rmMod.employeeId] })).status).toBe(403); // NLS is not omMod's BU
    expect((await allot(h.om.headers, { assigneeEmployeeIds: [h.d1.id] })).status).toBe(403);
    expect((await allot(h.hr.headers, { assigneeEmployeeIds: [h.rm.employeeId] })).status).toBe(403);
    expect((await allot(h.rm.headers, { assigneeEmployeeIds: [h.rm2.employeeId] })).status).toBe(403);
    expect((await allot(h.om.headers, { assigneeEmployeeIds: [h.rm.employeeId], date: addDays(today, -1) })).status).toBe(400);
    expect((await allot(h.om.headers, { assigneeEmployeeIds: [h.rm.employeeId], date: addDays(today, 3) })).body.items[0].date).toBe(addDays(today, 3));
  });
});

describe('submit and reopen (§8.1)', () => {
  let id: string;
  beforeEach(async () => {
    id = (await allot(h.om.headers, { assigneeEmployeeIds: [h.rm.employeeId] })).body.items[0].id;
  });

  it('RM submits not done with a reason; locked; OM and HR notified; OM reopens and the RM is notified', async () => {
    expect((await submit(h.rm, id, { status: 'NOT_DONE' })).status).toBe(400);
    const res = await submit(h.rm, id, { status: 'NOT_DONE', reason: 'Truck in workshop', comment: 'Will do tomorrow' });
    expect(res.status).toBe(200);
    expect(res.body).toMatchObject({ status: 'NOT_DONE', reason: 'Truck in workshop', canSubmit: false });
    expect([await notes(h.om, 'TASK_SUBMITTED'), await notes(h.hr, 'TASK_SUBMITTED'), await notes(h.hrMod, 'TASK_SUBMITTED')]).toEqual([1, 1, 0]);
    expect((await submit(h.rm, id, { status: 'COMPLETED' })).status).toBe(409);

    expect((await request(app).post(`${api}/tasks/${id}/reopen`).set(h.omMod.headers).send({ comment: 'Please redo' })).status).toBe(404);
    const reopened = await request(app).post(`${api}/tasks/${id}/reopen`).set(h.om.headers).send({ comment: 'Workshop is done now' });
    expect(reopened.body).toMatchObject({ status: 'PENDING', reopenCount: 1, reopenComment: 'Workshop is done now', submittedAt: null });
    expect(await notes(h.rm, 'TASK_REOPENED')).toBe(1);
    expect((await submit(h.rm, id, { status: 'COMPLETED' })).body.status).toBe('COMPLETED');
  });

  it('only the assignee submits; reopening needs a submitted task', async () => {
    expect((await submit(h.rm2, id, { status: 'COMPLETED' })).status).toBe(404);
    expect((await submit(h.om, id, { status: 'COMPLETED' })).status).toBe(403);
    expect((await request(app).post(`${api}/tasks/${id}/reopen`).set(h.om.headers).send({ comment: 'Too early' })).status).toBe(409);
  });

  it('a pending task after its date is overdue on both sides', async () => {
    await prisma.task.update({ where: { id }, data: { date: toDbDate(addDays(today, -1)) } });
    const rm = await request(app).get(`${api}/tasks?scope=assigned&state=open`).set(h.rm.headers);
    expect(rm.body.items[0]).toMatchObject({ id, overdue: true });
    expect(await titles(h.om, 'scope=allotted&overdue=true')).toEqual([id]);
    await submit(h.rm, id, { status: 'COMPLETED' });
    expect(await titles(h.om, 'scope=allotted&overdue=true')).toEqual([]);
    expect(await titles(h.rm, 'scope=assigned&state=submitted')).toEqual([id]);
  });
});

describe('visibility (§11 Tasks: RM assigned to them; OM allotted by them; HR / director all)', () => {
  let rmTask: string;
  let rm2Task: string;
  let bmsTask: string;
  let modTask: string;
  beforeEach(async () => {
    rmTask = (await allot(h.om.headers, { assigneeEmployeeIds: [h.rm.employeeId] })).body.items[0].id;
    rm2Task = (await allot(h.om.headers, { assigneeEmployeeIds: [h.rm2.employeeId] })).body.items[0].id;
    bmsTask = (await allot(h.om.headers, { businessUnitId: org.bms.id, assigneeEmployeeIds: [h.rmBms.employeeId] })).body.items[0].id;
    modTask = (await allot(h.omMod.headers, { businessUnitId: org.mod.id, assigneeEmployeeIds: [h.rmMod.employeeId] })).body.items[0].id;
  });

  it('RM sees only tasks assigned to them', async () => {
    expect(await titles(h.rm, 'scope=assigned')).toEqual([rmTask]);
    expect(await titles(h.rm, 'scope=allotted')).toEqual([]);
    expect((await request(app).get(`${api}/tasks?scope=all`).set(h.rm.headers)).status).toBe(403);
    expect((await request(app).get(`${api}/tasks/${rm2Task}`).set(h.rm.headers)).status).toBe(404);
  });

  it('OM sees tasks allotted by them, per business unit', async () => {
    expect(await titles(h.om, 'scope=allotted')).toEqual([rmTask, rm2Task, bmsTask].sort());
    expect(await titles(h.om, `scope=allotted&businessUnitId=${org.bms.id}`)).toEqual([bmsTask]);
    expect(await titles(h.omMod, 'scope=allotted')).toEqual([modTask]);
    expect((await request(app).get(`${api}/tasks/${modTask}`).set(h.om.headers)).status).toBe(404);
  });

  it('HR sees all tasks in their business units; the director sees everything', async () => {
    expect(await titles(h.hr, 'scope=all')).toEqual([rmTask, rm2Task, bmsTask].sort());
    expect(await titles(h.hr, `scope=all&assigneeEmployeeId=${h.rm2.employeeId}`)).toEqual([rm2Task]);
    expect(await titles(h.hrMod, 'scope=all')).toEqual([modTask]);
    expect(await titles(h.director, 'scope=all')).toEqual([rmTask, rm2Task, bmsTask, modTask].sort());
    expect((await request(app).get(`${api}/tasks/${modTask}`).set(h.hr.headers)).status).toBe(404);
  });
});
