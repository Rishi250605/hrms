import type { Request } from 'express';
import { contextOf } from '../../lib/context.js';
import { ModuleRouter } from '../../lib/route.js';
import type { RouteAccess, RouteInput } from '../../lib/route.js';
import { IdParams } from '../../lib/schemas.js';
import { authUser } from '../employees/controller.js';
import {
  EmployeeIdParams,
  EmployeeWeekParams,
  PerformanceMetricCreateBody,
  PerformanceMetricItem,
  PerformanceMetricList,
  PerformanceMetricUpdateBody,
  PerformancePeopleQuery,
  PerformancePersonList,
  PerformanceRatingCreateBody,
  PerformanceRatingItem,
  PerformanceSummary,
  PerformanceSummaryQuery,
  PerformanceWeekBody,
} from './schemas.js';
import * as s from './service.js';

type In<B, Q, P> = RouteInput<B, Q, P>;
const director: RouteAccess = { roles: ['DIRECTOR'] };

export const performanceMetricsRouter = new ModuleRouter('/performance-metrics', 'Performance')
  .route({
    method: 'get',
    path: '/',
    operationId: 'listPerformanceMetrics',
    summary: 'Weekly performance metrics (Mileage, Employee count, Maintenance, …)',
    access: { roles: 'any' },
    response: { status: 200, description: 'Metrics in display order', schema: PerformanceMetricList },
    handler: () => s.listMetrics(),
  })
  .route({
    method: 'post',
    path: '/',
    operationId: 'createPerformanceMetric',
    summary: 'Add a weekly metric',
    access: director,
    body: PerformanceMetricCreateBody,
    response: { status: 201, description: 'Created', schema: PerformanceMetricItem },
    errors: { 409: 'Code exists' },
    handler: (i: In<typeof PerformanceMetricCreateBody, undefined, undefined>, req: Request) => s.createMetric(i.body, contextOf(req)),
  })
  .route({
    method: 'patch',
    path: '/:id',
    operationId: 'updatePerformanceMetric',
    summary: 'Rename, reorder or deactivate a weekly metric',
    access: director,
    params: IdParams,
    body: PerformanceMetricUpdateBody,
    response: { status: 200, description: 'Updated', schema: PerformanceMetricItem },
    errors: { 404: 'Not found' },
    handler: (i: In<typeof PerformanceMetricUpdateBody, undefined, typeof IdParams>, req: Request) => s.updateMetric(i.params.id, i.body, contextOf(req)),
  });

export const performanceRouter = new ModuleRouter('/performance', 'Performance')
  .route({
    method: 'get',
    path: '/people',
    operationId: 'listPerformancePeople',
    summary: 'RMs, OMs and HRs in my business units with their latest rating (HR / director)',
    access: { roles: ['HR', 'DIRECTOR'] },
    query: PerformancePeopleQuery,
    response: { status: 200, description: 'People by name', schema: PerformancePersonList },
    handler: (i: In<undefined, typeof PerformancePeopleQuery, undefined>, req: Request) => s.listPeople(authUser(req), i.query),
  })
  .route({
    method: 'get',
    path: '/employees/:employeeId',
    operationId: 'getPerformance',
    summary: "A person's rating history and weekly values (self, HR in the BU, director)",
    access: { roles: 'any' },
    params: EmployeeIdParams,
    query: PerformanceSummaryQuery,
    response: { status: 200, description: 'Summary', schema: PerformanceSummary },
    errors: { 404: 'Not found or not visible' },
    handler: (i: In<undefined, typeof PerformanceSummaryQuery, typeof EmployeeIdParams>, req: Request) =>
      s.getSummary(authUser(req), i.params.employeeId, i.query.weeks),
  })
  .route({
    method: 'post',
    path: '/employees/:employeeId/ratings',
    operationId: 'ratePerformance',
    summary: 'Rate a person 1–5 (HR: RMs and OMs in their BUs; director: anyone rated)',
    access: { roles: ['HR', 'DIRECTOR'] },
    params: EmployeeIdParams,
    body: PerformanceRatingCreateBody,
    response: { status: 201, description: 'Rating', schema: PerformanceRatingItem },
    errors: { 403: 'Not allowed to rate this person', 404: 'Not found or not visible' },
    handler: (i: In<typeof PerformanceRatingCreateBody, undefined, typeof EmployeeIdParams>, req: Request) =>
      s.rate(authUser(req), i.params.employeeId, i.body, contextOf(req)),
  })
  .route({
    method: 'put',
    path: '/employees/:employeeId/weeks/:weekStart',
    operationId: 'putPerformanceWeek',
    summary: "Enter or change a person's weekly metric values (director); null removes a value",
    access: director,
    params: EmployeeWeekParams,
    body: PerformanceWeekBody,
    response: { status: 200, description: 'Updated summary', schema: PerformanceSummary },
    errors: { 400: 'Not a Monday, or a future week', 404: 'Not found', 422: 'Unknown or inactive metric' },
    handler: (i: In<typeof PerformanceWeekBody, undefined, typeof EmployeeWeekParams>, req: Request) =>
      s.putWeek(authUser(req), i.params.employeeId, i.params.weekStart, i.body, contextOf(req)),
  });
