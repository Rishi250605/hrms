import { readdirSync, readFileSync, statSync } from 'node:fs';
import { join } from 'node:path';
import { describe, expect, it } from 'vitest';
import { findUnauditedWrites } from './audit-coverage.js';

const root = join(import.meta.dirname, '..', '..', '..');

describe('audit coverage (CLAUDE.md §5: every write goes through audit.record)', () => {
  it('every Prisma write in services, jobs and lib is audited in the same top-level function', () => {
    const misses = findUnauditedWrites(root, ['src/modules', 'src/jobs', 'src/lib']).map((w) => `${w.file}:${w.line} ${w.fn} → ${w.write}`);
    expect(misses).toEqual([]);
  });

  it('no raw SQL writes bypass Prisma (and therefore the audit check)', () => {
    const files = (dir: string): string[] =>
      readdirSync(dir).flatMap((n) => {
        const p = join(dir, n);
        if (statSync(p).isDirectory()) return n === 'generated' ? [] : files(p);
        return n.endsWith('.ts') && !n.endsWith('.test.ts') ? [p] : [];
      });
    const raw = files(join(root, 'src'))
      .flatMap((f) => readFileSync(f, 'utf8').split('\n').map((line, i) => ({ f, line, i })))
      // A statement that starts with a write keyword (`SELECT … FOR UPDATE` row locks are fine).
      .filter(({ line }) => /\$(executeRaw|queryRaw)(Unsafe)?\s*`\s*(INSERT|UPDATE|DELETE|TRUNCATE)\b/i.test(line));
    expect(raw.map((r) => `${r.f}:${r.i + 1}`)).toEqual([]);
  });

  it('the checker itself flags an unaudited write', () => {
    // A self-test so a broken parser cannot silently pass the first case.
    const fixture = findUnauditedWrites(join(root, 'test'), ['fixtures']);
    expect(fixture.map((w) => `${w.fn} → ${w.write}`)).toEqual(['unaudited → employee.update']);
  });
});
