import type { Request } from 'express';
import { contextOf } from '../../lib/context.js';
import { Errors } from '../../lib/errors.js';
import type { RouteInput } from '../../lib/route.js';
import type { IdParams } from '../../lib/schemas.js';
import * as docs from './documents.service.js';
import type {
  CategoryParams,
  DocumentCreateBody,
  DocumentQuery,
  DocumentRejectBody,
  DocumentRequirementBody,
  DocumentVerifyBody,
  ExpiringQuery,
  PresignBody,
} from './documents.schemas.js';
import type { BankDetailsBody, BusinessUnitsBody, EmployeeCreateBody, EmployeeListQuery, EmployeeUpdateBody, ExitBody, JobChangeBody, NextCodeQuery, PromotionBody } from './schemas.js';
import type { PhotoBody } from './schemas.photo.js';
import * as service from './service.js';

export const authUser = (req: Request) => {
  if (!req.user) throw Errors.unauthenticated();
  return req.user;
};
/** Origin the client used to reach the API (prefixes relative signed URLs of the local storage driver). */
export const originOf = (req: Request) => `${req.protocol}://${req.get('host') ?? 'localhost'}`;

type In<B, Q, P> = RouteInput<B, Q, P>;

export const list = (i: In<undefined, typeof EmployeeListQuery, undefined>, req: Request) => service.listEmployees(authUser(req), i.query);
export const nextCode = (i: In<undefined, typeof NextCodeQuery, undefined>, req: Request) => service.nextEmpCode(authUser(req), i.query.businessUnitId);
export const promote = (i: In<typeof PromotionBody, undefined, typeof IdParams>, req: Request) => service.promote(authUser(req), i.params.id, i.body, contextOf(req));
export const setBusinessUnits = (i: In<typeof BusinessUnitsBody, undefined, typeof IdParams>, req: Request) =>
  service.setBusinessUnits(authUser(req), i.params.id, i.body, contextOf(req));
export const create = (i: In<typeof EmployeeCreateBody, undefined, undefined>, req: Request) => service.createEmployee(authUser(req), i.body, contextOf(req));
export const get = (i: In<undefined, undefined, typeof IdParams>, req: Request) => service.getEmployee(authUser(req), i.params.id);
export const update = (i: In<typeof EmployeeUpdateBody, undefined, typeof IdParams>, req: Request) =>
  service.updateEmployee(authUser(req), i.params.id, i.body, contextOf(req));
export const changeJob = (i: In<typeof JobChangeBody, undefined, typeof IdParams>, req: Request) =>
  service.changeJob(authUser(req), i.params.id, i.body, contextOf(req));
export const exit = (i: In<typeof ExitBody, undefined, typeof IdParams>, req: Request) => service.exitEmployee(authUser(req), i.params.id, i.body, contextOf(req));
export const getBank = (i: In<undefined, undefined, typeof IdParams>, req: Request) => service.getBankDetails(authUser(req), i.params.id, contextOf(req));
export const setBank = (i: In<typeof BankDetailsBody, undefined, typeof IdParams>, req: Request) =>
  service.setBankDetails(authUser(req), i.params.id, i.body, contextOf(req));

export const setPhoto = (i: In<typeof PhotoBody, undefined, typeof IdParams>, req: Request) =>
  docs.setPhoto(authUser(req), i.params.id, i.body.fileKey, contextOf(req));
export const photoUrl = (i: In<undefined, undefined, typeof IdParams>, req: Request) => docs.photoUrl(authUser(req), i.params.id, originOf(req));

export const listEmployeeDocuments = (i: In<undefined, undefined, typeof IdParams>, req: Request) => docs.listEmployeeDocuments(authUser(req), i.params.id);
export const createDocument = (i: In<typeof DocumentCreateBody, undefined, typeof IdParams>, req: Request) =>
  docs.createDocument(authUser(req), i.params.id, i.body, contextOf(req));

export const listDocuments = (i: In<undefined, typeof DocumentQuery, undefined>, req: Request) => docs.listDocuments(authUser(req), i.query);
export const expiring = (i: In<undefined, typeof ExpiringQuery, undefined>, req: Request) => docs.expiringDocuments(authUser(req), i.query);
export const getDocument = (i: In<undefined, undefined, typeof IdParams>, req: Request) => docs.getDocument(authUser(req), i.params.id);
export const fileUrl = (i: In<undefined, undefined, typeof IdParams>, req: Request) => docs.signedFileUrl(authUser(req), i.params.id, originOf(req));
export const verify = (i: In<typeof DocumentVerifyBody, undefined, typeof IdParams>, req: Request) =>
  docs.verifyDocument(authUser(req), i.params.id, i.body, contextOf(req));
export const reject = (i: In<typeof DocumentRejectBody, undefined, typeof IdParams>, req: Request) =>
  docs.rejectDocument(authUser(req), i.params.id, i.body, contextOf(req));

export const presign = (i: In<typeof PresignBody, undefined, undefined>, req: Request) => docs.presignUpload(authUser(req), i.body, originOf(req));

export const listRequirements = () => docs.listRequirements();
export const setRequirements = (i: In<typeof DocumentRequirementBody, undefined, typeof CategoryParams>, req: Request) =>
  docs.setRequirements(i.params.category, i.body, contextOf(req));
