import { registry, z } from '../../lib/openapi.js';
import { IsoDate, PageQuery } from '../../lib/schemas.js';
import { DocumentStatus, DocumentType, EmployeeCategory, EmployeeStatus, EmploymentType, Gender, PreferredChannel } from '../../generated/prisma/enums.js';
import { EmpCodeSchema, PhoneSchema } from '../auth/schemas.js';
import { BusinessUnitMembership, PersonRef, RoleSchema } from '../users/schemas.js';

export const EmployeeCategorySchema = registry.register('EmployeeCategory', z.enum(EmployeeCategory));
export const EmploymentTypeSchema = registry.register('EmploymentType', z.enum(EmploymentType));
export const EmployeeStatusSchema = registry.register('EmployeeStatus', z.enum(EmployeeStatus));
export const GenderSchema = registry.register('Gender', z.enum(Gender));
export const PreferredChannelSchema = registry.register('PreferredChannel', z.enum(PreferredChannel));
export const DocumentTypeSchema = registry.register('DocumentType', z.enum(DocumentType));
export const DocumentStatusSchema = registry.register('DocumentStatus', z.enum(DocumentStatus));

/** Per required document type, as of a date. */
export const ComplianceState = registry.register('ComplianceState', z.enum(['VALID', 'EXPIRING', 'UNVERIFIED', 'EXPIRED', 'REJECTED', 'MISSING']));
/** Worst state across an employee's required documents. */
export const ComplianceOverall = registry.register('ComplianceOverall', z.enum(['OK', 'EXPIRING', 'PENDING_VERIFICATION', 'EXPIRED', 'MISSING']));

export const ComplianceItem = registry.register(
  'ComplianceItem',
  z.object({ type: DocumentTypeSchema, state: ComplianceState, documentId: z.uuid().nullable(), expiryDate: IsoDate.nullable() }),
);

export const Compliance = registry.register(
  'Compliance',
  z.object({
    asOf: IsoDate,
    overall: ComplianceOverall,
    /** True when every required document is valid on `asOf` (the employee may be rostered). */
    rosterable: z.boolean(),
    items: z.array(ComplianceItem),
  }),
);

export const DepotSummary = registry.register('DepotSummary', z.object({ id: z.uuid(), code: z.string(), name: z.string() }));
export const BusinessUnitRef = registry.register('BusinessUnitRef', z.object({ id: z.uuid(), code: z.string(), name: z.string() }));

export const EmployeeListItem = registry.register(
  'EmployeeListItem',
  z.object({
    id: z.uuid(),
    empCode: z.string(),
    fullName: z.string(),
    phone: z.string(),
    category: EmployeeCategorySchema,
    role: RoleSchema.nullable().openapi({ description: 'Login role; null for drivers / loadmen and other non-login staff' }),
    employmentType: EmploymentTypeSchema,
    status: EmployeeStatusSchema,
    designation: z.string().nullable(),
    depot: DepotSummary.nullable(),
    businessUnit: BusinessUnitRef.nullable().openapi({ description: 'Primary business unit' }),
    reportingTo: PersonRef.nullable(),
    compliance: ComplianceOverall,
  }),
);

export const EmployeePage = registry.register('EmployeePage', z.object({ items: z.array(EmployeeListItem), nextCursor: z.uuid().nullable() }));

export const EmployeeListQuery = PageQuery.extend({
  q: z.string().trim().max(100).optional().openapi({ description: 'Name, employee ID or phone' }),
  businessUnitId: z.uuid().optional(),
  depotId: z.uuid().optional(),
  category: EmployeeCategorySchema.optional(),
  role: RoleSchema.optional(),
  staffOnly: z
    .enum(['true', 'false'])
    .transform((v) => v === 'true')
    .optional()
    .openapi({ type: 'boolean', description: 'Only non-login staff (drivers, loadmen, …)' }),
  reportingToEmployeeId: z.uuid().optional().openapi({ description: 'Direct reports of this employee' }),
  status: EmployeeStatusSchema.optional().openapi({ description: 'Default: everyone except EXITED' }),
  compliance: ComplianceOverall.optional(),
});

export const EmployeeJobItem = registry.register(
  'EmployeeJobItem',
  z.object({
    id: z.uuid(),
    depot: DepotSummary,
    designation: z.string(),
    grade: z.string().nullable(),
    reportingTo: PersonRef.nullable(),
    effectiveFrom: IsoDate,
    effectiveTo: IsoDate.nullable().openapi({ description: 'Exclusive; null = open' }),
    changeReason: z.string().nullable(),
  }),
);

export const EmployeeDetail = registry.register(
  'EmployeeDetail',
  EmployeeListItem.omit({ compliance: true }).extend({
    altPhone: z.string().nullable(),
    dob: IsoDate.nullable(),
    gender: GenderSchema.nullable(),
    joiningDate: IsoDate,
    exitDate: IsoDate.nullable(),
    exitReason: z.string().nullable(),
    contractorName: z.string().nullable(),
    uan: z.string().nullable(),
    esicNo: z.string().nullable(),
    aadhaarLast4: z.string().nullable(),
    panMasked: z.string().nullable().openapi({ description: 'HR / director only' }),
    hasBankDetails: z.boolean().openapi({ description: 'HR / director only; false for other roles' }),
    preferredChannel: PreferredChannelSchema,
    hasPhoto: z.boolean(),
    hasLogin: z.boolean(),
    businessUnits: z.array(BusinessUnitMembership),
    currentJob: EmployeeJobItem.nullable(),
    jobs: z.array(EmployeeJobItem).openapi({ description: 'Full job history, newest first' }),
    compliance: Compliance,
  }),
);

