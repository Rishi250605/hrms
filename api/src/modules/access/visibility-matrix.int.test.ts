import request from 'supertest';
import { beforeAll, describe, expect, it } from 'vitest';
import { createApp } from '../../app.js';
import { todayIst } from '../../lib/dates.js';
import { createHierarchy, createOrgFixture, resetDb } from '../../../test/helpers.js';
import type { Headers, Hierarchy, Login, Org } from '../../../test/helpers.js';

/**
 * PHASE-2-FEATURES §11 visibility matrix — one suite, every row × role, at least one allowed and one
 * forbidden case per cell. The data is created once through the API (so routing is exercised too) and
 * every case below is a read, or a write that must be refused.
 *
 *   director
 *   ├─ hr (NLS*, BMS) → om (NLS*, BMS) → rm (NLS) → d1, d2, l1 · rm2 (NLS) → d3 · rmBms (BMS) → d4
 *   └─ hrMod (MOD) → omMod (MOD) → rmMod (MOD) → d5
 *
 * Where a role sees "All", the forbidden case is a BU outside theirs (HR) or an action the role does not
 * have (director), since nothing in the data is hidden from them.
 */
const app = createApp();
const api = '/api/v1';
const today = todayIst();
let org: Org;
let h: Hierarchy;
const ids = {
  selfMark: {} as Record<string, string>,
  leave: {} as Record<string, string>,
  task: {} as Record<string, string>,
};

const get = (who: Login | { headers: Headers }, path: string) => request(app).get(`${api}${path}`).set(who.headers);
const post = (who: Login | { headers: Headers }, path: string, body: object = {}) => request(app).post(`${api}${path}`).set(who.headers).send(body);
const pdf = Buffer.from('%PDF-1.4\n%%EOF');

/** Employee ids appearing in a list response (at `pick` of each item). */
type Item = { id: string; employee: { id: string; employeeId: string }; beneficiary: { employeeId: string } };
async function subjects(who: Login | { headers: Headers }, path: string, pick: (item: Item) => string | string[]) {
  const res = await get(who, path);
  expect(res.status, `${path} → ${res.status} ${JSON.stringify(res.body).slice(0, 200)}`).toBe(200);
  const items = (res.body.items ?? res.body.rows) as Item[];
  return new Set(items.flatMap((i) => pick(i)));
}

