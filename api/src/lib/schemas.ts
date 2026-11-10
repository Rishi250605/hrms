import { isValidIsoDate } from './dates.js';
import { z } from './openapi.js';

/**
 * Shared zod building blocks. Business dates are plain 'YYYY-MM-DD' strings (no `format: date`) so the
 * generated Dart client keeps them as strings and never shifts them through a timezone.
 */
export const IsoDate = z
  .string()
  .refine(isValidIsoDate, 'Expected a calendar date YYYY-MM-DD')
  .openapi({ pattern: '^\\d{4}-\\d{2}-\\d{2}$', example: '2026-11-09', description: 'Calendar date (IST business date)' });

/** A month, 'YYYY-MM' (pay period, report month). */
export const Period = z
  .string()
  .regex(/^\d{4}-(0[1-9]|1[0-2])$/, 'Expected a month YYYY-MM')
  .openapi({ pattern: '^\\d{4}-(0[1-9]|1[0-2])$', example: '2026-11' });

export const HhMm = z
  .string()
  .regex(/^([01]\d|2[0-3]):[0-5]\d$/, 'Expected HH:MM (24h)')
  .openapi({ example: '06:30' });

export const Uuid = z.uuid();
export const IdParams = z.object({ id: z.uuid() });

export const DEFAULT_PAGE_SIZE = 50;
export const MAX_PAGE_SIZE = 200;

/** Cursor pagination query (CLAUDE.md §5): `?cursor=&limit=`, default 50, max 200. */
export const PageQuery = z.object({
  cursor: z.uuid().optional().openapi({ description: 'The nextCursor of the previous page' }),
  limit: z.coerce.number().int().min(1).max(MAX_PAGE_SIZE).default(DEFAULT_PAGE_SIZE),
});

export function pageOf<T extends z.ZodType>(item: T) {
  return z.object({ items: z.array(item), nextCursor: z.uuid().nullable() });
}

/** Prisma args for a cursor page: fetch one extra row to know whether there is a next page. */
export function pageArgs(q: { cursor?: string | undefined; limit: number }) {
  return {
    take: q.limit + 1,
    ...(q.cursor ? { cursor: { id: q.cursor }, skip: 1 } : {}),
  };
}

export function toPage<T extends { id: string }, R>(rows: T[], limit: number, map: (row: T) => R): { items: R[]; nextCursor: string | null } {
  const hasMore = rows.length > limit;
  const pageRows = hasMore ? rows.slice(0, limit) : rows;
  return { items: pageRows.map(map), nextCursor: hasMore ? (pageRows[pageRows.length - 1]?.id ?? null) : null };
}

/** Query-string boolean ('true' / 'false'). */
export const QueryBool = z
  .enum(['true', 'false'])
  .transform((v) => v === 'true')
  .openapi({ type: 'boolean' });
