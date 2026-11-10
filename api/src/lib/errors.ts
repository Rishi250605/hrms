/**
 * Typed application error. Thrown from services; turned into
 * `{ error: { code, message, details } }` by the error middleware.
 */
export class AppError extends Error {
  constructor(
    public readonly code: string,
    public readonly httpStatus: number,
    message: string,
    public readonly details?: unknown,
  ) {
    super(message);
    this.name = 'AppError';
  }
}

export const Errors = {
  validation: (details: unknown) => new AppError('VALIDATION_ERROR', 400, 'Request validation failed', details),
  unauthenticated: (message = 'Authentication required') => new AppError('UNAUTHENTICATED', 401, message),
  invalidToken: () => new AppError('INVALID_TOKEN', 401, 'Access token is invalid or expired'),
  forbidden: (message = 'You do not have access to this resource') => new AppError('FORBIDDEN', 403, message),
  notFound: (entity = 'Resource') => new AppError('NOT_FOUND', 404, `${entity} not found`),
  conflict: (code: string, message: string, details?: unknown) => new AppError(code, 409, message, details),
  rateLimited: (message = 'Too many requests, please try again later') => new AppError('RATE_LIMITED', 429, message),
};