beforeAll(async () => {
  await resetDb();
  org = await createOrgFixture();
  h = await createHierarchy(org);

  // Attendance: RM team marks (final) and pending self-marks up the line.
  for (const [rm, staff] of [
    [h.rm, h.d1],
    [h.rm2, h.d3],
    [h.rmBms, h.d4],
    [h.rmMod, h.d5],
  ] as const) {
    const res = await post(rm, '/attendance/team/bulk', { marks: [{ clientMutationId: crypto.randomUUID(), employeeId: staff.id, date: today, status: 'PRESENT' }] });
    expect(res.body.applied).toBe(1);
  }
  for (const [key, who] of Object.entries({ rm: h.rm, om: h.om, hr: h.hr, rmMod: h.rmMod })) {
    const res = await post(who, '/attendance/self', { date: today, status: 'PRESENT' });
    expect(res.status).toBe(201);
    ids.selfMark[key] = res.body.id;
  }

  // Leave / OD (OD needs no balance): RMs for their drivers (pending), managers for themselves.
  const od = (o: object = {}) => ({ kind: 'OD', fromDate: today, toDate: today, reason: 'Client site visit', odLocation: 'Nashik', odPurpose: 'Client visit', ...o });
  for (const [key, who, body] of [
    ['d1', h.rm, od({ subjectEmployeeId: h.d1.id, autoApprove: false })],
    ['d3', h.rm2, od({ subjectEmployeeId: h.d3.id, autoApprove: false })],
    ['d5', h.rmMod, od({ subjectEmployeeId: h.d5.id, autoApprove: false })],
    ['rm', h.rm, od()],
    ['om', h.om, od()],
    ['hr', h.hr, od()],
  ] as const) {
    const res = await post(who, '/leave-requests', body);
    expect(res.status, JSON.stringify(res.body)).toBe(201);
    ids.leave[key] = res.body.id;
  }

  // Allowances.
  const type = await post(h.hr, '/allowance-types', { code: 'BATTA', name: 'Batta' });
  const allowance = (o: object = {}) => ({ allowanceTypeId: type.body.id, amountPaise: 20000, fromDate: today, comment: 'Night run', ...o });
  for (const [who, body] of [
    [h.rm, allowance({ beneficiaryEmployeeIds: [h.d1.id] })],
    [h.rm, allowance()],
    [h.om, allowance()],
    [h.rmMod, allowance()],
  ] as const) {
    expect((await post(who, '/allowances', body)).status).toBe(201);
  }

  // Payslips for last month.
  const upload = (who: Login, people: { empCode: string }[]) => {
    let r = request(app).post(`${api}/payslips/upload?period=${today.slice(0, 7)}`).set(who.headers);
    for (const p of people) r = r.attach('files', pdf, { filename: `payslip-${p.empCode}.pdf`, contentType: 'application/pdf' });
    return r;
  };
  expect((await upload(h.hr, [h.hr, h.om, h.rm, { empCode: h.d1.empCode }, { empCode: h.d4.empCode }])).body.matched).toHaveLength(5);
  expect((await upload(h.hrMod, [h.rmMod, { empCode: h.d5.empCode }])).body.matched).toHaveLength(2);

  // Tasks.
  for (const [key, om, bu, rm] of [
    ['rm', h.om, org.nls.id, h.rm],
    ['rm2', h.om, org.nls.id, h.rm2],
    ['rmMod', h.omMod, org.mod.id, h.rmMod],
  ] as const) {
    const res = await post(om, '/tasks', { businessUnitId: bu, title: `Task for ${key}`, assigneeEmployeeIds: [rm.employeeId] });
    ids.task[key] = res.body.items[0].id;
  }
});

// ─────────────────────────── Row 1: driver / loadman records ───────────────────────────

describe('§11 driver/loadman records — RM own reports · OM their RMs’ (read) · HR all · director all', () => {
  it('RM', async () => {
    expect((await get(h.rm, `/employees/${h.d1.id}`)).status).toBe(200);
    expect((await get(h.rm, `/employees/${h.d3.id}`)).status).toBe(404);
  });
  it('OM', async () => {
    expect((await get(h.om, `/employees/${h.d3.id}`)).status).toBe(200);
    expect((await get(h.om, `/employees/${h.d5.id}`)).status).toBe(404);
    expect((await request(app).patch(`${api}/employees/${h.d1.id}`).set(h.om.headers).send({ altPhone: null })).status).toBe(403);
  });
  it('HR', async () => {
    expect((await get(h.hr, `/employees/${h.d4.id}`)).status).toBe(200);
    expect((await get(h.hr, `/employees/${h.d5.id}`)).status).toBe(404);
  });
  it('director', async () => {
    expect((await get(h.director, `/employees/${h.d5.id}`)).status).toBe(200);
    expect((await get(h.director, `/employees?staffOnly=true`)).body.items).toHaveLength(6);
  });
});

// ─────────────────────────── Row 2: attendance ───────────────────────────

