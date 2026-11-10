import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fakes.dart';

void main() {
  testWidgets('RM sees their own payslip and their team’s for the month; HR gets the upload action', (tester) async {
    final fakes = Fakes(user: rmUser);
    fakes.payslips.byScope = {
      'mine': [payslipJson('p0', 'emp-rm', 'Asha Patil', role: 'REGIONAL_MANAGER', category: 'OFFICE')],
      'team': [payslipJson('p1', 'e1', 'Ramesh Pawar'), payslipJson('p2', 'e2', 'Vijay More')],
    };
    await pumpApp(tester, fakes);
    await tester.tap(find.text('More'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('more.payslips')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('payslips.mine')), findsOneWidget);
    expect(find.byKey(const Key('payslip.p1')), findsOneWidget);
    expect(find.byKey(const Key('payslip.p2')), findsOneWidget);
    expect(find.byKey(const Key('payslips.upload')), findsNothing);
    expect(fakes.payslips.scopes.map((s) => s.split(':').first).toSet(), {'mine', 'team'});

    // Previous month: nothing uploaded yet.
    fakes.payslips.byScope = {};
    await tester.tap(find.byKey(const Key('month.prev')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('payslips.mine.none')), findsOneWidget);
  });

  testWidgets('HR sees all payslips with search and can open the upload screen', (tester) async {
    final fakes = Fakes(user: hrUser);
    fakes.payslips.byScope = {
      'all': [payslipJson('p1', 'e1', 'Ramesh Pawar'), payslipJson('p2', 'e2', 'Vijay More')],
    };
    await pumpApp(tester, fakes);
    await tester.tap(find.text('Payslips'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'vijay');
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('payslip.p1')), findsNothing);
    expect(find.byKey(const Key('payslip.p2')), findsOneWidget);

    await tester.tap(find.byKey(const Key('payslips.upload')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('upload.pick')), findsOneWidget);
    expect(find.textContaining('payslip-<employee code>.pdf'), findsOneWidget);
  });
}
