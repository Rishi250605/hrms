import request from 'supertest';
import { beforeEach, describe, expect, it } from 'vitest';
import { createApp } from '../../app.js';
import { addDays, todayIst } from '../../lib/dates.js';
import { prisma } from '../../lib/prisma.js';
import { createHierarchy, createOrgFixture, resetDb } from '../../../test/helpers.js';
import type { Headers, Hierarchy, Login, Org } from '../../../test/helpers.js';

const app = createApp();
const api = '/api/v1';
let org: Org;
let h: Hierarchy;
const period = todayIst().slice(0, 7);
const pdf = (text = 'payslip') => Buffer.from(`%PDF-1.4\n% ${text}\n%%EOF`);

beforeEach(async () => {
  await resetDb();
  org = await createOrgFixture();
  h = await createHierarchy(org);
});

function upload(headers: Headers, files: [string, Buffer][], p = period) {
  let r = request(app).post(`${api}/payslips/upload?period=${p}`).set(headers);
  for (const [name, body] of files) r = r.attach('files', body, { filename: name, contentType: 'application/pdf' });
  return r;
}
const names = (res: request.Response, key: string) => (res.body[key] as { fileName: string }[]).map((m) => m.fileName).sort();
const listed = async (who: Login, scope: string, extra = '') => {
  const res = await request(app).get(`${api}/payslips?scope=${scope}&period=${period}${extra}`).set(who.headers);
  expect(res.status, `${who.empCode} ${scope}`).toBe(200);
  return (res.body.items as { employee: { employeeId: string } }[]).map((i) => i.employee.employeeId).sort();
};

describe('bulk upload (§7.1)', () => {
  it('matches by employee code, reports unmatched / invalid / duplicates and stores only matches', async () => {
    const res = await upload(h.hr.headers, [
      [`payslip-${h.rm.empCode}.pdf`, pdf()],
      [`PAYSLIP-${h.d1.empCode.toLowerCase()}.PDF`, pdf()],
      [`payslip-${h.d4.empCode}.pdf`, pdf()], // BMS: HR has it
      [`payslip-${h.d5.empCode}.pdf`, pdf()], // MOD: not HR's business unit
      ['payslip-ZZZ999.pdf', pdf()],
      ['salary-NLS001.pdf', pdf()],
      [`payslip-${h.d2.empCode}.pdf`, Buffer.from('not a pdf')],
      [`payslip-${h.l1.empCode}.pdf`, pdf('a')],
      [`payslip-${h.l1.empCode.toLowerCase()}.pdf`, pdf('b')],
    ]);
    expect(res.status).toBe(200);
    expect(res.body.matched.map((m: { employee: { employeeId: string } }) => m.employee.employeeId).sort()).toEqual([h.rm.employeeId, h.d1.id, h.d4.id].sort());
    expect(res.body.unmatched.sort()).toEqual([`payslip-${h.d5.empCode}.pdf`, 'payslip-ZZZ999.pdf'].sort());
    expect(res.body.invalid).toEqual(
      expect.arrayContaining([
        { fileName: 'salary-NLS001.pdf', reason: 'NAME_FORMAT' },
        { fileName: `payslip-${h.d2.empCode}.pdf`, reason: 'NOT_PDF' },
      ]),
    );
    expect(res.body.duplicates).toHaveLength(2);
    expect(res.body.replaced).toEqual([]);
    const rows = await prisma.payslip.findMany({ include: { employee: true } });
    expect(rows).toHaveLength(3);
    const d4 = rows.find((r) => r.employeeId === h.d4.id)!;
    expect(d4.businessUnitId).toBe(org.bms.id);
    expect(d4.fileKey).toBe(`payslips/${period}/${h.d4.empCode.toLowerCase()}-v1.pdf`);
  });

  it('a re-upload is a new version; old versions only for HR / director', async () => {
    await upload(h.hr.headers, [[`payslip-${h.d1.empCode}.pdf`, pdf('one')]]);
    const again = await upload(h.hr.headers, [[`payslip-${h.d1.empCode}.pdf`, pdf('two')]]);
    expect(names(again, 'replaced')).toEqual([`payslip-${h.d1.empCode}.pdf`]);
    expect(again.body.matched[0].version).toBe(2);
    const id = again.body.matched[0].payslipId;
    const versions = await request(app).get(`${api}/payslips/${id}/versions`).set(h.hr.headers);
    expect(versions.body.items.map((v: { version: number }) => v.version)).toEqual([2, 1]);
    expect((await request(app).get(`${api}/payslips/${id}/versions`).set(h.rm.headers)).status).toBe(403);
    expect((await request(app).get(`${api}/payslips/${id}/download?version=1`).set(h.rm.headers)).status).toBe(403);
    const old = await request(app).get(`${api}/payslips/${id}/download?version=1`).set(h.hr.headers);
    expect(old.status).toBe(200);
    expect(old.body.url).toContain('-v1.pdf');
    const latest = await request(app).get(`${api}/payslips/${id}/download`).set(h.rm.headers);
    expect(latest.body.url).toContain('-v2.pdf');
    // The signed URL serves the file.
    const file = await request(app)
      .get(new URL(latest.body.url).pathname + new URL(latest.body.url).search)
      .responseType('blob');
    expect(file.status).toBe(200);
    expect(file.body.toString()).toContain('two');
    expect(await prisma.auditLog.count({ where: { action: 'payslip.download', entityId: id } })).toBe(2);
  });

  it('only HR uploads; size, period and request limits are enforced', async () => {
    expect((await upload(h.director.headers, [[`payslip-${h.d1.empCode}.pdf`, pdf()]])).status).toBe(403);
    expect((await upload(h.om.headers, [[`payslip-${h.d1.empCode}.pdf`, pdf()]])).status).toBe(403);
    expect((await upload(h.hr.headers, [[`payslip-${h.d1.empCode}.pdf`, pdf()]], addDays(todayIst(), 40).slice(0, 7))).status).toBe(400);
    expect((await upload(h.hr.headers, [[`payslip-${h.d1.empCode}.pdf`, pdf()]], '2026-13')).status).toBe(400);
    expect((await request(app).post(`${api}/payslips/upload?period=${period}`).set(h.hr.headers)).status).toBe(400);
    await prisma.setting.create({ data: { key: 'payslips.maxFileBytes', value: 10_000 } });
    const big = Buffer.concat([pdf(), Buffer.alloc(20_000, 32)]);
    expect((await upload(h.hr.headers, [[`payslip-${h.d1.empCode}.pdf`, big]])).body.invalid).toEqual([{ fileName: `payslip-${h.d1.empCode}.pdf`, reason: 'TOO_LARGE' }]);
    const huge = Buffer.concat([pdf(), Buffer.alloc(10 * 1024 * 1024 + 1, 32)]);
    const tooBig = await upload(h.hr.headers, [[`payslip-${h.d1.empCode}.pdf`, huge]]);
    expect(tooBig.status).toBe(413);
    expect(tooBig.body.error.code).toBe('FILE_TOO_LARGE');
    expect(await prisma.payslip.count()).toBe(0);
  });

  it('notifies RMs and OMs of the affected business units when enabled', async () => {
    await upload(h.hr.headers, [[`payslip-${h.d1.empCode}.pdf`, pdf()]]);
    const n = (u: Login) => prisma.notification.count({ where: { recipientUserId: u.user.id, type: 'PAYSLIPS_AVAILABLE' } });
    expect([await n(h.rm), await n(h.rm2), await n(h.om), await n(h.rmBms), await n(h.rmMod)]).toEqual([1, 1, 1, 0, 0]);
    await prisma.setting.create({ data: { key: 'payslips.notifyOnUpload', value: false } });
    await upload(h.hr.headers, [[`payslip-${h.d2.empCode}.pdf`, pdf()]]);
    expect(await n(h.rm)).toBe(1);
  });
});

