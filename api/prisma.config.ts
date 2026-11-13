import 'dotenv/config';
import { defineConfig } from 'prisma/config';

export default defineConfig({
  schema: 'prisma/schema.prisma',
  migrations: {
    path: 'prisma/migrations',
    seed: 'tsx prisma/seed.ts',
  },
  datasource: {
    // Not using env() so `prisma generate` works without a database configured (e.g. fresh clone, CI lint job).
    // DIRECT_URL = the non-pooled endpoint (Neon); migrations need session-level advisory locks,
    // which a transaction-mode pooler does not provide. The app itself uses DATABASE_URL (pooled).
    url: process.env.DIRECT_URL ?? process.env.DATABASE_URL ?? 'postgresql://unset:unset@localhost:5432/unset',
  },
});
