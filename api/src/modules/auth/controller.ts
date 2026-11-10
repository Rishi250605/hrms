import type { Request } from 'express';
import { contextOf } from '../../lib/context.js';
import type { RouteInput } from '../../lib/route.js';
import type { LoginBody, LogoutBody, RefreshBody } from './schemas.js';
import * as authService from './service.js';

export const login = (input: RouteInput<typeof LoginBody, undefined, undefined>, req: Request) =>
  authService.login(input.body.empCode, input.body.password, contextOf(req));

export const refresh = (input: RouteInput<typeof RefreshBody, undefined, undefined>, req: Request) => authService.refresh(input.body.refreshToken, contextOf(req));

export const logout = (input: RouteInput<typeof LogoutBody, undefined, undefined>) => authService.logout(input.body.refreshToken);
