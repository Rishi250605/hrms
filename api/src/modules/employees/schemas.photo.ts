import { registry, z } from '../../lib/openapi.js';

export const PhotoBody = registry.register(
  'PhotoBody',
  z.object({ fileKey: z.string().min(10).max(300).openapi({ description: 'Key from POST /uploads/presign (purpose PHOTO)' }) }),
);
