import { logger } from '../lib/logger.js';
import { prisma } from '../lib/prisma.js';

/** Deletes refresh tokens that expired more than 7 days ago. */
export async function purgeExpiredAuth(now = new Date()): Promise<{ refreshTokens: number }> {
  const weekAgo = new Date(now.getTime() - 7 * 24 * 60 * 60 * 1000);
  const refreshTokens = await prisma.refreshToken.deleteMany({ where: { expiresAt: { lt: weekAgo } } });
  const result = { refreshTokens: refreshTokens.count };
  logger.info(result, 'Purged expired auth records');
  return result;
}
