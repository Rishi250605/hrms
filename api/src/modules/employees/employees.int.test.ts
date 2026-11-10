import request from 'supertest';
import { beforeEach, describe, expect, it } from 'vitest';
import { createApp } from '../../app.js';
import { addDays, todayIst, toDbDate } from '../../lib/dates.js';
import { prisma } from '../../lib/prisma.js';
import { createHierarchy, createOrgFixture, createStaff, resetDb, seedDriverRequirements, validDriverDocs } from '../../../test/helpers.js';
import type { Headers, Hierarchy, Org } from '../../../test/helpers.js';
import { getJobAsOf } from './service.js';

const app = createApp();
const api = '/api/v1';
let org: Org;
let h: Hierarchy;

beforeEach(async () => {
  await resetDb();
  org = await createOrgFixture();
  await seedDriverRequirements();
  h = await createHierarchy(org);
});

describe('onboarding of drivers / loadmen (HR)', () => {
  const body = (o: Record<string, unknown> = {}) => ({
    empCode: 'nls200',
    fullName: 'New Driver',
    phone: '98765 43210',
    joiningDate: '2026-01-01',
    category: 'DRIVER',
    employmentType: 'PERMANENT',
    businessUnitId: org.nls.id,
    pan: 'ABCDE1234F',
    aadhaarLast4: '9876',
    bankAccount: '123456789012',
    ifsc: 'SBIN0001234',
    job: { depotId: org.pune.id, designation: 'Driver', reportingToEmployeeId: h.rm.employeeId },
    ...o,
  });

  it('creates the employee with one BU, an open job row reporting to the RM, encrypted secrets', async () => {
    const res = await request(app).post(`${api}/employees`).set(h.hr.headers).send(body());
    expect(res.status).toBe(201);
    expect(res.body).toMatchObject({ empCode: 'NLS200', phone: '+919876543210', panMasked: 'XXXXXX234F', role: null, hasLogin: false, businessUnit: { code: 'NLS' } });
    expect(res.body.currentJob).toMatchObject({ effectiveFrom: '2026-01-01', effectiveTo: null, depot: { code: 'PUN' }, reportingTo: { employeeId: h.rm.employeeId } });
    const row = await prisma.employee.findUniqueOrThrow({ where: { id: res.body.id } });
    expect(row.panEncrypted).not.toContain('ABCDE');
    // The RM now sees them.
    expect((await request(app).get(`${api}/employees/${res.body.id}`).set(h.rm.headers)).status).toBe(200);
  });

  it('refuses RMs/OMs, other BUs, wrong reporting lines and depots of another BU', async () => {
    expect((await request(app).post(`${api}/employees`).set(h.rm.headers).send(body())).status).toBe(403);
    expect((await request(app).post(`${api}/employees`).set(h.hr.headers).send(body({ businessUnitId: org.mod.id }))).status).toBe(403);
    const toOm = await request(app).post(`${api}/employees`).set(h.hr.headers).send(body({ job: { depotId: org.pune.id, designation: 'Driver', reportingToEmployeeId: h.om.employeeId } }));
    expect(toOm.body.error.code).toBe('INVALID_REPORTING_LINE');
    const otherDepot = await request(app).post(`${api}/employees`).set(h.hr.headers).send(body({ job: { depotId: org.mumbai.id, designation: 'Driver', reportingToEmployeeId: h.rm.employeeId } }));
    expect(otherDepot.status).toBe(400);
  });

  it('bank details are HR / director only, masked, and each read is audited', async () => {
    const id = (await request(app).post(`${api}/employees`).set(h.hr.headers).send(body())).body.id as string;
    expect((await request(app).get(`${api}/employees/${id}/bank-details`).set(h.rm.headers)).status).toBe(403);
    expect((await request(app).get(`${api}/employees/${id}/bank-details`).set(h.hr.headers)).body).toEqual({ accountMasked: 'XXXXXXXX9012', ifsc: 'SBIN0001234' });
    expect(await prisma.auditLog.count({ where: { action: 'employee.bankDetails.read', entityId: id } })).toBe(1);
    expect((await request(app).get(`${api}/employees/${id}`).set(h.rm.headers)).body.hasBankDetails).toBe(false);
  });
});

