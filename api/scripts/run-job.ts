/**
 * Runs a scheduled job once, without Redis/BullMQ (handy on dev machines and for ops re-runs).
 * Usage: npm run job -- <name>    e.g. npm run job -- document-expiry
 */
import { processors } from '../src/jobs/processors.js';
import type { MaintenanceJob } from '../src/jobs/queues.js';
import { prisma } from '../src/lib/prisma.js';

const name = process.argv[2] as MaintenanceJob | undefined;
const run = name ? processors[name] : undefined;
if (!run) {
  console.error(`Usage: npm run job -- <${Object.keys(processors).join(' | ')}>`);
  process.exit(1);
}

run()
  .then((result) => console.log(JSON.stringify({ job: name, result })))
  .catch((err: unknown) => {
    console.error(err);
    process.exitCode = 1;
  })
  .finally(() => prisma.$disconnect());
