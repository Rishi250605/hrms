import { registry, z } from '../../lib/openapi.js';
import { normalizePhone } from './phone.js';

export const PhoneSchema = z
  .string()
  .min(10)
  .max(20)
  .transform((value, ctx) => {
    const phone = normalizePhone(value);
    if (!phone) {
      ctx.addIssue({ code: 'custom', message: 'Enter a valid mobile number' });
      return z.NEVER;
    }
    return phone;
  })
  .openapi({ type: 'string', example: '+919876543210', description: 'E.164, or a 10-digit Indian mobile number' });

/** Employee ID: case-insensitive; stored and compared upper-case. */
export const EmpCodeSchema = z
  .string()
  .trim()
  .min(2)
  .max(20)
  .transform((s) => s.toUpperCase())
  .openapi({ type: 'string', example: 'NLS001' });

export const LoginBody = registry.register(
  'LoginBody',
  z.object({ empCode: EmpCodeSchema, password: z.string().min(1).max(200) }),
);

export const TokenPair = registry.register(
  'TokenPair',
  z.object({
    accessToken: z.string(),
    accessTokenExpiresAt: z.string().datetime(),
    refreshToken: z.string(),
    refreshTokenExpiresAt: z.string().datetime(),
    tokenType: z.literal('Bearer'),
  }),
);

export const RefreshBody = registry.register('RefreshBody', z.object({ refreshToken: z.string().min(20).max(200) }));
export const LogoutBody = registry.register('LogoutBody', z.object({ refreshToken: z.string().min(20).max(200) }));
