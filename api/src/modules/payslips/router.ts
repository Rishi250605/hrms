import type { Request } from 'express';
import { contextOf } from '../../lib/context.js';
import { ModuleRouter } from '../../lib/route.js';
import type { RouteInput } from '../../lib/route.js';
import { IdParams } from '../../lib/schemas.js';
import { authUser, originOf } from '../employees/controller.js';
import {
  DownloadQuery,
  PAYSLIP_UPLOAD_MAX_FILE_BYTES,
  PAYSLIP_UPLOAD_MAX_FILES,
  PayslipDownload,
  PayslipPage,
  PayslipQuery,
  PayslipUploadResult,
  PayslipVersionList,
  PeriodQuery,
} from './schemas.js';
import * as s from './service.js';

type In<B, Q, P> = RouteInput<B, Q, P>;

export const payslipsRouter = new ModuleRouter('/payslips', 'Payslips')
  .route({
    method: 'post',
    path: '/upload',
    operationId: 'uploadPayslips',
    summary: 'Bulk upload payslip PDFs for a pay period (payslip-<empCode>.pdf)',
    description: 'Each file is matched by its employee code; unmatched, invalid and duplicate files are reported and not stored. A re-upload adds a new version.',
    access: { roles: ['HR'] },
    query: PeriodQuery,
    upload: {
      maxFiles: PAYSLIP_UPLOAD_MAX_FILES,
      maxFileBytes: PAYSLIP_UPLOAD_MAX_FILE_BYTES,
      description: `PDF files named payslip-<empCode>.pdf (at most ${PAYSLIP_UPLOAD_MAX_FILES} per request)`,
    },
    response: { status: 200, description: 'Per-file result', schema: PayslipUploadResult },
    errors: { 413: 'FILE_TOO_LARGE or TOO_MANY_FILES' },
    handler: (i: In<undefined, typeof PeriodQuery, undefined>, req: Request) => s.uploadPayslips(authUser(req), i.query.period, i.files, contextOf(req)),
  })
  .route({
    method: 'get',
    path: '/',
    operationId: 'listPayslips',
    summary: 'Payslips: mine, my team (§7.2) or all in my business units (HR / director)',
    access: { roles: 'any' },
    query: PayslipQuery,
    response: { status: 200, description: 'Newest period first', schema: PayslipPage },
    errors: { 403: 'scope=all needs HR or the director' },
    handler: (i: In<undefined, typeof PayslipQuery, undefined>, req: Request) => s.listPayslips(authUser(req), i.query),
  })
  .route({
    method: 'get',
    path: '/:id/download',
    operationId: 'downloadPayslip',
    summary: 'Signed download URL (≤ 10 min, audited)',
    access: { roles: 'any' },
    params: IdParams,
    query: DownloadQuery,
    response: { status: 200, description: 'Signed URL', schema: PayslipDownload },
    errors: { 404: 'Not found or not visible' },
    handler: (i: In<undefined, typeof DownloadQuery, typeof IdParams>, req: Request) => s.downloadPayslip(authUser(req), i.params.id, i.query, originOf(req), contextOf(req)),
  })
  .route({
    method: 'get',
    path: '/:id/versions',
    operationId: 'listPayslipVersions',
    summary: 'Upload history of a payslip',
    access: { roles: ['HR', 'DIRECTOR'] },
    params: IdParams,
    response: { status: 200, description: 'Newest first', schema: PayslipVersionList },
    errors: { 404: 'Not found' },
    handler: (i: In<undefined, undefined, typeof IdParams>, req: Request) => s.listVersions(authUser(req), i.params.id, contextOf(req)),
  });
