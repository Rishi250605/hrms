import { registry, z } from '../../lib/openapi.js';
import { RoleSchema } from '../users/schemas.js';

export const SettingItem = registry.register(
  'SettingItem',
  z.object({
    key: z.string(),
    description: z.string(),
    value: z.unknown().openapi({ description: 'JSON value; its shape depends on the key' }),
    defaultValue: z.unknown(),
    isDefault: z.boolean(),
    editableBy: z.array(RoleSchema),
    updatedAt: z.string().datetime().nullable(),
  }),
);

export const SettingList = registry.register('SettingList', z.object({ items: z.array(SettingItem) }));
export const SettingKeyParams = z.object({ key: z.string().min(1).max(100) });
export const SettingUpdateBody = registry.register('SettingUpdateBody', z.object({ value: z.unknown() }));
