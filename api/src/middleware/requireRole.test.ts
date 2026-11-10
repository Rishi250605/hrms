import { describe, expect, it, vi } from 'vitest';
import type { Request, Response } from 'express';
import type { AuthUser } from '../lib/context.js';
import { requireRole } from './requireRole.js';

const user = (role: AuthUser['role']): AuthUser => ({
  id: 'u1',
  name: 'T',
  phone: '+919000000000',
  role,
  employeeId: 'e1',
  empCode: 'NLS001',
  businessUnitIds: [],
  primaryBusinessUnitId: null,
});

const run = (mw: ReturnType<typeof requireRole>, u?: AuthUser) => {
  const next = vi.fn();
  mw({ user: u } as unknown as Request, {} as Response, next);
  return next;
};

describe('requireRole', () => {
  it('passes allowed roles and rejects others', () => {
    expect(run(requireRole('DIRECTOR', 'HR'), user('HR'))).toHaveBeenCalled();
    expect(() => run(requireRole('DIRECTOR'), user('HR'))).toThrow(/access/);
    expect(() => run(requireRole('HR'))).toThrow(/Authentication/);
  });

  it('needs at least one role', () => {
    expect(() => requireRole()).toThrow();
  });
});
