import { describe, expect, it } from 'vitest';
import { parseEnv } from './env.js';

const valid = {
  DATABASE_URL: 'postgresql://x:y@localhost:5432/db',
  JWT_ACCESS_SECRET: 'a'.repeat(32),
  TOKEN_HASH_PEPPER: 'b'.repeat(32),
  DATA_ENCRYPTION_KEY: Buffer.alloc(32).toString('base64'),
};

describe('parseEnv', () => {
  it('applies defaults', () => {
    const env = parseEnv({ ...valid });
    expect(env.PORT).toBe(3000);
    expect(env.LOGIN_MAX_FAILED_ATTEMPTS).toBe(5);
    expect(env.LOGIN_LOCK_MINUTES).toBe(15);
    expect(env.CORS_ORIGINS).toEqual([]);
  });

  it('rejects short secrets and bad keys', () => {
    expect(() => parseEnv({ ...valid, JWT_ACCESS_SECRET: 'short' })).toThrow(/JWT_ACCESS_SECRET/);
    expect(() => parseEnv({ ...valid, DATA_ENCRYPTION_KEY: 'abc' })).toThrow(/DATA_ENCRYPTION_KEY/);
  });

  it('refuses dev-only settings in production', () => {
    expect(() => parseEnv({ ...valid, NODE_ENV: 'production', STORAGE_DRIVER: 'local' })).toThrow(/STORAGE_DRIVER/);
    // Console messaging is allowed in production (nothing sends messages since phase 2).
    expect(parseEnv({ ...valid, NODE_ENV: 'production', MESSAGING_PROVIDER: 'console' }).MESSAGING_PROVIDER).toBe('console');
  });

  it('parses CORS origins as a list', () => {
    expect(parseEnv({ ...valid, CORS_ORIGINS: 'http://a.test, http://b.test' }).CORS_ORIGINS).toEqual(['http://a.test', 'http://b.test']);
  });
});
