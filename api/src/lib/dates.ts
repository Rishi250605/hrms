/**
 * Business dates (duty date, attendance date, leave dates, document expiry) are calendar dates in
 * Asia/Kolkata (CLAUDE.md §5). In the API they travel as 'YYYY-MM-DD' strings; in Prisma, `@db.Date`
 * columns are JS Dates at UTC midnight. These helpers convert between the two and never apply a
 * timezone shift to a calendar date.
 */
export const BUSINESS_TZ = 'Asia/Kolkata';
const IST_OFFSET = '+05:30';
const DAY_MS = 24 * 60 * 60 * 1000;

const istDateFormatter = new Intl.DateTimeFormat('en-CA', {
  timeZone: BUSINESS_TZ,
  year: 'numeric',
  month: '2-digit',
  day: '2-digit',
});

/** Calendar date in IST of an instant, as 'YYYY-MM-DD'. */
export function istDateOf(instant: Date): string {
  return istDateFormatter.format(instant);
}

/** Today's business date in IST. */
export function todayIst(now: Date = new Date()): string {
  return istDateOf(now);
}

/** 'YYYY-MM-DD' → Date at UTC midnight (the value Prisma expects for a `@db.Date` column). */
export function toDbDate(isoDate: string): Date {
  const d = new Date(`${isoDate}T00:00:00.000Z`);
  if (Number.isNaN(d.getTime())) throw new Error(`Invalid date: ${isoDate}`);
  return d;
}

/** `@db.Date` value → 'YYYY-MM-DD'. */
export function fromDbDate(d: Date): string {
  return d.toISOString().slice(0, 10);
}

export function fromDbDateOrNull(d: Date | null | undefined): string | null {
  return d ? fromDbDate(d) : null;
}

export function addDays(isoDate: string, days: number): string {
  return fromDbDate(new Date(toDbDate(isoDate).getTime() + days * DAY_MS));
}

/** Whole days from `a` to `b` (b - a). */
export function diffDays(a: string, b: string): number {
  return Math.round((toDbDate(b).getTime() - toDbDate(a).getTime()) / DAY_MS);
}

/** 0 = Sunday … 6 = Saturday. */
export function dayOfWeek(isoDate: string): number {
  return toDbDate(isoDate).getUTCDay();
}

/** Inclusive list of dates from `from` to `to`. */
export function dateRange(from: string, to: string): string[] {
  const out: string[] = [];
  for (let d = from; d <= to; d = addDays(d, 1)) out.push(d);
  return out;
}

/** The instant of a wall-clock time ('HH:MM') on an IST business date. */
export function istInstant(isoDate: string, hhmm: string): Date {
  return new Date(`${isoDate}T${hhmm}:00.000${IST_OFFSET}`);
}

/** Wall-clock 'HH:MM' in IST of an instant. */
export function istTimeOf(instant: Date): string {
  return new Intl.DateTimeFormat('en-GB', { timeZone: BUSINESS_TZ, hour: '2-digit', minute: '2-digit', hourCycle: 'h23' }).format(instant);
}

export function isValidIsoDate(s: string): boolean {
  if (!/^\d{4}-\d{2}-\d{2}$/.test(s)) return false;
  const d = new Date(`${s}T00:00:00.000Z`);
  return !Number.isNaN(d.getTime()) && fromDbDate(d) === s;
}

export function minutesBetween(a: Date, b: Date): number {
  return Math.round((b.getTime() - a.getTime()) / 60000);
}
