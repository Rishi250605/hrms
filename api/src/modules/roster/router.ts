import { ModuleRouter } from '../../lib/route.js';
import { IdParams } from '../../lib/schemas.js';
import * as c from './controller.js';
import {
  AssignmentCreateBody,
  AssignmentResult,
  DutyCreateBody,
  DutyItem,
  DutyUpdateBody,
  RosterCopyBody,
  RosterCopyResult,
  RosterDay,
  RosterQuery,
  SpareList,
  SpareQuery,
} from './schemas.js';

/**
 * Rostering is done by operational managers; regional managers, the operational head and HR may also edit
 * within their scope. TODO(business): confirm whether roles other than operational managers may edit the roster.
 */
export const rosterRouter = new ModuleRouter('/roster', 'Roster')
  .route({
    method: 'get',
    path: '/',
    operationId: 'getRoster',
    summary: 'Day view of a depot: duties with crew, vehicle and route',
    access: { roles: 'any' },
    query: RosterQuery,
    response: { status: 200, description: 'The roster day', schema: RosterDay },
    errors: { 404: 'Depot not found / out of scope' },
    handler: c.getRoster,
  })
  .route({
    method: 'get',
    path: '/spares',
    operationId: 'getRosterSpares',
    summary: 'Available spares from the depot pool (documents valid, not on leave, free)',
    access: { roles: 'any' },
    query: SpareQuery,
    response: { status: 200, description: 'Least-worked first', schema: SpareList },
    errors: { 404: 'Depot or duty not found' },
    handler: c.spares,
  })
  .route({
    method: 'post',
    path: '/copy',
    operationId: 'copyRoster',
    summary: 'Copy a day (or week) of duties and crew to later dates',
    description: 'Assignments that fail any check (documents, leave, overlaps, BLOCK rules) are skipped and reported.',
    access: { roles: 'any' },
    body: RosterCopyBody,
    response: { status: 200, description: 'What was copied', schema: RosterCopyResult },
    errors: { 404: 'Depot not found' },
    handler: c.copy,
  });

export const dutiesRouter = new ModuleRouter('/duties', 'Roster')
  .route({
    method: 'post',
    path: '/',
    operationId: 'createDuty',
    summary: 'Create a duty (from a template or explicit times)',
    access: { roles: 'any' },
    body: DutyCreateBody,
    response: { status: 201, description: 'Created', schema: DutyItem },
    errors: { 404: 'Depot not found', 409: 'VEHICLE_DOUBLE_BOOKED or VEHICLE_NOT_AVAILABLE' },
    handler: c.createDuty,
  })
  .route({
    method: 'patch',
    path: '/:id',
    operationId: 'updateDuty',
    summary: 'Change times, vehicle, route, status or notes of a duty',
    access: { roles: 'any' },
    params: IdParams,
    body: DutyUpdateBody,
    response: { status: 200, description: 'Updated', schema: DutyItem },
    errors: { 404: 'Not found', 409: 'VEHICLE_DOUBLE_BOOKED, VEHICLE_NOT_AVAILABLE or DUTY_IN_FUTURE' },
    handler: c.updateDuty,
  })
  .route({
    method: 'post',
    path: '/:id/assignments',
    operationId: 'assignToDuty',
    summary: 'Assign an employee to a duty',
    description:
      '409 DOCUMENT_INVALID (details: failing documents + suggested spares), EMPLOYEE_ON_LEAVE, EMPLOYEE_DOUBLE_BOOKED, EMPLOYEE_NOT_IN_DEPOT, ' +
      'ROLE_NOT_ALLOWED, ROSTER_RULE_VIOLATION (rules set to BLOCK). Rules set to WARN come back in `warnings`.',
    access: { roles: 'any' },
    params: IdParams,
    body: AssignmentCreateBody,
    response: { status: 201, description: 'Assigned', schema: AssignmentResult },
    errors: { 404: 'Duty or employee not found', 409: 'Assignment refused (see description)' },
    handler: c.addAssignment,
  });

export const dutyAssignmentsRouter = new ModuleRouter('/duty-assignments', 'Roster').route({
  method: 'delete',
  path: '/:id',
  operationId: 'removeDutyAssignment',
  summary: 'Remove an employee from a duty',
  access: { roles: 'any' },
  params: IdParams,
  response: { status: 204, description: 'Removed' },
  errors: { 404: 'Not found', 409: 'Duty completed' },
  handler: c.removeAssignment,
});
