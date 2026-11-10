import type { Request } from 'express';
import { contextOf } from '../../lib/context.js';
import { ModuleRouter } from '../../lib/route.js';
import type { RouteInput } from '../../lib/route.js';
import { IdParams } from '../../lib/schemas.js';
import { authUser } from '../employees/controller.js';
import { TaskCreateBody, TaskItem, TaskList, TaskPage, TaskQuery, TaskReopenBody, TaskSubmitBody } from './schemas.js';
import * as s from './service.js';

type In<B, Q, P> = RouteInput<B, Q, P>;

export const tasksRouter = new ModuleRouter('/tasks', 'Tasks')
  .route({
    method: 'post',
    path: '/',
    operationId: 'createTasks',
    summary: 'Allot a task to one or more RMs (one task each)',
    access: { roles: ['OPERATIONAL_MANAGER'] },
    body: TaskCreateBody,
    response: { status: 201, description: 'Created tasks (same groupId)', schema: TaskList },
    errors: { 403: 'Assignee is not your RM in this business unit' },
    handler: (i: In<typeof TaskCreateBody, undefined, undefined>, req: Request) => s.createTasks(authUser(req), i.body, contextOf(req)),
  })
  .route({
    method: 'get',
    path: '/',
    operationId: 'listTasks',
    summary: 'Tasks assigned to me (RM), allotted by me (OM) or all (HR / director)',
    access: { roles: 'any' },
    query: TaskQuery,
    response: { status: 200, description: 'Tasks', schema: TaskPage },
    errors: { 403: 'scope=all needs HR or the director' },
    handler: (i: In<undefined, typeof TaskQuery, undefined>, req: Request) => s.listTasks(authUser(req), i.query),
  })
  .route({
    method: 'get',
    path: '/:id',
    operationId: 'getTask',
    summary: 'One task',
    access: { roles: 'any' },
    params: IdParams,
    response: { status: 200, description: 'Task', schema: TaskItem },
    errors: { 404: 'Not found' },
    handler: (i: In<undefined, undefined, typeof IdParams>, req: Request) => s.getTask(authUser(req), i.params.id),
  })
  .route({
    method: 'post',
    path: '/:id/submit',
    operationId: 'submitTask',
    summary: 'Submit as completed or not done (reason required); locks the task',
    access: { roles: ['REGIONAL_MANAGER'] },
    params: IdParams,
    body: TaskSubmitBody,
    response: { status: 200, description: 'Submitted', schema: TaskItem },
    errors: { 404: 'Not your task', 409: 'Already submitted' },
    handler: (i: In<typeof TaskSubmitBody, undefined, typeof IdParams>, req: Request) => s.submitTask(authUser(req), i.params.id, i.body, contextOf(req)),
  })
  .route({
    method: 'post',
    path: '/:id/reopen',
    operationId: 'reopenTask',
    summary: 'Reopen a submitted task with a comment',
    access: { roles: ['OPERATIONAL_MANAGER'] },
    params: IdParams,
    body: TaskReopenBody,
    response: { status: 200, description: 'Reopened', schema: TaskItem },
    errors: { 404: 'Not your task', 409: 'Not submitted yet' },
    handler: (i: In<typeof TaskReopenBody, undefined, typeof IdParams>, req: Request) => s.reopenTask(authUser(req), i.params.id, i.body.comment, contextOf(req)),
  });
