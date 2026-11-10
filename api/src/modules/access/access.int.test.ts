import request from 'supertest';
import { beforeEach, describe, expect, it } from 'vitest';
import { createApp } from '../../app.js';
import { prisma } from '../../lib/prisma.js';
import { createHierarchy, createOrgFixture, resetDb } from '../../../test/helpers.js';
import type { Hierarchy, Org } from '../../../test/helpers.js';
import { canAccess } from './scope.js';
import { loadAuthUser } from '../../middleware/authenticate.js';

/**
 * Visibility matrix (PHASE-2-FEATURES §11) for employee records and user management, plus the BU rule (§2.3)
 * and the reporting-line rule (§1.2). Feature modules have their own matrix cases.
 */
const app = createApp();
const api = '/api/v1';
let org: Org;
let h: Hierarchy;

beforeEach(async () => {
  await resetDb();
  org = await createOrgFixture();
  h = await createHierarchy(org);
});

const names = (res: request.Response) => (res.body.items as { fullName: string }[]).map((e) => e.fullName).sort();

describe('driver/loadman records (§11 row 1)', () => {
  it('RM: own reports only', async () => {
    const res = await request(app).get(`${api}/employees?staffOnly=true`).set(h.rm.headers);
    expect(names(res)).toEqual(['Driver One', 'Driver Two', 'Loadman One']);
    expect((await request(app).get(`${api}/employees/${h.d3.id}`).set(h.rm.headers)).status).toBe(404);
  });

  it('OM: their RMs and their RMs’ teams; not another OM’s', async () => {
    const res = await request(app).get(`${api}/employees`).set(h.om.headers);
    expect(names(res)).toEqual(['Driver Four', 'Driver One', 'Driver Three', 'Driver Two', 'Loadman One', 'OM NLS', 'RM BMS', 'RM One', 'RM Two'].sort());
    expect((await request(app).get(`${api}/employees/${h.d5.id}`).set(h.om.headers)).status).toBe(404);
  });

  it('HR: everyone in their business units; director: everyone', async () => {
    const hr = await request(app).get(`${api}/employees?staffOnly=true`).set(h.hr.headers);
    expect(names(hr)).toEqual(['Driver Four', 'Driver One', 'Driver Three', 'Driver Two', 'Loadman One']);
    expect((await request(app).get(`${api}/employees/${h.d5.id}`).set(h.hr.headers)).status).toBe(404);
    const dir = await request(app).get(`${api}/employees?staffOnly=true`).set(h.director.headers);
    expect(names(dir)).toHaveLength(6);
  });

  it('a business-unit filter outside my units is refused (403)', async () => {
    const res = await request(app).get(`${api}/employees?businessUnitId=${org.mod.id}`).set(h.hr.headers);
    expect(res.status).toBe(403);
    expect(res.body.error.code).toBe('FORBIDDEN_BUSINESS_UNIT');
    expect(names(await request(app).get(`${api}/employees?staffOnly=true&businessUnitId=${org.bms.id}`).set(h.hr.headers))).toEqual(['Driver Four']);
  });

  it('canAccess combines the BU match and the hierarchy match', async () => {
    const rm = (await loadAuthUser(prisma, h.rm.user.id))!;
    expect(await canAccess(prisma, rm, h.d1.id, org.nls.id, 'attendance')).toBe(true);
    expect(await canAccess(prisma, rm, h.d1.id, org.bms.id, 'attendance')).toBe(false);
    expect(await canAccess(prisma, rm, h.d3.id, org.nls.id, 'attendance')).toBe(false);
    const om = (await loadAuthUser(prisma, h.om.user.id))!;
    expect(await canAccess(prisma, om, h.d1.id, org.nls.id, 'attendance')).toBe(true);
    expect(await canAccess(prisma, om, h.d1.id, org.nls.id, 'payslips')).toBe(false); // OM: their RMs only
    expect(await canAccess(prisma, om, h.rm.employeeId, org.nls.id, 'payslips')).toBe(true);
  });
});

