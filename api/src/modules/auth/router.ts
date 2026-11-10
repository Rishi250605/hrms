import { ModuleRouter } from '../../lib/route.js';
import { loginAccountLimiter, loginIpLimiter } from '../../middleware/rateLimit.js';
import * as controller from './controller.js';
import { LoginBody, LogoutBody, RefreshBody, TokenPair } from './schemas.js';

export const authRouter = new ModuleRouter('/auth', 'Auth')
  .route({
    method: 'post',
    path: '/login',
    operationId: 'login',
    summary: 'Sign in with employee ID and password',
    description: 'Passwords are set by the director. After 5 failures in 15 minutes the account is locked for 15 minutes.',
    access: 'public',
    pre: [loginIpLimiter, loginAccountLimiter],
    body: LoginBody,
    response: { status: 200, description: 'Access + refresh tokens', schema: TokenPair },
    errors: { 401: 'Invalid employee ID or password (INVALID_CREDENTIALS)', 423: 'Account locked (ACCOUNT_LOCKED, details.minutes)', 429: 'Too many attempts' },
    handler: controller.login,
  })
  .route({
    method: 'post',
    path: '/refresh',
    operationId: 'refreshToken',
    summary: 'Rotate the refresh token and get a new access token',
    access: 'public',
    body: RefreshBody,
    response: { status: 200, description: 'New token pair (the old refresh token is now invalid)', schema: TokenPair },
    errors: { 401: 'Refresh token invalid, expired or re-used (INVALID_REFRESH_TOKEN)' },
    handler: controller.refresh,
  })
  .route({
    method: 'post',
    path: '/logout',
    operationId: 'logout',
    summary: 'End the session that the refresh token belongs to',
    access: 'public',
    body: LogoutBody,
    response: { status: 204, description: 'Logged out (idempotent)' },
    handler: controller.logout,
  });
