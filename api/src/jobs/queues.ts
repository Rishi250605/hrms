import { Queue } from 'bullmq';
import type { ConnectionOptions } from 'bullmq';
import { env } from '../config/env.js';

/** BullMQ connection from REDIS_URL. BullMQ requires maxRetriesPerRequest = null for workers. */
export function redisConnection(): ConnectionOptions {
  const url = new URL(env.REDIS_URL);
  return {
    host: url.hostname,
    port: Number(url.port || 6379),
    username: url.username || undefined,
    password: url.password || undefined,
    db: url.pathname.length > 1 ? Number(url.pathname.slice(1)) : 0,
    tls: url.protocol === 'rediss:' ? {} : undefined,
    maxRetriesPerRequest: null,
  };
}

/** Queue names. All scheduled jobs run on the maintenance queue (concurrency 1). */
export const QueueName = {
  maintenance: 'maintenance',
} as const;

export type MaintenanceJob = 'purge-expired-auth' | 'document-expiry' | 'employee-exits' | 'leave-accrual';

/** Repeatable schedules (cron in Asia/Kolkata). */
export const SCHEDULES: { id: string; job: MaintenanceJob; pattern: string }[] = [
  { id: 'purge-expired-auth-nightly', job: 'purge-expired-auth', pattern: '30 2 * * *' },
  { id: 'document-expiry-nightly', job: 'document-expiry', pattern: '15 0 * * *' },
  { id: 'employee-exits-nightly', job: 'employee-exits', pattern: '5 0 * * *' },
  { id: 'leave-accrual-monthly', job: 'leave-accrual', pattern: '30 0 1 * *' },
];

let maintenanceQueue: Queue | undefined;
export function getMaintenanceQueue(): Queue {
  maintenanceQueue ??= new Queue(QueueName.maintenance, { connection: redisConnection() });
  return maintenanceQueue;
}
