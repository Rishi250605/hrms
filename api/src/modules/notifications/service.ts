import { logger } from '../../lib/logger.js';
import { prisma } from '../../lib/prisma.js';
import type { Db } from '../../lib/prisma.js';
import { getPushService } from '../../lib/push.js';
import type { Role } from '../../generated/prisma/enums.js';

/** A notification (PHASE-2-FEATURES §10): stored in the in-app feed and pushed to the recipient's devices. */
export interface Notice {
  /** e.g. ATTENDANCE_SUBMITTED, LEAVE_DECIDED, TASK_ALLOTTED */
  type: string;
  title: string;
  body: string;
  /** What tapping it opens. */
  entityType?: string;
  entityId?: string;
  businessUnitId: string;
}

/**
 * Notifies users. Call AFTER the triggering transaction commits; failures are logged, never thrown.
 * Duplicate recipients and `exclude` (usually the actor) are skipped.
 */
export async function notify(userIds: (string | null | undefined)[], notice: Notice, exclude?: string): Promise<void> {
  const unique = [...new Set(userIds.filter((u): u is string => !!u && u !== exclude))];
  const push = getPushService();
  for (const recipientUserId of unique) {
    try {
      const devices = await prisma.deviceToken.findMany({ where: { userId: recipientUserId }, select: { token: true } });
      let pushStatus: 'STORED' | 'SENT' | 'FAILED' = 'STORED';
      if (devices.length > 0) {
        try {
          const res = await push.send(
            devices.map((d) => d.token),
            {
              title: notice.title,
              body: notice.body,
              data: { type: notice.type, entityType: notice.entityType ?? '', entityId: notice.entityId ?? '', businessUnitId: notice.businessUnitId },
            },
          );
          if (res.invalidTokens.length > 0) await prisma.deviceToken.deleteMany({ where: { token: { in: res.invalidTokens } } });
          pushStatus = res.sent > 0 ? 'SENT' : 'FAILED';
        } catch {
          pushStatus = 'FAILED';
        }
      }
      await prisma.notification.create({
        data: {
          recipientUserId,
          type: notice.type,
          title: notice.title,
          body: notice.body,
          entityType: notice.entityType ?? null,
          entityId: notice.entityId ?? null,
          businessUnitId: notice.businessUnitId,
          pushStatus,
        },
      });
    } catch (err) {
      logger.error({ err, recipientUserId, type: notice.type }, 'Failed to notify user');
    }
  }
}

// ───────────────────────────── Recipients ─────────────────────────────

/** Login (user id) of an employee, if active. */
export async function userIdOfEmployee(db: Db, employeeId: string | null | undefined): Promise<string | null> {
  if (!employeeId) return null;
  const u = await db.user.findUnique({ where: { employeeId }, select: { id: true, isActive: true } });
  return u?.isActive ? u.id : null;
}

/** Active users of a role who belong to the business unit (directors: all directors). */
export async function usersInBusinessUnit(db: Db, role: Role, businessUnitId: string): Promise<string[]> {
  const rows = await db.user.findMany({
    where: { role, isActive: true, ...(role === 'DIRECTOR' ? {} : { employee: { businessUnits: { some: { businessUnitId } } } }) },
    select: { id: true },
  });
  return rows.map((r) => r.id);
}

export const hrOf = (db: Db, businessUnitId: string) => usersInBusinessUnit(db, 'HR', businessUnitId);
export const directorsOf = (db: Db) => usersInBusinessUnit(db, 'DIRECTOR', '');

// ───────────────────────────── Feed ─────────────────────────────

export async function listMyNotifications(
  userId: string,
  q: { cursor?: string | undefined; limit: number; unreadOnly?: boolean | undefined; businessUnitId?: string | undefined },
) {
  const where = { recipientUserId: userId, ...(q.unreadOnly ? { readAt: null } : {}), ...(q.businessUnitId ? { businessUnitId: q.businessUnitId } : {}) };
  const rows = await prisma.notification.findMany({
    where,
    orderBy: [{ createdAt: 'desc' }, { id: 'desc' }],
    take: q.limit + 1,
    ...(q.cursor ? { cursor: { id: q.cursor }, skip: 1 } : {}),
  });
  const unreadCount = await prisma.notification.count({ where: { recipientUserId: userId, readAt: null } });
  const hasMore = rows.length > q.limit;
  const page = hasMore ? rows.slice(0, q.limit) : rows;
  return {
    unreadCount,
    nextCursor: hasMore ? (page[page.length - 1]?.id ?? null) : null,
    items: page.map((n) => ({
      id: n.id,
      type: n.type,
      title: n.title,
      body: n.body,
      entityType: n.entityType,
      entityId: n.entityId,
      businessUnitId: n.businessUnitId,
      createdAt: n.createdAt.toISOString(),
      readAt: n.readAt?.toISOString() ?? null,
    })),
  };
}

export async function markRead(userId: string, id: string | 'all'): Promise<void> {
  await prisma.notification.updateMany({ where: { recipientUserId: userId, readAt: null, ...(id === 'all' ? {} : { id }) }, data: { readAt: new Date() } });
}

export async function registerDevice(userId: string, token: string, platform: string): Promise<void> {
  await prisma.deviceToken.upsert({ where: { token }, create: { userId, token, platform }, update: { userId, platform, lastSeenAt: new Date() } });
}

export async function unregisterDevice(userId: string, token: string): Promise<void> {
  await prisma.deviceToken.deleteMany({ where: { token, userId } });
}
