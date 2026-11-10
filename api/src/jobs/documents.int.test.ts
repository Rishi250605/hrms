import { beforeEach, describe, expect, it } from 'vitest';
import { addDays, todayIst, toDbDate } from '../lib/dates.js';
import { prisma } from '../lib/prisma.js';
import { createHierarchy, createOrgFixture, createStaff, resetDb, seedDriverRequirements } from '../../test/helpers.js';
import type { Hierarchy, Org } from '../../test/helpers.js';
import { runDocumentExpiry, runEmployeeExits } from './documents.js';

let org: Org;
let h: Hierarchy;

beforeEach(async () => {
  await resetDb();
  org = await createOrgFixture();
  await seedDriverRequirements();
  h = await createHierarchy(org);
});

const notes = (userId: string) => prisma.notification.count({ where: { recipientUserId: userId, type: 'DOCUMENTS_EXPIRING' } });

describe('nightly document expiry job', () => {
  it('marks past-expiry documents EXPIRED (audited)', async () => {
    const e = await createStaff({ businessUnitId: org.nls.id, depotId: org.pune.id, reportsTo: h.rm.employeeId, docs: [{ type: 'DRIVING_LICENCE', expiryDate: addDays(todayIst(), -1) }] });
    expect((await runDocumentExpiry()).expired).toBe(1);
    const doc = await prisma.document.findFirstOrThrow({ where: { employeeId: e.id } });
    expect(doc.status).toBe('EXPIRED');
    expect(await prisma.auditLog.count({ where: { action: 'document.expire', entityId: doc.id } })).toBe(1);
  });

  it('alerts the employee’s RM and HR of the business unit, once per threshold', async () => {
    await createStaff({ businessUnitId: org.nls.id, depotId: org.pune.id, reportsTo: h.rm.employeeId, docs: [{ type: 'DRIVING_LICENCE', expiryDate: addDays(todayIst(), 6) }] });
    expect((await runDocumentExpiry()).alerted).toBe(1);
    expect(await notes(h.rm.user.id)).toBe(1);
    expect(await notes(h.hr.user.id)).toBe(1);
    expect(await notes(h.rm2.user.id)).toBe(0);
    expect(await notes(h.hrMod.user.id)).toBe(0);
    expect((await runDocumentExpiry()).alerted).toBe(0);
    expect((await runDocumentExpiry(new Date(Date.now() + 5 * 86_400_000))).alerted).toBe(1);
  });
});

describe('nightly exits job', () => {
  it('moves ON_NOTICE employees past their exit date to EXITED and deactivates their login', async () => {
    await prisma.employee.update({ where: { id: h.rm2.employeeId }, data: { status: 'ON_NOTICE', exitDate: toDbDate(addDays(todayIst(), -1)) } });
    expect(await runEmployeeExits()).toEqual({ exited: 1 });
    expect((await prisma.user.findUniqueOrThrow({ where: { id: h.rm2.user.id } })).isActive).toBe(false);
  });
});
