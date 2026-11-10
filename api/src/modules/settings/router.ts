import { ModuleRouter } from '../../lib/route.js';
import * as controller from './controller.js';
import { SettingItem, SettingKeyParams, SettingList, SettingUpdateBody } from './schemas.js';

export const settingsRouter = new ModuleRouter('/settings', 'Settings')
  .route({
    method: 'get',
    path: '/',
    operationId: 'listSettings',
    summary: 'Company settings with their current values and defaults',
    access: { roles: 'any' },
    response: { status: 200, description: 'All settings', schema: SettingList },
    handler: controller.list,
  })
  .route({
    method: 'put',
    path: '/:key',
    operationId: 'updateSetting',
    summary: 'Change a company setting',
    description: 'The value is validated against the schema registered for the key. Which roles may edit is per key.',
    access: { roles: ['HR', 'DIRECTOR'] },
    params: SettingKeyParams,
    body: SettingUpdateBody,
    response: { status: 200, description: 'The updated setting', schema: SettingItem },
    errors: { 404: 'Unknown key' },
    handler: controller.update,
  });
