import { z } from '../../lib/openapi.js';
import type { Role } from '../../generated/prisma/enums.js';

/**
 * Company-level settings. Business numbers live here as configurable values, never in code paths.
 * Defaults apply until HR / the director saves a value.
 *
 * TODO(business): every default below is a placeholder to confirm with the company.
 */
const Enforcement = z.enum(['WARN', 'BLOCK']);
const EDITORS: Role[] = ['HR', 'DIRECTOR'];

export const SETTINGS = {
  'documents.expiryAlertDays': {
    description: 'Days before a document expires on which alerts are sent.',
    schema: z.array(z.number().int().min(0).max(365)).min(1).max(10),
    default: [30, 15, 7, 1],
    editableBy: EDITORS,
  },
  'roster.maxDutyMinutesPerDay': {
    // TODO(business): confirm against the Motor Transport Workers Act / state rules and company policy.
    description: 'Daily duty-time cap per employee, in minutes. Exceeding it raises a roster warning (or block).',
    schema: z.number().int().min(60).max(24 * 60),
    default: 600,
    editableBy: EDITORS,
  },
  'roster.minRestMinutes': {
    // TODO(business): confirm the minimum rest between two duties.
    description: 'Minimum rest between the end of one duty and the start of the next, in minutes.',
    schema: z.number().int().min(0).max(24 * 60),
    default: 480,
    editableBy: EDITORS,
  },
  'roster.maxConsecutiveWorkDays': {
    // TODO(business): "no weekly off in 7 days" → 6 consecutive working days allowed by default.
    description: 'Maximum consecutive days with a duty before a weekly off is required.',
    schema: z.number().int().min(1).max(30),
    default: 6,
    editableBy: EDITORS,
  },
  'roster.enforcement': {
    description: 'Per roster rule: WARN (assignment allowed, warning returned) or BLOCK (409 ROSTER_RULE_VIOLATION).',
    schema: z.object({ dutyHourCap: Enforcement, minRest: Enforcement, weeklyOff: Enforcement }),
    default: { dutyHourCap: 'WARN', minRest: 'WARN', weeklyOff: 'WARN' } as const,
    editableBy: EDITORS,
  },
  'roster.roleCategories': {
    // TODO(business): which employee categories may fill each duty role (also drives spare suggestions).
    description: 'Employee categories allowed to fill each duty role (and suggested as spares for it).',
    schema: z.record(z.enum(['DRIVER', 'CO_DRIVER', 'CONDUCTOR', 'HELPER']), z.array(z.enum(['DRIVER', 'LOADMAN', 'CONDUCTOR', 'HELPER', 'MECHANIC', 'DEPOT_STAFF', 'OFFICE']))),
    default: { DRIVER: ['DRIVER'], CO_DRIVER: ['DRIVER'], CONDUCTOR: ['CONDUCTOR'], HELPER: ['HELPER', 'LOADMAN'] },
    editableBy: EDITORS,
  },
  'attendance.editWindowDays': {
    // PHASE-2-FEATURES §4.1: editable until 23:59 IST the next day → 1.
    description: 'Attendance for a date can be marked or changed until 23:59 IST this many days later; after that a correction request is needed.',
    schema: z.number().int().min(0).max(31),
    default: 1,
    editableBy: EDITORS,
  },
  'leave.balanceEnforcement': {
    // TODO(business): PHASE-2-FEATURES §5.1 — block or only warn when the leave balance is short.
    description: 'When a leave request exceeds the available balance: BLOCK (409 INSUFFICIENT_BALANCE) or WARN (allowed, warning returned).',
    schema: Enforcement,
    default: 'BLOCK',
    editableBy: EDITORS,
  },
  'payslips.maxFileBytes': {
    description: 'Largest payslip PDF accepted by the bulk upload, in bytes (at most 10 MB, the upload hard limit).',
    schema: z.number().int().min(10_000).max(10 * 1024 * 1024),
    default: 5 * 1024 * 1024,
    editableBy: EDITORS,
  },
  'payslips.notifyOnUpload': {
    description: 'Notify RMs and OMs in the affected business units when payslips for a month are uploaded.',
    schema: z.boolean(),
    default: true,
    editableBy: EDITORS,
  },
} as const;

export type SettingKey = keyof typeof SETTINGS;
export type SettingValue<K extends SettingKey> = z.infer<(typeof SETTINGS)[K]['schema']>;

export const SETTING_KEYS = Object.keys(SETTINGS) as SettingKey[];

export function isSettingKey(key: string): key is SettingKey {
  return Object.hasOwn(SETTINGS, key);
}
