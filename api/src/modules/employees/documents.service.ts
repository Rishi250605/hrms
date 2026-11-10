import { randomUUID } from 'node:crypto';
import type { z } from 'zod';
import { env } from '../../config/env.js';
import { encryptField } from '../../lib/crypto.js';
import { addDays, diffDays, fromDbDate, fromDbDateOrNull, todayIst, toDbDate } from '../../lib/dates.js';
import { AppError, Errors } from '../../lib/errors.js';
import { prisma } from '../../lib/prisma.js';
import type { AuthUser, RequestContext } from '../../lib/context.js';
import { getStorageService } from '../../lib/storage.js';
import type { SignedUrl } from '../../lib/storage.js';
import { primaryBusinessUnitOf } from '../access/hierarchy.js';
import { employeeWhere, scopeFor } from '../access/scope.js';
import type { Prisma } from '../../generated/prisma/client.js';
import type { EmployeeCategory } from '../../generated/prisma/enums.js';
import { audit } from '../audit/service.js';
import { notify } from '../notifications/service.js';
import { EMPLOYEE_CATEGORIES } from './constants.js';
import type {
  DocumentCreateBody,
  DocumentQuery,
  DocumentRejectBody,
  DocumentRequirementBody,
  DocumentVerifyBody,
  ExpiringQuery,
  PresignBody,
} from './documents.schemas.js';
import { findEmployeeInScope } from './service.js';

const docInclude = { employee: { select: { id: true } } } satisfies Prisma.DocumentInclude;
const withEmployeeInclude = {
  employee: {
    select: {
      id: true,
      empCode: true,
      fullName: true,
      category: true,
      jobs: { orderBy: { effectiveFrom: 'desc' }, take: 1, select: { depot: { select: { id: true, code: true, name: true } } } },
    },
  },
} satisfies Prisma.DocumentInclude;

type DocRow = Prisma.DocumentGetPayload<{ include: typeof docInclude }>;
type DocWithEmployeeRow = Prisma.DocumentGetPayload<{ include: typeof withEmployeeInclude }>;

async function verifierNames(rows: { verifiedById: string | null }[]): Promise<Map<string, string>> {
  const ids = [...new Set(rows.flatMap((r) => (r.verifiedById ? [r.verifiedById] : [])))];
  if (ids.length === 0) return new Map();
  const users = await prisma.user.findMany({ where: { id: { in: ids } }, select: { id: true, name: true } });
  return new Map(users.map((u) => [u.id, u.name]));
}

function toItem(d: DocRow | DocWithEmployeeRow, names: Map<string, string>, today = todayIst()) {
  return {
    id: d.id,
    employeeId: d.employeeId,
    type: d.type,
    number: d.number,
    licenceClass: d.licenceClass,
    issueDate: fromDbDateOrNull(d.issueDate),
    expiryDate: fromDbDateOrNull(d.expiryDate),
    status: d.status,
    hasFile: d.fileKey !== null,
    verifiedAt: d.verifiedAt?.toISOString() ?? null,
    verifiedByName: d.verifiedById ? (names.get(d.verifiedById) ?? null) : null,
    rejectionReason: d.rejectionReason,
    createdAt: d.createdAt.toISOString(),
    daysToExpiry: d.expiryDate ? diffDays(today, fromDbDate(d.expiryDate)) : null,
  };
}

function toItemWithEmployee(d: DocWithEmployeeRow, names: Map<string, string>, today = todayIst()) {
  const { jobs, ...employee } = d.employee;
  return { ...toItem(d, names, today), employee: { ...employee, depot: jobs[0]?.depot ?? null } };
}

/** Document of an employee in the user's scope, or 404. */
async function findDocumentInScope(user: AuthUser, id: string) {
  const scope = await scopeFor(prisma, user, 'documents');
  const doc = await prisma.document.findFirst({ where: { id, employee: employeeWhere(user, scope) } });
  if (!doc) throw Errors.notFound('Document');
  return doc;
}