describe('visibility (§7.2 / §11 Payslips)', () => {
  let everyone: Record<string, string>;
  beforeEach(async () => {
    const people = { rm: h.rm, rm2: h.rm2, rmBms: h.rmBms, om: h.om, hr: h.hr };
    const files: [string, Buffer][] = [
      ...Object.values(people).map((p): [string, Buffer] => [`payslip-${p.empCode}.pdf`, pdf()]),
      ...[h.d1, h.d2, h.d3, h.d4].map((d): [string, Buffer] => [`payslip-${d.empCode}.pdf`, pdf()]),
    ];
    const res = await upload(h.hr.headers, files);
    expect(res.body.matched).toHaveLength(9);
    await upload(h.hrMod.headers, [[`payslip-${h.d5.empCode}.pdf`, pdf()], [`payslip-${h.rmMod.empCode}.pdf`, pdf()]]);
    everyone = Object.fromEntries((await prisma.payslip.findMany()).map((p) => [p.employeeId, p.id]));
  });

  it('RM: own + their drivers / loadmen', async () => {
    expect(await listed(h.rm, 'mine')).toEqual([h.rm.employeeId]);
    expect(await listed(h.rm, 'team')).toEqual([h.d1.id, h.d2.id].sort());
    expect(await listed(h.rm2, 'team')).toEqual([h.d3.id]);
    expect((await request(app).get(`${api}/payslips?scope=all`).set(h.rm.headers)).status).toBe(403);
    expect((await request(app).get(`${api}/payslips/${everyone[h.d3.id]}/download`).set(h.rm.headers)).status).toBe(404);
    expect((await request(app).get(`${api}/payslips/${everyone[h.om.employeeId]}/download`).set(h.rm.headers)).status).toBe(404);
  });

  it('OM: own + their RMs only (not the RMs’ drivers)', async () => {
    expect(await listed(h.om, 'mine')).toEqual([h.om.employeeId]);
    expect(await listed(h.om, 'team')).toEqual([h.rm.employeeId, h.rm2.employeeId, h.rmBms.employeeId].sort());
    expect(await listed(h.om, 'team', `&businessUnitId=${org.bms.id}`)).toEqual([h.rmBms.employeeId]);
    expect((await request(app).get(`${api}/payslips/${everyone[h.d1.id]}/download`).set(h.om.headers)).status).toBe(404);
    expect(await listed(h.omMod, 'team')).toEqual([h.rmMod.employeeId]);
  });

  it('HR: everything in their business units incl. their own; director: all', async () => {
    const hrAll = await listed(h.hr, 'all');
    expect(hrAll).toHaveLength(9);
    expect(hrAll).not.toContain(h.d5.id);
    expect(await listed(h.hrMod, 'all')).toEqual([h.d5.id, h.rmMod.employeeId].sort());
    expect(await listed(h.director, 'all')).toHaveLength(11);
    expect((await request(app).get(`${api}/payslips/${everyone[h.d5.id]}/download`).set(h.hr.headers)).status).toBe(404);
    expect((await request(app).get(`${api}/payslips/${everyone[h.d5.id]}/download`).set(h.director.headers)).status).toBe(200);
    const search = await request(app).get(`${api}/payslips?scope=all&q=driver%20one`).set(h.hr.headers);
    expect(search.body.items.map((i: { employee: { employeeId: string } }) => i.employee.employeeId)).toEqual([h.d1.id]);
  });
});
