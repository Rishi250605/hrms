import { pino } from 'pino';
import { env } from '../config/env.js';

export const logger = pino({
  level: env.NODE_ENV === 'test' ? 'silent' : env.LOG_LEVEL,
  base: { service: 'hrms-api' },
  redact: {
    // Never log credentials or personal financial data.
    paths: [
      'req.headers.authorization',
      'req.headers.cookie',
      '*.code',
      '*.refreshToken',
      '*.accessToken',
      '*.pan',
      '*.bankAccount',
    ],
    censor: '[redacted]',
  },
  timestamp: pino.stdTimeFunctions.isoTime,
});

export type Logger = typeof logger;
