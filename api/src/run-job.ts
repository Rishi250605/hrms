/**
 * Runs scheduled jobs once, in order, without Redis/BullMQ (dev machines, ops re-runs, Render cron).
 * Usage: npm run job -- <name> [<name> ...]          (dev, tsx)
 *        npm run job:prod -- <name> [<name> ...]     (compiled)
 * A failing job is logged and the rest still run; the process exits 1 if any failed.
 */
import { processors } from './jobs/processors.js';
import type { MaintenanceJob } from './jobs/queues.js';
import { prisma } from './lib/prisma.js';

const names = process.argv.slice(2);
const unknown = names.filter((n) => !(n in processors));
if (names.length === 0 || unknown.length > 0) {
  if (unknown.length > 0) console.error(`Unknown job(s): ${unknown.join(', ')}`);
  console.error(`Usage: npm run job -- <${Object.keys(processors).join(' | ')}> [...]`);
  process.exit(1);
}

async function main() {
  for (const name of names as MaintenanceJob[]) {
    try {
      const result = await processors[name]();
      console.log(JSON.stringify({ job: name, result }));
    } catch (err: unknown) {
      console.error(JSON.stringify({ job: name, error: err instanceof Error ? err.message : String(err) }));
      console.error(err);
      process.exitCode = 1;
    }
  }
}

main().finally(() => prisma.$disconnect());