const Pan = z
  .string()
  .trim()
  .toUpperCase()
  .regex(/^[A-Z]{5}[0-9]{4}[A-Z]$/, 'Invalid PAN');
const Ifsc = z
  .string()
  .trim()
  .toUpperCase()
  .regex(/^[A-Z]{4}0[A-Z0-9]{6}$/, 'Invalid IFSC');
const BankAccount = z
  .string()
  .trim()
  .regex(/^\d{9,18}$/, 'Invalid account number');
const Name = z.string().trim().min(2).max(120);

export const JobInput = registry.register(
  'JobInput',
  z.object({
    depotId: z.uuid().openapi({ description: 'Must belong to the business unit' }),
    designation: z.string().trim().min(2).max(80),
    grade: z.string().trim().max(40).optional(),
    reportingToEmployeeId: z.uuid().openapi({ description: 'The regional manager (sharing the business unit)' }),
  }),
);

/** Onboarding of non-login staff (drivers, loadmen, …) by HR / the director. Logins are created via POST /users. */
export const EmployeeCreateBody = registry.register(
  'EmployeeCreateBody',
  z.object({
    empCode: EmpCodeSchema.openapi({ description: 'BU code + digits, e.g. NLS001 (GET /employees/next-code suggests one)' }),
    fullName: Name,
    phone: PhoneSchema,
    altPhone: PhoneSchema.optional(),
    dob: IsoDate.optional(),
    gender: GenderSchema.optional(),
    joiningDate: IsoDate,
    category: EmployeeCategorySchema,
    employmentType: EmploymentTypeSchema,
    contractorName: z.string().trim().max(120).optional(),
    preferredChannel: PreferredChannelSchema.optional(),
    businessUnitId: z.uuid().openapi({ description: 'Drivers / loadmen belong to exactly one business unit' }),
    uan: z
      .string()
      .regex(/^\d{12}$/)
      .optional(),
    esicNo: z
      .string()
      .regex(/^\d{10,17}$/)
      .optional(),
    pan: Pan.optional(),
    aadhaarLast4: z
      .string()
      .regex(/^\d{4}$/, 'Only the last 4 digits of Aadhaar are stored')
      .optional(),
    bankAccount: BankAccount.optional(),
    ifsc: Ifsc.optional(),
    job: JobInput,
  }),
);

export const EmployeeUpdateBody = registry.register(
  'EmployeeUpdateBody',
  z.object({
    fullName: Name.optional(),
    phone: PhoneSchema.optional(),
    altPhone: PhoneSchema.nullable().optional(),
    dob: IsoDate.nullable().optional(),
    gender: GenderSchema.nullable().optional(),
    category: EmployeeCategorySchema.optional(),
    employmentType: EmploymentTypeSchema.optional(),
    contractorName: z.string().trim().max(120).nullable().optional(),
    preferredChannel: PreferredChannelSchema.optional(),
    uan: z
      .string()
      .regex(/^\d{12}$/)
      .nullable()
      .optional(),
    esicNo: z
      .string()
      .regex(/^\d{10,17}$/)
      .nullable()
      .optional(),
    pan: Pan.nullable().optional(),
    aadhaarLast4: z
      .string()
      .regex(/^\d{4}$/)
      .nullable()
      .optional(),
    status: z.enum(['ACTIVE', 'SUSPENDED']).optional().openapi({ description: 'Suspend / reinstate. Exits go through POST /employees/{id}/exit.' }),
  }),
);

export const JobChangeBody = registry.register(
  'JobChangeBody',
  z.object({
    effectiveFrom: IsoDate,
    depotId: z.uuid().optional(),
    designation: z.string().trim().min(2).max(80).optional(),
    grade: z.string().trim().max(40).nullable().optional(),
    reportingToEmployeeId: z.uuid().optional(),
    reason: z.string().trim().min(2).max(500),
  }),
);

/** Role change of a login (decision Q1: roles change only through an HR promotion). */
export const PromotionBody = registry.register(
  'PromotionBody',
  z.object({
    role: RoleSchema.exclude(['DIRECTOR']),
    reportingToEmployeeId: z.uuid().openapi({ description: 'New reporting manager (one role above the new role)' }),
    effectiveFrom: IsoDate,
    designation: z.string().trim().min(2).max(80).optional(),
    reason: z.string().trim().min(2).max(500),
  }),
);

export const PromotionResult = registry.register(
  'PromotionResult',
  z.object({
    employee: EmployeeDetail,
    reportsNeedingReassignment: z.array(PersonRef).openapi({ description: 'Direct reports whose reporting line is no longer valid' }),
  }),
);

export const BusinessUnitsBody = registry.register(
  'BusinessUnitsBody',
  z.object({ businessUnitIds: z.array(z.uuid()).min(1).max(20), primaryBusinessUnitId: z.uuid() }),
);

export const NextCodeQuery = z.object({ businessUnitId: z.uuid() });
export const NextCodeResponse = registry.register('NextCodeResponse', z.object({ empCode: z.string() }));

export const ExitBody = registry.register('ExitBody', z.object({ exitDate: IsoDate, reason: z.string().trim().min(2).max(500) }));

export const BankDetails = registry.register('BankDetails', z.object({ accountMasked: z.string().nullable(), ifsc: z.string().nullable() }));
export const BankDetailsBody = registry.register('BankDetailsBody', z.object({ bankAccount: BankAccount, ifsc: Ifsc }));