describe('§11 attendance — RM self + own staff · OM self + RMs (+ teams, read) · HR all · director all', () => {
  const marks = (who: Login) => subjects(who, `/attendance/marks?from=${today}&to=${today}`, (m) => m.employee.id);
  it('RM', async () => {
    const s = await marks(h.rm);
    expect([...s].sort()).toEqual([h.rm.employeeId, h.d1.id].sort());
    expect(s.has(h.d3.id)).toBe(false);
    expect((await post(h.rm, '/attendance/team/bulk', { marks: [{ clientMutationId: crypto.randomUUID(), employeeId: h.d3.id, date: today, status: 'ABSENT' }] })).status).toBe(403);
  });
  it('OM', async () => {
    const s = await marks(h.om);
    for (const id of [h.om.employeeId, h.rm.employeeId, h.d1.id, h.d3.id, h.d4.id]) expect(s.has(id), id).toBe(true);
    for (const id of [h.hr.employeeId, h.d5.id, h.rmMod.employeeId]) expect(s.has(id), id).toBe(false);
    expect((await get(h.om, `/attendance/team?date=${today}`)).status).toBe(403);
  });
  it('HR', async () => {
    const s = await marks(h.hr);
    for (const id of [h.hr.employeeId, h.om.employeeId, h.d4.id]) expect(s.has(id), id).toBe(true);
    expect(s.has(h.d5.id)).toBe(false);
    expect((await get(h.hr, `/attendance/marks?from=${today}&to=${today}&businessUnitId=${org.mod.id}`)).status).toBe(403);
  });
  it('director', async () => {
    const s = await marks(h.director);
    for (const id of [h.d5.id, h.hr.employeeId, h.rmMod.employeeId]) expect(s.has(id), id).toBe(true);
    expect((await post(h.director, '/attendance/self', { date: today, status: 'PRESENT' })).status).toBe(403);
  });
});

// ─────────────────────────── Row 3: attendance approvals ───────────────────────────

describe('§11 attendance approvals — RM none · OM their RMs · HR their OMs · director HR', () => {
  const queue = (who: Login) => subjects(who, '/attendance/approvals', (m) => m.id);
  it('RM', async () => {
    expect((await get(h.rm, '/attendance/approvals')).status).toBe(403);
    expect((await post(h.rm, `/attendance/${ids.selfMark.rm}/approve`)).status).toBe(403);
  });
  it('OM', async () => {
    const q = await queue(h.om);
    expect(q.has(ids.selfMark.rm!)).toBe(true);
    expect(q.has(ids.selfMark.rmMod!)).toBe(false);
    expect((await post(h.omMod, `/attendance/${ids.selfMark.rm}/approve`)).status).toBe(404);
  });
  it('HR', async () => {
    const q = await queue(h.hr);
    expect(q.has(ids.selfMark.om!)).toBe(true);
    expect(q.has(ids.selfMark.rm!)).toBe(false);
    expect((await post(h.hr, `/attendance/${ids.selfMark.rm}/approve`)).status).toBe(404);
  });
  it('director', async () => {
    const q = await queue(h.director);
    expect(q.has(ids.selfMark.hr!)).toBe(true);
    expect(q.has(ids.selfMark.om!)).toBe(false);
    expect((await post(h.director, `/attendance/${ids.selfMark.om}/approve`)).status).toBe(404);
  });
});

// ─────────────────────────── Row 4: leave / OD ───────────────────────────

describe('§11 leave/OD — RM self + team · OM self + RMs (+ teams, read) · HR all · director all', () => {
  const leave = (who: Login, scope: string) => subjects(who, `/leave-requests?scope=${scope}`, (r) => r.id);
  it('RM', async () => {
    const team = await leave(h.rm, 'team');
    expect(team.has(ids.leave.d1!)).toBe(true);
    expect(team.has(ids.leave.d3!)).toBe(false);
    expect((await leave(h.rm, 'mine')).has(ids.leave.rm!)).toBe(true);
    expect((await get(h.rm, '/leave-requests?scope=all')).status).toBe(403);
  });
  it('OM', async () => {
    const team = await leave(h.om, 'team');
    for (const k of ['rm', 'd1', 'd3']) expect(team.has(ids.leave[k]!), k).toBe(true);
    for (const k of ['d5', 'hr']) expect(team.has(ids.leave[k]!), k).toBe(false);
    expect((await post(h.om, `/leave-requests/${ids.leave.d1}/approve`)).status).toBe(404);
  });
  it('HR', async () => {
    const all = await leave(h.hr, 'all');
    for (const k of ['d1', 'd3', 'rm', 'om', 'hr']) expect(all.has(ids.leave[k]!), k).toBe(true);
    expect(all.has(ids.leave.d5!)).toBe(false);
  });
  it('director', async () => {
    const all = await leave(h.director, 'all');
    expect(all.has(ids.leave.d5!)).toBe(true);
    expect((await leave(h.director, 'approvals')).has(ids.leave.hr!)).toBe(true);
    expect((await post(h.director, `/leave-requests/${ids.leave.d1}/approve`)).status).toBe(404);
  });
});

