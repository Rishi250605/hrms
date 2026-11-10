import { describe, expect, it } from 'vitest';
import { addDays, istInstant } from '../../lib/dates.js';
import { evaluateRules, overlappingDuties } from './rules.js';
import type { DutySpan } from './rules.js';

const limits = { maxDutyMinutesPerDay: 600, minRestMinutes: 480, maxConsecutiveWorkDays: 6 };
let n = 0;
/** Duty on `date` from `from` to `to` (HH:MM, IST); `to` <= `from` means it ends the next day. */
const duty = (date: string, from: string, to: string): DutySpan => {
  const end = istInstant(to <= from ? addDays(date, 1) : date, to);
  return { id: `d${++n}`, dutyDate: date, start: istInstant(date, from), end };
};
const codes = (c: DutySpan, others: DutySpan[]) => evaluateRules(c, others, limits).map((v) => v.code);

describe('roster rules', () => {
  it('no violations for a normal day', () => {
    expect(codes(duty('2026-11-10', '06:00', '14:00'), [duty('2026-11-09', '06:00', '14:00')])).toEqual([]);
  });

  it('daily duty-hour cap counts every duty on the date', () => {
    const c = duty('2026-11-10', '18:00', '22:00');
    expect(codes(c, [duty('2026-11-10', '06:00', '13:00')])).toContain('DUTY_HOURS_EXCEEDED');
    expect(codes(c, [duty('2026-11-10', '06:00', '11:00')])).not.toContain('DUTY_HOURS_EXCEEDED');
  });

  it('minimum rest applies across midnight on both sides', () => {
    // Night duty ends 02:00 on the 10th; next starts 06:00 → 4 h rest.
    const night = duty('2026-11-09', '20:00', '02:00');
    expect(codes(duty('2026-11-10', '06:00', '12:00'), [night])).toContain('MIN_REST_VIOLATED');
    expect(codes(duty('2026-11-10', '10:00', '16:00'), [night])).not.toContain('MIN_REST_VIOLATED');
    // A later duty too close after the candidate.
    expect(codes(duty('2026-11-10', '06:00', '12:00'), [duty('2026-11-10', '15:00', '17:00')])).toContain('MIN_REST_VIOLATED');
  });

  it('a seventh consecutive working day breaks the weekly off rule', () => {
    const others = ['2026-11-04', '2026-11-05', '2026-11-06', '2026-11-07', '2026-11-08', '2026-11-09'].map((d) => duty(d, '06:00', '14:00'));
    expect(codes(duty('2026-11-10', '06:00', '14:00'), others)).toContain('NO_WEEKLY_OFF');
    expect(codes(duty('2026-11-10', '06:00', '14:00'), others.slice(1))).not.toContain('NO_WEEKLY_OFF');
    // Days after the candidate count too.
    const around = ['2026-11-07', '2026-11-08', '2026-11-09', '2026-11-11', '2026-11-12', '2026-11-13'].map((d) => duty(d, '06:00', '14:00'));
    expect(codes(duty('2026-11-10', '06:00', '14:00'), around)).toContain('NO_WEEKLY_OFF');
  });

  it('detects overlapping duties', () => {
    const c = duty('2026-11-10', '06:00', '14:00');
    expect(overlappingDuties(c, [duty('2026-11-10', '13:00', '18:00')])).toHaveLength(1);
    expect(overlappingDuties(c, [duty('2026-11-10', '14:00', '18:00')])).toHaveLength(0);
  });
});
