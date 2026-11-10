import { describe, expect, it } from 'vitest';
import { toDbDate } from '../../lib/dates.js';
import { evaluateCompliance, evaluateType } from './compliance.js';
import type { DocLike } from './compliance.js';

let n = 0;
const doc = (over: Partial<DocLike> & Pick<DocLike, 'type'>): DocLike => ({
  id: `d${++n}`,
  status: 'VERIFIED',
  issueDate: null,
  expiryDate: null,
  verifiedAt: new Date(),
  ...over,
});
const d = toDbDate;

describe('document compliance evaluation', () => {
  it('valid (expiring) on the day of expiry, expired the day after', () => {
    const docs = [doc({ type: 'DRIVING_LICENCE', expiryDate: d('2026-11-10') })];
    expect(evaluateType('DRIVING_LICENCE', docs, '2026-11-09', 0).state).toBe('VALID');
    expect(evaluateType('DRIVING_LICENCE', docs, '2026-11-10', 0).state).toBe('EXPIRING');
    expect(evaluateType('DRIVING_LICENCE', docs, '2026-11-11', 0).state).toBe('EXPIRED');
  });

  it('flags EXPIRING inside the alert window but stays rosterable', () => {
    const docs = [doc({ type: 'DRIVING_LICENCE', expiryDate: d('2026-11-20') })];
    const c = evaluateCompliance(['DRIVING_LICENCE'], docs, '2026-11-10', 30);
    expect(c).toMatchObject({ overall: 'EXPIRING', rosterable: true });
  });

  it('unverified or rejected documents do not count', () => {
    expect(evaluateType('PSV_BADGE', [doc({ type: 'PSV_BADGE', status: 'PENDING_VERIFICATION', verifiedAt: null })], '2026-11-10', 30).state).toBe('UNVERIFIED');
    expect(evaluateType('PSV_BADGE', [doc({ type: 'PSV_BADGE', status: 'REJECTED', verifiedAt: null })], '2026-11-10', 30).state).toBe('REJECTED');
    expect(evaluateType('PSV_BADGE', [], '2026-11-10', 30).state).toBe('MISSING');
  });

  it('a document issued after the date is not yet valid', () => {
    const docs = [doc({ type: 'MEDICAL_FITNESS', issueDate: d('2026-12-01') })];
    expect(evaluateType('MEDICAL_FITNESS', docs, '2026-11-10', 30).state).toBe('MISSING');
  });

  it('a renewal wins over the old expired document; historical dates still use the old one', () => {
    const docs = [
      doc({ type: 'DRIVING_LICENCE', status: 'EXPIRED', expiryDate: d('2026-10-01') }),
      doc({ type: 'DRIVING_LICENCE', issueDate: d('2026-10-02'), expiryDate: d('2046-10-01') }),
    ];
    expect(evaluateType('DRIVING_LICENCE', docs, '2026-11-10', 30).state).toBe('VALID');
    expect(evaluateType('DRIVING_LICENCE', docs, '2026-09-15', 0)).toMatchObject({ state: 'VALID', expiryDate: '2026-10-01' });
  });

  it('overall is the worst state; MISSING blocks rostering', () => {
    const docs = [doc({ type: 'DRIVING_LICENCE' }), doc({ type: 'PSV_BADGE', expiryDate: d('2026-01-01'), status: 'EXPIRED' })];
    const c = evaluateCompliance(['DRIVING_LICENCE', 'PSV_BADGE', 'MEDICAL_FITNESS'], docs, '2026-11-10', 30);
    expect(c.overall).toBe('MISSING');
    expect(c.rosterable).toBe(false);
    expect(c.items.map((i) => i.state)).toEqual(['VALID', 'EXPIRED', 'MISSING']);
    expect(evaluateCompliance([], [], '2026-11-10', 30)).toMatchObject({ overall: 'OK', rosterable: true });
  });
});
