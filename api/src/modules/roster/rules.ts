import { addDays, minutesBetween } from '../../lib/dates.js';

/**
 * Roster rules (CLAUDE.md §7). Pure functions over an employee's duties around a candidate duty, so they
 * are unit-testable without a database. Limits come from `Setting` (roster.*), never from code.
 */
export interface DutySpan {
  id: string;
  dutyDate: string; // IST business date
  start: Date;
  end: Date;
}

export interface RosterLimits {
  maxDutyMinutesPerDay: number;
  minRestMinutes: number;
  maxConsecutiveWorkDays: number;
}

export type RuleCode = 'DUTY_HOURS_EXCEEDED' | 'MIN_REST_VIOLATED' | 'NO_WEEKLY_OFF';
export type EnforcementKey = 'dutyHourCap' | 'minRest' | 'weeklyOff';

export const RULE_ENFORCEMENT_KEY: Record<RuleCode, EnforcementKey> = {
  DUTY_HOURS_EXCEEDED: 'dutyHourCap',
  MIN_REST_VIOLATED: 'minRest',
  NO_WEEKLY_OFF: 'weeklyOff',
};

export interface RuleViolation {
  code: RuleCode;
  message: string;
  details: Record<string, number | string>;
}

const overlaps = (a: DutySpan, b: DutySpan) => a.start < b.end && b.start < a.end;

/** Other duties of the employee that overlap the candidate in time (always a hard block). */
export function overlappingDuties(candidate: DutySpan, others: DutySpan[]): DutySpan[] {
  return others.filter((o) => o.id !== candidate.id && overlaps(candidate, o));
}

/** Rule violations if `candidate` is added to `others` (the employee's other non-cancelled duties). */
export function evaluateRules(candidate: DutySpan, others: DutySpan[], limits: RosterLimits): RuleViolation[] {
  const all = [...others.filter((o) => o.id !== candidate.id), candidate];
  const violations: RuleViolation[] = [];

  // 1. Daily duty-time cap (duties are counted on their duty date).
  const dayMinutes = all.filter((d) => d.dutyDate === candidate.dutyDate).reduce((sum, d) => sum + minutesBetween(d.start, d.end), 0);
  if (dayMinutes > limits.maxDutyMinutesPerDay) {
    violations.push({
      code: 'DUTY_HOURS_EXCEEDED',
      message: `${Math.round((dayMinutes / 60) * 10) / 10} h of duty on ${candidate.dutyDate} (cap ${limits.maxDutyMinutesPerDay / 60} h)`,
      details: { dutyMinutes: dayMinutes, capMinutes: limits.maxDutyMinutesPerDay },
    });
  }

  // 2. Minimum rest between consecutive duties (the gaps either side of the candidate).
  const sorted = [...all].sort((a, b) => a.start.getTime() - b.start.getTime());
  const i = sorted.findIndex((d) => d.id === candidate.id);
  const prev = sorted[i - 1];
  const next = sorted[i + 1];
  const gaps = [prev ? minutesBetween(prev.end, candidate.start) : Infinity, next ? minutesBetween(candidate.end, next.start) : Infinity];
  const shortest = Math.min(...gaps);
  if (shortest >= 0 && shortest < limits.minRestMinutes) {
    violations.push({
      code: 'MIN_REST_VIOLATED',
      message: `Only ${Math.floor(shortest / 60)} h ${shortest % 60} min rest between duties (minimum ${limits.minRestMinutes / 60} h)`,
      details: { restMinutes: shortest, minRestMinutes: limits.minRestMinutes },
    });
  }

  // 3. Weekly off: the run of consecutive working days through the candidate's date.
  const workDays = new Set(all.map((d) => d.dutyDate));
  let run = 1;
  for (let d = addDays(candidate.dutyDate, -1); workDays.has(d); d = addDays(d, -1)) run++;
  for (let d = addDays(candidate.dutyDate, 1); workDays.has(d); d = addDays(d, 1)) run++;
  if (run > limits.maxConsecutiveWorkDays) {
    violations.push({
      code: 'NO_WEEKLY_OFF',
      message: `${run} consecutive working days without a weekly off (maximum ${limits.maxConsecutiveWorkDays})`,
      details: { consecutiveDays: run, maxConsecutiveWorkDays: limits.maxConsecutiveWorkDays },
    });
  }
  return violations;
}
