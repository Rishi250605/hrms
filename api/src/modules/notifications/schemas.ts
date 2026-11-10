import { registry, z } from '../../lib/openapi.js';
import { PageQuery, QueryBool } from '../../lib/schemas.js';

export const NotificationItem = registry.register(
  'NotificationItem',
  z.object({
    id: z.uuid(),
    type: z.string(),
    title: z.string(),
    body: z.string(),
    entityType: z.string().nullable().openapi({ description: 'ATTENDANCE, CORRECTION, LEAVE, ALLOWANCE, PAYSLIP, TASK, DOCUMENT, USER' }),
    entityId: z.string().nullable(),
    businessUnitId: z.uuid(),
    createdAt: z.string().datetime(),
    readAt: z.string().datetime().nullable(),
  }),
);

export const NotificationPage = registry.register(
  'NotificationPage',
  z.object({ items: z.array(NotificationItem), nextCursor: z.uuid().nullable(), unreadCount: z.number().int() }),
);

export const NotificationQuery = PageQuery.extend({ unreadOnly: QueryBool.optional(), businessUnitId: z.uuid().optional() });

export const DeviceRegisterBody = registry.register(
  'DeviceRegisterBody',
  z.object({ token: z.string().min(10).max(4096), platform: z.enum(['android', 'ios', 'web']) }),
);

export const DeviceUnregisterBody = registry.register('DeviceUnregisterBody', z.object({ token: z.string().min(10).max(4096) }));
