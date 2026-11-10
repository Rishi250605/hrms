import { ModuleRouter } from '../../lib/route.js';
import { IdParams } from '../../lib/schemas.js';
import * as controller from './controller.js';
import { NotificationPage, NotificationQuery } from './schemas.js';

/** The signed-in manager's in-app notification feed (the same notices are pushed to their devices). */
export const notificationsRouter = new ModuleRouter('/notifications', 'Notifications')
  .route({
    method: 'get',
    path: '/',
    operationId: 'listMyNotifications',
    summary: 'My notifications, newest first',
    access: { roles: 'any' },
    query: NotificationQuery,
    response: { status: 200, description: 'A page of notifications', schema: NotificationPage },
    handler: controller.list,
  })
  .route({
    method: 'post',
    path: '/read-all',
    operationId: 'markAllNotificationsRead',
    summary: 'Mark all my notifications read',
    access: { roles: 'any' },
    response: { status: 204, description: 'Done' },
    handler: controller.markAllRead,
  })
  .route({
    method: 'post',
    path: '/:id/read',
    operationId: 'markNotificationRead',
    summary: 'Mark one notification read',
    access: { roles: 'any' },
    params: IdParams,
    response: { status: 204, description: 'Done' },
    handler: controller.markRead,
  });
