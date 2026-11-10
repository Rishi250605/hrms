import { importPKCS8, SignJWT } from 'jose';
import { env } from '../config/env.js';
import { logger } from './logger.js';

/**
 * Push notifications to managers' devices (FCM). Drivers never receive push — they are not app users.
 */
export interface PushMessage {
  title: string;
  body: string;
  /** String-only key/values delivered to the app (e.g. { type: 'APPROVAL', id }). */
  data?: Record<string, string>;
}

export interface PushResult {
  sent: number;
  /** Tokens FCM reported as unregistered/invalid; the caller deletes them. */
  invalidTokens: string[];
  failed: number;
}

export interface PushService {
  send(tokens: string[], message: PushMessage): Promise<PushResult>;
}

/** Dev adapter: logs instead of sending. */
export class ConsolePushService implements PushService {
  readonly sent: { tokens: string[]; message: PushMessage }[] = [];

  async send(tokens: string[], message: PushMessage): Promise<PushResult> {
    this.sent.push({ tokens, message });
    logger.info({ push: { devices: tokens.length, title: message.title, data: message.data } }, 'console push: notification "sent"');
    return { sent: tokens.length, invalidTokens: [], failed: 0 };
  }
}

interface ServiceAccount {
  project_id: string;
  client_email: string;
  private_key: string;
  token_uri?: string;
}

/**
 * FCM HTTP v1 without the firebase-admin SDK: a service-account JWT is exchanged for an OAuth token
 * (cached until shortly before expiry), then one request per device token.
 */
export class FcmPushService implements PushService {
  private readonly account: ServiceAccount;
  private cached: { token: string; expiresAt: number } | undefined;

  constructor(serviceAccountB64: string) {
    this.account = JSON.parse(Buffer.from(serviceAccountB64, 'base64').toString('utf8')) as ServiceAccount;
  }

  private async accessToken(): Promise<string> {
    if (this.cached && this.cached.expiresAt > Date.now() + 60_000) return this.cached.token;
    const tokenUri = this.account.token_uri ?? 'https://oauth2.googleapis.com/token';
    const key = await importPKCS8(this.account.private_key, 'RS256');
    const now = Math.floor(Date.now() / 1000);
    const assertion = await new SignJWT({ scope: 'https://www.googleapis.com/auth/firebase.messaging' })
      .setProtectedHeader({ alg: 'RS256', typ: 'JWT' })
      .setIssuer(this.account.client_email)
      .setSubject(this.account.client_email)
      .setAudience(tokenUri)
      .setIssuedAt(now)
      .setExpirationTime(now + 3600)
      .sign(key);
    const res = await fetch(tokenUri, {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: new URLSearchParams({ grant_type: 'urn:ietf:params:oauth:grant-type:jwt-bearer', assertion }),
    });
    if (!res.ok) throw new Error(`FCM auth failed: ${res.status}`);
    const json = (await res.json()) as { access_token: string; expires_in: number };
    this.cached = { token: json.access_token, expiresAt: Date.now() + json.expires_in * 1000 };
    return json.access_token;
  }

  async send(tokens: string[], message: PushMessage): Promise<PushResult> {
    const result: PushResult = { sent: 0, invalidTokens: [], failed: 0 };
    if (tokens.length === 0) return result;
    const bearer = await this.accessToken();
    const url = `https://fcm.googleapis.com/v1/projects/${this.account.project_id}/messages:send`;
    await Promise.all(
      tokens.map(async (token) => {
        const res = await fetch(url, {
          method: 'POST',
          headers: { Authorization: `Bearer ${bearer}`, 'Content-Type': 'application/json' },
          body: JSON.stringify({
            message: { token, notification: { title: message.title, body: message.body }, data: message.data ?? {} },
          }),
        });
        if (res.ok) {
          result.sent += 1;
        } else if (res.status === 404 || res.status === 400) {
          // UNREGISTERED / INVALID_ARGUMENT: the token is dead.
          result.invalidTokens.push(token);
        } else {
          result.failed += 1;
          logger.warn({ status: res.status }, 'FCM send failed');
        }
      }),
    );
    return result;
  }
}

let instance: PushService | undefined;

export function getPushService(): PushService {
  if (!instance) {
    instance = env.PUSH_PROVIDER === 'fcm' && env.FCM_SERVICE_ACCOUNT_B64 ? new FcmPushService(env.FCM_SERVICE_ACCOUNT_B64) : new ConsolePushService();
  }
  return instance;
}

/** Test hook. */
export function setPushService(service: PushService): void {
  instance = service;
}
