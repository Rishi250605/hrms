import { Router } from 'express';
import type { Request, RequestHandler, Response } from 'express';
import type { RouteConfig } from '@asteasolutions/zod-to-openapi';
import multer from 'multer';
import type { ZodType } from 'zod';
import { authenticate } from '../middleware/authenticate.js';
import { requireRole } from '../middleware/requireRole.js';
import { AppError, Errors } from './errors.js';
import { bearerAuth, ErrorResponseSchema, registry, z } from './openapi.js';
import type { Role } from '../generated/prisma/enums.js';

type Method = 'get' | 'post' | 'put' | 'patch' | 'delete';

/**
 * Who may call a route:
 *  - 'public'                      no authentication (auth endpoints, health)
 *  - { roles: 'any' }              any authenticated manager
 *  - { roles: [...] }              authenticated + one of these roles (e.g. ['DIRECTOR'] for user management)
 */
export type RouteAccess = 'public' | { roles: Role[] | 'any' };

type Infer<T> = T extends ZodType ? z.infer<T> : undefined;

export interface UploadedFile {
  fieldname: string;
  originalname: string;
  mimetype: string;
  size: number;
  buffer: Buffer;
}

export interface RouteInput<B, Q, P> {
  body: Infer<B>;
  query: Infer<Q>;
  params: Infer<P>;
  /** Files of a multipart route (`upload` set); empty otherwise. */
  files: UploadedFile[];
}

/** Multipart file upload: field `files` (repeatable), held in memory, parsed only after authentication. */
export interface UploadSpec {
  maxFiles: number;
  maxFileBytes: number;
  description: string;
}

const UPLOAD_FIELDS = new Set(['files', 'files[]']);

function uploadMiddleware(spec: UploadSpec): RequestHandler {
  const parse = multer({ storage: multer.memoryStorage(), limits: { files: spec.maxFiles, fileSize: spec.maxFileBytes, fields: 20, parts: spec.maxFiles + 20 } }).any();
  return (req, res, next) => {
    parse(req, res, (err: unknown) => {
      if (!err) return next();
      if (err instanceof multer.MulterError) {
        if (err.code === 'LIMIT_FILE_SIZE') return next(new AppError('FILE_TOO_LARGE', 413, `Each file may be at most ${Math.floor(spec.maxFileBytes / 1024 / 1024)} MB`));
        if (err.code === 'LIMIT_FILE_COUNT' || err.code === 'LIMIT_PART_COUNT') return next(new AppError('TOO_MANY_FILES', 413, `Upload at most ${spec.maxFiles} files at a time`));
        return next(Errors.validation([{ path: [err.field ?? 'files'], message: err.message }]));
      }
      return next(err);
    });
  };
}

export interface RouteSpec<B extends ZodType | undefined, Q extends ZodType | undefined, P extends ZodType | undefined, R extends ZodType | undefined> {
  method: Method;
  /** Express-style path relative to the module mount, e.g. "/:id/scopes". */
  path: string;
  operationId: string;
  summary: string;
  description?: string;
  access: RouteAccess;
  body?: B;
  query?: Q;
  params?: P;
  /** Success response. Omit `schema` for 204 No Content. */
  response: { status: 200 | 201 | 202 | 204; description: string; schema?: R };
  /** Extra error statuses to document (400/401/403/500 are documented automatically where relevant). */
  errors?: Partial<Record<400 | 401 | 403 | 404 | 409 | 413 | 422 | 423 | 429, string>>;
  /** multipart/form-data with files (the body schema then describes only the text fields, if any). */
  upload?: UploadSpec;
  /** Runs before authentication (e.g. rate limiters). */
  pre?: RequestHandler[];
  handler: (input: RouteInput<B, Q, P>, req: Request, res: Response) => Promise<Infer<R> | void>;
}

/** Express path ("/:id") → OpenAPI path ("/{id}"). */
function toOpenApiPath(path: string): string {
  return path.replace(/:([A-Za-z0-9_]+)/g, '{$1}');
}

/**
 * A module router that enforces the route pipeline from CLAUDE.md §5:
 *   authenticate → requireRole(...) → zod validation → handler (controller) → service
 * and registers every route in the OpenAPI registry, so the spec can never drift from the code.
 */
export class ModuleRouter {
  readonly router = Router();

