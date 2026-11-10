import { registry, z } from '../../lib/openapi.js';
import { IsoDate, PageQuery, Period } from '../../lib/schemas.js';
import { RequestStatusSchema } from '../attendance/schemas.js';
import { SignedUrlResponse } from '../employees/documents.schemas.js';
import { BusinessUnitRef } from '../employees/schemas.js';
import { PersonRef } from '../users/schemas.js';

export const AllowanceTypeItem = registry.register(
  'AllowanceTypeItem',
  z.object({ id: z.uuid(), code: z.string(), name: z.string(), maxAmountPaise: z.number().int().nullable(), isActive: z.boolean() }),
);
export const AllowanceTypeList = registry.register('AllowanceTypeList', z.object({ items: z.array(AllowanceTypeItem) }));
export const AllowanceTypeCreateBody = registry.register(
  'AllowanceTypeCreateBody',
  z.object({
    code: z
      .string()
      .trim()
      .toUpperCase()
      .regex(/^[A-Z0-9_]{2,20}$/),
    name: z.string().trim().min(2).max(60),
    maxAmountPaise: z.number().int().positive().optional(),
  }),
);
export const AllowanceTypeUpdateBody = registry.register(
  'AllowanceTypeUpdateBody',
  z.object({ name: z.string().trim().min(2).max(60).optional(), maxAmountPaise: z.number().int().positive().nullable().optional(), isActive: z.boolean().optional() }),
);

export const AllowanceItem = registry.register(
  'AllowanceItem',
  z.object({
    id: z.uuid(),
    batchId: z.uuid(),
    beneficiary: PersonRef,
    raisedBy: PersonRef,
    businessUnit: BusinessUnitRef,
    allowanceType: z.object({ id: z.uuid(), code: z.string(), name: z.string() }),
    requestedAmountPaise: z.number().int(),
    approvedAmountPaise: z.number().int().nullable(),
    fromDate: IsoDate,
    toDate: IsoDate,
    comment: z.string().nullable(),
    hasVoiceNote: z.boolean(),
    hasReceipt: z.boolean(),
    status: RequestStatusSchema,
    approver: PersonRef.nullable(),
    decidedAt: z.string().datetime().nullable(),
    decidedByName: z.string().nullable(),
    decisionComment: z.string().nullable(),
    rejectionReason: z.string().nullable(),
    canDecide: z.boolean(),
    createdAt: z.string().datetime(),
  }),
);
export const AllowancePage = registry.register('AllowancePage', z.object({ items: z.array(AllowanceItem), nextCursor: z.uuid().nullable() }));
export const AllowanceList = registry.register('AllowanceList', z.object({ items: z.array(AllowanceItem) }));

export const AllowanceQuery = PageQuery.extend({
  scope: z.enum(['mine', 'team', 'approvals', 'all']).default('mine').openapi({ description: 'mine: raised by me or for me; team: my reports; approvals: waiting for me; all: HR / director' }),
  status: RequestStatusSchema.optional(),
  businessUnitId: z.uuid().optional(),
  batchId: z.uuid().optional(),
  from: IsoDate.optional(),
  to: IsoDate.optional(),
});

export const AllowanceCreateBody = registry.register(
  'AllowanceCreateBody',
  z.object({
    beneficiaryEmployeeIds: z
      .array(z.uuid())
      .min(1)
      .max(100)
      .optional()
      .openapi({ description: 'RM: drivers / loadmen reporting to them (one request each, same batch). Omit for yourself.' }),
    allowanceTypeId: z.uuid(),
    amountPaise: z.number().int().positive().openapi({ description: 'Per beneficiary, in paise' }),
    fromDate: IsoDate,
    toDate: IsoDate.optional(),
    comment: z.string().trim().max(1000).optional(),
    voiceNoteKey: z.string().max(300).optional().openapi({ description: 'From POST /uploads/presign (purpose VOICE_NOTE), max 2 minutes' }),
    receiptKey: z.string().max(300).optional().openapi({ description: 'From POST /uploads/presign (purpose RECEIPT)' }),
  }),
);

export const AllowanceApproveBody = registry.register(
  'AllowanceApproveBody',
  z.object({
    approvedAmountPaise: z.number().int().positive().optional().openapi({ description: 'Approve a different amount (a comment is then required)' }),
    comment: z.string().trim().max(500).optional(),
  }),
);
export const BatchParams = z.object({ batchId: z.uuid() });
export const BatchApproveResult = registry.register('BatchApproveResult', z.object({ approved: z.array(z.uuid()), skipped: z.array(z.uuid()) }));

export const AllowanceFiles = registry.register(
  'AllowanceFiles',
  z.object({ voiceNote: SignedUrlResponse.nullable(), receipt: SignedUrlResponse.nullable() }),
);

export const AllowanceSummaryQuery = z.object({
  month: Period,
  businessUnitId: z.uuid().optional(),
});
export const AllowanceSummary = registry.register(
  'AllowanceSummary',
  z.object({
    month: z.string(),
    items: z.array(
      z.object({
        businessUnit: BusinessUnitRef,
        requests: z.number().int(),
        pending: z.number().int(),
        requestedPaise: z.number().int(),
        approvedPaise: z.number().int(),
      }),
    ),
  }),
);