const absolute = (signed: SignedUrl, origin: string) => ({
  url: signed.url.startsWith('/') ? `${origin}${signed.url}` : signed.url,
  method: signed.method,
  headers: signed.headers,
  expiresAt: signed.expiresAt.toISOString(),
});

// ───────────────────────────── Uploads ─────────────────────────────

const EXT: Record<z.infer<typeof PresignBody>['contentType'], string> = {
  'image/jpeg': 'jpg',
  'image/png': 'png',
  'image/webp': 'webp',
  'application/pdf': 'pdf',
  'audio/mp4': 'm4a',
  'audio/aac': 'aac',
  'audio/m4a': 'm4a',
  'audio/x-m4a': 'm4a',
};

const PURPOSE_TYPES: Record<z.infer<typeof PresignBody>['purpose'], string[]> = {
  DOCUMENT: ['image/jpeg', 'image/png', 'image/webp', 'application/pdf'],
  PHOTO: ['image/jpeg', 'image/png', 'image/webp'],
  VOICE_NOTE: ['audio/mp4', 'audio/aac', 'audio/m4a', 'audio/x-m4a'],
  RECEIPT: ['image/jpeg', 'image/png', 'image/webp', 'application/pdf'],
};

/**
 * Signed upload URL. DOCUMENT / PHOTO keys are bound to the employee they are about; VOICE_NOTE / RECEIPT keys
 * (allowance requests) are bound to the uploader.
 */
export async function presignUpload(user: AuthUser, body: z.infer<typeof PresignBody>, origin: string) {
  if (!PURPOSE_TYPES[body.purpose].includes(body.contentType)) {
    throw Errors.validation([{ path: ['contentType'], message: `${body.contentType} is not allowed for ${body.purpose}` }]);
  }
  let ownerId = user.employeeId;
  if (body.purpose === 'DOCUMENT' || body.purpose === 'PHOTO') {
    if (!body.employeeId) throw Errors.validation([{ path: ['employeeId'], message: 'Required for documents and photos' }]);
    await findEmployeeInScope(prisma, user, body.employeeId, 'documents');
    ownerId = body.employeeId;
  }
  if (body.sizeBytes > env.MAX_UPLOAD_BYTES) {
    throw new AppError('FILE_TOO_LARGE', 413, `Files may be at most ${Math.floor(env.MAX_UPLOAD_BYTES / 1024 / 1024)} MB`);
  }
  const key = `employees/${ownerId}/${body.purpose.toLowerCase().replace('_', '-')}/${randomUUID()}.${EXT[body.contentType]}`;
  const signed = await getStorageService().presignPut(key, body.contentType);
  return { key, ...absolute(signed, origin) };
}

/** The key was issued by presignUpload for this owner and purpose, and the file is in storage. */
export async function assertOwnUpload(ownerEmployeeId: string, purpose: 'voice-note' | 'receipt', key: string) {
  if (!key.startsWith(`employees/${ownerEmployeeId}/${purpose}/`)) {
    throw Errors.validation([{ path: [purpose], message: 'The file was not uploaded by you' }]);
  }
  if (!(await getStorageService().exists(key))) throw new AppError('FILE_NOT_UPLOADED', 422, 'Upload the file to the signed URL before saving');
}

/** Signed GET for any stored key (callers check access first). */
export async function signedUrlFor(key: string, origin: string) {
  return absolute(await getStorageService().presignGet(key), origin);
}
async function assertUploaded(employeeId: string, purpose: 'document' | 'photo', key: string) {
  if (!key.startsWith(`employees/${employeeId}/${purpose}/`)) {
    throw Errors.validation([{ path: ['fileKey'], message: 'The file does not belong to this employee' }]);
  }
  if (!(await getStorageService().exists(key))) {
    throw new AppError('FILE_NOT_UPLOADED', 422, 'Upload the file to the signed URL before saving');
  }
}