describe('user management (§11 last row)', () => {
  const body = (o: Record<string, unknown> = {}) => ({
    empCode: 'NLS100',
    fullName: 'New RM',
    phone: '98765 43210',
    role: 'REGIONAL_MANAGER',
    businessUnitIds: [org.nls.id],
    reportingToEmployeeId: h.om.employeeId,
    depotId: org.pune.id,
    password: 'Initial-Pass-1',
    ...o,
  });

  it('only the director creates logins', async () => {
    expect((await request(app).post(`${api}/users`).set(h.hr.headers).send(body())).status).toBe(403);
    expect((await request(app).post(`${api}/users`).set(h.om.headers).send(body())).status).toBe(403);
    const res = await request(app).post(`${api}/users`).set(h.director.headers).send(body());
    expect(res.status).toBe(201);
    expect(res.body).toMatchObject({ empCode: 'NLS100', role: 'REGIONAL_MANAGER', hasPassword: true, reportingTo: { employeeId: h.om.employeeId } });
    expect((await request(app).post(`${api}/auth/login`).send({ empCode: 'nls100', password: 'Initial-Pass-1' })).status).toBe(200);
  });

  it('rejects an invalid reporting line (422 INVALID_REPORTING_LINE)', async () => {
    // RM must report to an OM, not to HR.
    const wrongRole = await request(app).post(`${api}/users`).set(h.director.headers).send(body({ reportingToEmployeeId: h.hr.employeeId }));
    expect(wrongRole.status).toBe(422);
    expect(wrongRole.body.error.code).toBe('INVALID_REPORTING_LINE');
    // OM MOD shares no business unit with an NLS-only RM.
    const noSharedBu = await request(app).post(`${api}/users`).set(h.director.headers).send(body({ reportingToEmployeeId: h.omMod.employeeId }));
    expect(noSharedBu.body.error.code).toBe('INVALID_REPORTING_LINE');
  });

  it('employee IDs carry the business-unit prefix and are unique case-insensitively', async () => {
    const wrongPrefix = await request(app).post(`${api}/users`).set(h.director.headers).send(body({ empCode: 'BMS100' }));
    expect(wrongPrefix.body.error.code).toBe('INVALID_EMP_CODE');
    await request(app).post(`${api}/users`).set(h.director.headers).send(body());
    const dup = await request(app).post(`${api}/users`).set(h.director.headers).send(body({ empCode: 'nls100', phone: '98765 43211' }));
    expect(dup.status).toBe(409);
    const next = await request(app).get(`${api}/employees/next-code?businessUnitId=${org.nls.id}`).set(h.hr.headers);
    expect(next.body.empCode).toMatch(/^NLS\d{3}$/);
  });

  it('HR may change driver / loadman records but not managers', async () => {
    expect((await request(app).patch(`${api}/employees/${h.d1.id}`).set(h.hr.headers).send({ fullName: 'Driver Uno' })).status).toBe(200);
    expect((await request(app).patch(`${api}/employees/${h.rm.employeeId}`).set(h.hr.headers).send({ fullName: 'RM Uno' })).status).toBe(403);
    expect((await request(app).patch(`${api}/employees/${h.rm.employeeId}`).set(h.director.headers).send({ fullName: 'RM Uno' })).status).toBe(200);
    expect((await request(app).patch(`${api}/employees/${h.d1.id}`).set(h.rm.headers).send({ fullName: 'x y' })).status).toBe(403);
  });
});

describe('promotion (decision Q1)', () => {
  it('HR promotes an RM to OM with a new reporting line and lists reports to reassign', async () => {
    const res = await request(app)
      .post(`${api}/employees/${h.rm.employeeId}/promotion`)
      .set(h.hr.headers)
      .send({ role: 'OPERATIONAL_MANAGER', reportingToEmployeeId: h.hr.employeeId, effectiveFrom: '2026-01-01', reason: 'Good work' });
    expect(res.status).toBe(200);
    expect(res.body.employee.role).toBe('OPERATIONAL_MANAGER');
    expect(res.body.employee.reportingTo.employeeId).toBe(h.hr.employeeId);
    // Drivers cannot report to an OM.
    expect(res.body.reportsNeedingReassignment.map((p: { employeeId: string }) => p.employeeId).sort()).toEqual([h.d1.id, h.d2.id, h.l1.id].sort());
    expect((await prisma.user.findUniqueOrThrow({ where: { id: h.rm.user.id } })).role).toBe('OPERATIONAL_MANAGER');
  });

  it('only HR / director promote, and the new reporting line is validated', async () => {
    const promo = { role: 'OPERATIONAL_MANAGER', reportingToEmployeeId: h.om.employeeId, effectiveFrom: '2026-01-01', reason: 'x promotion' };
    expect((await request(app).post(`${api}/employees/${h.rm.employeeId}/promotion`).set(h.om.headers).send(promo)).status).toBe(403);
    const bad = await request(app).post(`${api}/employees/${h.rm.employeeId}/promotion`).set(h.hr.headers).send(promo);
    expect(bad.body.error.code).toBe('INVALID_REPORTING_LINE');
    expect((await prisma.user.findUniqueOrThrow({ where: { id: h.rm.user.id } })).role).toBe('REGIONAL_MANAGER');
  });
});

describe('business units and /me', () => {
  it('lists my units; the director sees all and edits them', async () => {
    expect((await request(app).get(`${api}/business-units`).set(h.rm.headers)).body.items.map((b: { code: string }) => b.code)).toEqual(['NLS']);
    expect((await request(app).get(`${api}/business-units`).set(h.director.headers)).body.items).toHaveLength(3);
    expect((await request(app).patch(`${api}/business-units/${org.mod.id}`).set(h.hr.headers).send({ name: 'X' })).status).toBe(403);
    expect((await request(app).patch(`${api}/business-units/${org.mod.id}`).set(h.director.headers).send({ name: 'Modern' })).status).toBe(200);
  });

  it('/me shows reporting-to and business units with the primary marked', async () => {
    const me = await request(app).get(`${api}/me`).set(h.om.headers);
    expect(me.body.reportingTo).toMatchObject({ employeeId: h.hr.employeeId, role: 'HR' });
    expect(me.body.businessUnits.map((b: { code: string; isPrimary: boolean }) => [b.code, b.isPrimary])).toEqual([
      ['BMS', false],
      ['NLS', true],
    ]);
    expect((await request(app).get(`${api}/me`).set(h.director.headers)).body.reportingTo).toBeNull();
  });

  it('depots are limited to my business units', async () => {
    expect((await request(app).get(`${api}/depots`).set(h.rmBms.headers)).body.items.map((d: { code: string }) => d.code)).toEqual(['MUM']);
  });
});
