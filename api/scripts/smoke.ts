/**
 * End-to-end smoke test against a running API with the demo seed (`npm run db:seed`, SEED_DEMO=true).
 *   npm run smoke                      # http://localhost:3000/api/v1
 *   API_URL=http://192.168.1.26:3000/api/v1 npm run smoke
 * Logs in as every demo role and walks the main Phase 2 flows. It writes demo data (marks, requests, a task,
 * an allowance, a payslip) to whatever database the API uses — never point it at production.
 */
/* eslint-disable no-console */
const base = process.env.API_URL ?? 'http://localhost:3000/api/v1';
const demoPassword = process.env.SEED_DEMO_PASSWORD ?? 'Demo@1234';
const directorPassword = process.env.SEED_DIRECTOR_PASSWORD ?? 'Director@123';
const today = new Date(Date.now() + 5.5 * 3600_000).toISOString().slice(0, 10);

let failures = 0;
const results: string[] = [];

type Json = Record<string, any>; // eslint-disable-line @typescript-eslint/no-explicit-any

async function call(token: string | null, method: string, path: string, body?: unknown, expect: number[] = [200, 201]): Promise<Json> {
  const res = await fetch(`${base}${path}`, {
    method,
    headers: { ...(token ? { Authorization: `Bearer ${token}` } : {}), ...(body && !(body instanceof FormData) ? { 'Content-Type': 'application/json' } : {}) },
    body: body instanceof FormData ? body : body ? JSON.stringify(body) : undefined,
  });
  const text = await res.text();
  const json = text ? (JSON.parse(text) as Json) : {};
  const ok = expect.includes(res.status);
  results.push(`${ok ? 'ok  ' : 'FAIL'} ${res.status} ${method} ${path}${ok ? '' : ` → ${text.slice(0, 160)}`}`);
  if (!ok) failures += 1;
  return json;
}

async function login(empCode: string, password = demoPassword) {
  const r = await call(null, 'POST', '/auth/login', { empCode, password });
  return r.accessToken as string;
}

async function main() {
  await call(null, 'GET', '/health');
  await call(null, 'POST', '/auth/login', { empCode: 'NLS003', password: 'wrong-password' }, [401]);

  const director = await login('DIR001', directorPassword);
  const hr = await login('NLS001');
  const om = await login('NLS002');
  const rm = await login('NLS003');

  for (const t of [director, hr, om, rm]) {
    await call(t, 'GET', '/me');
    await call(t, 'GET', '/reports/dashboard');
    await call(t, 'GET', '/notifications');
  }

  // Attendance: RM marks the team, RM self-marks, OM approves.
  const team = await call(rm, 'GET', `/attendance/team?date=${today}`);
  const rows = (team.rows ?? []) as Json[];
  if (rows.length) {
    await call(rm, 'POST', '/attendance/team/bulk', {
      marks: rows.map((r) => ({ clientMutationId: crypto.randomUUID(), employeeId: r.employee.id, date: today, status: r.suggestedStatus })),
    });
  }
  const self = await call(rm, 'POST', '/attendance/self', { date: today, status: 'PRESENT' }, [201, 409]);
  const queue = await call(om, 'GET', '/attendance/approvals');
  if (self.id && (queue.items as Json[]).some((m) => m.id === self.id)) await call(om, 'POST', `/attendance/${self.id}/approve`);

  // Leave / OD: RM raises OD for themself; OM sees it in approvals.
  await call(rm, 'POST', '/leave-requests', { kind: 'OD', fromDate: today, toDate: today, reason: 'Smoke test visit', odLocation: 'Nashik', odPurpose: 'Depot audit' }, [201, 409, 422]);
  await call(om, 'GET', '/leave-requests?scope=approvals');
  await call(hr, 'GET', '/leave-requests?scope=all');

  // Allowance: RM for self; OM approves.
  const types = await call(rm, 'GET', '/allowance-types');
  const allowance = await call(rm, 'POST', '/allowances', { allowanceTypeId: types.items[0].id, amountPaise: 25000, fromDate: today, comment: 'Smoke test' });
  await call(om, 'POST', `/allowances/${allowance.items[0].id}/approve`, {});
  await call(hr, 'GET', `/allowances/summary?month=${today.slice(0, 7)}`);

  // Task: OM allots to the RM; RM completes.
  const me = await call(rm, 'GET', '/me');
  const task = await call(om, 'POST', '/tasks', { businessUnitId: me.businessUnits[0].id, title: 'Smoke test task', assigneeEmployeeIds: [me.employeeId] });
  await call(rm, 'POST', `/tasks/${task.items[0].id}/submit`, { status: 'COMPLETED', comment: 'Done' });

  // Payslip: HR uploads one for the RM; the RM downloads it.
  const form = new FormData();
  form.append('files', new Blob([Buffer.from('%PDF-1.4\n% smoke\n%%EOF')], { type: 'application/pdf' }), `payslip-${me.empCode}.pdf`);
  const upload = await call(hr, 'POST', `/payslips/upload?period=${today.slice(0, 7)}`, form);
  if (!upload.matched?.length) {
    failures += 1;
    results.push(`FAIL payslip not matched: ${JSON.stringify(upload)}`);
  }
  const mine = await call(rm, 'GET', `/payslips?scope=mine&period=${today.slice(0, 7)}`);
  if (mine.items?.[0]) {
    const url = await call(rm, 'GET', `/payslips/${mine.items[0].id}/download`);
    const file = await fetch(url.url);
    results.push(`${file.ok ? 'ok  ' : 'FAIL'} ${file.status} GET <signed payslip url>`);
    if (!file.ok) failures += 1;
  }

  // Reports.
  await call(director, 'GET', `/reports/attendance?from=${today.slice(0, 7)}-01&to=${today}`);
  for (const format of ['xlsx', 'pdf']) {
    const f = await call(hr, 'GET', `/reports/attendance/export?format=${format}`);
    const file = await fetch(f.url);
    results.push(`${file.ok ? 'ok  ' : 'FAIL'} ${file.status} GET <signed ${format} url> (${(await file.arrayBuffer()).byteLength} bytes)`);
    if (!file.ok) failures += 1;
  }

  // Visibility spot checks: RM cannot see all; OM cannot manage users.
  await call(rm, 'GET', '/leave-requests?scope=all', undefined, [403]);
  await call(om, 'POST', '/users', {}, [400, 403]);
  await call(director, 'GET', '/users');

  console.log(results.join('\n'));
  console.log(`\n${results.length - failures} passed, ${failures} failed against ${base}`);
  process.exit(failures ? 1 : 0);
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
