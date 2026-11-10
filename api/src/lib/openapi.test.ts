import { describe, expect, it } from 'vitest';
import { moduleRouters } from '../app.js';
import { generateOpenApiDocument } from './openapi.js';

describe('OpenAPI document', () => {
  it('documents the routes with security where required', () => {
    expect(moduleRouters.length).toBeGreaterThan(0);
    const doc = generateOpenApiDocument();
    const paths = doc.paths ?? {};
    expect(Object.keys(paths)).toEqual(
      expect.arrayContaining([
        '/auth/logout',
        '/auth/login',
        '/auth/refresh',
        '/health',
        '/health/ready',
        '/me',
        '/employees',
        '/employees/{id}/job-changes',
        '/documents/{id}/verify',
        '/uploads/presign',
      ]),
    );
    // Only the auth and health endpoints are public.
    const publicOps = Object.entries(paths).flatMap(([path, item]) =>
      Object.values(item as Record<string, { security?: unknown[] }>)
        .filter((op) => Array.isArray(op.security) && op.security.length === 0)
        .map(() => path),
    );
    expect(new Set(publicOps)).toEqual(new Set(['/auth/logout', '/auth/login', '/auth/refresh', '/health', '/health/ready']));
    // The dart-dio generator emits non-const constructor defaults for list/map defaults (does not compile).
    const nonScalarDefaults: string[] = [];
    const walk = (node: unknown, path: string) => {
      if (!node || typeof node !== 'object') return;
      const obj = node as Record<string, unknown>;
      if ('default' in obj && typeof obj.default === 'object' && obj.default !== null) nonScalarDefaults.push(path);
      for (const [k, v] of Object.entries(obj)) walk(v, `${path}.${k}`);
    };
    walk(doc.components?.schemas, 'schemas');
    expect(nonScalarDefaults).toEqual([]);
    expect(paths['/me']?.get?.security).toEqual([{ bearerAuth: [] }]);
    expect(paths['/auth/login']?.post?.security).toEqual([]);
    expect(paths['/me']?.get?.operationId).toBe('getMe');
  });
});
