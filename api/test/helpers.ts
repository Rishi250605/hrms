import { randomUUID } from 'node:crypto';
import { signAccessToken } from '../src/lib/jwt.js';
import { prisma } from '../src/lib/prisma.js';
import type { DocumentType, EmployeeCategory, Role } from '../src/generated/prisma/enums.js';
import { toDbDate } from '../src/lib/dates.js';

/** Empties every application table (test database only). */
export async function resetDb(): Promise<void> {
  const tables = await prisma.$queryRaw<{ tablename: string }[]>`
    SELECT tablename FROM pg_tables WHERE schemaname = 'public' AND tablename <> '_prisma_migrations'`;
  if (tables.length === 0) return;
  const list = tables.map((t) => `"public"."${t.tablename}"`).join(', ');
  await prisma.$executeRawUnsafe(`TRUNCATE TABLE ${list} RESTART IDENTITY CASCADE`);
}

let phoneCounter = 0;
export function uniquePhone(): string {
  phoneCounter += 1;
  return `+9198${String(Date.now()).slice(-6)}${String(phoneCounter).padStart(2, '0')}`;
}

let codeCounter = 0;
const nextCode = (prefix: string) => `${prefix}${String(++codeCounter).padStart(3, '0')}`;

/** Bearer header for a user, bypassing the password login (tested separately). */
export async function authHeader(user: { id: string; role: Role }): Promise<{ Authorization: string }> {
  const { token } = await signAccessToken({ sub: user.id, role: user.role, sid: randomUUID() });
  return { Authorization: `Bearer ${token}` };
}

export type Headers = { Authorization: string };

/**
 * Business units NLS, BMS, MOD with one depot each (PUN → NLS, MUM → BMS, BLR → MOD) and a region.
 */
export async function createOrgFixture() {
  const region = await prisma.region.create({ data: { code: 'WEST', name: 'West' } });
  const nls = await prisma.businessUnit.create({ data: { code: 'NLS', name: 'NLS Enterprises' } });
  const bms = await prisma.businessUnit.create({ data: { code: 'BMS', name: 'BMS Associates' } });
  const mod = await prisma.businessUnit.create({ data: { code: 'MOD', name: 'Modern Agency' } });
  const pune = await prisma.depot.create({ data: { code: 'PUN', name: 'Pune', regionId: region.id, businessUnitId: nls.id, state: 'MH' } });
  const mumbai = await prisma.depot.create({ data: { code: 'MUM', name: 'Mumbai', regionId: region.id, businessUnitId: bms.id, state: 'MH' } });
  const blr = await prisma.depot.create({ data: { code: 'BLR', name: 'Bengaluru', regionId: region.id, businessUnitId: mod.id, state: 'KA' } });
  return { region, nls, bms, mod, pune, mumbai, blr };
}
export type Org = Awaited<ReturnType<typeof createOrgFixture>>;

export interface Login {
  user: { id: string; role: Role };
  employeeId: string;
  empCode: string;
  headers: Headers;
}

/** A login (employee + user + BU membership + job row). */
export async function createLogin(input: {
  role: Role;
  businessUnitIds: string[];
  primary?: string;
  depotId?: string;
  reportsTo?: string | null;
  name?: string;
  empCode?: string;
  passwordHash?: string | null;
  isActive?: boolean;
  from?: string;
}): Promise<Login> {
  const from = input.from ?? '2025-01-01';
  const bu = input.primary ?? input.businessUnitIds[0];
  const prefix = bu ? (await prisma.businessUnit.findUniqueOrThrow({ where: { id: bu } })).code : 'DIR';
  const empCode = input.empCode ?? nextCode(prefix);
  const phone = uniquePhone();
  const employee = await prisma.employee.create({
    data: { empCode, fullName: input.name ?? `${input.role} ${empCode}`, phone, category: 'OFFICE', employmentType: 'PERMANENT', joiningDate: toDbDate(from) },
  });
  for (const b of input.businessUnitIds) {
    await prisma.employeeBusinessUnit.create({ data: { employeeId: employee.id, businessUnitId: b, isPrimary: b === bu } });
  }
  if (input.depotId) {
    await prisma.employeeJob.create({
      data: { employeeId: employee.id, depotId: input.depotId, designation: input.role, reportingToEmployeeId: input.reportsTo ?? null, effectiveFrom: toDbDate(from) },
    });
  }
  const user = await prisma.user.create({
    data: { name: employee.fullName, phone, role: input.role, employeeId: employee.id, passwordHash: input.passwordHash ?? null, isActive: input.isActive ?? true },
  });
  return { user, employeeId: employee.id, empCode, headers: await authHeader(user) };
}

