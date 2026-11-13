import { z } from 'zod';

/**
 * All configuration comes from environment variables, validated here once at startup.
 * Never read process.env anywhere else in the app.
 */
const csv = z
  .string()
  .default('')
  .transform((s) =>
    s
      .split(',')
      .map((x) => x.trim())
      .filter(Boolean),
  );

const base64Key32 = z
  .string()
  .refine((s) => Buffer.from(s, 'base64').length === 32, 'must be 32 bytes, base64-encoded');

export const EnvSchema = z
  .object({
    NODE_ENV: z.enum(['development', 'test', 'production']).default('development'),
    PORT: z.coerce.number().int().positive().default(3000),
    LOG_LEVEL: z.enum(['fatal', 'error', 'warn', 'info', 'debug', 'trace', 'silent']).default('info'),
    /** Trust X-Forwarded-For from this many proxy hops (for rate limiting / audit IPs). */
    TRUST_PROXY_HOPS: z.coerce.number().int().min(0).default(0),
    CORS_ORIGINS: csv,

    DATABASE_URL: z.string().min(1),
    REDIS_URL: z.string().default('redis://localhost:6379'),

    JWT_ACCESS_SECRET: z.string().min(32, 'JWT_ACCESS_SECRET must be at least 32 characters'),
    JWT_ISSUER: z.string().default('transport-hrms'),
    JWT_AUDIENCE: z.string().default('transport-hrms-app'),
    JWT_ACCESS_TTL_SECONDS: z.coerce.number().int().positive().default(15 * 60),
    REFRESH_TOKEN_TTL_DAYS: z.coerce.number().int().positive().default(30),

    /** HMAC key used to hash refresh tokens (and signed storage URLs) at rest. */
    TOKEN_HASH_PEPPER: z.string().min(32, 'TOKEN_HASH_PEPPER must be at least 32 characters'),
    /** Account lockout (PHASE-2-FEATURES §1.3): N failed passwords within the window lock the account. */
    LOGIN_MAX_FAILED_ATTEMPTS: z.coerce.number().int().positive().default(5),
    LOGIN_FAILURE_WINDOW_MINUTES: z.coerce.number().int().positive().default(15),
    LOGIN_LOCK_MINUTES: z.coerce.number().int().positive().default(15),
    /** AES-256-GCM key for PAN / bank account encryption (32 bytes, base64). */
    DATA_ENCRYPTION_KEY: base64Key32,

    MESSAGING_PROVIDER: z.enum(['console']).default('console'),

    /** Push notifications to managers: 'console' logs them, 'fcm' sends via FCM HTTP v1. */
    PUSH_PROVIDER: z.enum(['console', 'fcm']).default('console'),
    /** Firebase service-account JSON, base64-encoded (required when PUSH_PROVIDER=fcm). */
    FCM_SERVICE_ACCOUNT_B64: z.string().optional(),

    /**
     * Document storage. 's3' = any S3-compatible store (MinIO locally, S3 in production).
     * 'local' = files on disk served by the API itself (dev machines without MinIO; refused in production).
     */
    STORAGE_DRIVER: z.enum(['s3', 'local']).default('s3'),
    S3_ENDPOINT: z.string().optional(),
    S3_REGION: z.string().default('ap-south-1'),
    S3_BUCKET: z.string().default('hrms-documents'),
    S3_ACCESS_KEY_ID: z.string().optional(),
    S3_SECRET_ACCESS_KEY: z.string().optional(),
    S3_FORCE_PATH_STYLE: z
      .enum(['true', 'false'])
      .default('true')
      .transform((v) => v === 'true'),
    LOCAL_STORAGE_DIR: z.string().default('.storage'),
    /** Lifetime of signed upload/download URLs. CLAUDE.md §7: at most 10 minutes. */
    SIGNED_URL_TTL_SECONDS: z.coerce.number().int().positive().max(600).default(600),
    MAX_UPLOAD_BYTES: z.coerce.number().int().positive().default(10 * 1024 * 1024),
  })
  .superRefine((env, ctx) => {
    if (env.PUSH_PROVIDER === 'fcm' && !env.FCM_SERVICE_ACCOUNT_B64) {
      ctx.addIssue({ code: 'custom', path: ['FCM_SERVICE_ACCOUNT_B64'], message: 'required when PUSH_PROVIDER=fcm' });
    }
    if (env.NODE_ENV === 'production') {
      if (env.STORAGE_DRIVER === 'local') {
        ctx.addIssue({ code: 'custom', path: ['STORAGE_DRIVER'], message: 'local storage is not allowed in production' });
      }
      // MESSAGING_PROVIDER=console is allowed in production: nothing sends SMS/WhatsApp since OTP login
      // was removed in phase 2. TODO(business): refuse 'console' again once a real provider adapter exists.
    }
  });

export type Env = z.infer<typeof EnvSchema>;

export function parseEnv(source: NodeJS.ProcessEnv): Env {
  const result = EnvSchema.safeParse(source);
  if (!result.success) {
    const lines = result.error.issues.map((i) => `  - ${i.path.join('.')}: ${i.message}`).join('\n');
    throw new Error(`Invalid environment configuration:\n${lines}`);
  }
  return result.data;
}

export const env: Env = parseEnv(process.env);
