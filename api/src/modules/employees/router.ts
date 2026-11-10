import { ModuleRouter } from '../../lib/route.js';
import { IdParams } from '../../lib/schemas.js';
import * as c from './controller.js';
import {
  CategoryParams,
  DocumentCreateBody,
  DocumentItem,
  DocumentList,
  DocumentPage,
  DocumentQuery,
  DocumentRejectBody,
  DocumentRequirementBody,
  DocumentRequirementItem,
  DocumentRequirementList,
  DocumentVerifyBody,
  DocumentWithEmployee,
  ExpiringDocumentList,
  ExpiringQuery,
  PresignBody,
  PresignResponse,
  SignedUrlResponse,
} from './documents.schemas.js';
import {
  BankDetails,
  BankDetailsBody,
  BusinessUnitsBody,
  EmployeeCreateBody,
  EmployeeDetail,
  EmployeeListQuery,
  EmployeePage,
  EmployeeUpdateBody,
  ExitBody,
  JobChangeBody,
  NextCodeQuery,
  NextCodeResponse,
  PromotionBody,
  PromotionResult,
} from './schemas.js';
import { PhotoBody } from './schemas.photo.js';

export const employeesRouter = new ModuleRouter('/employees', 'Employees')
  .route({
    method: 'get',
    path: '/',
    operationId: 'listEmployees',
    summary: 'Employees in my scope',
    description: 'Business unit + reporting line (§11): RM their reports, OM their RMs and their teams, HR / director everyone in their BUs. EXITED left out unless status=EXITED.',
    access: { roles: 'any' },
    query: EmployeeListQuery,
    response: { status: 200, description: 'A page of employees', schema: EmployeePage },
    handler: c.list,
  })
  .route({
    method: 'post',
    path: '/',
    operationId: 'createEmployee',
    summary: 'Onboard an employee with their first job row',
    access: { roles: ['HR', 'DIRECTOR'] },
    body: EmployeeCreateBody,
    response: { status: 201, description: 'Created', schema: EmployeeDetail },
    errors: { 404: 'Depot not found', 409: 'Employee code already used' },
    handler: c.create,
  })
  .route({
    method: 'get',
    path: '/next-code',
    operationId: 'suggestEmpCode',
    summary: 'Next free employee ID for a business unit (e.g. NLS014)',
    access: { roles: ['HR', 'DIRECTOR'] },
    query: NextCodeQuery,
    response: { status: 200, description: 'Suggestion (HR may use another free code)', schema: NextCodeResponse },
    errors: { 403: 'Not your business unit', 404: 'Business unit not found' },
    handler: c.nextCode,
  })
  .route({
    method: 'post',
    path: '/:id/promotion',
    operationId: 'promoteEmployee',
    summary: 'Change the role of a login (promotion) with its new reporting line',
    description: 'The only way a role changes (decision Q1). Returns direct reports that must be reassigned.',
    access: { roles: ['HR', 'DIRECTOR'] },
    params: IdParams,
    body: PromotionBody,
    response: { status: 200, description: 'Promoted', schema: PromotionResult },
    errors: { 404: 'Not found', 409: 'NO_LOGIN, SAME_ROLE or JOB_CHANGE_BEFORE_CURRENT', 422: 'INVALID_REPORTING_LINE' },
    handler: c.promote,
  })
  .route({
    method: 'put',
    path: '/:id/business-units',
    operationId: 'setEmployeeBusinessUnits',
    summary: 'Set business-unit membership (staff: exactly one; managers: one or more with a primary)',
    access: { roles: ['HR', 'DIRECTOR'] },
    params: IdParams,
    body: BusinessUnitsBody,
    response: { status: 200, description: 'Updated', schema: EmployeeDetail },
    errors: { 403: 'Not your business unit, or HR changing a manager', 404: 'Not found' },
    handler: c.setBusinessUnits,
  })
  .route({
    method: 'get',
    path: '/:id',
    operationId: 'getEmployee',
    summary: 'Employee profile with job history and document compliance',
    access: { roles: 'any' },
    params: IdParams,
    response: { status: 200, description: 'The employee', schema: EmployeeDetail },
    errors: { 404: 'Not found or out of scope' },
    handler: c.get,
  })
  .route({
    method: 'patch',
    path: '/:id',
    operationId: 'updateEmployee',
    summary: 'Update personal details, or suspend / reinstate',
    access: { roles: ['HR', 'DIRECTOR'] },
    params: IdParams,
    body: EmployeeUpdateBody,
    response: { status: 200, description: 'Updated', schema: EmployeeDetail },
    errors: { 404: 'Not found', 409: 'Employee is exiting (EMPLOYEE_EXITING)' },
    handler: c.update,
  })
  .route({
    method: 'post',
    path: '/:id/job-changes',
    operationId: 'changeEmployeeJob',
    summary: 'Transfer / promote: close the open job row and start a new one',
    access: { roles: ['HR', 'DIRECTOR'] },
    params: IdParams,
    body: JobChangeBody,
    response: { status: 201, description: 'The employee with the new job row', schema: EmployeeDetail },
    errors: { 404: 'Employee or depot not found / out of scope', 409: 'JOB_CHANGE_BEFORE_CURRENT, NO_OPEN_JOB or EMPLOYEE_EXITED' },
    handler: c.changeJob,
  })
  .route({
    method: 'post',
    path: '/:id/exit',
    operationId: 'exitEmployee',
    summary: 'Record an exit (last working day)',
    access: { roles: ['HR', 'DIRECTOR'] },
    params: IdParams,
    body: ExitBody,
    response: { status: 200, description: 'The employee (ON_NOTICE until the exit date passes)', schema: EmployeeDetail },
    errors: { 404: 'Not found', 409: 'Exit already recorded' },
    handler: c.exit,
  })
  .route({
    method: 'get',
    path: '/:id/bank-details',
    operationId: 'getEmployeeBankDetails',
    summary: 'Masked bank details (pay data, audited)',
    access: { roles: ['HR', 'DIRECTOR'] },
    params: IdParams,
    response: { status: 200, description: 'Masked account and IFSC', schema: BankDetails },
    errors: { 404: 'Not found' },
    handler: c.getBank,
  })
  .route({
    method: 'put',
    path: '/:id/bank-details',
    operationId: 'setEmployeeBankDetails',
    summary: 'Set bank details (stored encrypted)',
    access: { roles: ['HR', 'DIRECTOR'] },
    params: IdParams,
    body: BankDetailsBody,
    response: { status: 200, description: 'Masked account and IFSC', schema: BankDetails },
    errors: { 404: 'Not found' },
    handler: c.setBank,
  })
  .route({
    method: 'put',
    path: '/:id/photo',
    operationId: 'setEmployeePhoto',
    summary: 'Attach an uploaded photo',
    access: { roles: 'any' },
    params: IdParams,
    body: PhotoBody,
    response: { status: 204, description: 'Saved' },
    errors: { 404: 'Not found', 422: 'File not uploaded (FILE_NOT_UPLOADED)' },
    handler: c.setPhoto,
  })
  .route({
    method: 'get',
    path: '/:id/photo-url',
    operationId: 'getEmployeePhotoUrl',
    summary: 'Short-lived signed URL of the photo',
    access: { roles: 'any' },
    params: IdParams,
    response: { status: 200, description: 'Signed URL', schema: SignedUrlResponse },
    errors: { 404: 'No photo' },
    handler: c.photoUrl,
  })
  .route({
    method: 'get',
    path: '/:id/documents',
    operationId: 'listEmployeeDocuments',
    summary: "An employee's documents",
    access: { roles: 'any' },
    params: IdParams,
    response: { status: 200, description: 'Documents', schema: DocumentList },
    errors: { 404: 'Not found' },
    handler: c.listEmployeeDocuments,
  })
  .route({
    method: 'post',
    path: '/:id/documents',
    operationId: 'createEmployeeDocument',
    summary: 'Record a captured document (pending HR verification)',
    access: { roles: 'any' },
    params: IdParams,
    body: DocumentCreateBody,
    response: { status: 201, description: 'Created', schema: DocumentItem },
    errors: { 404: 'Not found', 422: 'File not uploaded (FILE_NOT_UPLOADED)' },
    handler: c.createDocument,
  });