/** Non-login staff (driver / loadman …) with one BU, a job row and optional documents. */
export async function createStaff(input: {
  businessUnitId: string;
  depotId: string;
  reportsTo: string | null;
  category?: EmployeeCategory;
  fullName?: string;
  from?: string;
  docs?: { type: DocumentType; expiryDate?: string | null; status?: 'VERIFIED' | 'PENDING_VERIFICATION' | 'EXPIRED' | 'REJECTED' }[];
}) {
  const from = input.from ?? '2025-01-01';
  const prefix = (await prisma.businessUnit.findUniqueOrThrow({ where: { id: input.businessUnitId } })).code;
  const employee = await prisma.employee.create({
    data: {
      empCode: nextCode(prefix),
      fullName: input.fullName ?? `Staff ${codeCounter}`,
      phone: uniquePhone(),
      category: input.category ?? 'DRIVER',
      employmentType: 'PERMANENT',
      joiningDate: toDbDate(from),
    },
  });
  await prisma.employeeBusinessUnit.create({ data: { employeeId: employee.id, businessUnitId: input.businessUnitId, isPrimary: true } });
  await prisma.employeeJob.create({
    data: { employeeId: employee.id, depotId: input.depotId, designation: 'Driver', reportingToEmployeeId: input.reportsTo, effectiveFrom: toDbDate(from) },
  });
  for (const d of input.docs ?? []) {
    const status = d.status ?? 'VERIFIED';
    await prisma.document.create({
      data: {
        employeeId: employee.id,
        type: d.type,
        number: d.type === 'AADHAAR' ? '1234' : 'NUM-1',
        expiryDate: d.expiryDate ? toDbDate(d.expiryDate) : null,
        status,
        verifiedAt: status === 'VERIFIED' || status === 'EXPIRED' ? new Date() : null,
      },
    });
  }
  return employee;
}

/** Valid driver documents (DL, PSV, medical) expiring far in the future. */
export const validDriverDocs = (expiryDate = '2099-12-31') => (['DRIVING_LICENCE', 'PSV_BADGE', 'MEDICAL_FITNESS'] as const).map((type) => ({ type, expiryDate }));

export async function seedDriverRequirements() {
  await prisma.documentRequirement.createMany({
    data: (['DRIVING_LICENCE', 'PSV_BADGE', 'MEDICAL_FITNESS'] as const).map((documentType) => ({ category: 'DRIVER' as const, documentType })),
    skipDuplicates: true,
  });
}

/**
 * The standard hierarchy (PHASE-2-FEATURES §1.2) used by the visibility-matrix tests:
 *
 *   director
 *   ├─ hr (NLS*, BMS)                ├─ hrMod (MOD)
 *   │  └─ om (NLS*, BMS)             │  └─ omMod (MOD)
 *   │     ├─ rm (NLS) ── d1, d2, l1  │     └─ rmMod (MOD) ── d5
 *   │     ├─ rm2 (NLS) ── d3
 *   │     └─ rmBms (BMS) ── d4
 */
export async function createHierarchy(org: Org, opts: { docs?: boolean } = {}) {
  const docs = opts.docs ? validDriverDocs() : [];
  const director = await createLogin({ role: 'DIRECTOR', businessUnitIds: [], empCode: 'DIR001', name: 'Director' });
  const hr = await createLogin({ role: 'HR', businessUnitIds: [org.nls.id, org.bms.id], depotId: org.pune.id, reportsTo: director.employeeId, name: 'HR NLS' });
  const om = await createLogin({ role: 'OPERATIONAL_MANAGER', businessUnitIds: [org.nls.id, org.bms.id], depotId: org.pune.id, reportsTo: hr.employeeId, name: 'OM NLS' });
  const rm = await createLogin({ role: 'REGIONAL_MANAGER', businessUnitIds: [org.nls.id], depotId: org.pune.id, reportsTo: om.employeeId, name: 'RM One' });
  const rm2 = await createLogin({ role: 'REGIONAL_MANAGER', businessUnitIds: [org.nls.id], depotId: org.pune.id, reportsTo: om.employeeId, name: 'RM Two' });
  const rmBms = await createLogin({ role: 'REGIONAL_MANAGER', businessUnitIds: [org.bms.id], depotId: org.mumbai.id, reportsTo: om.employeeId, name: 'RM BMS' });
  const hrMod = await createLogin({ role: 'HR', businessUnitIds: [org.mod.id], depotId: org.blr.id, reportsTo: director.employeeId, name: 'HR MOD' });
  const omMod = await createLogin({ role: 'OPERATIONAL_MANAGER', businessUnitIds: [org.mod.id], depotId: org.blr.id, reportsTo: hrMod.employeeId, name: 'OM MOD' });
  const rmMod = await createLogin({ role: 'REGIONAL_MANAGER', businessUnitIds: [org.mod.id], depotId: org.blr.id, reportsTo: omMod.employeeId, name: 'RM MOD' });
  const d1 = await createStaff({ businessUnitId: org.nls.id, depotId: org.pune.id, reportsTo: rm.employeeId, fullName: 'Driver One', docs });
  const d2 = await createStaff({ businessUnitId: org.nls.id, depotId: org.pune.id, reportsTo: rm.employeeId, fullName: 'Driver Two', docs });
  const l1 = await createStaff({ businessUnitId: org.nls.id, depotId: org.pune.id, reportsTo: rm.employeeId, fullName: 'Loadman One', category: 'LOADMAN' });
  const d3 = await createStaff({ businessUnitId: org.nls.id, depotId: org.pune.id, reportsTo: rm2.employeeId, fullName: 'Driver Three', docs });
  const d4 = await createStaff({ businessUnitId: org.bms.id, depotId: org.mumbai.id, reportsTo: rmBms.employeeId, fullName: 'Driver Four', docs });
  const d5 = await createStaff({ businessUnitId: org.mod.id, depotId: org.blr.id, reportsTo: rmMod.employeeId, fullName: 'Driver Five', docs });
  return { director, hr, om, rm, rm2, rmBms, hrMod, omMod, rmMod, d1, d2, l1, d3, d4, d5 };
}
export type Hierarchy = Awaited<ReturnType<typeof createHierarchy>>;
