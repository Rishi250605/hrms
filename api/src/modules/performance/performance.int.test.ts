import request from 'supertest';
import { beforeEach, describe, expect, it } from 'vitest';
import { createApp } from '../../app.js';
import { addDays, todayIst } from '../../lib/dates.js';
import { prisma } from '../../lib/prisma.js';
import { createHierarchy, createOrgFixture, resetDb } from '../../../test/helpers.js';
import type { Hierarchy, Login, Org } from '../../../test/helpers.js';
import { weekStartOf } from './service.js';

const app = createApp();
const api = '/api/v1';
let org: Org;
let h: Hierarchy;
let metrics: Record<string, string>;
const thisWeek = weekStartOf(todayIst());

beforeEach(async () => {
  await resetDb();
  org = await createOrgFixture();
  h = await createHierarchy(org);
  metrics = {};
  for (const [code, name, unit] of [
    ['MILEAGE', 'Mileage', 'km/l'],
    ['EMPLOYEE_COUNT', 'Employee count', 'count'],
    ['MAINTENANCE', 'Maintenance', null],
  ] as const) {
    const res = await request(app)
      .post(`${api}/performance-metrics`)
      .set(h.director.headers)
      .send({ code, name, ...(unit ? { unit } : {}) });
    expect(res.status).toBe(201);
    metrics[code] = res.body.id;
  }
});

const rate = (who: Login, subject: Login, body: object) => request(app).post(`${api}/performance/employees/${subject.employeeId}/ratings`).set(who.headers).send(body);
const summary = (who: Login, subject: Login) => request(app).get(`${api}/performance/employees/${subject.employeeId}`).set(who.headers);
const putWeek = (who: Login, subject: Login, week: string, values: object[]) =>
  request(app).put(`${api}/performance/employees/${subject.employeeId}/weeks/${week}`).set(who.headers).send({ values });
const notes = (u: Login, type: string) => prisma.notification.count({ where: { recipientUserId: u.user.id, type } });

describe('ratings', () => {
  it('director and HR rate; every rating is kept; latest first; the person is notified and sees it', async () => {
    expect((await rate(h.director, h.om, { rating: 3, comment: 'Average quarter' })).status).toBe(201);
    const res = await rate(h.hr, h.om, { rating: 5, comment: 'Great turnaround' });
    expect(res.status).toBe(201);
    expect(res.body).toMatchObject({ rating: 5, comment: 'Great turnaround', ratedBy: { employeeId: h.hr.employeeId } });
    expect(await notes(h.om, 'PERFORMANCE_RATED')).toBe(2);

    const mine = await summary(h.om, h.om);
    expect(mine.status).toBe(200);
    expect(mine.body).toMatchObject({ latestRating: { rating: 5 }, canRate: false, canEnterMetrics: false, businessUnit: { code: 'NLS' } });
    expect(mine.body.ratings.map((r: { rating: number }) => r.rating)).toEqual([5, 3]);
    expect(await prisma.auditLog.count({ where: { action: 'performanceRating.create' } })).toBe(2);
  });

  it('who may rate whom', async () => {
    expect((await rate(h.hr, h.rm, { rating: 4 })).status).toBe(201);
    expect((await rate(h.director, h.hr, { rating: 4 })).status).toBe(201);
    expect((await rate(h.hr, h.hr, { rating: 5 })).status).toBe(403); // self
    expect((await rate(h.hrMod, h.hr, { rating: 2 })).status).toBe(404); // HR of another BU cannot see them
    expect((await rate(h.hr, h.rmMod, { rating: 2 })).status).toBe(404); // outside HR's BUs
    expect((await rate(h.om, h.rm, { rating: 4 })).status).toBe(403); // role
    expect((await rate(h.rm, h.rm2, { rating: 4 })).status).toBe(403);
    expect((await rate(h.hr, h.rm, { rating: 6 })).status).toBe(400);
    expect((await rate(h.hr, h.rm, { rating: 0 })).status).toBe(400);
    // Drivers / loadmen and the director are not rated.
    expect((await request(app).post(`${api}/performance/employees/${h.d1.id}/ratings`).set(h.director.headers).send({ rating: 3 })).status).toBe(404);
    expect((await rate(h.hr, h.director, { rating: 3 })).status).toBe(404);
  });
});

