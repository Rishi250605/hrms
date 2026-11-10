import { TaskPriority, TaskStatus } from '../../generated/prisma/enums.js';
import { registry, z } from '../../lib/openapi.js';
import { IsoDate, PageQuery } from '../../lib/schemas.js';
import { BusinessUnitRef } from '../employees/schemas.js';
import { PersonRef } from '../users/schemas.js';

export const TaskPrioritySchema = registry.register('TaskPriority', z.enum(TaskPriority));
export const TaskStatusSchema = registry.register('TaskStatus', z.enum(TaskStatus));

export const TaskItem = registry.register(
  'TaskItem',
  z.object({
    id: z.uuid(),
    groupId: z.uuid(),
    date: IsoDate,
    businessUnit: BusinessUnitRef,
    title: z.string(),
    details: z.string().nullable(),
    priority: TaskPrioritySchema,
    allottedBy: PersonRef,
    assignee: PersonRef,
    status: TaskStatusSchema,
    overdue: z.boolean().openapi({ description: 'Still PENDING after its date (IST)' }),
    reason: z.string().nullable(),
    comment: z.string().nullable(),
    submittedAt: z.string().datetime().nullable(),
    reopenedAt: z.string().datetime().nullable(),
    reopenComment: z.string().nullable(),
    reopenCount: z.number().int(),
    canSubmit: z.boolean(),
    canReopen: z.boolean(),
    createdAt: z.string().datetime(),
  }),
);
export const TaskPage = registry.register('TaskPage', z.object({ items: z.array(TaskItem), nextCursor: z.uuid().nullable() }));
export const TaskList = registry.register('TaskList', z.object({ items: z.array(TaskItem) }));

export const TaskQuery = PageQuery.extend({
  scope: z.enum(['allotted', 'assigned', 'all']).default('assigned').openapi({ description: 'allotted: by me (OM); assigned: to me (RM); all: HR / director' }),
  state: z.enum(['open', 'submitted']).optional().openapi({ description: 'open: PENDING (incl. overdue); submitted: COMPLETED or NOT_DONE' }),
  status: TaskStatusSchema.optional(),
  overdue: z
    .enum(['true', 'false'])
    .transform((v) => v === 'true')
    .optional()
    .openapi({ type: 'boolean' }),
  date: IsoDate.optional(),
  from: IsoDate.optional(),
  to: IsoDate.optional(),
  businessUnitId: z.uuid().optional(),
  assigneeEmployeeId: z.uuid().optional(),
  allottedByEmployeeId: z.uuid().optional(),
});

export const TaskCreateBody = registry.register(
  'TaskCreateBody',
  z.object({
    date: IsoDate.optional().openapi({ description: 'Default today (IST); future dates allowed' }),
    businessUnitId: z.uuid(),
    title: z.string().trim().min(2).max(200),
    details: z.string().trim().max(2000).optional(),
    priority: TaskPrioritySchema.optional(),
    assigneeEmployeeIds: z.array(z.uuid()).min(1).max(50).openapi({ description: 'RMs reporting to you in this business unit; one task each' }),
  }),
);

export const TaskSubmitBody = registry.register(
  'TaskSubmitBody',
  z.object({
    status: z.enum(['COMPLETED', 'NOT_DONE']),
    reason: z.string().trim().min(3).max(1000).optional().openapi({ description: 'Required for NOT_DONE' }),
    comment: z.string().trim().max(1000).optional(),
  }),
);
export const TaskReopenBody = registry.register('TaskReopenBody', z.object({ comment: z.string().trim().min(3).max(1000) }));
