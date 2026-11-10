import { Worker } from 'bullmq';
import { processors } from './jobs/processors.js';
import { getMaintenanceQueue, QueueName, redisConnection, SCHEDULES } from './jobs/queues.js';
import type { MaintenanceJob } from './jobs/queues.js';
import { logger } from './lib/logger.js';
import { prisma } from './lib/prisma.js';

/**
 * BullMQ worker entry point. Runs scheduled (repeatable) jobs.
 * Times are in Asia/Kolkata (CLAUDE.md §5: business dates are IST).
 */
async function main() {
  const maintenance = getMaintenanceQueue();
  for (const s of SCHEDULES) {
    await maintenance.upsertJobScheduler(s.id, { pattern: s.pattern, tz: 'Asia/Kolkata' }, { name: s.job });
  }

  const worker = new Worker(
    QueueName.maintenance,
    async (job) => {
      const run = processors[job.name as MaintenanceJob];
      if (!run) throw new Error(`Unknown maintenance job: ${job.name}`);
      return run();
    },
    { connection: redisConnection(), concurrency: 1 },
  );

  worker.on('completed', (job) => logger.info({ jobId: job.id, name: job.name }, 'Job completed'));
  worker.on('failed', (job, err) => logger.error({ jobId: job?.id, name: job?.name, err }, 'Job failed'));
  logger.info({ schedules: SCHEDULES.map((s) => s.id) }, 'Worker started');

  const shutdown = async () => {
    await worker.close();
    await maintenance.close();
    await prisma.$disconnect();
    process.exit(0);
  };
  process.on('SIGINT', () => void shutdown());
  process.on('SIGTERM', () => void shutdown());
}

main().catch((err: unknown) => {
  logger.fatal({ err }, 'Worker failed to start');
  process.exit(1);
});