export const documentsRouter = new ModuleRouter('/documents', 'Documents')
  .route({
    method: 'get',
    path: '/',
    operationId: 'listDocuments',
    summary: 'Documents in my scope (HR verification queue: status=PENDING_VERIFICATION)',
    access: { roles: 'any' },
    query: DocumentQuery,
    response: { status: 200, description: 'Oldest first', schema: DocumentPage },
    handler: c.listDocuments,
  })
  .route({
    method: 'get',
    path: '/expiring',
    operationId: 'listExpiringDocuments',
    summary: 'Documents expiring soon (latest per employee and type)',
    access: { roles: 'any' },
    query: ExpiringQuery,
    response: { status: 200, description: 'Soonest first', schema: ExpiringDocumentList },
    handler: c.expiring,
  })
  .route({
    method: 'get',
    path: '/:id',
    operationId: 'getDocument',
    summary: 'One document',
    access: { roles: 'any' },
    params: IdParams,
    response: { status: 200, description: 'The document', schema: DocumentWithEmployee },
    errors: { 404: 'Not found or out of scope' },
    handler: c.getDocument,
  })
  .route({
    method: 'get',
    path: '/:id/file-url',
    operationId: 'getDocumentFileUrl',
    summary: 'Short-lived signed URL of the scan (≤ 10 min)',
    access: { roles: 'any' },
    params: IdParams,
    response: { status: 200, description: 'Signed URL', schema: SignedUrlResponse },
    errors: { 404: 'Not found' },
    handler: c.fileUrl,
  })
  .route({
    method: 'post',
    path: '/:id/verify',
    operationId: 'verifyDocument',
    summary: 'Verify a pending document',
    access: { roles: ['HR', 'DIRECTOR'] },
    params: IdParams,
    body: DocumentVerifyBody,
    response: { status: 200, description: 'Verified (or EXPIRED if its expiry date has passed)', schema: DocumentWithEmployee },
    errors: { 404: 'Not found', 409: 'Not pending (DOCUMENT_NOT_PENDING)' },
    handler: c.verify,
  })
  .route({
    method: 'post',
    path: '/:id/reject',
    operationId: 'rejectDocument',
    summary: 'Reject a pending document (notifies whoever captured it)',
    access: { roles: ['HR', 'DIRECTOR'] },
    params: IdParams,
    body: DocumentRejectBody,
    response: { status: 200, description: 'Rejected', schema: DocumentWithEmployee },
    errors: { 404: 'Not found', 409: 'Not pending (DOCUMENT_NOT_PENDING)' },
    handler: c.reject,
  });

