import request from 'supertest';
import { describe, expect, it } from 'vitest';
import { createApp } from './app.js';

// These tests exercise the HTTP pipeline without touching the database.
const app = createApp();

describe('app pipeline', () => {
  it('serves the liveness probe and echoes a request id', async () => {
    const res = await request(app).get('/api/v1/health').set('X-Request-Id', 'test-request-0001');
    expect(res.status).toBe(200);
    expect(res.body.status).toBe('ok');
    expect(res.headers['x-request-id']).toBe('test-request-0001');
  });

  it('generates a request id when none (or an unsafe one) is supplied', async () => {
    const res = await request(app).get('/api/v1/health').set('X-Request-Id', 'bad id!');
    expect(res.headers['x-request-id']).toMatch(/^[0-9a-f-]{36}$/);
  });

  it('returns VALIDATION_ERROR in the standard error shape', async () => {
    const res = await request(app).post('/api/v1/auth/login').send({ empCode: '' });
    expect(res.status).toBe(400);
    expect(res.body.error.code).toBe('VALIDATION_ERROR');
    expect(res.body.error.details[0].location).toBe('body');
  });

  it('rejects malformed JSON', async () => {
    const res = await request(app).post('/api/v1/auth/login').set('Content-Type', 'application/json').send('{bad');
    expect(res.status).toBe(400);
    expect(res.body.error.code).toBe('MALFORMED_JSON');
  });

  it('requires a bearer token for /me', async () => {
    const res = await request(app).get('/api/v1/me');
    expect(res.status).toBe(401);
    expect(res.body.error.code).toBe('UNAUTHENTICATED');
  });

  it('rejects an invalid access token', async () => {
    const res = await request(app).get('/api/v1/me').set('Authorization', 'Bearer not-a-jwt');
    expect(res.status).toBe(401);
    expect(res.body.error.code).toBe('INVALID_TOKEN');
  });

  it('returns ROUTE_NOT_FOUND for unknown routes', async () => {
    const res = await request(app).get('/api/v1/nope');
    expect(res.status).toBe(404);
    expect(res.body.error.code).toBe('ROUTE_NOT_FOUND');
  });
});
