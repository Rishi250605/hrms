import request from 'supertest';
import { beforeEach, describe, expect, it } from 'vitest';
import { createApp } from '../../app.js';
import { todayIst } from '../../lib/dates.js';
import { prisma } from '../../lib/prisma.js';
import { getStorageService } from '../../lib/storage.js';
import { createHierarchy, createOrgFixture, resetDb } from '../../../test/helpers.js';
import type { Headers, Hierarchy, Login, Org } from '../../../test/helpers.js';

const app = createApp();
const api = '/api/v1';
let org: Org;
let h: Hierarchy;
let batta: { id: string };
let food: { id: string };
const today = todayIst();

beforeEach(async () => {
  await resetDb();
  org = await createOrgFixture();
  h = await createHierarchy(org);
  batta = await prisma.allowanceType.create({ data: { code: 'BATTA', name: 'Batta' } });
  food = await prisma.allowanceType.create({ data: { code: 'FOOD', name: 'Food', maxAmountPaise: 50_000 } });
});

const raise = (headers: Headers, body: Record<string, unknown>) =>
  request(app)
    .post(`${api}/allowances`)
    .set(headers)
    .send({ allowanceTypeId: batta.id, amountPaise: 30_000, fromDate: today, comment: 'Night run to Nashik', ...body });
const list = async (who: Login, scope: string, extra = '') => {
  const res = await request(app).get(`${api}/allowances?scope=${scope}${extra}`).set(who.headers);
  return res;
};
const ids = (res: request.Response) => (res.body.items as { id: string }[]).map((i) => i.id).sort();
const notes = (userId: string, type: string) => prisma.notification.count({ where: { recipientUserId: userId, type } });

/** Uploads a voice note as `who` the way the app does: presign, then PUT to the signed URL. */
async function uploadVoiceNote(who: Login) {
  const presign = await request(app).post(`${api}/uploads/presign`).set(who.headers).send({ purpose: 'VOICE_NOTE', contentType: 'audio/mp4', sizeBytes: 1000 });
  expect(presign.status).toBe(200);
  await getStorageService().putObject(presign.body.key, Buffer.from('fake-m4a'), 'audio/mp4');
  return presign.body.key as string;
}

describe('raising (§6.1, §6.2)', () => {
  it('RM raises for two drivers: one request each in one batch, routed to their OM; OM and HR notified', async () => {
    const res = await raise(h.rm.headers, { beneficiaryEmployeeIds: [h.d1.id, h.l1.id] });
    expect(res.status).toBe(201);
    expect(res.body.items).toHaveLength(2);
    const [a, b] = res.body.items;
    expect(a.batchId).toBe(b.batchId);
    expect(a).toMatchObject({ status: 'PENDING', requestedAmountPaise: 30_000, approver: { employeeId: h.om.employeeId }, raisedBy: { employeeId: h.rm.employeeId }, businessUnit: { code: 'NLS' } });
    expect(await notes(h.om.user.id, 'ALLOWANCE_SUBMITTED')).toBe(1);
    expect(await notes(h.hr.user.id, 'ALLOWANCE_SUBMITTED')).toBe(1);
    expect(await notes(h.hrMod.user.id, 'ALLOWANCE_SUBMITTED')).toBe(0);
  });

  it('RM for themself → their OM; OM for themself → their HR (HR not double-notified)', async () => {
    const rm = await raise(h.rm.headers, {});
    expect(rm.body.items[0]).toMatchObject({ beneficiary: { employeeId: h.rm.employeeId }, approver: { employeeId: h.om.employeeId } });
    const om = await raise(h.om.headers, {});
    expect(om.body.items[0]).toMatchObject({ beneficiary: { employeeId: h.om.employeeId }, approver: { employeeId: h.hr.employeeId } });
    expect(await notes(h.hr.user.id, 'ALLOWANCE_SUBMITTED')).toBe(2);
  });

  it('RM cannot raise for another RM’s driver or for a peer; OM cannot raise for drivers; HR and director cannot raise', async () => {
    expect((await raise(h.rm.headers, { beneficiaryEmployeeIds: [h.d3.id] })).status).toBe(403);
    expect((await raise(h.rm.headers, { beneficiaryEmployeeIds: [h.rm2.employeeId] })).status).toBe(403);
    expect((await raise(h.om.headers, { beneficiaryEmployeeIds: [h.d1.id] })).status).toBe(403);
    expect((await raise(h.hr.headers, {})).status).toBe(403);
    expect((await raise(h.director.headers, {})).status).toBe(403);
    expect(await prisma.allowanceRequest.count()).toBe(0);
  });

  it('needs a comment or a voice note, and respects the per-type limit', async () => {
    expect((await raise(h.rm.headers, { comment: undefined })).status).toBe(400);
    const over = await raise(h.rm.headers, { allowanceTypeId: food.id, amountPaise: 60_000 });
    expect(over.status).toBe(422);
    expect(over.body.error.code).toBe('AMOUNT_ABOVE_LIMIT');
    expect((await raise(h.rm.headers, { amountPaise: 0 })).status).toBe(400);
  });

  it('accepts a voice note instead of a comment; only the uploader’s own, actually uploaded file', async () => {
    const key = await uploadVoiceNote(h.rm);
    const ok = await raise(h.rm.headers, { comment: undefined, voiceNoteKey: key });
    expect(ok.status).toBe(201);
    expect(ok.body.items[0].hasVoiceNote).toBe(true);
    // Someone else's key.
    const other = await uploadVoiceNote(h.rm2);
    expect((await raise(h.rm.headers, { comment: undefined, voiceNoteKey: other })).status).toBe(400);
    // Presigned but never uploaded.
    const presign = await request(app).post(`${api}/uploads/presign`).set(h.rm.headers).send({ purpose: 'VOICE_NOTE', contentType: 'audio/mp4', sizeBytes: 1000 });
    const missing = await raise(h.rm.headers, { comment: undefined, voiceNoteKey: presign.body.key });
    expect(missing.status).toBe(422);
    expect(missing.body.error.code).toBe('FILE_NOT_UPLOADED');
  });

  it('voice note playback: the approver and HR get signed URLs, other RMs and other BUs do not', async () => {
    const key = await uploadVoiceNote(h.rm);
    const id = (await raise(h.rm.headers, { voiceNoteKey: key })).body.items[0].id;
    for (const who of [h.rm, h.om, h.hr, h.director]) {
      const res = await request(app).get(`${api}/allowances/${id}/files`).set(who.headers);
      expect(res.status, who.empCode).toBe(200);
      expect(res.body.voiceNote.url).toContain('voice-note');
      expect(res.body.receipt).toBeNull();
    }
    for (const who of [h.rm2, h.hrMod, h.omMod]) expect((await request(app).get(`${api}/allowances/${id}/files`).set(who.headers)).status, who.empCode).toBe(404);
    expect(await prisma.auditLog.count({ where: { action: 'allowance.files.read', entityId: id } })).toBe(4);
  });
});

