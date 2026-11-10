import { diffDays, fromDbDate, todayIst } from '../../lib/dates.js';
import type { Db } from '../../lib/prisma.js';
import type { DocumentStatus, DocumentType, EmployeeCategory } from '../../generated/prisma/enums.js';
import { getSetting } from '../settings/service.js';

/**
 * Document validity for rostering (CLAUDE.md §7): an employee may be assigned to a duty on a date only
 * when every document required for their category is present, verified and not expired on that date.
 */
export type ComplianceStateT = 'VALID' | 'EXPIRING' | 'UNVERIFIED' | 'EXPIRED' | 'REJECTED' | 'MISSING';
export type ComplianceOverallT = 'OK' | 'EXPIRING' | 'PENDING_VERIFICATION' | 'EXPIRED' | 'MISSING';

export interface DocLike {
  id: string;
  type: DocumentType;
  status: DocumentStatus;
  issueDate: Date | null;
  expiryDate: Date | null;
  verifiedAt: Date | null;
}

export interface ComplianceItemT {
  type: DocumentType;
  state: ComplianceStateT;
  documentId: string | null;
  expiryDate: string | null;
}

export interface ComplianceT {
  asOf: string;
  overall: ComplianceOverallT;
  rosterable: boolean;
  items: ComplianceItemT[];
}

const SEVERITY: ComplianceOverallT[] = ['OK', 'EXPIRING', 'PENDING_VERIFICATION', 'EXPIRED', 'MISSING'];
const toOverall: Record<ComplianceStateT, ComplianceOverallT> = {
  VALID: 'OK',
  EXPIRING: 'EXPIRING',
  UNVERIFIED: 'PENDING_VERIFICATION',
  EXPIRED: 'EXPIRED',
  REJECTED: 'MISSING',
  MISSING: 'MISSING',
};

/** True if the document was verified and its validity window covers `date`. */
function coversDate(d: DocLike, date: string): boolean {
  if (!d.verifiedAt || d.status === 'REJECTED') return false;
  if (d.issueDate && fromDbDate(d.issueDate) > date) return false;
  return !d.expiryDate || fromDbDate(d.expiryDate) >= date;
}

/**
 * Pure evaluation of one required document type on `date`. `expiringWithinDays` turns a valid document
 * that expires soon into EXPIRING (still rosterable).
 */
export function evaluateType(type: DocumentType, docs: DocLike[], date: string, expiringWithinDays: number): ComplianceItemT {
  const ofType = docs.filter((d) => d.type === type);
  const valid = ofType
    .filter((d) => coversDate(d, date))
    // Prefer the one valid longest (null expiry = no expiry).
    .sort((a, b) => (b.expiryDate?.getTime() ?? Infinity) - (a.expiryDate?.getTime() ?? Infinity))[0];
  if (valid) {
    const expiry = valid.expiryDate ? fromDbDate(valid.expiryDate) : null;
    const expiring = expiry !== null && diffDays(date, expiry) <= expiringWithinDays;
    return { type, state: expiring ? 'EXPIRING' : 'VALID', documentId: valid.id, expiryDate: expiry };
  }
  const pending = ofType.find((d) => d.status === 'PENDING_VERIFICATION' && (!d.expiryDate || fromDbDate(d.expiryDate) >= date));
  if (pending) return { type, state: 'UNVERIFIED', documentId: pending.id, expiryDate: pending.expiryDate ? fromDbDate(pending.expiryDate) : null };
  const expired = ofType
    .filter((d) => d.status !== 'REJECTED' && d.expiryDate && fromDbDate(d.expiryDate) < date)
    .sort((a, b) => b.expiryDate!.getTime() - a.expiryDate!.getTime())[0];
  if (expired) return { type, state: 'EXPIRED', documentId: expired.id, expiryDate: fromDbDate(expired.expiryDate!) };
  const rejected = ofType.find((d) => d.status === 'REJECTED');
  if (rejected) return { type, state: 'REJECTED', documentId: rejected.id, expiryDate: null };
  return { type, state: 'MISSING', documentId: null, expiryDate: null };
}

export function evaluateCompliance(required: DocumentType[], docs: DocLike[], date: string, expiringWithinDays: number): ComplianceT {
  const items = required.map((t) => evaluateType(t, docs, date, expiringWithinDays));
  const overall = items.reduce<ComplianceOverallT>((worst, i) => {
    const o = toOverall[i.state];
    return SEVERITY.indexOf(o) > SEVERITY.indexOf(worst) ? o : worst;
  }, 'OK');
  return { asOf: date, overall, rosterable: items.every((i) => i.state === 'VALID' || i.state === 'EXPIRING'), items };
}

/** Required document types per category (DocumentRequirement config). */
export async function requiredTypesByCategory(db: Db): Promise<Map<EmployeeCategory, DocumentType[]>> {
  const rows = await db.documentRequirement.findMany({ orderBy: { documentType: 'asc' } });
  const map = new Map<EmployeeCategory, DocumentType[]>();
  for (const r of rows) map.set(r.category, [...(map.get(r.category) ?? []), r.documentType]);
  return map;
}

/** Batched compliance for many employees on one date (one query for requirements, one for documents). */
export async function complianceFor(
  db: Db,
  employees: { id: string; category: EmployeeCategory }[],
  date: string = todayIst(),
): Promise<Map<string, ComplianceT>> {
  const result = new Map<string, ComplianceT>();
  if (employees.length === 0) return result;
  // Sequential on purpose: db may be an interactive transaction (one connection).
  const required = await requiredTypesByCategory(db);
  const alertDays = await getSetting('documents.expiryAlertDays', db);
  const window = Math.max(...alertDays);
  const types = [...new Set([...required.values()].flat())];
  const docs = types.length
    ? await db.document.findMany({
        where: { employeeId: { in: employees.map((e) => e.id) }, type: { in: types } },
        select: { id: true, employeeId: true, type: true, status: true, issueDate: true, expiryDate: true, verifiedAt: true },
      })
    : [];
  const byEmployee = new Map<string, DocLike[]>();
  for (const d of docs) byEmployee.set(d.employeeId, [...(byEmployee.get(d.employeeId) ?? []), d]);
  for (const e of employees) {
    result.set(e.id, evaluateCompliance(required.get(e.category) ?? [], byEmployee.get(e.id) ?? [], date, window));
  }
  return result;
}
