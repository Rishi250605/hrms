import { ModuleRouter } from '../../lib/route.js';
import type { RouteAccess } from '../../lib/route.js';
import { IdParams } from '../../lib/schemas.js';
import * as notifications from '../notifications/controller.js';
import { DeviceRegisterBody, DeviceUnregisterBody } from '../notifications/schemas.js';
import * as controller from './controller.js';
import { MeResponse, ResetPasswordBody, UserCreateBody, UserItem, UserList, UserListQuery, UserUpdateBody } from './schemas.js';

const director: RouteAccess = { roles: ['DIRECTOR'] };

export const meRouter = new ModuleRouter('/me', 'Users')
  .route({
    method: 'get',
    path: '/',
    operationId: 'getMe',
    summary: 'My profile: employee ID, role, reporting-to, business units',
    access: { roles: 'any' },
    response: { status: 200, description: 'The signed-in user', schema: MeResponse },
    handler: controller.getMe,
  })
  .route({
    method: 'post',
    path: '/devices',
    operationId: 'registerDevice',
    summary: 'Register this device for push notifications (FCM token)',
    access: { roles: 'any' },
    body: DeviceRegisterBody,
    response: { status: 204, description: 'Registered' },
    handler: notifications.registerDevice,
  })
  .route({
    method: 'post',
    path: '/devices/unregister',
    operationId: 'unregisterDevice',
    summary: 'Stop push notifications to this device (call on logout)',
    access: { roles: 'any' },
    body: DeviceUnregisterBody,
    response: { status: 204, description: 'Unregistered' },
    handler: notifications.unregisterDevice,
  });

export const usersRouter = new ModuleRouter('/users', 'Users')
  .route({
    method: 'get',
    path: '/',
    operationId: 'listUsers',
    summary: 'Logins in my business units (HR uses it to pick reporting managers)',
    access: { roles: ['DIRECTOR', 'HR', 'OPERATIONAL_MANAGER'] },
    query: UserListQuery,
    response: { status: 200, description: 'A page of users', schema: UserList },
    errors: { 403: 'Not your business unit' },
    handler: controller.list,
  })
  .route({
    method: 'post',
    path: '/',
    operationId: 'createUser',
    summary: 'Create a login (new employee, or an existing one being promoted) with an initial password',
    access: director,
    body: UserCreateBody,
    response: { status: 201, description: 'Created', schema: UserItem },
    errors: { 404: 'Business unit, depot or employee not found', 409: 'Employee ID or phone already used', 422: 'INVALID_REPORTING_LINE or INVALID_EMP_CODE' },
    handler: controller.create,
  })
  .route({
    method: 'patch',
    path: '/:id',
    operationId: 'updateUser',
    summary: 'Update, deactivate or reactivate a login',
    access: director,
    params: IdParams,
    body: UserUpdateBody,
    response: { status: 200, description: 'Updated', schema: UserItem },
    errors: { 404: 'Not found', 409: 'Would deactivate yourself (SELF_LOCKOUT)' },
    handler: controller.update,
  })
  .route({
    method: 'post',
    path: '/:id/reset-password',
    operationId: 'resetUserPassword',
    summary: "Set a user's password (revokes their sessions and clears any lockout)",
    access: director,
    params: IdParams,
    body: ResetPasswordBody,
    response: { status: 200, description: 'Password set', schema: UserItem },
    errors: { 404: 'Not found' },
    handler: controller.resetPassword,
  })
  .route({
    method: 'post',
    path: '/:id/unlock',
    operationId: 'unlockUser',
    summary: 'Unlock an account locked after failed sign-ins',
    access: director,
    params: IdParams,
    response: { status: 200, description: 'Unlocked', schema: UserItem },
    errors: { 404: 'Not found' },
    handler: controller.unlock,
  });
