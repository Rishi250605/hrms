import { readdirSync, readFileSync, statSync } from 'node:fs';
import { join, relative } from 'node:path';
import ts from 'typescript';

/**
 * Static audit-coverage check (CLAUDE.md §5: "every write goes through audit.record").
 *
 * Finds every Prisma write (`<client>.<model>.create|update|upsert|delete…`) in services and jobs, and checks
 * that the enclosing top-level function also calls `audit.record`. A function may opt out with a comment
 * `audit: by-caller <who>` (a helper whose callers audit) or `audit: exempt <reason>` (not a business write).
 * Tables that are logs or security plumbing themselves are exempt by model.
 */

export const WRITE_OPS = new Set(['create', 'createMany', 'createManyAndReturn', 'update', 'updateMany', 'updateManyAndReturn', 'upsert', 'delete', 'deleteMany']);

/** Models that are not business data: the audit log itself, delivery/feed logs, sessions, push tokens, job bookkeeping. */
export const EXEMPT_MODELS = new Set(['auditLog', 'refreshToken', 'notification', 'deviceToken', 'documentAlert', 'leaveAccrualLog']);

export interface UnauditedWrite {
  file: string;
  fn: string;
  write: string;
  line: number;
}

function sourceFiles(dir: string): string[] {
  return readdirSync(dir).flatMap((name) => {
    const path = join(dir, name);
    if (statSync(path).isDirectory()) return name === 'generated' ? [] : sourceFiles(path);
    return name.endsWith('.ts') && !name.endsWith('.test.ts') ? [path] : [];
  });
}

/** The outermost function-like node (or class method) containing `node` — the unit that must audit. */
function topLevelFunction(node: ts.Node): ts.Node | undefined {
  let found: ts.Node | undefined;
  for (let n: ts.Node | undefined = node; n; n = n.parent) {
    if (ts.isFunctionLike(n)) found = n;
  }
  return found;
}

function functionName(fn: ts.Node): string {
  if ((ts.isFunctionDeclaration(fn) || ts.isMethodDeclaration(fn)) && fn.name) return fn.name.getText();
  const decl = fn.parent;
  if (decl && ts.isVariableDeclaration(decl)) return decl.name.getText();
  if (decl && ts.isPropertyAssignment(decl)) return decl.name.getText();
  return '<anonymous>';
}

export function findUnauditedWrites(root: string, dirs: string[]): UnauditedWrite[] {
  const out: UnauditedWrite[] = [];
  for (const file of dirs.flatMap((d) => sourceFiles(join(root, d)))) {
    const text = readFileSync(file, 'utf8');
    const sf = ts.createSourceFile(file, text, ts.ScriptTarget.Latest, true);
    const visit = (node: ts.Node) => {
      if (ts.isCallExpression(node) && ts.isPropertyAccessExpression(node.expression)) {
        const op = node.expression.name.text;
        const target = node.expression.expression;
        if (WRITE_OPS.has(op) && ts.isPropertyAccessExpression(target) && ts.isIdentifier(target.expression)) {
          const model = target.name.text;
          if (!EXEMPT_MODELS.has(model) && !model.startsWith('$')) {
            const fn = topLevelFunction(node);
            const body = fn?.getFullText() ?? '';
            const audited = /\baudit\.record\(/.test(body) || /audit: (by-caller|exempt)\b/.test(body);
            if (!audited) {
              out.push({
                file: relative(root, file).replace(/\\/g, '/'),
                fn: fn ? functionName(fn) : '<module>',
                write: `${model}.${op}`,
                line: sf.getLineAndCharacterOfPosition(node.getStart()).line + 1,
              });
            }
          }
        }
      }
      ts.forEachChild(node, visit);
    };
    visit(sf);
  }
  return out;
}
