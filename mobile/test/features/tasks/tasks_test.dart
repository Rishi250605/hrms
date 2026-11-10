import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hrms_api/hrms_api.dart';

import '../../support/fakes.dart';

void main() {
  testWidgets('RM sees overdue tasks and must give a reason to submit Not done', (tester) async {
    final fakes = Fakes(user: rmUser);
    fakes.tasks.byQuery = {
      'assigned:open': [taskJson('t1', overdue: true, canSubmit: true), taskJson('t2', canSubmit: true, title: 'Collect challans')],
      'assigned:submitted': [taskJson('t0', status: 'COMPLETED', title: 'Fuel log')],
    };
    await pumpApp(tester, fakes);
    await tester.tap(find.text('More'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('more.tasks')));
    await tester.pumpAndSettle();

    expect(find.descendant(of: find.byKey(const Key('task.t1')), matching: find.text('Overdue')), findsOneWidget);
    await tester.tap(find.byKey(const Key('task.t1')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Not done'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('task.submit')));
    await tester.pumpAndSettle();
    expect(fakes.tasks.submitted, isEmpty);
    expect(find.text('Give a reason when the task was not done'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('task.reason')), 'Truck in workshop');
    await tester.tap(find.byKey(const Key('task.submit')));
    await tester.pumpAndSettle();
    expect(fakes.tasks.submitted.single, ('t1', false, 'Truck in workshop'));

    await tester.tap(find.byKey(const Key('tasks.tab.submitted')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('task.t0')), findsOneWidget);
  });

  testWidgets('OM allots a task to their RMs', (tester) async {
    final fakes = Fakes(user: omUser);
    fakes.employees.employees
      ..clear()
      ..addAll([employeeListItemJson('emp-rm', 'Asha Patil', role: 'REGIONAL_MANAGER'), employeeListItemJson('emp-rm2', 'Rahul Desai', role: 'REGIONAL_MANAGER')]);
    await pumpApp(tester, fakes);
    await tester.tap(find.text('Tasks'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('tasks.new')));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('task.title')), 'Inspect tyres');
    await tester.tap(find.byKey(const Key('task.assignees')));
    await tester.pumpAndSettle();
    expect(fakes.employees.listFilters.last.role, Role.REGIONAL_MANAGER);
    expect(fakes.employees.listFilters.last.reportingToEmployeeId, 'emp-om');
    await tester.tap(find.byKey(const Key('employeePicker.emp-rm')));
    await tester.tap(find.byKey(const Key('employeePicker.emp-rm2')));
    await tester.tap(find.byKey(const Key('employeePicker.ok')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const Key('task.save')));
    await tester.tap(find.byKey(const Key('task.save')));
    await tester.pumpAndSettle();

    final body = fakes.tasks.createdBodies.single;
    expect(body.title, 'Inspect tyres');
    expect(body.assigneeEmployeeIds, ['emp-rm', 'emp-rm2']);
    expect(body.businessUnitId, 'bu-nls');
    expect(find.text('2 tasks allotted'), findsOneWidget);
  });
}