export const uploadsRouter = new ModuleRouter('/uploads', 'Documents').route({
  method: 'post',
  path: '/presign',
  operationId: 'presignUpload',
  summary: 'Signed URL to upload a document scan or photo directly to storage',
  description: 'PUT the file to `url` with the returned headers before it expires, then send `key` as fileKey.',
  access: { roles: 'any' },
  body: PresignBody,
  response: { status: 200, description: 'Signed upload URL', schema: PresignResponse },
  errors: { 404: 'Employee not found', 413: 'File too large (FILE_TOO_LARGE)' },
  handler: c.presign,
});

export const documentRequirementsRouter = new ModuleRouter('/document-requirements', 'Documents')
  .route({
    method: 'get',
    path: '/',
    operationId: 'listDocumentRequirements',
    summary: 'Documents required per employee category to be rostered',
    access: { roles: 'any' },
    response: { status: 200, description: 'Per category', schema: DocumentRequirementList },
    handler: c.listRequirements,
  })
  .route({
    method: 'put',
    path: '/:category',
    operationId: 'setDocumentRequirements',
    summary: 'Replace the required documents of a category',
    access: { roles: ['HR', 'DIRECTOR'] },
    params: CategoryParams,
    body: DocumentRequirementBody,
    response: { status: 200, description: 'Saved', schema: DocumentRequirementItem },
    handler: c.setRequirements,
  });
