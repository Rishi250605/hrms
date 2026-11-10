/**
 * Idempotent seed (PHASE-2-FEATURES).
 *  - Always: the four business units, document requirements, and the bootstrap DIRECTOR
 *    (SEED_DIRECTOR_EMP_CODE / _NAME / _PHONE / _PASSWORD).
 *  - When SEED_DEMO=true (default outside production): depots, a demo hierarchy
 *    DIRECTOR → HR → OM → RM → drivers / loadmen in each BU, fleet and placeholder leave types.
 * Run: npm run db:seed
 */
import 'dotenv/config';
import { prisma } from '../src/lib/prisma.js';
import { systemContext } from '../src/lib/context.js';
import { addDays, todayIst, toDbDate } from '../src/lib/dates.js';
import { hashPassword } from '../src/lib/password.js';
import { audit } from '../src/modules/audit/service.js';
import { normalizePhone } from '../src/modules/auth/phone.js';
import { DEFAULT_DOCUMENT_REQUIREMENTS } from '../src/modules/employees/constants.js';
import type { DocumentType, EmployeeCategory, Role } from '../src/generated/prisma/enums.js';

const ctx = systemContext('seed');
const isProd = process.env.NODE_ENV === 'production';

function phoneOrThrow(raw: string): string {
  const phone = normalizePhone(raw);
  if (!phone) throw new Error(`Invalid phone in seed: ${raw}`);
  return phone;
}

/** PHASE-2-FEATURES §2: exactly these four (codes editable by the director later). */
const BUSINESS_UNITS = [
  { code: 'NLS', name: 'NLS Enterprises' },
  { code: 'BMS', name: 'BMS Associates' },
  { code: 'MOD', name: 'Modern Agency' },
  { code: 'AERO', name: 'Aerothread Logistics' },
];

async function ensureBusinessUnits() {
  const out: Record<string, string> = {};
  for (const bu of BUSINESS_UNITS) {
    const existing = await prisma.businessUnit.findUnique({ where: { code: bu.code } });
    if (existing) {
      out[bu.code] = existing.id;
      continue;
    }
    out[bu.code] = await prisma.$transaction(async (tx) => {
      const row = await tx.businessUnit.create({ data: bu });
      await audit.record(tx, ctx, { action: 'businessUnit.create', entityType: 'BusinessUnit', entityId: row.id, after: row });
      return row.id;
    });
  }
  return out;
}

async function ensureDocumentRequirements() {
  for (const [category, types] of Object.entries(DEFAULT_DOCUMENT_REQUIREMENTS) as [EmployeeCategory, DocumentType[]][]) {
    if ((await prisma.documentRequirement.count({ where: { category } })) > 0) continue;
    await prisma.$transaction(async (tx) => {
      await tx.documentRequirement.createMany({ data: types.map((documentType) => ({ category, documentType })) });
      await audit.record(tx, ctx, { action: 'documentRequirement.set', entityType: 'DocumentRequirement', entityId: category, after: types });
    });
  }
}

interface PersonSeed {
  empCode: string;
  name: string;
  phone: string;
  role?: Role;
  category?: EmployeeCategory;
  businessUnits: string[];
  primary?: string;
  depotId?: string;
  reportsTo?: string | null;
  designation?: string;
  password?: string;
}

