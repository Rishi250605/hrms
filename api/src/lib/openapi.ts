import { extendZodWithOpenApi, OpenAPIRegistry, OpenApiGeneratorV3 } from '@asteasolutions/zod-to-openapi';
import { z } from 'zod';

// Must run before any schema calls `.openapi(...)`. Every module imports `z` from here.
extendZodWithOpenApi(z);

export { z };

export const registry = new OpenAPIRegistry();

export const bearerAuth = registry.registerComponent('securitySchemes', 'bearerAuth', {
  type: 'http',
  scheme: 'bearer',
  bearerFormat: 'JWT',
});

export const ErrorResponseSchema = registry.register(
  'ErrorResponse',
  z.object({
    error: z.object({
      code: z.string().openapi({ example: 'VALIDATION_ERROR' }),
      message: z.string(),
      details: z.unknown().optional(),
    }),
  }),
);

export const API_BASE_PATH = '/api/v1';

export function generateOpenApiDocument() {
  const generator = new OpenApiGeneratorV3(registry.definitions);
  return generator.generateDocument({
    openapi: '3.0.3',
    info: {
      title: 'Transport HRMS API',
      version: '1.0.0',
      description:
        'Internal HRMS API for a transport services company. Generated from zod schemas - do not edit by hand (run `npm run openapi`).',
    },
    servers: [{ url: API_BASE_PATH }],
  });
}
