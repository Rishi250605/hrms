import type { Request } from 'express';
import { contextOf } from '../../lib/context.js';
import type { RouteInput } from '../../lib/route.js';
import type { SettingKeyParams, SettingUpdateBody } from './schemas.js';
import * as service from './service.js';

export const list = async () => ({ items: await service.listSettings() });

export const update = (input: RouteInput<typeof SettingUpdateBody, undefined, typeof SettingKeyParams>, req: Request) =>
  service.updateSetting(input.params.key, input.body.value, contextOf(req));
