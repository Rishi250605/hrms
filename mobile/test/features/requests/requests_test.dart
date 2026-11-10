import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hrms_api/hrms_api.dart';

import '../../support/fakes.dart';

void main() {
  testWidgets('RM raises leave for a driver in their team and approves it in the same step, seeing the balance', (tester) async {
    final fakes = Fakes(user: rmUser);
    await pumpApp(tester, fakes);
    await tester.tap(find.text('Leave & OD'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('leave.tab.approvals')), findsOneWidget);
    await tester.tap(find.byKey(const Key('leave.new')));
    await tester.pumpAndSettle();

    // Submitting empty sends nothing.
    await tester.tap(find.byKey(const Key('leave.submit')));
    await tester.pumpAndSettle();
    expect(fakes.requests.created, isEmpty);

    await tester.tap(find.byKey(const Key('leave.forTeam')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('employeePicker')));
    await tester.pumpAndSettle();
    // Only staff reporting to me are offered.
    expect(fakes.employees.listFilters.last.staffOnly, isTrue);
    expect(fakes.employees.listFilters.last.reportingToEmployeeId, 'emp-rm');
    await tester.tap(find.byKey(const Key('employeePicker.e1')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('leave.type')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Casual leave (CL)').last);
    await tester.pumpAndSettle();
    expect(find.text('Available: 4 day(s) (1 pending)'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('leave.reason')), 'Family function');
    await tester.ensureVisible(find.byKey(const Key('leave.submit')));
    await tester.tap(find.byKey(const Key('leave.submit')));
    await tester.pumpAndSettle();
    final body = fakes.requests.created.single;
    expect(body.subjectEmployeeId, 'e1');
    expect(body.kind, LeaveKind.LEAVE);
    expect(body.leaveTypeId, 'lt-cl');
    expect(body.autoApprove, isTrue);
    expect(find.text('Leave recorded (no approval step applied)'), findsOneWidget);
  });

  testWidgets('an OM raises on-duty (OD) for themself; location is required', (tester) async {
    final fakes = Fakes(user: omUser);
    await pumpApp(tester, fakes);
    await tester.tap(find.text('Leave & OD'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('leave.new')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('leave.forTeam')), findsNothing);

    await tester.tap(find.text('On duty (OD)'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('leave.reason')), 'Client visit');
    await tester.ensureVisible(find.byKey(const Key('leave.submit')));
    await tester.tap(find.byKey(const Key('leave.submit')));
    await tester.pumpAndSettle();
    expect(fakes.requests.created, isEmpty);

    await tester.enterText(find.byKey(const Key('leave.odLocation')), 'Nashik depot');
    await tester.ensureVisible(find.byKey(const Key('leave.submit')));
    await tester.tap(find.byKey(const Key('leave.submit')));
    await tester.pumpAndSettle();
    final body = fakes.requests.created.single;
    expect(body.kind, LeaveKind.OD);
    expect(body.subjectEmployeeId, isNull);
    expect(body.odLocation, 'Nashik depot');
    expect(find.text('Leave submitted for approval'), findsOneWidget);
  });
}
