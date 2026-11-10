import { registry, z } from '../../lib/openapi.js';
import { IsoDate } from '../../lib/schemas.js';
import { Role } from '../../generated/prisma/enums.js';
import { EmpCodeSchema, PhoneSchema } from '../auth/schemas.js';

export const RoleSchema = registry.register('Role', z.enum(Role));

export const BusinessUnitMembership = registry.register(
  'BusinessUnitMembership',
  z.object({ id: z.uuid(), code: z.string(), name: z.string(), isPrimary: z.boolean() }),
);

export const PersonRef = registry.register(
  'PersonRef',
  z.object({ employeeId: z.uuid(), empCode: z.string(), name: z.string(), role: RoleSchema.nullable().openapi({ description: 'Null for non-login staff' }) }),
);

export const MeResponse = registry.register(
  'MeResponse',
  z.object({
    id: z.uuid(),
    employeeId: z.uuid(),
    empCode: z.string(),
    name: z.string(),
    phone: z.string(),
    email: z.string().nullable(),
    role: RoleSchema,
    lastLoginAt: z.string().datetime().nullable(),
    passwordChangedAt: z.string().datetime().nullable(),
    reportingTo: PersonRef.nullable().openapi({ description: 'Null for the director' }),
    businessUnits: z.array(BusinessUnitMembership).openapi({ description: 'The director gets every active BU (none primary)' }),
  }),
);

export const PasswordSchema = z.string().min(8, 'At least 8 characters').max(128);

export const UserItem = registry.register(
  'UserItem',
  z.object({
    id: z.uuid(),
    employeeId: z.uuid(),
    empCode: z.string(),
    name: z.string(),
    phone: z.string(),
    email: z.string().nullable(),
    role: RoleSchema,
    isActive: z.boolean(),
    hasPassword: z.boolean(),
    lockedUntil: z.string().datetime().nullable(),
    lastLoginAt: z.string().datetime().nullable(),
    reportingTo: PersonRef.nullable(),
    businessUnits: z.array(BusinessUnitMembership),
  }),
);

export const UserList = registry.register('UserList', z.object({ items: z.array(UserItem), nextCursor: z.uuid().nullable() }));

export const UserListQuery = z.object({
  role: RoleSchema.optional(),
  businessUnitId: z.uuid().optional(),
  q: z.string().trim().max(100).optional(),
  includeInactive: z
    .enum(['true', 'false'])
    .transform((v) => v === 'true')
    .optional()
    .openapi({ type: 'boolean' }),
  cursor: z.uuid().optional(),
  limit: z.coerce.number().int().min(1).max(200).default(50),
});

export const UserCreateBody = registry.register(
  'UserCreateBody',
  z.object({
    existingEmployeeId: z.uuid().optional().openapi({ description: 'Give a login to an existing employee (e.g. a driver promoted to RM). Omit to create a new employee.' }),
    empCode: EmpCodeSchema.optional().openapi({ description: 'Required for a new employee: BU code + digits, e.g. NLS001' }),
    fullName: z.string().trim().min(2).max(120).optional(),
    phone: PhoneSchema,
    email: z.email().optional(),
    role: RoleSchema,
    businessUnitIds: z.array(z.uuid()).max(20).optional().openapi({ description: 'Required except for the director' }),
    primaryBusinessUnitId: z.uuid().optional(),
    reportingToEmployeeId: z.uuid().optional().openapi({ description: 'One role up, sharing a BU (none for the director)' }),
    depotId: z.uuid().optional().openapi({ description: 'Base depot for a new employee (must be in one of the BUs)' }),
    designation: z.string().trim().min(2).max(80).optional(),
    joiningDate: IsoDate.optional(),
    password: PasswordSchema,
  }),
);

export const UserUpdateBody = registry.register(
  'UserUpdateBody',
  z.object({
    name: z.string().trim().min(2).max(120).optional(),
    phone: PhoneSchema.optional(),
    email: z.email().nullable().optional(),
    isActive: z.boolean().optional().openapi({ description: 'Deactivating revokes all sessions' }),
  }),
);

export const ResetPasswordBody = registry.register('ResetPasswordBody', z.object({ password: PasswordSchema }));
