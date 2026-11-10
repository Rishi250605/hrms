import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hrms_app/core/labels.dart';

import '../../support/fakes.dart';

void main() {
  test('rupees are parsed to and formatted from integer paise', () {
    expect(parseRupees('1,250.50'), 125050);
    expect(parseRupees('₹ 300'), 30000);
    expect(parseRupees('0'), isNull);
    expect(parseRupees('abc'), isNull);
    expect(formatRupees(125050), '₹1,250.50');
    expect(formatRupees(30000000), '₹3,00,000');
  });

  testWidgets('RM raises one allowance for two drivers (one batch); a comment or voice note is required', (tester) async {
    final fakes = Fakes(user: rmUser);
    fakes.employees.employees.add(employeeListItemJson('e3', 'Loadman One', category: 'LOADMAN'));
    await pumpApp(tester, fakes);
    await tester.tap(find.text('Allowances'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('allowances.new')));
    await tester.pumpAndSettle();

    await tester.tap(find.text('My team'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('allowance.beneficiaries')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('employeePicker.e1')));
    await tester.tap(find.byKey(const Key('employeePicker.e3')));
    await tester.tap(find.byKey(const Key('employeePicker.ok')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('allowance.type')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Batta').last);
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('allowance.amountField')), '300');
    await tester.pumpAndSettle();
    expect(find.text('Total ₹600'), findsOneWidget);

    // No comment, no voice note → refused.
    await tester.dragUntilVisible(find.byKey(const Key('allowance.submit')), find.byType(ListView).last, const Offset(0, -300));
    await tester.ensureVisible(find.byKey(const Key('allowance.submit')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('allowance.submit')));
    await tester.pumpAndSettle();
    expect(fakes.allowances.created, isEmpty);
    expect(find.text('Add a comment or record a voice note'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('allowance.commentField')), 'Night halt at Nashik');
    await tester.dragUntilVisible(find.byKey(const Key('allowance.submit')), find.byType(ListView).last, const Offset(0, -300));
    await tester.ensureVisible(find.byKey(const Key('allowance.submit')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('allowance.submit')));
    await tester.pumpAndSettle();

    final body = fakes.allowances.created.single;
    expect(body.beneficiaryEmployeeIds, ['e1', 'e3']);
    expect(body.amountPaise, 30000);
    expect(body.allowanceTypeId, 'at-batta');
    expect(body.voiceNoteKey, isNull);
    expect(find.text('2 allowances sent for approval'), findsOneWidget);
  });

  testWidgets('OM approves a team batch in one action and a single request with a changed amount only with a comment', (tester) async {
    final fakes = Fakes(user: omUser);
    fakes.allowances.byScope['approvals'] = [
      allowanceJson('a1', batchId: 'b1', canDecide: true),
      allowanceJson('a2', batchId: 'b1', beneficiary: 'Driver Two', canDecide: true),
      allowanceJson('a3', batchId: 'b2', beneficiary: 'Asha Patil', amount: 50000, canDecide: true),
    ];
    await pumpApp(tester, fakes);
    await tester.tap(find.text('More'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('more.allowances')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('allowances.tab.approvals')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('allowance.batchApprove.b1')));
    await tester.pumpAndSettle();
    expect(fakes.allowances.approvedBatches, ['b1']);
    // Let the confirmation snackbar time out so it does not cover the sheet's buttons.
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('allowance.a3')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('allowance.amount')), '400');
    await tester.tap(find.byKey(const Key('allowance.approve')));
    await tester.pumpAndSettle();
    expect(fakes.allowances.approvals, isEmpty);
    expect(find.text('Add a comment explaining the changed amount'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('allowance.comment')), 'Only one night');
    await tester.tap(find.byKey(const Key('allowance.approve')));
    await tester.pumpAndSettle();
    expect(fakes.allowances.approvals.single, ('a3', 40000, 'Only one night'));
  });
}
