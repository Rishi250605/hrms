/**
 * Test environment. Runs before every test file (unit + integration).
 * Integration tests ALWAYS use TEST_DATABASE_URL — never the development DATABASE_URL —
 * because they truncate tables.
 */
import { tmpdir } from 'node:os';
import { join } from 'node:path';
import { config } from 'dotenv';

config({ quiet: true });

process.env.NODE_ENV = 'test';
process.env.DATABASE_URL = process.env.TEST_DATABASE_URL ?? 'postgresql://hrms:hrms@localhost:5432/hrms_test';
process.env.JWT_ACCESS_SECRET = 'test-access-secret-0123456789-0123456789';
process.env.TOKEN_HASH_PEPPER = 'test-token-pepper-0123456789-0123456789';
process.env.DATA_ENCRYPTION_KEY = Buffer.alloc(32, 7).toString('base64');
process.env.MESSAGING_PROVIDER = 'console';
process.env.PUSH_PROVIDER = 'console';
process.env.STORAGE_DRIVER = 'local';
process.env.LOCAL_STORAGE_DIR = join(tmpdir(), 'hrms-test-storage');
process.env.LOG_LEVEL = process.env.LOG_LEVEL ?? 'silent';
process.env.LOGIN_MAX_FAILED_ATTEMPTS = '5';
