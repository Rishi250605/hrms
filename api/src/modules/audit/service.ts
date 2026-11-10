import type { RequestContext } from '../../lib/context.js';
import type { Db } from '../../lib/prisma.js';
import type { Prisma } from '../../generated/prisma/client.js';

/** Keys that must never be copied into the audit trail. */
const SECRET_KEYS = new Set([
  'codeHash',
  'tokenHash',
  'panEncrypted',
  'bankAccountEncrypted',
  'password',
  'refreshToken',
  'accessToken',
]);

/** JSON-safe, secret-free snapshot (Dates → ISO strings, BigInt → string). */
export function snapshot(value: unknown): Prisma.InputJsonValue | undefined {
  if (value === undefined || value === null) return undefined;
  const json = JSON.stringify(value, (key, v: unknown) => {
    if (SECRET_KEYS.has(key)) return '[redacted]';
    if (typeof v === 'bigint') return v.toString();
    return v;
  });
  return JSON.parse(json) as Prisma.InputJsonValue;
}

export interface AuditEntry {
  /** Overrides the actor from the context (e.g. on login, before the request is authenticated). */
  actorUserId?: string;
  /** e.g. "user.create", "auth.login", "depot.update" */
  action: string;
  entityType: string;
  entityId: string;
  before?: unknown;
  after?: unknown;
}

/**
 * Records an audit entry. Call with the transaction client (`tx`) of the write being audited
 * so the entry commits or rolls back together with it (CLAUDE.md §5).
 */
export async function record(db: Db, ctx: RequestContext, entry: AuditEntry): Promise<void> {
  await db.auditLog.create({
    data: {
      actorUserId: entry.actorUserId ?? ctx.user?.id ?? null,
      action: entry.action,
      entityType: entry.entityType,
      entityId: entry.entityId,
      before: snapshot(entry.before),
      after: snapshot(entry.after),
      requestId: ctx.requestId,
      ip: ctx.ip,
    },
  });
}

export const audit = { record };