export async function signedFileUrl(user: AuthUser, id: string, origin: string) {
  const doc = await findDocumentInScope(user, id);
  if (!doc.fileKey) throw Errors.notFound('File');
  return absolute(await getStorageService().presignGet(doc.fileKey), origin);
}

export async function setPhoto(user: AuthUser, employeeId: string, fileKey: string, ctx: RequestContext) {
  await findEmployeeInScope(prisma, user, employeeId);
  await assertUploaded(employeeId, 'photo', fileKey);
  await prisma.$transaction(async (tx) => {
    const before = await tx.employee.findUniqueOrThrow({ where: { id: employeeId }, select: { photoKey: true } });
    const after = await tx.employee.update({ where: { id: employeeId }, data: { photoKey: fileKey }, select: { photoKey: true } });
    await audit.record(tx, ctx, { action: 'employee.photo.update', entityType: 'Employee', entityId: employeeId, before, after });
  });
}

export async function photoUrl(user: AuthUser, employeeId: string, origin: string) {
  const e = await findEmployeeInScope(prisma, user, employeeId);
  if (!e.photoKey) throw Errors.notFound('Photo');
  return absolute(await getStorageService().presignGet(e.photoKey), origin);
}

// ───────────────────────────── Documents ─────────────────────────────

export async function listEmployeeDocuments(user: AuthUser, employeeId: string) {
  await findEmployeeInScope(prisma, user, employeeId);
  const rows = await prisma.document.findMany({
    where: { employeeId },
    include: docInclude,
    orderBy: [{ type: 'asc' }, { createdAt: 'desc' }],
  });
  const names = await verifierNames(rows);
  return { items: rows.map((r) => toItem(r, names)) };
}

/** Records a captured document as PENDING_VERIFICATION. Aadhaar keeps only the last 4; PAN is encrypted. */
export async function createDocument(user: AuthUser, employeeId: string, body: z.infer<typeof DocumentCreateBody>, ctx: RequestContext) {
  await findEmployeeInScope(prisma, user, employeeId);
  await assertUploaded(employeeId, 'document', body.fileKey);
  if (body.issueDate && body.expiryDate && body.expiryDate < body.issueDate) {
    throw Errors.validation([{ path: ['expiryDate'], message: 'Expiry is before issue date' }]);
  }

  let number = body.number.replace(/\s/g, '').toUpperCase();
  const employeeUpdate: Prisma.EmployeeUpdateInput = {};
  if (body.type === 'AADHAAR') {
    if (!/^(\d{4}|\d{12})$/.test(number)) throw Errors.validation([{ path: ['number'], message: 'Enter the last 4 digits of the Aadhaar number' }]);
    number = number.slice(-4);
    employeeUpdate.aadhaarLast4 = number;
  } else if (body.type === 'PAN') {
    if (!/^[A-Z]{5}[0-9]{4}[A-Z]$/.test(number)) throw Errors.validation([{ path: ['number'], message: 'Invalid PAN' }]);
    employeeUpdate.panEncrypted = encryptField(number, env.DATA_ENCRYPTION_KEY);
    employeeUpdate.panLast4 = number.slice(-4);
    number = `XXXXXX${number.slice(-4)}`;
  }

  const doc = await prisma.$transaction(async (tx) => {
    const created = await tx.document.create({
      data: {
        employeeId,
        type: body.type,
        number,
        licenceClass: body.licenceClass ?? null,
        issueDate: body.issueDate ? toDbDate(body.issueDate) : null,
        expiryDate: body.expiryDate ? toDbDate(body.expiryDate) : null,
        fileKey: body.fileKey,
        status: 'PENDING_VERIFICATION',
        createdById: ctx.user?.id ?? null,
      },
      include: docInclude,
    });
    if (Object.keys(employeeUpdate).length > 0) {
      const before = await tx.employee.findUniqueOrThrow({ where: { id: employeeId } });
      const after = await tx.employee.update({ where: { id: employeeId }, data: employeeUpdate });
      await audit.record(tx, ctx, { action: 'employee.update', entityType: 'Employee', entityId: employeeId, before, after });
    }
    await audit.record(tx, ctx, { action: 'document.create', entityType: 'Document', entityId: created.id, after: created });
    return created;
  });
  return toItem(doc, new Map());
}

