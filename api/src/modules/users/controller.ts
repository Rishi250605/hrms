import type { Request } from 'express';
import { contextOf } from '../../lib/context.js';
import { Errors } from '../../lib/errors.js';
import type { RouteInput } from '../../lib/route.js';
import type { IdParams } from '../../lib/schemas.js';
import type { ResetPasswordBody, UserCreateBody, UserListQuery, UserUpdateBody } from './schemas.js';
import * as usersService from './service.js';

const authUser = (req: Request) => {
  if (!req.user) throw Errors.unauthenticated();
  return req.user;
};

export const getMe = (_input: unknown, req: Request) => usersService.getMe(authUser(req));
export const list = (i: RouteInput<undefined, typeof UserListQuery, undefined>, req: Request) => usersService.listUsers(authUser(req), i.query);
export const create = (i: RouteInput<typeof UserCreateBody, undefined, undefined>, req: Request) => usersService.createUser(i.body, contextOf(req));
export const update = (i: RouteInput<typeof UserUpdateBody, undefined, typeof IdParams>, req: Request) => usersService.updateUser(i.params.id, i.body, contextOf(req));
export const resetPassword = (i: RouteInput<typeof ResetPasswordBody, undefined, typeof IdParams>, req: Request) =>
  usersService.resetPassword(i.params.id, i.body, contextOf(req));
export const unlock = (i: RouteInput<undefined, undefined, typeof IdParams>, req: Request) => usersService.unlockUser(i.params.id, contextOf(req));
