import type { ErrorRequestHandler, RequestHandler } from 'express';
import { ZodError } from 'zod';
import { AppError } from '../lib/errors.js';
import { logger } from '../lib/logger.js';
import { Prisma } from '../generated/prisma/client.js';

interface ErrorBody {
  error: { code: string; message: string; details?: unknown };
}

function toAppError(err: unknown): AppError | null {
  if (err instanceof AppError) return err;
  if (err instanceof ZodError) {
    return new AppError('VALIDATION_ERROR', 400, 'Request validation failed', err.issues);
  }
  // body-parser errors (malformed JSON, payload too large)
  if (typeof err === 'object' && err !== null && 'type' in err && 'status' in err) {
    const e = err as { type: string; status: number };
    if (e.type === 'entity.parse.failed') return new AppError('MALFORMED_JSON', 400, 'Request body is not valid JSON');
    if (e.type === 'entity.too.large') return new AppError('PAYLOAD_TOO_LARGE', 413, 'Request body is too large');
  }
  if (err instanceof Prisma.PrismaClientKnownRequestError) {
    if (err.code === 'P2002') {
      return new AppError('UNIQUE_CONSTRAINT', 409, 'A record with these values already exists', {
        target: err.meta?.target,
      });
    }
    if (err.code === 'P2025') return new AppError('NOT_FOUND', 404, 'Record not found');
  }
  return null;
}

export const errorHandler: ErrorRequestHandler = (err, req, res, _next) => {
  const appError = toAppError(err);
  if (appError) {
    if (appError.httpStatus >= 500) req.log?.error({ err }, appError.message);
    const body: ErrorBody = { error: { code: appError.code, message: appError.message } };
    if (appError.details !== undefined) body.error.details = appError.details;
    res.status(appError.httpStatus).json(body);
    return;
  }
  (req.log ?? logger).error({ err }, 'Unhandled error');
  const body: ErrorBody = { error: { code: 'INTERNAL_ERROR', message: 'Something went wrong' } };
  res.status(500).json(body);
};

export const notFoundHandler: RequestHandler = (req, res) => {
  const body: ErrorBody = { error: { code: 'ROUTE_NOT_FOUND', message: `No route for ${req.method} ${req.path}` } };
  res.status(404).json(body);
};
