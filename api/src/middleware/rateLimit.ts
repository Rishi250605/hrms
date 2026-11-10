import { rateLimit, ipKeyGenerator } from 'express-rate-limit';
import type { NextFunction, Request, Response } from 'express';
import { env } from '../config/env.js';
import { AppError } from '../lib/errors.js';

// In-memory stores are fine for a single API instance.
// TODO(infra): switch to a Redis store (rate-limit-redis) before running more than one API replica.

const handler = (_req: Request, _res: Response, next: NextFunction, options: { message: unknown }) => {
  next(new AppError('RATE_LIMITED', 429, String(options.message)));
};

const skipInTest = () => env.NODE_ENV === 'test';

/** General API limiter per IP. */
export const apiLimiter = rateLimit({
  windowMs: 60_000,
  limit: 600,
  standardHeaders: 'draft-8',
  legacyHeaders: false,
  skip: skipInTest,
  message: 'Too many requests, please slow down',
  handler,
});

/** Login: per IP (account lockout after failed passwords is enforced in the database). */
export const loginIpLimiter = rateLimit({
  windowMs: 15 * 60_000,
  limit: 50,
  standardHeaders: 'draft-8',
  legacyHeaders: false,
  skip: skipInTest,
  message: 'Too many sign-in attempts from this network, try again later',
  handler,
});

/** Login: per employee ID (also applies to unknown IDs, so they behave like known ones). */
export const loginAccountLimiter = rateLimit({
  windowMs: 15 * 60_000,
  limit: 20,
  standardHeaders: 'draft-8',
  legacyHeaders: false,
  skip: skipInTest,
  keyGenerator: (req) => {
    const raw = (req.body as { empCode?: unknown } | undefined)?.empCode;
    return typeof raw === 'string' && raw.trim() ? `emp:${raw.trim().toUpperCase()}` : `ip:${ipKeyGenerator(req.ip ?? '')}`;
  },
  message: 'Too many sign-in attempts for this employee ID, try again later',
  handler,
});