  constructor(
    readonly mountPath: string,
    readonly tag: string,
  ) {}

  route<B extends ZodType | undefined = undefined, Q extends ZodType | undefined = undefined, P extends ZodType | undefined = undefined, R extends ZodType | undefined = undefined>(
    spec: RouteSpec<B, Q, P, R>,
  ): this {
    const chain: RequestHandler[] = [...(spec.pre ?? [])];
    if (spec.access !== 'public') {
      chain.push(authenticate);
      if (spec.access.roles !== 'any') chain.push(requireRole(...spec.access.roles));
    }
    if (spec.upload) chain.push(uploadMiddleware(spec.upload));

    const validateAndHandle: RequestHandler = async (req, res) => {
      const issues: unknown[] = [];
      const parse = (schema: ZodType | undefined, value: unknown, location: string): unknown => {
        if (!schema) return undefined;
        const r = schema.safeParse(value ?? {});
        if (!r.success) {
          issues.push(...r.error.issues.map((i) => ({ ...i, location })));
          return undefined;
        }
        return r.data;
      };
      const input = {
        params: parse(spec.params, req.params, 'params'),
        query: parse(spec.query, req.query, 'query'),
        body: parse(spec.body, req.body, 'body'),
        files: Array.isArray(req.files) ? (req.files as UploadedFile[]).filter((f) => UPLOAD_FIELDS.has(f.fieldname)) : [],
      } as RouteInput<B, Q, P>;
      if (issues.length > 0) throw Errors.validation(issues);

      const result = await spec.handler(input, req, res);
      if (res.headersSent) return;
      if (spec.response.status === 204 || result === undefined) {
        res.status(spec.response.status === 204 ? 204 : spec.response.status).end();
      } else {
        res.status(spec.response.status).json(result);
      }
    };
    chain.push(validateAndHandle);

    this.router[spec.method](spec.path, ...chain);
    registry.registerPath(this.toOpenApi(spec));
    return this;
  }

  private toOpenApi<B extends ZodType | undefined, Q extends ZodType | undefined, P extends ZodType | undefined, R extends ZodType | undefined>(
    spec: RouteSpec<B, Q, P, R>,
  ): RouteConfig {
    const errorContent = (description: string) => ({
      description,
      content: { 'application/json': { schema: ErrorResponseSchema } },
    });
    const responses: RouteConfig['responses'] = {
      [spec.response.status]: spec.response.schema
        ? { description: spec.response.description, content: { 'application/json': { schema: spec.response.schema } } }
        : { description: spec.response.description },
    };
    if (spec.body || spec.query || spec.params) responses[400] = errorContent('Validation error');
    if (spec.access !== 'public') {
      responses[401] = errorContent('Missing or invalid access token');
      if (spec.access.roles !== 'any') responses[403] = errorContent('Role not permitted');
    }
    for (const [status, description] of Object.entries(spec.errors ?? {})) {
      responses[status] = errorContent(description);
    }

    const request: RouteConfig['request'] = {};
    if (spec.upload) {
      const files = z.array(z.string().openapi({ type: 'string', format: 'binary' })).openapi({ description: spec.upload.description });
      const shape = spec.body instanceof z.ZodObject ? spec.body.extend({ files }) : z.object({ files });
      request.body = { required: true, content: { 'multipart/form-data': { schema: shape } } };
    } else if (spec.body) {
      request.body = { required: true, content: { 'application/json': { schema: spec.body } } };
    }
    // zod-to-openapi requires object schemas for query/params.
    if (spec.query) request.query = spec.query as unknown as NonNullable<RouteConfig['request']>['query'];
    if (spec.params) request.params = spec.params as unknown as NonNullable<RouteConfig['request']>['params'];

    const accessNote =
      spec.access === 'public'
        ? 'Public.'
        : spec.access.roles === 'any'
            ? 'Any authenticated manager.'
            : `Roles: ${spec.access.roles.join(', ')}.`;

    return {
      method: spec.method,
      path: toOpenApiPath(`${this.mountPath}${spec.path === '/' ? '' : spec.path}`),
      operationId: spec.operationId,
      summary: spec.summary,
      description: [spec.description, accessNote].filter(Boolean).join('\n\n'),
      tags: [this.tag],
      security: spec.access === 'public' ? [] : [{ [bearerAuth.name]: [] }],
      request,
      responses,
    };
  }
}