// ─────────────────────────── Row 5: allowances ───────────────────────────

describe('§11 allowances — RM self + own team · OM self + their RMs’ requests · HR all · director all', () => {
  const beneficiaries = (who: Login, scope: string) => subjects(who, `/allowances?scope=${scope}`, (a) => a.beneficiary.employeeId);
  it('RM', async () => {
    expect([...(await beneficiaries(h.rm, 'team'))]).toEqual([h.d1.id]);
    expect((await beneficiaries(h.rm2, 'team')).size).toBe(0);
    expect((await get(h.rm, '/allowances?scope=all')).status).toBe(403);
  });
  it('OM', async () => {
    const team = await beneficiaries(h.om, 'team');
    expect(team.has(h.rm.employeeId) && team.has(h.d1.id)).toBe(true);
    expect(team.has(h.rmMod.employeeId)).toBe(false);
  });
  it('HR', async () => {
    const all = await beneficiaries(h.hr, 'all');
    expect(all.has(h.om.employeeId)).toBe(true);
    expect(all.has(h.rmMod.employeeId)).toBe(false);
  });
  it('director', async () => {
    expect((await beneficiaries(h.director, 'all')).has(h.rmMod.employeeId)).toBe(true);
    expect((await post(h.director, '/allowances', { allowanceTypeId: crypto.randomUUID(), amountPaise: 100, fromDate: today, comment: 'x' })).status).toBe(403);
  });
});

// ─────────────────────────── Row 6: payslips ───────────────────────────

describe('§11 payslips — RM self + own staff · OM self + their RMs · HR all · director all', () => {
  const period = today.slice(0, 7);
  const owners = (who: Login, scope: string) => subjects(who, `/payslips?scope=${scope}&period=${period}`, (p) => p.employee.employeeId);
  it('RM', async () => {
    expect([...(await owners(h.rm, 'mine'))]).toEqual([h.rm.employeeId]);
    const team = await owners(h.rm, 'team');
    expect(team.has(h.d1.id)).toBe(true);
    expect(team.has(h.d4.id)).toBe(false);
  });
  it('OM', async () => {
    const team = await owners(h.om, 'team');
    expect(team.has(h.rm.employeeId)).toBe(true);
    expect(team.has(h.d1.id)).toBe(false);
  });
  it('HR', async () => {
    const all = await owners(h.hr, 'all');
    expect(all.has(h.d4.id) && all.has(h.hr.employeeId)).toBe(true);
    expect(all.has(h.d5.id)).toBe(false);
  });
  it('director', async () => {
    expect((await owners(h.director, 'all')).has(h.d5.id)).toBe(true);
    expect((await request(app).post(`${api}/payslips/upload?period=${period}`).set(h.director.headers)).status).toBe(403);
  });
});

// ─────────────────────────── Row 7: tasks ───────────────────────────

