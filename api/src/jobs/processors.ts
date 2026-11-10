import { runDocumentExpiry, runEmployeeExits } from './documents.js';
import { runLeaveAccrual } from './leave.js';
import { purgeExpiredAuth } from './maintenance.js';
import type { MaintenanceJob } from './queues.js';

/** Job name → processor. Every processor is idempotent (safe to re-run after a crash or by hand). */
export const processors: Record<MaintenanceJob, () => Promise<unknown>> = {
  'purge-expired-auth': () => purgeExpiredAuth(),
  'document-expiry': () => runDocumentExpiry(),
  'employee-exits': () => runEmployeeExits(),
  'leave-accrual': () => runLeaveAccrual(),
};
