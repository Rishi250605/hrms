import request from 'supertest';
import { beforeEach, describe, expect, it } from 'vitest';
import { createApp } from '../../app.js';
import { hashPassword } from '../../lib/password.js';
import { prisma } from '../../lib/prisma.js';
import { createLogin, createOrgFixture, resetDb } from '../../../test/helpers.js';
import type { Login, Org } from '../../../test/helpers.js';

const app = createApp();
const api = '/api/v1';
let org: Org;
let director: Login;
let rm: Login;
const PASSWORD = 'Correct-Horse-1';

beforeEach(async () => {
  await resetDb();
  org = await createOrgFixture();
  const hash = await hashPassword(PASSWORD);
  director = await createLogin({ role: 'DIRECTOR', businessUnitIds: [], empCode: 'DIR001', passwordHash: hash });
  rm = await createLogin({ role: 'REGIONAL_MANAGER', businessUnitIds: [org.nls.id], depotId: org.pune.id, reportsTo: director.employeeId, empCode: 'NLS010', passwordHash: hash });
});

const login = (empCode: string, password: string) => request(app).post(`${api}/auth/login`).send({ empCode, password });

describe('employee ID + password login', () => {
  it('signs in case-insensitively and returns a token pair usable for /me', async () => {
    const res = await login('nls010', PASSWORD);
    expect(res.status).toBe(200);
    expect(res.body.tokenType).toBe('Bearer');
    const me = await request(app).get(`${api}/me`).set('Authorization', `Bearer ${res.body.accessToken}`);
    expect(me.status).toBe(200);
    expect(me.body).toMatchObject({ empCode: 'NLS010', role: 'REGIONAL_MANAGER', reportingTo: { empCode: 'DIR001' } });
    expect(me.body.businessUnits).toEqual([{ id: org.nls.id, code: 'NLS', name: 'NLS Enterprises', isPrimary: true }]);
    expect(await prisma.auditLog.count({ where: { action: 'auth.login' } })).toBe(1);
  });

  it('answers the same 401 for unknown IDs, wrong passwords, no password and inactive users', async () => {
    const noPassword = await createLogin({ role: 'HR', businessUnitIds: [org.nls.id], empCode: 'NLS011' });
    const inactive = await createLogin({ role: 'HR', businessUnitIds: [org.nls.id], empCode: 'NLS012', passwordHash: await hashPassword(PASSWORD), isActive: false });
    for (const [code, pw] of [
      ['NOPE999', PASSWORD],
      ['NLS010', 'wrong-password'],
      [noPassword.empCode, PASSWORD],
      [inactive.empCode, PASSWORD],
    ] as const) {
      const res = await login(code, pw);
      expect(res.status).toBe(401);
      expect(res.body.error).toMatchObject({ code: 'INVALID_CREDENTIALS', message: 'Invalid employee ID or password' });
    }
  });

  it('locks the account after 5 failures in 15 minutes; the director can unlock it', async () => {
    for (let i = 0; i < 4; i++) expect((await login('NLS010', 'nope')).status).toBe(401);
    const fifth = await login('NLS010', 'nope');
    expect(fifth.status).toBe(423);
    expect(fifth.body.error.code).toBe('ACCOUNT_LOCKED');
    expect(fifth.body.error.details.minutes).toBe(15);
    // Even the right password is refused while locked.
    expect((await login('NLS010', PASSWORD)).status).toBe(423);

    expect((await request(app).post(`${api}/users/${rm.user.id}/unlock`).set(rm.headers)).status).toBe(403);
    expect((await request(app).post(`${api}/users/${rm.user.id}/unlock`).set(director.headers)).status).toBe(200);
    expect((await login('NLS010', PASSWORD)).status).toBe(200);
  });

  it('a failure window older than 15 minutes starts again', async () => {
    await prisma.user.update({ where: { id: rm.user.id }, data: { failedLoginCount: 4, failedWindowStartedAt: new Date(Date.now() - 16 * 60_000) } });
    expect((await login('NLS010', 'nope')).status).toBe(401);
    expect((await prisma.user.findUniqueOrThrow({ where: { id: rm.user.id } })).failedLoginCount).toBe(1);
  });

  it('a director password reset revokes every session and notifies the user', async () => {
    const tokens = (await login('NLS010', PASSWORD)).body;
    const reset = await request(app).post(`${api}/users/${rm.user.id}/reset-password`).set(director.headers).send({ password: 'New-Password-2' });
    expect(reset.status).toBe(200);
    expect((await request(app).post(`${api}/auth/refresh`).send({ refreshToken: tokens.refreshToken })).status).toBe(401);
    expect((await login('NLS010', PASSWORD)).status).toBe(401);
    expect((await login('NLS010', 'New-Password-2')).status).toBe(200);
    expect(await prisma.notification.count({ where: { recipientUserId: rm.user.id, type: 'PASSWORD_RESET' } })).toBe(1);
  });

  it('refresh rotates; re-using a rotated token revokes the session', async () => {
    const first = (await login('NLS010', PASSWORD)).body;
    const second = await request(app).post(`${api}/auth/refresh`).send({ refreshToken: first.refreshToken });
    expect(second.status).toBe(200);
    expect((await request(app).post(`${api}/auth/refresh`).send({ refreshToken: first.refreshToken })).status).toBe(401);
    expect((await request(app).post(`${api}/auth/refresh`).send({ refreshToken: second.body.refreshToken })).status).toBe(401);
  });

  it('deactivation blocks the next request at once', async () => {
    const res = await request(app).get(`${api}/me`).set(rm.headers);
    expect(res.status).toBe(200);
    await request(app).patch(`${api}/users/${rm.user.id}`).set(director.headers).send({ isActive: false });
    expect((await request(app).get(`${api}/me`).set(rm.headers)).status).toBe(401);
  });
});
