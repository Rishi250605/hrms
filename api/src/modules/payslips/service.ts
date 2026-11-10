import type { z } from 'zod';
import { todayIst } from '../../lib/dates.js';
import { AppError, Errors } from '../../lib/errors.js';
import { prisma } from '../../lib/prisma.js';
import type { AuthUser, RequestContext } from '../../lib/context.js';
import type { UploadedFile } from '../../lib/route.js';
import { getStorageService } from '../../lib/storage.js';
import type { Prisma } from '../../generated/prisma/client.js';
import { businessUnitsFor, canAccess, scopeFor } from '../access/scope.js';
import { audit } from '../audit/service.js';
import { signedUrlFor } from '../employees/documents.service.js';
import { notify, usersInBusinessUnit } from '../notifications/service.js';
import { getSetting } from '../settings/service.js';
import type { DownloadQuery, PayslipQuery, PayslipUploadResult } from './schemas.js';

/**
 * Payslips (PHASE-2-FEATURES §7): PDFs produced outside the app, bulk-uploaded by HR as
 * `payslip-<empCode>.pdf`. Re-uploads add a version; older versions are HR / director only.
 */

const FILE_NAME = /^payslip-([A-Za-z0-9]{2,20})\.pdf$/i;
const PDF_MAGIC = Buffer.from('%PDF-');

const monthName = (period: string) =>
  new Date(`${period}-01T00:00:00Z`).toLocaleDateString('en-IN', { month: 'long', year: 'numeric', timeZone: 'UTC' });

type UploadResult = z.infer<typeof PayslipUploadResult>;

