import type { Request } from 'express';
import type { Role } from '../generated/prisma/enums.js';

/** The authenticated user, loaded fresh from the database on every request. */
export interface AuthUser {
  id: string;
  name: string;
  phone: string;
  role: Role;
  /** Every login is an employee (PHASE-2-FEATURES §1.3). */
  employeeId: string;
  empCode: string;
  /** Business units the user belongs to; the director gets every active BU. */
  businessUnitIds: string[];
  /** Primary BU (records about the user themself use it). Null only for the director. */
  primaryBusinessUnitId: string | null;
}

/** What services need to know about the caller (for scope checks and audit). */
export interface RequestContext {
  user: AuthUser | null;
  requestId: string | null;
  ip: string | null;
  userAgent: string | null;
}

declare module 'express-serve-static-core' {
  interface Request {
    requestId?: string;
    user?: AuthUser;
  }
}

export function contextOf(req: Request): RequestContext {
  return {
    user: req.user ?? null,
    requestId: req.requestId ?? null,
    ip: req.ip ?? null,
    userAgent: req.get('user-agent') ?? null,
  };
}

/** Context for background jobs / seed scripts (actor = system). */
export function systemContext(requestId: string | null = null): RequestContext {
  return { user: null, requestId, ip: null, userAgent: null };
}
