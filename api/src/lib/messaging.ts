import { env } from '../config/env.js';
import { logger } from './logger.js';

/**
 * Provider-agnostic outbound messaging (SMS / WhatsApp).
 * Production adapters (e.g. a WhatsApp BSP or SMS gateway) implement this interface.
 * TODO(business): choose WhatsApp/SMS provider (CLAUDE.md §13) and add its adapter + DLT template ids.
 */
export type MessageChannel = 'SMS' | 'WHATSAPP';

export interface OutboundMessage {
  to: string; // E.164
  channel: MessageChannel;
  template: string;
  params: Record<string, string>;
}

export interface SendResult {
  providerRef: string;
}

export interface MessagingService {
  send(message: OutboundMessage): Promise<SendResult>;
}

/** Dev adapter: writes the message to the log instead of sending it. */
export class ConsoleMessagingService implements MessagingService {
  public readonly sent: OutboundMessage[] = [];

  async send(message: OutboundMessage): Promise<SendResult> {
    this.sent.push(message);
    logger.info({ messaging: { to: message.to, channel: message.channel, template: message.template, params: message.params } }, 'console messaging: message "sent"');
    return { providerRef: `console-${Date.now()}` };
  }
}

let instance: MessagingService | undefined;

export function getMessagingService(): MessagingService {
  if (!instance) {
    instance = createMessagingService(env.MESSAGING_PROVIDER);
  }
  return instance;
}

function createMessagingService(provider: typeof env.MESSAGING_PROVIDER): MessagingService {
  switch (provider) {
    case 'console':
      return new ConsoleMessagingService();
  }
}

/** Test hook. */
export function setMessagingService(service: MessagingService): void {
  instance = service;
}