export async function uploadPayslips(user: AuthUser, period: string, files: UploadedFile[], ctx: RequestContext): Promise<UploadResult> {
  if (files.length === 0) throw Errors.validation([{ path: ['files'], message: 'Choose at least one PDF' }]);
  // TODO(business): may HR upload ahead of the month? For now: up to the current month.
  if (period > todayIst().slice(0, 7)) throw Errors.validation([{ path: ['period'], message: 'The pay period is in the future' }]);
  const maxBytes = await getSetting('payslips.maxFileBytes');
  const result: UploadResult = { period, matched: [], replaced: [], unmatched: [], invalid: [], duplicates: [] };

  // 1. File-level checks, then group by employee code.
  const byCode = new Map<string, { file: UploadedFile; name: string }[]>();
  for (const file of files) {
    const name = file.originalname.split(/[\\/]/).pop() ?? file.originalname;
    const m = FILE_NAME.exec(name);
    if (!m) result.invalid.push({ fileName: name, reason: 'NAME_FORMAT' });
    else if (file.size === 0) result.invalid.push({ fileName: name, reason: 'EMPTY' });
    else if (file.size > maxBytes) result.invalid.push({ fileName: name, reason: 'TOO_LARGE' });
    else if (!file.buffer.subarray(0, PDF_MAGIC.length).equals(PDF_MAGIC)) result.invalid.push({ fileName: name, reason: 'NOT_PDF' });
    else {
      const code = m[1]!.toUpperCase();
      byCode.set(code, [...(byCode.get(code) ?? []), { file, name }]);
    }
  }
  for (const [code, list] of byCode) {
    if (list.length > 1) {
      result.duplicates.push(...list.map((l) => l.name));
      byCode.delete(code);
    }
  }

  // 2. Match employees (case-insensitive code) whose primary BU is one of HR's.
  const employees = await prisma.employee.findMany({
    where: { deletedAt: null, OR: [...byCode.keys()].map((code) => ({ empCode: { equals: code, mode: 'insensitive' as const } })) },
    select: { id: true, empCode: true, fullName: true, user: { select: { role: true } }, businessUnits: { where: { isPrimary: true }, select: { businessUnitId: true } } },
  });
  const byUpper = new Map(employees.map((e) => [e.empCode.toUpperCase(), e]));
  const storage = getStorageService();
  const touchedBus = new Set<string>();

  for (const [code, [first]] of byCode) {
    const { file, name } = first!;
    const e = byUpper.get(code);
    const bu = e?.businessUnits[0]?.businessUnitId;
    if (!e || !bu || !user.businessUnitIds.includes(bu)) {
      result.unmatched.push(name);
      continue;
    }
    const stored = await prisma.$transaction(async (tx) => {
      // Serialise concurrent uploads for the same employee and period.
      await tx.$executeRaw`SELECT pg_advisory_xact_lock(hashtext(${`payslip:${e.id}:${period}`}))`;
      const before = await tx.payslip.findUnique({ where: { employeeId_period: { employeeId: e.id, period } } });
      const version = (before?.latestVersion ?? 0) + 1;
      const fileKey = `payslips/${period}/${e.empCode.toLowerCase()}-v${version}.pdf`;
      await storage.putObject(fileKey, file.buffer, 'application/pdf');
      const now = new Date();
      const data = { businessUnitId: bu, latestVersion: version, fileKey, sizeBytes: file.size, uploadedById: user.id, uploadedAt: now };
      const after = before
        ? await tx.payslip.update({ where: { id: before.id }, data })
        : await tx.payslip.create({ data: { employeeId: e.id, period, ...data } });
      await tx.payslipVersion.create({ data: { payslipId: after.id, version, fileKey, sizeBytes: file.size, originalName: name, uploadedById: user.id } });
      await audit.record(tx, ctx, { action: before ? 'payslip.replace' : 'payslip.upload', entityType: 'Payslip', entityId: after.id, before, after });
      return { id: after.id, version };
    });
    const match = { fileName: name, payslipId: stored.id, employee: { employeeId: e.id, empCode: e.empCode, name: e.fullName, role: e.user?.role ?? null }, version: stored.version };
    result.matched.push(match);
    if (stored.version > 1) result.replaced.push(match);
    touchedBus.add(bu);
  }

  // §7.1: optional notice to RMs / OMs of the affected business units.
  if (result.matched.length && (await getSetting('payslips.notifyOnUpload'))) {
    for (const bu of touchedBus) {
      const recipients = [...(await usersInBusinessUnit(prisma, 'REGIONAL_MANAGER', bu)), ...(await usersInBusinessUnit(prisma, 'OPERATIONAL_MANAGER', bu))];
      await notify(
        recipients,
        { type: 'PAYSLIPS_AVAILABLE', title: 'Payslips available', body: `Payslips for ${monthName(period)} are available`, entityType: 'PAYSLIP_PERIOD', entityId: period, businessUnitId: bu },
        user.id,
      );
    }
  }
  return result;
}

const include = {
  employee: { select: { id: true, empCode: true, fullName: true, category: true, user: { select: { role: true } } } },
} satisfies Prisma.PayslipInclude;
type Row = Prisma.PayslipGetPayload<{ include: typeof include }>;

