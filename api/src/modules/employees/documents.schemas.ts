import { registry, z } from '../../lib/openapi.js';
import { IsoDate, PageQuery } from '../../lib/schemas.js';
import { DepotSummary, DocumentStatusSchema, DocumentTypeSchema, EmployeeCategorySchema } from './schemas.js';

export const DocumentEmployee = registry.register(
  'DocumentEmployee',
  z.object({ id: z.uuid(), empCode: z.string(), fullName: z.string(), category: EmployeeCategorySchema, depot: DepotSummary.nullable() }),
);

export const DocumentItem = registry.register(
  'DocumentItem',
  z.object({
    id: z.uuid(),
    employeeId: z.uuid(),
    type: DocumentTypeSchema,
    number: z.string().openapi({ description: 'Masked for PAN; last 4 digits for Aadhaar' }),
    licenceClass: z.string().nullable(),
    issueDate: IsoDate.nullable(),
    expiryDate: IsoDate.nullable(),
    status: DocumentStatusSchema,
    hasFile: z.boolean(),
    verifiedAt: z.string().datetime().nullable(),
    verifiedByName: z.string().nullable(),
    rejectionReason: z.string().nullable(),
    createdAt: z.string().datetime(),
    daysToExpiry: z.number().int().nullable().openapi({ description: 'From today (IST); negative when already expired' }),
  }),
);

export const DocumentWithEmployee = registry.register('DocumentWithEmployee', DocumentItem.extend({ employee: DocumentEmployee }));

export const DocumentList = registry.register('DocumentList', z.object({ items: z.array(DocumentItem) }));
export const DocumentPage = registry.register('DocumentPage', z.object({ items: z.array(DocumentWithEmployee), nextCursor: z.uuid().nullable() }));
export const ExpiringDocumentList = registry.register('ExpiringDocumentList', z.object({ items: z.array(DocumentWithEmployee) }));

export const DocumentQuery = PageQuery.extend({
  businessUnitId: z.uuid().optional(),
  status: DocumentStatusSchema.optional(),
  type: DocumentTypeSchema.optional(),
  depotId: z.uuid().optional(),
});

export const ExpiringQuery = z.object({
  businessUnitId: z.uuid().optional(),
  withinDays: z.coerce.number().int().min(0).max(365).default(30),
  depotId: z.uuid().optional(),
  includeExpired: z
    .enum(['true', 'false'])
    .transform((v) => v === 'true')
    .optional()
    .openapi({ type: 'boolean', description: 'Also list the latest already-expired, not-yet-renewed documents' }),
});

export const DocumentCreateBody = registry.register(
  'DocumentCreateBody',
  z.object({
    type: DocumentTypeSchema,
    number: z
      .string()
      .trim()
      .min(4)
      .max(40)
      .openapi({ description: 'For AADHAAR send the last 4 digits (a 12-digit number is truncated to its last 4). For PAN the full PAN (stored encrypted).' }),
    licenceClass: z.string().trim().max(40).optional(),
    issueDate: IsoDate.optional(),
    expiryDate: IsoDate.optional(),
    fileKey: z.string().min(10).max(300).openapi({ description: 'Key returned by POST /uploads/presign after the file was uploaded' }),
  }),
);

export const DocumentVerifyBody = registry.register(
  'DocumentVerifyBody',
  z.object({
    expiryDate: IsoDate.optional().openapi({ description: 'Correct the expiry date while verifying' }),
    note: z.string().trim().max(500).optional(),
  }),
);
export const DocumentRejectBody = registry.register('DocumentRejectBody', z.object({ reason: z.string().trim().min(3).max(500) }));

export const SignedUrlResponse = registry.register(
  'SignedUrlResponse',
  z.object({ url: z.string(), method: z.enum(['GET', 'PUT']), headers: z.record(z.string(), z.string()), expiresAt: z.string().datetime() }),
);

export const PresignBody = registry.register(
  'PresignBody',
  z.object({
    employeeId: z.uuid().optional().openapi({ description: 'Required for DOCUMENT and PHOTO; VOICE_NOTE / RECEIPT files belong to the uploader' }),
    purpose: z.enum(['DOCUMENT', 'PHOTO', 'VOICE_NOTE', 'RECEIPT']).openapi({ description: 'VOICE_NOTE / RECEIPT files belong to the uploader (allowance requests)' }),
    contentType: z.enum(['image/jpeg', 'image/png', 'image/webp', 'application/pdf', 'audio/mp4', 'audio/aac', 'audio/m4a', 'audio/x-m4a']),
    sizeBytes: z.number().int().positive(),
  }),
);

export const PresignResponse = registry.register(
  'PresignResponse',
  SignedUrlResponse.extend({ key: z.string().openapi({ description: 'Send this as fileKey when creating the document' }) }),
);

export const DocumentRequirementItem = registry.register(
  'DocumentRequirementItem',
  z.object({ category: EmployeeCategorySchema, documentTypes: z.array(DocumentTypeSchema) }),
);
export const DocumentRequirementList = registry.register('DocumentRequirementList', z.object({ items: z.array(DocumentRequirementItem) }));
export const CategoryParams = z.object({ category: EmployeeCategorySchema });
export const DocumentRequirementBody = registry.register(
  'DocumentRequirementBody',
  z.object({ documentTypes: z.array(DocumentTypeSchema).max(8) }),
);

export const EmployeeDocParams = z.object({ id: z.uuid() });