describe('decisions (§6.2)', () => {
  it('OM approves a different amount only with a comment; both amounts kept; RM and HR notified', async () => {
    const id = (await raise(h.rm.headers, { beneficiaryEmployeeIds: [h.d1.id] })).body.items[0].id;
    expect((await request(app).post(`${api}/allowances/${id}/approve`).set(h.om.headers).send({ approvedAmountPaise: 20_000 })).status).toBe(400);
    const res = await request(app).post(`${api}/allowances/${id}/approve`).set(h.om.headers).send({ approvedAmountPaise: 20_000, comment: 'Only one night' });
    expect(res.status).toBe(200);
    expect(res.body).toMatchObject({ status: 'APPROVED', requestedAmountPaise: 30_000, approvedAmountPaise: 20_000, decisionComment: 'Only one night', canDecide: false });
    expect(await notes(h.rm.user.id, 'ALLOWANCE_APPROVED')).toBe(1);
    expect(await notes(h.hr.user.id, 'ALLOWANCE_APPROVED')).toBe(1);
    expect((await request(app).post(`${api}/allowances/${id}/reject`).set(h.om.headers).send({ reason: 'Too late' })).status).toBe(409);
  });

  it('HR decides OM requests (OM notified, no HR copy); reject needs a reason', async () => {
    const id = (await raise(h.om.headers, {})).body.items[0].id;
    expect((await request(app).post(`${api}/allowances/${id}/reject`).set(h.hr.headers).send({})).status).toBe(400);
    const res = await request(app).post(`${api}/allowances/${id}/reject`).set(h.hr.headers).send({ reason: 'No receipt' });
    expect(res.body).toMatchObject({ status: 'REJECTED', rejectionReason: 'No receipt' });
    expect(await notes(h.om.user.id, 'ALLOWANCE_REJECTED')).toBe(1);
    expect(await prisma.notification.count({ where: { type: 'ALLOWANCE_REJECTED' } })).toBe(1);
  });

  it('only the routed approver decides: not the raiser, another OM, or HR for an RM request', async () => {
    const id = (await raise(h.rm.headers, {})).body.items[0].id;
    expect((await request(app).post(`${api}/allowances/${id}/approve`).set(h.rm.headers).send({})).status).toBe(403);
    expect((await request(app).post(`${api}/allowances/${id}/approve`).set(h.omMod.headers).send({})).status).toBe(404);
    expect((await request(app).post(`${api}/allowances/${id}/approve`).set(h.hr.headers).send({})).status).toBe(404);
    expect((await request(app).post(`${api}/allowances/${id}/approve`).set(h.om.headers).send({})).body.approvedAmountPaise).toBe(30_000);
  });

  it('OM approves a whole batch at once', async () => {
    const res = await raise(h.rm.headers, { beneficiaryEmployeeIds: [h.d1.id, h.d2.id, h.l1.id] });
    const batchId = res.body.items[0].batchId;
    expect((await request(app).post(`${api}/allowances/batch/${batchId}/approve`).set(h.omMod.headers)).status).toBe(404);
    const ok = await request(app).post(`${api}/allowances/batch/${batchId}/approve`).set(h.om.headers);
    expect(ok.status).toBe(200);
    expect(ok.body.approved).toHaveLength(3);
    expect(await prisma.allowanceRequest.count({ where: { batchId, status: 'APPROVED' } })).toBe(3);
    expect(await notes(h.rm.user.id, 'ALLOWANCE_APPROVED')).toBe(1);
  });
});

