import type { RequestHandler } from 'express';
import { Errors } from '../lib/errors.js';
import type { Role } from '../generated/prisma/enums.js';

/** Allows the request only if the authenticated user has one of `roles`. Must run after `authenticate`. */
export function requireRole(...roles: Role[]): RequestHandler {
  if (roles.length === 0) throw new Error('requireRole needs at least one role');
  return (req, _res, next) => {
    if (!req.user) throw Errors.unauthenticated();
    if (!roles.includes(req.user.role)) throw Errors.forbidden();
    next();
  };
}
