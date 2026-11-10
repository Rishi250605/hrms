import argon2 from 'argon2';

/**
 * Password hashing (PHASE-2-FEATURES §1.3): argon2id with OWASP-recommended parameters.
 * Passwords are never logged or returned.
 */
export async function hashPassword(plain: string): Promise<string> {
  return argon2.hash(plain, { type: argon2.argon2id, memoryCost: 19_456, timeCost: 2, parallelism: 1 });
}

export async function verifyPassword(hash: string, plain: string): Promise<boolean> {
  try {
    return await argon2.verify(hash, plain);
  } catch {
    return false;
  }
}

/** A real hash of a random value, verified against for unknown accounts so timing does not reveal them. */
let dummyHash: Promise<string> | undefined;
export function dummyPasswordHash(): Promise<string> {
  dummyHash ??= hashPassword(`dummy-${Math.random()}`);
  return dummyHash;
}

/** Minimum rules for passwords the director sets. TODO(business): confirm the password policy. */
export const PASSWORD_RULE = { minLength: 8, maxLength: 128 } as const;