describe('visibility (§11 Allowances: RM self + team; OM self + their RMs; HR / director all in BUs)', () => {
  let rmTeam: string;
  let rmSelf: string;
  let rm2Self: string;
  let rmBmsSelf: string;
  let omSelf: string;
  let rmModSelf: string;
  beforeEach(async () => {
    rmTeam = (await raise(h.rm.headers, { beneficiaryEmployeeIds: [h.d1.id] })).body.items[0].id;
    rmSelf = (await raise(h.rm.headers, {})).body.items[0].id;
    rm2Self = (await raise(h.rm2.headers, {})).body.items[0].id;
    rmBmsSelf = (await raise(h.rmBms.headers, {})).body.items[0].id;
    omSelf = (await raise(h.om.headers, {})).body.items[0].id;
    rmModSelf = (await raise(h.rmMod.headers, {})).body.items[0].id;
  });

  it('RM: mine = self + raised by me; team = own team only', async () => {
    expect(ids(await list(h.rm, 'mine'))).toEqual([rmTeam, rmSelf].sort());
    expect(ids(await list(h.rm, 'team'))).toEqual([rmTeam]);
    expect(ids(await list(h.rm2, 'team'))).toEqual([]);
    expect((await list(h.rm, 'all')).status).toBe(403);
  });

  it('OM: team = their RMs’ requests across shared BUs; approvals = waiting for them', async () => {
    expect(ids(await list(h.om, 'team'))).toEqual([rmTeam, rmSelf, rm2Self, rmBmsSelf].sort());
    expect(ids(await list(h.om, 'team', `&businessUnitId=${org.bms.id}`))).toEqual([rmBmsSelf]);
    expect(ids(await list(h.om, 'approvals'))).toEqual([rmTeam, rmSelf, rm2Self, rmBmsSelf].sort());
    expect(ids(await list(h.omMod, 'team'))).toEqual([rmModSelf]);
    expect((await list(h.om, 'team', `&businessUnitId=${org.mod.id}`)).status).toBe(403);
  });

  it('HR sees everything in their BUs and approves OM requests; the director sees all', async () => {
    expect(ids(await list(h.hr, 'all'))).toEqual([rmTeam, rmSelf, rm2Self, rmBmsSelf, omSelf].sort());
    expect(ids(await list(h.hr, 'approvals'))).toEqual([omSelf]);
    expect(ids(await list(h.hrMod, 'all'))).toEqual([rmModSelf]);
    expect(ids(await list(h.director, 'all'))).toEqual([rmTeam, rmSelf, rm2Self, rmBmsSelf, omSelf, rmModSelf].sort());
  });

  it('monthly totals per BU for HR, requested vs approved', async () => {
    await request(app).post(`${api}/allowances/${rmSelf}/approve`).set(h.om.headers).send({ approvedAmountPaise: 10_000, comment: 'Partial' });
    const res = await request(app).get(`${api}/allowances/summary?month=${today.slice(0, 7)}`).set(h.hr.headers);
    expect(res.status).toBe(200);
    const nls = res.body.items.find((i: { businessUnit: { code: string } }) => i.businessUnit.code === 'NLS');
    expect(nls).toMatchObject({ requests: 4, pending: 3, requestedPaise: 120_000, approvedPaise: 10_000 });
    expect(res.body.items.map((i: { businessUnit: { code: string } }) => i.businessUnit.code)).toEqual(['BMS', 'NLS']);
    expect((await request(app).get(`${api}/allowances/summary?month=${today.slice(0, 7)}`).set(h.om.headers)).status).toBe(403);
  });
});

describe('allowance types', () => {
  it('HR and the director manage types; managers only read them', async () => {
    const created = await request(app).post(`${api}/allowance-types`).set(h.hr.headers).send({ code: 'toll', name: 'Toll', maxAmountPaise: 100_000 });
    expect(created.status).toBe(201);
    expect(created.body.code).toBe('TOLL');
    expect((await request(app).post(`${api}/allowance-types`).set(h.om.headers).send({ code: 'X1', name: 'Xx' })).status).toBe(403);
    expect((await request(app).patch(`${api}/allowance-types/${created.body.id}`).set(h.director.headers).send({ isActive: false })).body.isActive).toBe(false);
    expect((await raise(h.rm.headers, { allowanceTypeId: created.body.id })).status).toBe(404);
    expect((await request(app).get(`${api}/allowance-types`).set(h.rm.headers)).body.items).toHaveLength(3);
  });
});
