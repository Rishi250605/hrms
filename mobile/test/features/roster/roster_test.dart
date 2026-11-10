import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hrms_app/core/errors/api_failure.dart';

import '../../support/fakes.dart';

void main() {
  testWidgets('assigning a driver with invalid documents shows the failing documents and suggested spares', (tester) async {
    final fakes = Fakes(user: omUser);
    fakes.roster.failures['e2'] = const ApiFailure(
      code: 'DOCUMENT_INVALID',
      message: 'Required documents are missing, unverified or expired on the duty date',
      statusCode: 409,
      details: {
        'failing': [
          {'type': 'MEDICAL_FITNESS', 'state': 'MISSING', 'documentId': null, 'expiryDate': null},
        ],
        'spares': [
          {
            'employee': {'id': 's9', 'empCode': 'D005', 'fullName': 'Santosh Patil', 'category': 'DRIVER', 'phone': '+919000010005'},
            'designation': 'Spare driver',
            'compliance': 'OK',
            'dutyMinutesLast7Days': 0,
            'dutiesOnDate': 0,
            'warnings': <Object>[],
          },
        ],
      },
    );
    await pumpApp(tester, fakes);
    await tester.tap(find.text('More'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('more.roster')));
    await tester.pumpAndSettle();

    expect(find.text('1 unfilled'), findsOneWidget);
    await tester.tap(find.byKey(const Key('duty.duty1')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('duty.assign.DRIVER')));
    await tester.pumpAndSettle();

    // Pick Vijay More (missing medical) from all employees.
    await tester.scrollUntilVisible(find.byKey(const Key('assign.employee.e2')), 200, scrollable: find.byType(Scrollable).last);
    await tester.tap(find.byKey(const Key('assign.employee.e2')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('assign.blocked')), findsOneWidget);
    expect(find.text('Medical fitness: Missing'), findsOneWidget);
    expect(find.byKey(const Key('blocked.spare.s9')), findsOneWidget);
    expect(fakes.roster.assigned, isEmpty);

    // Take the suggested spare instead.
    await tester.tap(find.byKey(const Key('blocked.spare.s9')));
    await tester.pumpAndSettle();
    expect(fakes.roster.assigned, ['s9']);
    // Back on the duty sheet the crew now lists the spare.
    expect(find.byKey(const Key('crew.s9')), findsOneWidget);
  });
}
