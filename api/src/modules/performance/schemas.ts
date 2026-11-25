import { registry, z } from '../../lib/openapi.js';
import { IsoDate } from '../../lib/schemas.js';
import { BusinessUnitRef } from '../employees/schemas.js';
import { PersonRef } from '../users/schemas.js';

// ───────────────────────────── Metrics (configurable weekly KPIs) ─────────────────────────────

export const PerformanceMetricItem = registry.register(
  'PerformanceMetricItem',
  z.object({ id: z.uuid(), code: z.string(), name: z.string(), unit: z.string().nullable(), sortOrder: z.number().int(), isActive: z.boolean() }),
);
export const PerformanceMetricList = registry.register('PerformanceMetricList', z.object({ items: z.array(PerformanceMetricItem) }));
export const PerformanceMetricCreateBody = registry.register(
  'PerformanceMetricCreateBody',
  z.object({
    code: z
      .string()
      .trim()
      .toUpperCase()
      .regex(/^[A-Z0-9_]{2,30}$/),
    name: z.string().trim().min(2).max(60),
    unit: z.string().trim().min(1).max(20).optional(),
    sortOrder: z.number().int().min(0).max(1000).optional(),
  }),
);
export const PerformanceMetricUpdateBody = registry.register(
  'PerformanceMetricUpdateBody',
  z.object({
    name: z.string().trim().min(2).max(60).optional(),
    unit: z.string().trim().min(1).max(20).nullable().optional(),
    sortOrder: z.number().int().min(0).max(1000).optional(),
    isActive: z.boolean().optional(),
  }),
);

// ───────────────────────────── Ratings and weekly values ─────────────────────────────

export const PerformanceRatingItem = registry.register(
  'PerformanceRatingItem',
  z.object({
    id: z.uuid(),
    rating: z.number().int().min(1).max(5),
    comment: z.string().nullable(),
    ratedBy: PersonRef,
    createdAt: z.string().datetime(),
  }),
);

export const PerformanceWeekValue = registry.register(
  'PerformanceWeekValue',
  z.object({ metricId: z.uuid(), code: z.string(), name: z.string(), unit: z.string().nullable(), value: z.number().nullable() }),
);
export const PerformanceWeek = registry.register(
  'PerformanceWeek',
  z.object({
    weekStart: IsoDate.openapi({ description: 'Monday of the week (IST)' }),
    values: z.array(PerformanceWeekValue).openapi({ description: 'One entry per active metric, in display order; value null = not entered' }),
  }),
);

export const PerformanceSummary = registry.register(
  'PerformanceSummary',
  z.object({
    person: PersonRef,
    businessUnit: BusinessUnitRef,
    latestRating: PerformanceRatingItem.nullable(),
    ratings: z.array(PerformanceRatingItem).openapi({ description: 'Rating history, newest first (last 50)' }),
    weeks: z.array(PerformanceWeek).openapi({ description: 'Weeks with at least one value, newest first' }),
    canRate: z.boolean(),
    canEnterMetrics: z.boolean(),
  }),
);

export const PerformancePersonItem = registry.register(
  'PerformancePersonItem',
  z.object({
    person: PersonRef,
    businessUnit: BusinessUnitRef,
    latestRating: PerformanceRatingItem.nullable(),
    lastWeekStart: IsoDate.nullable().openapi({ description: 'Latest week with values entered' }),
    canRate: z.boolean(),
    canEnterMetrics: z.boolean(),
  }),
);
export const PerformancePersonList = registry.register('PerformancePersonList', z.object({ items: z.array(PerformancePersonItem) }));

export const PerformancePeopleQuery = z.object({ businessUnitId: z.uuid().optional() });
export const PerformanceSummaryQuery = z.object({
  weeks: z.coerce.number().int().min(1).max(104).default(12).openapi({ type: 'integer', description: 'How many recent weeks to return' }),
});
export const EmployeeIdParams = z.object({ employeeId: z.uuid() });
export const EmployeeWeekParams = z.object({ employeeId: z.uuid(), weekStart: IsoDate });

export const PerformanceRatingCreateBody = registry.register(
  'PerformanceRatingCreateBody',
  z.object({ rating: z.number().int().min(1).max(5), comment: z.string().trim().max(1000).optional() }),
);

export const PerformanceWeekBody = registry.register(
  'PerformanceWeekBody',
  z.object({
    values: z
      .array(z.object({ metricId: z.uuid(), value: z.number().min(0).max(1e12).nullable().openapi({ description: 'null removes the value' }) }))
      .min(1)
      .max(50),
  }),
);