describe('weekly values', () => {
  it('director enters, edits and clears values; the person sees them and is notified; audited', async () => {
    const lastWeek = addDays(thisWeek, -7);
    let res = await putWeek(h.director, h.rm, lastWeek, [
      { metricId: metrics.MILEAGE, value: 4.25 },
      { metricId: metrics.EMPLOYEE_COUNT, value: 12 },
    ]);
    expect(res.status).toBe(200);
    expect((await putWeek(h.director, h.rm, thisWeek, [{ metricId: metrics.MAINTENANCE, value: 1500 }])).status).toBe(200);
    res = await putWeek(h.director, h.rm, lastWeek, [
      { metricId: metrics.MILEAGE, value: 4.5 },
      { metricId: metrics.EMPLOYEE_COUNT, value: null },
    ]);
    expect(res.status).toBe(200);

    const mine = await summary(h.rm, h.rm);
    expect(mine.body.weeks.map((w: { weekStart: string }) => w.weekStart)).toEqual([thisWeek, lastWeek]);
    const last = mine.body.weeks[1].values as { code: string; value: number | null; unit: string | null }[];
    expect(last.map((v) => [v.code, v.value])).toEqual([
      ['EMPLOYEE_COUNT', null],
      ['MAINTENANCE', null],
      ['MILEAGE', 4.5],
    ]);
    expect(await notes(h.rm, 'PERFORMANCE_WEEK')).toBe(3);
    const actions = (await prisma.auditLog.findMany({ where: { entityType: 'PerformanceMetricValue' }, select: { action: true } })).map((a) => a.action).sort();
    expect(actions).toEqual([
      'performanceMetricValue.create',
      'performanceMetricValue.create',
      'performanceMetricValue.create',
      'performanceMetricValue.delete',
      'performanceMetricValue.update',
    ]);
  });

  it('only the director; only Mondays; no future weeks; active metrics only', async () => {
    const v = [{ metricId: metrics.MILEAGE, value: 4 }];
    expect((await putWeek(h.hr, h.rm, thisWeek, v)).status).toBe(403);
    expect((await putWeek(h.om, h.rm, thisWeek, v)).status).toBe(403);
    expect((await putWeek(h.director, h.rm, addDays(thisWeek, 1), v)).status).toBe(400);
    expect((await putWeek(h.director, h.rm, addDays(thisWeek, 7), v)).status).toBe(400);
    expect((await putWeek(h.director, h.rm, thisWeek, [{ metricId: metrics.MILEAGE, value: -1 }])).status).toBe(400);
    await request(app).patch(`${api}/performance-metrics/${metrics.MILEAGE}`).set(h.director.headers).send({ isActive: false });
    expect((await putWeek(h.director, h.rm, thisWeek, v)).status).toBe(422);
  });
});

describe('visibility — self · HR in their BUs · director all', () => {
  it('RM and OM see only themselves', async () => {
    expect((await summary(h.rm, h.rm)).status).toBe(200);
    expect((await summary(h.rm, h.rm2)).status).toBe(404);
    expect((await summary(h.om, h.om)).status).toBe(200);
    expect((await summary(h.om, h.rm)).status).toBe(404);
    expect((await request(app).get(`${api}/performance/people`).set(h.om.headers)).status).toBe(403);
  });
  it('HR sees the people of their BUs; the director sees everyone', async () => {
    expect((await summary(h.hr, h.rmBms)).status).toBe(200);
    expect((await summary(h.hr, h.rmMod)).status).toBe(404);
    const names = async (who: Login) =>
      ((await request(app).get(`${api}/performance/people`).set(who.headers)).body.items as { person: { employeeId: string } }[]).map((i) => i.person.employeeId).sort();
    expect(await names(h.hr)).toEqual([h.hr, h.om, h.rm, h.rm2, h.rmBms].map((x) => x.employeeId).sort());
    expect(await names(h.director)).toHaveLength(8);
    expect((await summary(h.director, h.rmMod)).body).toMatchObject({ canRate: true, canEnterMetrics: true });
  });
  it('metrics: anyone reads, only the director writes', async () => {
    expect((await request(app).get(`${api}/performance-metrics`).set(h.rm.headers)).body.items).toHaveLength(3);
    expect((await request(app).post(`${api}/performance-metrics`).set(h.hr.headers).send({ code: 'TRIPS', name: 'Trips' })).status).toBe(403);
    expect((await request(app).post(`${api}/performance-metrics`).set(h.director.headers).send({ code: 'MILEAGE', name: 'Again' })).status).toBe(409);
  });
});