export async function listPayslips(user: AuthUser, q: z.infer<typeof PayslipQuery>) {
  const and: Prisma.PayslipWhereInput[] = [];
  if (q.scope === 'mine') {
    and.push({ employeeId: user.employeeId });
  } else {
    if (q.scope === 'all' && user.role !== 'HR' && user.role !== 'DIRECTOR') throw Errors.forbidden('Only HR and the director can see all payslips');
    const scope = await scopeFor(prisma, user, 'payslips', q.businessUnitId);
    and.push({ businessUnitId: { in: scope.businessUnitIds } });
    if (scope.employeeIds) and.push({ employeeId: { in: scope.employeeIds } });
    if (q.scope === 'team') and.push({ employeeId: { not: user.employeeId } });
  }
  if (q.businessUnitId) and.push({ businessUnitId: { in: businessUnitsFor(user, q.businessUnitId) } });
  if (q.period) and.push({ period: q.period });
  if (q.q) and.push({ employee: { OR: [{ fullName: { contains: q.q, mode: 'insensitive' } }, { empCode: { contains: q.q, mode: 'insensitive' } }] } });
  const rows = await prisma.payslip.findMany({
    where: { AND: and },
    include,
    orderBy: [{ period: 'desc' }, { employee: { fullName: 'asc' } }, { id: 'asc' }],
    take: q.limit + 1,
    ...(q.cursor ? { cursor: { id: q.cursor }, skip: 1 } : {}),
  });
  const hasMore = rows.length > q.limit;
  const page = hasMore ? rows.slice(0, q.limit) : rows;
  const bus = new Map(
    (await prisma.businessUnit.findMany({ where: { id: { in: page.map((r) => r.businessUnitId) } }, select: { id: true, code: true, name: true } })).map((b) => [b.id, b]),
  );
  return { items: page.map((r) => toItem(r, bus.get(r.businessUnitId)!)), nextCursor: hasMore ? (page[page.length - 1]?.id ?? null) : null };
}

function toItem(r: Row, businessUnit: { id: string; code: string; name: string }) {
  return {
    id: r.id,
    employee: { employeeId: r.employee.id, empCode: r.employee.empCode, name: r.employee.fullName, role: r.employee.user?.role ?? null, category: r.employee.category },
    businessUnit,
    period: r.period,
    version: r.latestVersion,
    sizeBytes: r.sizeBytes,
    uploadedAt: r.uploadedAt.toISOString(),
  };
}

const isHrOrDirector = (user: AuthUser) => user.role === 'HR' || user.role === 'DIRECTOR';

/** §7.2 visibility: own, plus the hierarchy / BU rules; everything else is a 404. */
async function findVisible(user: AuthUser, id: string) {
  const p = await prisma.payslip.findUnique({ where: { id } });
  if (!p) throw Errors.notFound('Payslip');
  const own = p.employeeId === user.employeeId;
  if (!own && !(await canAccess(prisma, user, p.employeeId, p.businessUnitId, 'payslips'))) throw Errors.notFound('Payslip');
  return p;
}

export async function downloadPayslip(user: AuthUser, id: string, q: z.infer<typeof DownloadQuery>, origin: string, ctx: RequestContext) {
  const p = await findVisible(user, id);
  let key = p.fileKey;
  if (q.version !== undefined && q.version !== p.latestVersion) {
    if (!isHrOrDirector(user)) throw new AppError('FORBIDDEN', 403, 'Earlier versions are for HR only');
    const v = await prisma.payslipVersion.findUnique({ where: { payslipId_version: { payslipId: id, version: q.version } } });
    if (!v) throw Errors.notFound('Payslip version');
    key = v.fileKey;
  }
  await audit.record(prisma, ctx, { action: 'payslip.download', entityType: 'Payslip', entityId: id, after: { version: q.version ?? p.latestVersion, employeeId: p.employeeId, period: p.period } });
  return signedUrlFor(key, origin);
}

export async function listVersions(user: AuthUser, id: string, ctx: RequestContext) {
  const p = await findVisible(user, id);
  if (!isHrOrDirector(user)) throw Errors.notFound('Payslip');
  await audit.record(prisma, ctx, { action: 'payslip.versions.read', entityType: 'Payslip', entityId: id });
  const versions = await prisma.payslipVersion.findMany({ where: { payslipId: p.id }, orderBy: { version: 'desc' } });
  const names = new Map((await prisma.user.findMany({ where: { id: { in: versions.map((v) => v.uploadedById) } }, select: { id: true, name: true } })).map((u) => [u.id, u.name]));
  return {
    items: versions.map((v) => ({ version: v.version, sizeBytes: v.sizeBytes, originalName: v.originalName, uploadedByName: names.get(v.uploadedById) ?? null, uploadedAt: v.createdAt.toISOString() })),
  };
}