describe('effective-dated job history', () => {
  it('a transfer to another RM / depot closes the open row and opens a new one', async () => {
    const effective = addDays(todayIst(), 10);
    const res = await request(app).post(`${api}/employees/${h.d1.id}/job-changes`).set(h.hr.headers).send({ effectiveFrom: effective, reportingToEmployeeId: h.rm2.employeeId, reason: 'Team change' });
    expect(res.status).toBe(201);
    expect(res.body.jobs[1]).toMatchObject({ effectiveTo: effective });
    expect((await getJobAsOf(h.d1.id, todayIst()))?.reportingToEmployeeId).toBe(h.rm.employeeId);
    expect((await getJobAsOf(h.d1.id, effective))?.reportingToEmployeeId).toBe(h.rm2.employeeId);
  });

  it('moving a driver to a depot of another BU moves their business unit too', async () => {
    const res = await request(app)
      .post(`${api}/employees/${h.d1.id}/job-changes`)
      .set(h.hr.headers)
      .send({ effectiveFrom: addDays(todayIst(), 1), depotId: org.mumbai.id, reportingToEmployeeId: h.rmBms.employeeId, reason: 'Transfer' });
    expect(res.status).toBe(201);
    expect(res.body.businessUnits.map((b: { code: string }) => b.code)).toEqual(['BMS']);
  });

  it('the database refuses overlapping job rows (exclusion constraint)', async () => {
    await expect(
      prisma.employeeJob.create({ data: { employeeId: h.d1.id, depotId: org.pune.id, designation: 'X', effectiveFrom: toDbDate('2025-03-01'), effectiveTo: toDbDate('2025-04-01') } }),
    ).rejects.toThrow();
    await expect(
      prisma.employeeJob.create({ data: { employeeId: h.d1.id, depotId: org.pune.id, designation: 'X', effectiveFrom: toDbDate('2024-01-02'), effectiveTo: toDbDate('2024-01-01') } }),
    ).rejects.toThrow();
  });

  it('an exit closes the job row; an exited manager can no longer sign in', async () => {
    const res = await request(app).post(`${api}/employees/${h.rm2.employeeId}/exit`).set(h.director.headers).send({ exitDate: '2025-12-31', reason: 'Resigned' });
    expect(res.status).toBe(200);
    expect(res.body.status).toBe('EXITED');
    expect((await prisma.user.findUniqueOrThrow({ where: { id: h.rm2.user.id } })).isActive).toBe(false);
    expect((await request(app).get(`${api}/me`).set(h.rm2.headers)).status).toBe(401);
  });
});

describe('documents', () => {
  async function upload(headers: Headers, employeeId: string) {
    const presign = await request(app).post(`${api}/uploads/presign`).set(headers).send({ employeeId, purpose: 'DOCUMENT', contentType: 'image/jpeg', sizeBytes: 3 });
    expect(presign.status).toBe(200);
    const url = new URL(presign.body.url as string);
    expect((await request(app).put(url.pathname + url.search).set('Content-Type', 'image/jpeg').send(Buffer.from([1, 2, 3]))).status).toBe(200);
    return presign.body.key as string;
  }

  it('RM captures → HR verifies → rosterable; other RMs cannot reach the file', async () => {
    const e = await createStaff({ businessUnitId: org.nls.id, depotId: org.pune.id, reportsTo: h.rm.employeeId, docs: validDriverDocs().slice(0, 2) });
    const key = await upload(h.rm.headers, e.id);
    const doc = await request(app).post(`${api}/employees/${e.id}/documents`).set(h.rm.headers).send({ type: 'MEDICAL_FITNESS', number: 'MED-1', expiryDate: '2099-01-01', fileKey: key });
    expect(doc.status).toBe(201);
    expect((await request(app).post(`${api}/documents/${doc.body.id}/verify`).set(h.rm.headers).send({})).status).toBe(403);
    expect((await request(app).post(`${api}/documents/${doc.body.id}/verify`).set(h.hr.headers).send({})).body.status).toBe('VERIFIED');
    expect((await request(app).get(`${api}/employees/${e.id}`).set(h.rm.headers)).body.compliance).toMatchObject({ overall: 'OK', rosterable: true });
    expect((await request(app).get(`${api}/documents/${doc.body.id}/file-url`).set(h.rm2.headers)).status).toBe(404);
    expect((await request(app).post(`${api}/uploads/presign`).set(h.rm2.headers).send({ employeeId: e.id, purpose: 'DOCUMENT', contentType: 'image/jpeg', sizeBytes: 3 })).status).toBe(404);
  });

  it('the HR verification queue is limited to HR’s business units', async () => {
    for (const e of [h.d1, h.d5]) {
      await prisma.document.create({ data: { employeeId: e.id, type: 'PSV_BADGE', number: 'X1', status: 'PENDING_VERIFICATION' } });
    }
    expect((await request(app).get(`${api}/documents?status=PENDING_VERIFICATION`).set(h.hr.headers)).body.items).toHaveLength(1);
    expect((await request(app).get(`${api}/documents?status=PENDING_VERIFICATION`).set(h.hrMod.headers)).body.items).toHaveLength(1);
    expect((await request(app).get(`${api}/documents?status=PENDING_VERIFICATION`).set(h.director.headers)).body.items).toHaveLength(2);
  });

  it('keeps only the last 4 Aadhaar digits and masks PAN', async () => {
    const a = await request(app).post(`${api}/employees/${h.d1.id}/documents`).set(h.hr.headers).send({ type: 'AADHAAR', number: '1234 5678 9012', fileKey: await upload(h.hr.headers, h.d1.id) });
    expect(a.body.number).toBe('9012');
    const p = await request(app).post(`${api}/employees/${h.d1.id}/documents`).set(h.hr.headers).send({ type: 'PAN', number: 'abcde1234f', fileKey: await upload(h.hr.headers, h.d1.id) });
    expect(p.body.number).toBe('XXXXXX234F');
  });
});
