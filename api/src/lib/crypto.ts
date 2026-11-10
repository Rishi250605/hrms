import { createCipheriv, createDecipheriv, createHmac, randomBytes, randomInt, timingSafeEqual } from 'node:crypto';

/**
 * Keyed hash for secrets we only need to compare (OTP codes, refresh tokens).
 * HMAC-SHA256 with a server-side pepper, hex encoded.
 */
export function hmacHash(value: string, pepper: string): string {
  return createHmac('sha256', pepper).update(value, 'utf8').digest('hex');
}

/** Constant-time comparison of two hex digests. */
export function safeEqualHex(a: string, b: string): boolean {
  const ba = Buffer.from(a, 'hex');
  const bb = Buffer.from(b, 'hex');
  if (ba.length !== bb.length || ba.length === 0) return false;
  return timingSafeEqual(ba, bb);
}

/** Cryptographically random numeric code, zero-padded (e.g. "042917"). */
export function randomNumericCode(digits = 6): string {
  return randomInt(0, 10 ** digits)
    .toString()
    .padStart(digits, '0');
}

/** Opaque URL-safe token (default 256 bits). */
export function randomToken(bytes = 32): string {
  return randomBytes(bytes).toString('base64url');
}

// ───────────── Field encryption (PAN, bank account) — AES-256-GCM ─────────────
// Format: v1.<iv b64url>.<auth tag b64url>.<ciphertext b64url>
const VERSION = 'v1';

export function encryptField(plaintext: string, keyBase64: string): string {
  const key = Buffer.from(keyBase64, 'base64');
  if (key.length !== 32) throw new Error('Encryption key must be 32 bytes');
  const iv = randomBytes(12);
  const cipher = createCipheriv('aes-256-gcm', key, iv);
  const ct = Buffer.concat([cipher.update(plaintext, 'utf8'), cipher.final()]);
  const tag = cipher.getAuthTag();
  return [VERSION, iv.toString('base64url'), tag.toString('base64url'), ct.toString('base64url')].join('.');
}

export function decryptField(payload: string, keyBase64: string): string {
  const [version, ivB64, tagB64, ctB64] = payload.split('.');
  if (version !== VERSION || !ivB64 || !tagB64 || ctB64 === undefined) {
    throw new Error('Unsupported encrypted payload');
  }
  const key = Buffer.from(keyBase64, 'base64');
  const decipher = createDecipheriv('aes-256-gcm', key, Buffer.from(ivB64, 'base64url'));
  decipher.setAuthTag(Buffer.from(tagB64, 'base64url'));
  return Buffer.concat([decipher.update(Buffer.from(ctB64, 'base64url')), decipher.final()]).toString('utf8');
}

/** "XXXXXXXX1234" style mask showing only the last 4 characters. */
export function maskLast4(value: string): string {
  if (value.length <= 4) return value;
  return 'X'.repeat(value.length - 4) + value.slice(-4);
}
