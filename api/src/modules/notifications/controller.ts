import type { Request } from 'express';
import { Errors } from '../../lib/errors.js';
import type { RouteInput } from '../../lib/route.js';
import type { IdParams } from '../../lib/schemas.js';
import type { DeviceRegisterBody, DeviceUnregisterBody, NotificationQuery } from './schemas.js';
import * as service from './service.js';

const userId = (req: Request) => {
  if (!req.user) throw Errors.unauthenticated();
  return req.user.id;
};

export const list = (input: RouteInput<undefined, typeof NotificationQuery, undefined>, req: Request) =>
  service.listMyNotifications(userId(req), input.query);

export const markRead = (input: RouteInput<undefined, undefined, typeof IdParams>, req: Request) => service.markRead(userId(req), input.params.id);

export const markAllRead = (_input: unknown, req: Request) => service.markRead(userId(req), 'all');

export const registerDevice = (input: RouteInput<typeof DeviceRegisterBody, undefined, undefined>, req: Request) =>
  service.registerDevice(userId(req), input.body.token, input.body.platform);

export const unregisterDevice = (input: RouteInput<typeof DeviceUnregisterBody, undefined, undefined>, req: Request) =>
  service.unregisterDevice(userId(req), input.body.token);
