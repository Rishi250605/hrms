/**
 * Integration test global setup: applies migrations to the TEST database.
 * Requires TEST_DATABASE_URL (see .env.example). The database is created if it does not exist.
 */
import { execSync } from 'node:child_process';
import { config } from 'dotenv';

export default function setup() {
  config({ quiet: true });
  const url = process.env.TEST_DATABASE_URL;
  if (!url) {
    throw new Error(
      'TEST_DATABASE_URL is not set. Integration tests need a dedicated Postgres database ' +
        '(e.g. postgresql://hrms:hrms@localhost:5432/hrms_test). Set it in api/.env or the environment.',
    );
  }
  if (process.env.DATABASE_URL && url === process.env.DATABASE_URL) {
    throw new Error('TEST_DATABASE_URL must differ from DATABASE_URL — integration tests truncate tables.');
  }
  execSync('npx prisma migrate deploy', {
    stdio: 'inherit',
    env: { ...process.env, DATABASE_URL: url },
  });
}
