import { AppError } from '../../lib/errors.js';
import { registry, z } from '../../lib/openapi.js';
import { prisma } from '../../lib/prisma.js';
import { ModuleRouter } from '../../lib/route.js';

const HealthResponse = registry.register(
  'HealthResponse',
  z.object({ status: z.literal('ok'), time: z.string().datetime() }),
);

export const healthRouter = new ModuleRouter('/health', 'Health')
  .route({
    method: 'get',
    path: '/',
    operationId: 'getHealth',
    summary: 'Liveness probe',
    access: 'public',
    response: { status: 200, description: 'Process is up', schema: HealthResponse },
    handler: async () => ({ status: 'ok' as const, time: new Date().toISOString() }),
  })
  .route({
    method: 'get',
    path: '/ready',
    operationId: 'getReadiness',
    summary: 'Readiness probe (checks the database)',
    access: 'public',
    response: { status: 200, description: 'Ready to serve traffic', schema: HealthResponse },
    handler: async () => {
      try {
        await prisma.$queryRaw`SELECT 1`;
      } catch {
        throw new AppError('NOT_READY', 503, 'Database unavailable');
      }
      return { status: 'ok' as const, time: new Date().toISOString() };
    },
  });