export async function listDocuments(user: AuthUser, q: z.infer<typeof DocumentQuery>) {
  const today = toDbDate(todayIst());
  const scope = await scopeFor(prisma, user, 'documents', q.businessUnitId);
  const whereEmployee: Prisma.EmployeeWhereInput = {
    AND: [
      employeeWhere(user, scope),
      q.depotId ? { jobs: { some: { depotId: q.depotId, OR: [{ effectiveTo: null }, { effectiveTo: { gt: today } }] } } } : {},
    ],
  };
  const rows = await prisma.document.findMany({
    where: { employee: whereEmployee, ...(q.status ? { status: q.status } : {}), ...(q.type ? { type: q.type } : {}) },
    include: withEmployeeInclude,
    // Oldest first: the verification queue is worked FIFO.
    orderBy: [{ createdAt: 'asc' }, { id: 'asc' }],
    take: q.limit + 1,
    ...(q.cursor ? { cursor: { id: q.cursor }, skip: 1 } : {}),
  });
  const hasMore = rows.length > q.limit;
  const page = hasMore ? rows.slice(0, q.limit) : rows;
  const names = await verifierNames(page);
  return { items: page.map((r) => toItemWithEmployee(r, names)), nextCursor: hasMore ? (page[page.length - 1]?.id ?? null) : null };
}

export async function getDocument(user: AuthUser, id: string) {
  await findDocumentInScope(user, id);
  const row = await prisma.document.findUniqueOrThrow({ where: { id }, include: withEmployeeInclude });
  return toItemWithEmployee(row, await verifierNames([row]));
}

/**
 * Latest non-rejected document per (employee, type) that expires within `withinDays` (and optionally
 * those already expired and not renewed). Exited employees are left out.
 */
export async function expiringDocuments(user: AuthUser, q: z.infer<typeof ExpiringQuery>) {
  const today = todayIst();
  const until = toDbDate(addDays(today, q.withinDays));
  const scope = await scopeFor(prisma, user, 'documents', q.businessUnitId);
  const rows = await prisma.document.findMany({
    where: {
      status: { not: 'REJECTED' },
      expiryDate: { not: null, lte: until, ...(q.includeExpired ? {} : { gte: toDbDate(today) }) },
      employee: {
        AND: [
          { status: { not: 'EXITED' } },
          employeeWhere(user, scope),
          q.depotId ? { jobs: { some: { depotId: q.depotId, OR: [{ effectiveTo: null }, { effectiveTo: { gt: toDbDate(today) } }] } } } : {},
        ],
      },
    },
    include: withEmployeeInclude,
    orderBy: { expiryDate: 'asc' },
    take: 1000,
  });
  // Drop documents superseded by a renewal (a newer, non-rejected document of the same type).
  const renewals = await prisma.document.findMany({
    where: { status: { not: 'REJECTED' }, employeeId: { in: [...new Set(rows.map((r) => r.employeeId))] } },
    select: { employeeId: true, type: true, expiryDate: true, id: true },
  });
  const superseded = (d: DocWithEmployeeRow) =>
    renewals.some((r) => r.id !== d.id && r.employeeId === d.employeeId && r.type === d.type && (!r.expiryDate || r.expiryDate > d.expiryDate!));
  const names = await verifierNames(rows);
  return { items: rows.filter((r) => !superseded(r)).map((r) => toItemWithEmployee(r, names, today)) };
}

