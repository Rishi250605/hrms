import request from 'supertest';
import { beforeEach, describe, expect, it } from 'vitest';
import { createApp } from '../../app.js';
import { addDays, todayIst } from '../../lib/dates.js';
import { prisma } from '../../lib/prisma.js';
import { createHierarchy, createOrgFixture, createStaff, resetDb, seedDriverRequirements, validDriverDocs } from '../../../test/helpers.js';
import type { Headers, Hierarchy, Org } from '../../../test/helpers.js';

const app = createApp();
const api = '/api/v1';
let org: Org;
let h: Hierarchy;
const date = addDays(todayIst(), 2);

beforeEach(async () => {
  await resetDb();
  org = await createOrgFixture();
  await seedDriverRequirements();
  h = await createHierarchy(org, { docs: true });
});

async function duty(headers: Headers, body: Record<string, unknown>) {
  const res = await request(app).post(`${api}/duties`).set(headers).send({ depotId: org.pune.id, dutyDate: date, ...body });
  expect(res.status).toBe(201);
  return res.body as { id: string; scheduledStart: string; scheduledEnd: string; crossesMidnight: boolean };
}
const assign = (headers: Headers, dutyId: string, employeeId: string, role = 'DRIVER') => request(app).post(`${api}/duties/${dutyId}/assignments`).set(headers).send({ employeeId, role });

describe('fleet and duties (BU scope through the depot)', () => {
  it('vehicles, routes and templates within my business units only', async () => {
    const v = await request(app).post(`${api}/vehicles`).set(h.rm.headers).send({ regNo: 'mh 12 ab 1234', type: 'Truck', depotId: org.pune.id });
    expect(v.body.regNo).toBe('MH12AB1234');
    expect((await request(app).post(`${api}/vehicles`).set(h.rm.headers).send({ regNo: 'KA01AB1234', type: 'Truck', depotId: org.blr.id })).status).toBe(404);
    expect((await request(app).get(`${api}/vehicles`).set(h.rmMod.headers)).body.items).toHaveLength(0);
    const t = await request(app).post(`${api}/duty-templates`).set(h.rm.headers).send({ depotId: org.pune.id, name: 'Night', startTime: '22:00', endTime: '06:00' });
    expect(t.body.crossesMidnight).toBe(true);
  });

  it('roster day view and 404 for another BU’s depot', async () => {
    await duty(h.rm.headers, { startTime: '06:00', endTime: '14:00' });
    const day = await request(app).get(`${api}/roster?depotId=${org.pune.id}&date=${date}`).set(h.rm.headers);
    expect(day.body.summary).toEqual({ duties: 1, filled: 0, unfilled: 1, cancelled: 0 });
    expect((await request(app).get(`${api}/roster?depotId=${org.pune.id}&date=${date}`).set(h.rmMod.headers)).status).toBe(404);
  });

  it('refuses to double-book a vehicle', async () => {
    const v = await request(app).post(`${api}/vehicles`).set(h.rm.headers).send({ regNo: 'MH12AB0001', type: 'Truck', depotId: org.pune.id });
    await duty(h.rm.headers, { startTime: '06:00', endTime: '14:00', vehicleId: v.body.id });
    const clash = await request(app).post(`${api}/duties`).set(h.rm.headers).send({ depotId: org.pune.id, dutyDate: date, startTime: '13:00', endTime: '18:00', vehicleId: v.body.id });
    expect(clash.body.error.code).toBe('VEHICLE_DOUBLE_BOOKED');
  });
});

describe('assignments', () => {
  it('409 DOCUMENT_INVALID with spares from my team', async () => {
    const expired = await createStaff({
      businessUnitId: org.nls.id,
      depotId: org.pune.id,
      reportsTo: h.rm.employeeId,
      fullName: 'Expired DL',
      docs: [...validDriverDocs().slice(1), { type: 'DRIVING_LICENCE', expiryDate: addDays(date, -1) }],
    });
    const d = await duty(h.rm.headers, { startTime: '06:00', endTime: '14:00' });
    const res = await assign(h.rm.headers, d.id, expired.id);
    expect(res.status).toBe(409);
    expect(res.body.error.code).toBe('DOCUMENT_INVALID');
    expect(res.body.error.details.failing[0]).toMatchObject({ type: 'DRIVING_LICENCE', state: 'EXPIRED' });
    // Spares come from the RM's own team (d1, d2); RM Two's driver is not offered.
    expect(res.body.error.details.spares.map((s: { employee: { id: string } }) => s.employee.id).sort()).toEqual([h.d1.id, h.d2.id].sort());
    expect((await assign(h.rm.headers, d.id, h.d1.id)).status).toBe(201);
  });

  it('an RM cannot roster another RM’s driver; the OM can roster both teams', async () => {
    const d = await duty(h.rm.headers, { startTime: '06:00', endTime: '14:00' });
    expect((await assign(h.rm.headers, d.id, h.d3.id)).status).toBe(404);
    expect((await assign(h.om.headers, d.id, h.d3.id)).status).toBe(201);
  });

  it('refuses overlapping duties and warns on rest rules; BLOCK from Settings refuses', async () => {
    const morning = await duty(h.rm.headers, { startTime: '06:00', endTime: '14:00' });
    const overlap = await duty(h.rm.headers, { startTime: '13:00', endTime: '15:00' });
    const evening = await duty(h.rm.headers, { startTime: '18:00', endTime: '22:00' });
    expect((await assign(h.rm.headers, morning.id, h.d1.id)).status).toBe(201);
    expect((await assign(h.rm.headers, overlap.id, h.d1.id)).body.error.code).toBe('EMPLOYEE_DOUBLE_BOOKED');
    const warned = await assign(h.rm.headers, evening.id, h.d1.id);
    expect(warned.body.warnings.map((w: { code: string }) => w.code).sort()).toEqual(['DUTY_HOURS_EXCEEDED', 'MIN_REST_VIOLATED']);

    expect((await request(app).put(`${api}/settings/roster.enforcement`).set(h.om.headers).send({ value: {} })).status).toBe(403);
    expect((await request(app).put(`${api}/settings/roster.enforcement`).set(h.hr.headers).send({ value: { dutyHourCap: 'WARN', minRest: 'BLOCK', weeklyOff: 'WARN' } })).status).toBe(200);
    expect((await assign(h.rm.headers, evening.id, h.d2.id)).status).toBe(201);
    const late = await duty(h.rm.headers, { startTime: '15:00', endTime: '16:00' });
    expect((await assign(h.rm.headers, late.id, h.d2.id)).body.error.code).toBe('ROSTER_RULE_VIOLATION');
  });

  it('loadmen may fill a helper role (roleCategories setting)', async () => {
    const d = await duty(h.rm.headers, { startTime: '06:00', endTime: '14:00' });
    expect((await assign(h.rm.headers, d.id, h.l1.id, 'DRIVER')).body.error.code).toBe('ROLE_NOT_ALLOWED');
    expect((await assign(h.rm.headers, d.id, h.l1.id, 'HELPER')).status).toBe(201);
  });

  it('copies a day with crew', async () => {
    const a = await duty(h.rm.headers, { startTime: '06:00', endTime: '14:00' });
    await assign(h.rm.headers, a.id, h.d1.id);
    const to = addDays(date, 1);
    const res = await request(app).post(`${api}/roster/copy`).set(h.rm.headers).send({ depotId: org.pune.id, fromDate: date, toDate: to });
    expect(res.body).toMatchObject({ createdDuties: 1, copiedAssignments: 1 });
    expect(await prisma.duty.count()).toBe(2);
  });
});