describe('§11 tasks — RM assigned to them · OM allotted by them · HR all · director all', () => {
  it('RM', async () => {
    expect((await get(h.rm, `/tasks/${ids.task.rm}`)).status).toBe(200);
    expect((await get(h.rm, `/tasks/${ids.task.rm2}`)).status).toBe(404);
  });
  it('OM', async () => {
    expect((await get(h.om, '/tasks?scope=allotted')).body.items).toHaveLength(2);
    expect((await get(h.om, `/tasks/${ids.task.rmMod}`)).status).toBe(404);
  });
  it('HR', async () => {
    const all = await subjects(h.hr, '/tasks?scope=all', (t) => t.id);
    expect(all.has(ids.task.rm!) && all.has(ids.task.rm2!)).toBe(true);
    expect(all.has(ids.task.rmMod!)).toBe(false);
  });
  it('director', async () => {
    expect((await get(h.director, `/tasks/${ids.task.rmMod}`)).status).toBe(200);
    expect((await post(h.director, '/tasks', { businessUnitId: org.nls.id, title: 'x task', assigneeEmployeeIds: [h.rm.employeeId] })).status).toBe(403);
  });
});

// ─────────────────────────── Row 8: reports ───────────────────────────

describe('§11 reports — RM self + team · OM self + RMs + RMs’ teams · HR all · director all', () => {
  const rows = (who: Login) => subjects(who, `/reports/attendance?from=${today}&to=${today}`, (r) => r.employee.employeeId);
  it('RM', async () => {
    const s = await rows(h.rm);
    expect(s.has(h.rm.employeeId) && s.has(h.l1.id)).toBe(true);
    expect(s.has(h.d3.id)).toBe(false);
  });
  it('OM', async () => {
    const s = await rows(h.om);
    expect(s.has(h.d3.id) && s.has(h.d4.id)).toBe(true);
    expect(s.has(h.hr.employeeId) || s.has(h.d5.id)).toBe(false);
  });
  it('HR', async () => {
    const s = await rows(h.hr);
    expect(s.has(h.hr.employeeId)).toBe(true);
    expect(s.has(h.d5.id)).toBe(false);
    expect((await get(h.hr, `/reports/dashboard?businessUnitId=${org.mod.id}`)).status).toBe(403);
  });
  it('director', async () => {
    const s = await rows(h.director);
    expect(s.has(h.d5.id)).toBe(true);
    expect(s.has(h.director.employeeId)).toBe(false);
  });
});

// ─────────────────────────── Row 9: user management ───────────────────────────

describe('§11 user management — RM none · OM none · HR driver/loadman records only · director everything', () => {
  const newUser = () => ({
    empCode: `NLS${Math.floor(500 + Math.random() * 400)}`,
    fullName: 'Matrix User',
    phone: `98${String(Date.now()).slice(-8)}`,
    role: 'REGIONAL_MANAGER',
    businessUnitIds: [org.nls.id],
    reportingToEmployeeId: h.om.employeeId,
    depotId: org.pune.id,
    password: 'Initial-Pass-1',
  });
  it('RM', async () => {
    expect((await post(h.rm, '/users', newUser())).status).toBe(403);
    expect((await get(h.rm, '/users')).status).toBe(403);
  });
  it('OM', async () => {
    expect((await post(h.om, '/users', newUser())).status).toBe(403);
    expect((await post(h.om, `/users/${h.rm.user.id}/unlock`)).status).toBe(403);
  });
  it('HR', async () => {
    expect((await request(app).patch(`${api}/employees/${h.d1.id}`).set(h.hr.headers).send({ altPhone: '+919811111111' })).status).toBe(200);
    expect((await request(app).patch(`${api}/employees/${h.om.employeeId}`).set(h.hr.headers).send({ altPhone: '+919811111111' })).status).toBe(403);
    expect((await post(h.hr, `/users/${h.rm.user.id}/reset-password`, { password: 'Another-Pass-1' })).status).toBe(403);
  });
  it('director', async () => {
    expect((await post(h.director, '/users', newUser())).status).toBe(201);
    expect((await request(app).patch(`${api}/employees/${h.om.employeeId}`).set(h.director.headers).send({ altPhone: '+919822222222' })).status).toBe(200);
  });
});