export async function verifyDocument(user: AuthUser, id: string, body: z.infer<typeof DocumentVerifyBody>, ctx: RequestContext) {
  await findDocumentInScope(user, id);
  await prisma.$transaction(async (tx) => {
    const before = await tx.document.findUniqueOrThrow({ where: { id } });
    if (before.status !== 'PENDING_VERIFICATION') {
      throw Errors.conflict('DOCUMENT_NOT_PENDING', `The document is already ${before.status.toLowerCase().replace('_', ' ')}`);
    }
    const expiry = body.expiryDate ?? fromDbDateOrNull(before.expiryDate);
    if (body.expiryDate && before.issueDate && body.expiryDate < fromDbDate(before.issueDate)) {
      throw Errors.validation([{ path: ['expiryDate'], message: 'Expiry is before issue date' }]);
    }
    const after = await tx.document.update({
      where: { id },
      data: {
        status: expiry && expiry < todayIst() ? 'EXPIRED' : 'VERIFIED',
        expiryDate: expiry ? toDbDate(expiry) : null,
        verifiedById: ctx.user?.id ?? null,
        verifiedAt: new Date(),
      },
    });
    await audit.record(tx, ctx, { action: 'document.verify', entityType: 'Document', entityId: id, before, after: { ...after, note: body.note } });
  });
  return getDocument(user, id);
}

export async function rejectDocument(user: AuthUser, id: string, body: z.infer<typeof DocumentRejectBody>, ctx: RequestContext) {
  await findDocumentInScope(user, id);
  const doc = await prisma.$transaction(async (tx) => {
    const before = await tx.document.findUniqueOrThrow({ where: { id } });
    if (before.status !== 'PENDING_VERIFICATION') {
      throw Errors.conflict('DOCUMENT_NOT_PENDING', `The document is already ${before.status.toLowerCase().replace('_', ' ')}`);
    }
    const after = await tx.document.update({
      where: { id },
      data: { status: 'REJECTED', rejectionReason: body.reason, verifiedById: ctx.user?.id ?? null, verifiedAt: null },
    });
    await audit.record(tx, ctx, { action: 'document.reject', entityType: 'Document', entityId: id, before, after });
    return after;
  });
  // Tell whoever captured it, so they can re-photograph.
  if (doc.createdById && doc.createdById !== ctx.user?.id) {
    const employee = await prisma.employee.findUniqueOrThrow({ where: { id: doc.employeeId }, select: { fullName: true, empCode: true } });
    await notify([doc.createdById], {
      type: 'DOCUMENT_REJECTED',
      title: 'Document rejected',
      body: `${employee.fullName} (${employee.empCode}) ${doc.type.replace(/_/g, ' ').toLowerCase()}: ${body.reason}`,
      entityType: 'EMPLOYEE',
      entityId: doc.employeeId,
      businessUnitId: await primaryBusinessUnitOf(prisma, doc.employeeId),
    });
  }
  return getDocument(user, id);
}

// ───────────────────────────── Requirements ─────────────────────────────

export async function listRequirements() {
  const rows = await prisma.documentRequirement.findMany({ orderBy: { documentType: 'asc' } });
  return {
    items: EMPLOYEE_CATEGORIES.map((category) => ({
      category,
      documentTypes: rows.filter((r) => r.category === category).map((r) => r.documentType),
    })),
  };
}

export async function setRequirements(category: EmployeeCategory, body: z.infer<typeof DocumentRequirementBody>, ctx: RequestContext) {
  // TODO(business): only masked Aadhaar may be held; confirm whether AADHAAR may be a required type at all.
  const types = [...new Set(body.documentTypes)];
  await prisma.$transaction(async (tx) => {
    const before = await tx.documentRequirement.findMany({ where: { category } });
    await tx.documentRequirement.deleteMany({ where: { category } });
    await tx.documentRequirement.createMany({ data: types.map((documentType) => ({ category, documentType, createdById: ctx.user?.id ?? null })) });
    await audit.record(tx, ctx, {
      action: 'documentRequirement.set',
      entityType: 'DocumentRequirement',
      entityId: category,
      before: before.map((b) => b.documentType),
      after: types,
    });
  });
  return { category, documentTypes: types };
}
