import { describe, expect, it } from 'vitest';
import { decryptField, encryptField, hmacHash, maskLast4, randomNumericCode, randomToken, safeEqualHex } from './crypto.js';

const KEY = Buffer.alloc(32, 1).toString('base64');

describe('crypto', () => {
  it('encrypts and decrypts a field with AES-256-GCM', () => {
    const ct = encryptField('ABCDE1234F', KEY);
    expect(ct.startsWith('v1.')).toBe(true);
    expect(ct).not.toContain('ABCDE1234F');
    expect(decryptField(ct, KEY)).toBe('ABCDE1234F');
  });

  it('uses a fresh IV per encryption', () => {
    expect(encryptField('same', KEY)).not.toBe(encryptField('same', KEY));
  });

  it('rejects tampered ciphertext', () => {
    const parts = encryptField('123456789012', KEY).split('.');
    const ct = Buffer.from(parts[3]!, 'base64url');
    ct[0] = ct[0]! ^ 0xff;
    parts[3] = ct.toString('base64url');
    expect(() => decryptField(parts.join('.'), KEY)).toThrow();
  });

  it('rejects a wrong key', () => {
    const ct = encryptField('secret', KEY);
    expect(() => decryptField(ct, Buffer.alloc(32, 2).toString('base64'))).toThrow();
  });

  it('hmacHash is deterministic and pepper-dependent', () => {
    expect(hmacHash('x', 'p1')).toBe(hmacHash('x', 'p1'));
    expect(hmacHash('x', 'p1')).not.toBe(hmacHash('x', 'p2'));
  });

  it('safeEqualHex compares digests', () => {
    const a = hmacHash('a', 'p');
    expect(safeEqualHex(a, a)).toBe(true);
    expect(safeEqualHex(a, hmacHash('b', 'p'))).toBe(false);
    expect(safeEqualHex(a, '')).toBe(false);
  });

  it('generates 6-digit numeric codes and random tokens', () => {
    for (let i = 0; i < 50; i++) expect(randomNumericCode()).toMatch(/^\d{6}$/);
    expect(randomToken()).toMatch(/^[A-Za-z0-9_-]{43}$/);
    expect(randomToken()).not.toBe(randomToken());
  });

  it('masks all but the last 4 characters', () => {
    expect(maskLast4('123456789012')).toBe('XXXXXXXX9012');
    expect(maskLast4('12')).toBe('12');
  });
});