/** Employee (+ BU membership, job row, and login when `role` is set). Returns the employee id. */
async function ensurePerson(p: PersonSeed): Promise<string> {
  const existing = await prisma.employee.findUnique({ where: { empCode: p.empCode } });
  if (existing) return existing.id;
  const joining = addDays(todayIst(), -400);
  const passwordHash = p.password ? await hashPassword(p.password) : null;
  return prisma.$transaction(async (tx) => {
    const employee = await tx.employee.create({
      data: { empCode: p.empCode, fullName: p.name, phone: p.phone, category: p.category ?? 'OFFICE', employmentType: 'PERMANENT', joiningDate: toDbDate(joining) },
    });
    if (p.businessUnits.length) {
      await tx.employeeBusinessUnit.createMany({
        data: p.businessUnits.map((b) => ({ employeeId: employee.id, businessUnitId: b, isPrimary: b === (p.primary ?? p.businessUnits[0]) })),
      });
    }
    if (p.depotId) {
      await tx.employeeJob.create({
        data: { employeeId: employee.id, depotId: p.depotId, designation: p.designation ?? 'Staff', reportingToEmployeeId: p.reportsTo ?? null, effectiveFrom: toDbDate(joining), changeReason: 'Joining' },
      });
    }
    if (p.role) {
      const user = await tx.user.create({
        data: { name: p.name, phone: p.phone, role: p.role, employeeId: employee.id, passwordHash, passwordChangedAt: passwordHash ? new Date() : null },
      });
      await audit.record(tx, ctx, { action: 'user.create', entityType: 'User', entityId: user.id, after: user });
    }
    await audit.record(tx, ctx, { action: 'employee.create', entityType: 'Employee', entityId: employee.id, after: employee });
    return employee.id;
  });
}

async function ensureRegion(code: string, name: string) {
  return (await prisma.region.findUnique({ where: { code } })) ?? prisma.region.create({ data: { code, name } });
}

async function ensureDepot(d: { code: string; name: string; regionId: string; businessUnitId: string; state: string }) {
  return (await prisma.depot.findUnique({ where: { code: d.code } })) ?? prisma.depot.create({ data: d });
}

type DemoDoc = { type: DocumentType; number: string; expiresInDays: number };
const driverDocs = (dlDays: number, medical = true): DemoDoc[] => [
  { type: 'DRIVING_LICENCE', number: 'MH1220150012345', expiresInDays: dlDays },
  { type: 'PSV_BADGE', number: 'PSV-55021', expiresInDays: 400 },
  ...(medical ? [{ type: 'MEDICAL_FITNESS' as const, number: 'MED-2026-01', expiresInDays: 200 }] : []),
];

async function addDocs(employeeId: string, docs: DemoDoc[]) {
  if ((await prisma.document.count({ where: { employeeId } })) > 0) return;
  const today = todayIst();
  for (const d of docs) {
    const expiry = addDays(today, d.expiresInDays);
    await prisma.document.create({
      data: {
        employeeId,
        type: d.type,
        number: d.number,
        issueDate: toDbDate(addDays(today, -300)),
        expiryDate: toDbDate(expiry),
        status: expiry < today ? 'EXPIRED' : 'VERIFIED',
        verifiedAt: new Date(),
      },
    });
  }
}

/** Demo-only placeholders. TODO(business): replace with the company's real leave types and quotas. */
async function seedDemoLeaveAndFleet(depotId: string) {
  if ((await prisma.leaveType.count()) === 0) {
    const types = [
      { code: 'CL', name: 'Casual leave', paid: true, accrualRule: { type: 'MONTHLY' }, carryForwardMax: 0, quota: 8 },
      { code: 'SL', name: 'Sick leave', paid: true, accrualRule: { type: 'MONTHLY' }, carryForwardMax: 0, quota: 7 },
      { code: 'EL', name: 'Earned leave', paid: true, accrualRule: { type: 'ANNUAL' }, carryForwardMax: 30, quota: 15 },
      { code: 'LOP', name: 'Unpaid leave', paid: false, accrualRule: { type: 'NONE' }, carryForwardMax: 0, quota: 0 },
    ];
    for (const { quota, ...data } of types) {
      const lt = await prisma.leaveType.create({ data });
      await prisma.leavePolicy.create({ data: { leaveTypeId: lt.id, annualQuota: quota } });
    }
  }
  if ((await prisma.vehicle.count()) === 0) {
    for (const regNo of ['MH12AB1001', 'MH12AB1002', 'MH12AB1003']) await prisma.vehicle.create({ data: { regNo, type: 'Truck', capacity: 10, depotId } });
    const r1 = await prisma.route.create({ data: { code: 'PUN-NSK', name: 'Pune – Nashik', origin: 'Pune', destination: 'Nashik', distanceKm: 210, standardMinutes: 300, depotId } });
    await prisma.dutyTemplate.create({ data: { depotId, name: 'Morning Nashik', startTime: '06:00', endTime: '14:00', routeId: r1.id } });
    await prisma.dutyTemplate.create({ data: { depotId, name: 'Night Nashik', startTime: '22:00', endTime: '06:00', crossesMidnight: true, routeId: r1.id } });
  }
}

