// Fixture for audit-coverage.test.ts — not compiled into the app.
/* eslint-disable */
declare const prisma: any;
declare const audit: any;

export async function audited(id: string) {
  await prisma.$transaction(async (tx: any) => {
    await tx.employee.update({ where: { id }, data: {} });
    await audit.record(tx, {}, {});
  });
}

export async function unaudited(id: string) {
  await prisma.employee.update({ where: { id }, data: {} });
}

export async function helper(tx: any) {
  // audit: by-caller audited()
  await tx.employee.create({ data: {} });
}

export async function logsOnly() {
  await prisma.notification.create({ data: {} });
}
