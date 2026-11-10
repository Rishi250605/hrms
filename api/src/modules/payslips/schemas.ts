import { registry, z } from '../../lib/openapi.js';
import { PageQuery, Period } from '../../lib/schemas.js';
import { SignedUrlResponse } from '../employees/documents.schemas.js';
import { BusinessUnitRef } from '../employees/schemas.js';
import { PersonRef } from '../users/schemas.js';

/** Hard limits of the multipart upload; the per-file size setting (payslips.maxFileBytes) is checked per file below this. */
export const PAYSLIP_UPLOAD_MAX_FILES = 100;
export const PAYSLIP_UPLOAD_MAX_FILE_BYTES = 10 * 1024 * 1024;

export const PeriodQuery = z.object({ period: Period });

const PayslipEmployee = PersonRef.extend({ category: z.string() });

export const PayslipItem = registry.register(
  'PayslipItem',
  z.object({
    id: z.uuid(),
    employee: PayslipEmployee,
    businessUnit: BusinessUnitRef,
    period: z.string(),
    version: z.number().int(),
    sizeBytes: z.number().int(),
    uploadedAt: z.string().datetime(),
  }),
);
export const PayslipPage = registry.register('PayslipPage', z.object({ items: z.array(PayslipItem), nextCursor: z.uuid().nullable() }));

export const PayslipQuery = PageQuery.extend({
  period: Period.optional(),
  scope: z.enum(['mine', 'team', 'all']).default('mine').openapi({ description: 'mine: my own; team: people I can see (§7.2), not me; all: HR / director' }),
  businessUnitId: z.uuid().optional(),
  q: z.string().trim().min(1).max(60).optional().openapi({ description: 'Name or employee code contains' }),
});

export const PayslipUploadMatch = registry.register(
  'PayslipUploadMatch',
  z.object({ fileName: z.string(), payslipId: z.uuid(), employee: PersonRef, version: z.number().int() }),
);
export const PayslipUploadResult = registry.register(
  'PayslipUploadResult',
  z.object({
    period: z.string(),
    matched: z.array(PayslipUploadMatch),
    replaced: z.array(PayslipUploadMatch).openapi({ description: 'Matched files that replaced an earlier upload (new version)' }),
    unmatched: z.array(z.string()).openapi({ description: 'File names whose employee code is unknown or outside your business units' }),
    invalid: z.array(z.object({ fileName: z.string(), reason: z.enum(['NAME_FORMAT', 'NOT_PDF', 'TOO_LARGE', 'EMPTY']) })),
    duplicates: z.array(z.string()).openapi({ description: 'Several files for the same employee in one upload; none of them was stored' }),
  }),
);

export const DownloadQuery = z.object({ version: z.coerce.number().int().min(1).optional().openapi({ description: 'Earlier version (HR / director only)' }) });
export const PayslipDownload = SignedUrlResponse;

export const PayslipVersionList = registry.register(
  'PayslipVersionList',
  z.object({
    items: z.array(
      z.object({ version: z.number().int(), sizeBytes: z.number().int(), originalName: z.string(), uploadedByName: z.string().nullable(), uploadedAt: z.string().datetime() }),
    ),
  }),
);
