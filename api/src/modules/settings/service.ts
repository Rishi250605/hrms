import { Errors } from '../../lib/errors.js';
import { logger } from '../../lib/logger.js';
import { prisma } from '../../lib/prisma.js';
import type { Db } from '../../lib/prisma.js';
import type { RequestContext } from '../../lib/context.js';
import type { Prisma } from '../../generated/prisma/client.js';
import { audit } from '../audit/service.js';
import { isSettingKey, SETTING_KEYS, SETTINGS } from './registry.js';
import type { SettingKey, SettingValue } from './registry.js';

/** Typed read of a setting: the stored value if valid, else the default. */
export async function getSetting<K extends SettingKey>(key: K, db: Db = prisma): Promise<SettingValue<K>> {
  const row = await db.setting.findUnique({ where: { key } });
  const def = SETTINGS[key];
  if (!row) return def.default as SettingValue<K>;
  const parsed = def.schema.safeParse(row.value);
  if (!parsed.success) {
    logger.error({ key }, 'Stored setting is invalid; using default');
    return def.default as SettingValue<K>;
  }
  return parsed.data as SettingValue<K>;
}

export async function listSettings() {
  const rows = await prisma.setting.findMany();
  const byKey = new Map(rows.map((r) => [r.key, r]));
  return SETTING_KEYS.map((key) => {
    const def = SETTINGS[key];
    const row = byKey.get(key);
    const parsed = row ? def.schema.safeParse(row.value) : undefined;
    return {
      key,
      description: def.description,
      value: parsed?.success ? parsed.data : def.default,
      defaultValue: def.default,
      isDefault: !parsed?.success,
      editableBy: def.editableBy,
      updatedAt: row?.updatedAt.toISOString() ?? null,
    };
  });
}

export async function updateSetting(key: string, value: unknown, ctx: RequestContext) {
  if (!isSettingKey(key)) throw Errors.notFound('Setting');
  const def = SETTINGS[key];
  if (!ctx.user || !def.editableBy.includes(ctx.user.role)) throw Errors.forbidden('Your role cannot change this setting');
  const parsed = def.schema.safeParse(value);
  if (!parsed.success) throw Errors.validation(parsed.error.issues);

  await prisma.$transaction(async (tx) => {
    const before = await tx.setting.findUnique({ where: { key } });
    const json = parsed.data as Prisma.InputJsonValue;
    const after = await tx.setting.upsert({
      where: { key },
      create: { key, value: json, updatedById: ctx.user?.id ?? null },
      update: { value: json, updatedById: ctx.user?.id ?? null },
    });
    await audit.record(tx, ctx, { action: 'setting.update', entityType: 'Setting', entityId: key, before, after });
  });
  const all = await listSettings();
  return all.find((s) => s.key === key)!;
}