/** Starter allowance types (HR edits them in the app). TODO(business): confirm the real list and per-request limits. */
async function ensureAllowanceTypes() {
  if ((await prisma.allowanceType.count()) > 0) return;
  const types = [
    { code: 'BATTA', name: 'Batta' },
    { code: 'NIGHT_HALT', name: 'Night halt' },
    { code: 'TRAVEL', name: 'Travel' },
    { code: 'FOOD', name: 'Food' },
    { code: 'FUEL', name: 'Fuel' },
    { code: 'OTHER', name: 'Other' },
  ];
  await prisma.$transaction(async (tx) => {
    await tx.allowanceType.createMany({ data: types });
    await audit.record(tx, ctx, { action: 'allowanceType.seed', entityType: 'AllowanceType', entityId: 'seed', after: types });
  });
}

async function main() {
  const bu = await ensureBusinessUnits();
  await ensureDocumentRequirements();
  await ensureAllowanceTypes();

  const directorPassword = process.env.SEED_DIRECTOR_PASSWORD;
  if (!directorPassword || directorPassword.length < 8) throw new Error('SEED_DIRECTOR_PASSWORD (8+ characters) is required to seed the director');
  if (isProd && /change-me|password|director@123/i.test(directorPassword)) throw new Error('Refusing a default/weak SEED_DIRECTOR_PASSWORD in production');
  const directorCode = (process.env.SEED_DIRECTOR_EMP_CODE ?? 'DIR001').toUpperCase();
  const director = await ensurePerson({
    empCode: directorCode,
    name: process.env.SEED_DIRECTOR_NAME ?? 'Director',
    phone: phoneOrThrow(process.env.SEED_DIRECTOR_PHONE ?? '+919000000001'),
    role: 'DIRECTOR',
    businessUnits: [],
    password: directorPassword,
  });
  console.log(`Director: ${directorCode}`);

  const seedDemo = (process.env.SEED_DEMO ?? (isProd ? 'false' : 'true')) === 'true';
  if (!seedDemo) return;

  // Demo org. Phones are fictitious (+91 90000 xxxxx). Every demo login uses SEED_DEMO_PASSWORD.
  const pw = process.env.SEED_DEMO_PASSWORD ?? 'Demo@1234';
  const west = await ensureRegion('WEST', 'West');
  const south = await ensureRegion('SOUTH', 'South');
  const pun = await ensureDepot({ code: 'PUN', name: 'Pune Depot', regionId: west.id, businessUnitId: bu.NLS!, state: 'MH' });
  const mum = await ensureDepot({ code: 'MUM', name: 'Mumbai Depot', regionId: west.id, businessUnitId: bu.BMS!, state: 'MH' });
  const blr = await ensureDepot({ code: 'BLR', name: 'Bengaluru Depot', regionId: south.id, businessUnitId: bu.MOD!, state: 'KA' });
  await ensureDepot({ code: 'HYD', name: 'Hyderabad Depot', regionId: south.id, businessUnitId: bu.AERO!, state: 'TS' });

  const hr = await ensurePerson({ empCode: 'NLS001', name: 'Priya Nair (HR)', phone: '+919000000002', role: 'HR', businessUnits: [bu.NLS!, bu.BMS!, bu.MOD!, bu.AERO!], primary: bu.NLS!, depotId: pun.id, reportsTo: director, designation: 'HR manager', password: pw });
  const om = await ensurePerson({ empCode: 'NLS002', name: 'Arjun Mehta (OM)', phone: '+919000000003', role: 'OPERATIONAL_MANAGER', businessUnits: [bu.NLS!, bu.BMS!], primary: bu.NLS!, depotId: pun.id, reportsTo: hr, designation: 'Operations manager', password: pw });
  const rmPun = await ensurePerson({ empCode: 'NLS003', name: 'Asha Patil (RM Pune)', phone: '+919000000004', role: 'REGIONAL_MANAGER', businessUnits: [bu.NLS!], depotId: pun.id, reportsTo: om, designation: 'Regional manager', password: pw });
  const rmMum = await ensurePerson({ empCode: 'BMS001', name: 'Rahul Desai (RM Mumbai)', phone: '+919000000005', role: 'REGIONAL_MANAGER', businessUnits: [bu.BMS!], depotId: mum.id, reportsTo: om, designation: 'Regional manager', password: pw });
  const omMod = await ensurePerson({ empCode: 'MOD001', name: 'Kavya Rao (OM South)', phone: '+919000000006', role: 'OPERATIONAL_MANAGER', businessUnits: [bu.MOD!], depotId: blr.id, reportsTo: hr, designation: 'Operations manager', password: pw });
  const rmBlr = await ensurePerson({ empCode: 'MOD002', name: 'Manjunath Gowda (RM Bengaluru)', phone: '+919000000007', role: 'REGIONAL_MANAGER', businessUnits: [bu.MOD!], depotId: blr.id, reportsTo: omMod, designation: 'Regional manager', password: pw });

  const staff: [string, string, string, EmployeeCategory, string, string, string, DemoDoc[]][] = [
    ['NLS004', 'Ramesh Pawar', '+919000010001', 'DRIVER', bu.NLS!, pun.id, rmPun, driverDocs(900)],
    ['NLS005', 'Suresh Jadhav', '+919000010002', 'DRIVER', bu.NLS!, pun.id, rmPun, driverDocs(600)],
    ['NLS006', 'Anil Shinde', '+919000010003', 'DRIVER', bu.NLS!, pun.id, rmPun, driverDocs(10)],
    ['NLS007', 'Vijay More', '+919000010004', 'DRIVER', bu.NLS!, pun.id, rmPun, driverDocs(700, false)],
    ['NLS008', 'Raju Gaikwad', '+919000010005', 'LOADMAN', bu.NLS!, pun.id, rmPun, []],
    ['NLS009', 'Ganesh Kale', '+919000010006', 'LOADMAN', bu.NLS!, pun.id, rmPun, []],
    ['BMS002', 'Imran Shaikh', '+919000010101', 'DRIVER', bu.BMS!, mum.id, rmMum, driverDocs(-5)],
    ['BMS003', 'Sachin Kamble', '+919000010102', 'LOADMAN', bu.BMS!, mum.id, rmMum, []],
    ['MOD003', 'Ravi Shetty', '+919000010201', 'DRIVER', bu.MOD!, blr.id, rmBlr, driverDocs(25)],
    ['MOD004', 'Naveen Kumar', '+919000010202', 'LOADMAN', bu.MOD!, blr.id, rmBlr, []],
  ];
  for (const [empCode, name, phone, category, b, depotId, rm, docs] of staff) {
    const id = await ensurePerson({ empCode, name, phone, category, businessUnits: [b], depotId, reportsTo: rm, designation: category === 'DRIVER' ? 'Driver' : 'Loadman' });
    await addDocs(id, docs);
  }
  await seedDemoLeaveAndFleet(pun.id);
  console.log(`Demo data seeded: 4 business units, depots PUN/MUM/BLR/HYD; logins NLS001 (HR), NLS002 / MOD001 (OM), NLS003 / BMS001 / MOD002 (RM), password ${pw}`);
}

main()
  .catch((err: unknown) => {
    console.error(err);
    process.exitCode = 1;
  })
  .finally(() => prisma.$disconnect());
