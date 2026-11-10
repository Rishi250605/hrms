import cors from 'cors';
import express from 'express';
import helmet from 'helmet';
import { pinoHttp } from 'pino-http';
import { env } from './config/env.js';
import { logger } from './lib/logger.js';
import { API_BASE_PATH } from './lib/openapi.js';
import { errorHandler, notFoundHandler } from './middleware/errorHandler.js';
import { apiLimiter } from './middleware/rateLimit.js';
import { requestId } from './middleware/requestId.js';
import { allowancesRouter, allowanceTypesRouter } from './modules/allowances/router.js';
import { attendanceRouter } from './modules/attendance/router.js';
import { authRouter } from './modules/auth/router.js';
import { healthRouter } from './modules/health/router.js';
import { documentRequirementsRouter, documentsRouter, employeesRouter, uploadsRouter } from './modules/employees/router.js';
import { dutyTemplatesRouter, routesRouter, vehiclesRouter } from './modules/fleet/router.js';
import { leaveBalancesRouter, leavePoliciesRouter, leaveRequestsRouter, leaveTypesRouter } from './modules/leave/router.js';
import { notificationsRouter } from './modules/notifications/router.js';
import { payslipsRouter } from './modules/payslips/router.js';
import { reportsRouter } from './modules/reports/router.js';
import { dutiesRouter, dutyAssignmentsRouter, rosterRouter } from './modules/roster/router.js';
import { businessUnitsRouter, depotsRouter, regionsRouter } from './modules/org/router.js';
import { settingsRouter } from './modules/settings/router.js';
import { tasksRouter } from './modules/tasks/router.js';
import { meRouter, usersRouter } from './modules/users/router.js';
import { getStorageService, LOCAL_STORAGE_PATH, LocalStorageService, localStorageRouter } from './lib/storage.js';

/** All module routers, in mount order. Importing this list also registers every route in the OpenAPI registry. */
export const moduleRouters = [
  healthRouter,
  authRouter,
  meRouter,
  usersRouter,
  businessUnitsRouter,
  regionsRouter,
  depotsRouter,
  settingsRouter,
  notificationsRouter,
  employeesRouter,
  documentsRouter,
  documentRequirementsRouter,
  uploadsRouter,
  vehiclesRouter,
  routesRouter,
  dutyTemplatesRouter,
  rosterRouter,
  dutiesRouter,
  dutyAssignmentsRouter,
  attendanceRouter,
  leaveTypesRouter,
  leavePoliciesRouter,
  leaveBalancesRouter,
  leaveRequestsRouter,
  allowanceTypesRouter,
  allowancesRouter,
  payslipsRouter,
  tasksRouter,
  reportsRouter,
];

/** Builds the Express app without listening (used by server.ts and tests). */
export function createApp() {
  const app = express();
  app.disable('x-powered-by');
  app.set('trust proxy', env.TRUST_PROXY_HOPS);

  app.use(requestId);
  app.use(
    pinoHttp({
      logger,
      genReqId: (req) => (req as express.Request).requestId ?? 'unknown',
      customLogLevel: (_req, res, err) => (err || res.statusCode >= 500 ? 'error' : res.statusCode >= 400 ? 'warn' : 'info'),
      serializers: {
        req: (req: { id: string; method: string; url: string }) => ({ id: req.id, method: req.method, url: req.url }),
      },
    }),
  );
  app.use(helmet());
  app.use(cors({ origin: env.CORS_ORIGINS.length > 0 ? env.CORS_ORIGINS : false }));
  // Dev-only emulation of presigned storage URLs (raw bodies, signature-authorised). Refused in production.
  const storage = getStorageService();
  if (env.STORAGE_DRIVER === 'local' && storage instanceof LocalStorageService) {
    app.use(`${API_BASE_PATH}${LOCAL_STORAGE_PATH}`, localStorageRouter(storage));
  }
  app.use(express.json({ limit: '1mb' }));
  app.use(apiLimiter);

  const api = express.Router();
  for (const m of moduleRouters) {
    api.use(m.mountPath, m.router);
  }
  app.use(API_BASE_PATH, api);

  app.use(notFoundHandler);
  app.use(errorHandler);
  return app;
}
