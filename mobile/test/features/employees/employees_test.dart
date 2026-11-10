import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hrms_api/hrms_api.dart';
import 'package:hrms_app/features/employees/data/employees_repository.dart';
import 'package:hrms_app/features/employees/presentation/providers/employees_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hrms_app/app/app.dart';

import '../../support/fakes.dart';

// 1x1 transparent PNG.
final _png = Uint8List.fromList(const [
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4,
  0x89, 0x00, 0x00, 0x00, 0x0D, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00, 0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE,
  0x42, 0x60, 0x82,
]);

Future<void> _pump(WidgetTester tester, Fakes fakes, {Size size = const Size(420, 900)}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        ...fakes.overrides,
        filePickerProvider.overrideWithValue(({required bool camera}) async => PickedUpload(bytes: _png, contentType: 'image/png')),
      ],
      retry: (_, _) => null,
      child: const HrmsApp(),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('HR lists employees with compliance and filters to missing documents', (tester) async {
    final fakes = Fakes(user: hrUser);
    await _pump(tester, fakes);
    await tester.tap(find.text('More'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('more.employees')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('employee.e1')), findsOneWidget);
    expect(find.descendant(of: find.byKey(const Key('employee.e2')), matching: find.text('Missing')), findsOneWidget);

    await tester.tap(find.widgetWithText(ChoiceChip, 'Missing'));
    await tester.pumpAndSettle();
    expect(fakes.employees.listFilters.last.compliance, ComplianceOverall.MISSING);
    expect(find.byKey(const Key('employee.e1')), findsNothing);
    expect(find.byKey(const Key('employee.e2')), findsOneWidget);
  });

  testWidgets('profile shows compliance; a manager captures a document photo and saves it for verification', (tester) async {
    final fakes = Fakes(user: omUser);
    await _pump(tester, fakes);
    await tester.tap(find.text('More'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('more.employees')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('employee.e2')));
    await tester.pumpAndSettle();

    expect(find.text('Required documents'), findsOneWidget);
    expect(find.text('Cannot be rostered until every required document is valid.'), findsOneWidget);

    await tester.tap(find.byKey(const Key('profile.addDocument')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('capture.type')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Medical fitness').last);
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('capture.number')), 'MED-77');
    // Saving without a photo is refused.
    await tester.tap(find.byKey(const Key('capture.save')));
    await tester.pumpAndSettle();
    expect(fakes.employees.createdDocuments, isEmpty);

    await tester.tap(find.byKey(const Key('capture.camera')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const Key('capture.save')));
    await tester.tap(find.byKey(const Key('capture.save')));
    await tester.pumpAndSettle();

    expect(fakes.employees.uploads.single.$1, 'e2');
    expect(fakes.employees.createdDocuments.single.type, DocumentType.MEDICAL_FITNESS);
    expect(fakes.employees.createdDocuments.single.number, 'MED-77');
    expect(fakes.employees.createdDocuments.single.fileKey, startsWith('employees/e2/document/'));
    expect(find.text('Document saved. HR will verify it.'), findsOneWidget);
  });

  testWidgets('onboarding wizard validates each step and creates the employee with a job row', (tester) async {
    final fakes = Fakes(user: hrUser);
    await _pump(tester, fakes);
    await tester.tap(find.text('More'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('more.employees')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('employees.add')));
    await tester.pumpAndSettle();

    // Step 1 refuses empty fields.
    await tester.tap(find.byKey(const Key('onboard.next.0')));
    await tester.pumpAndSettle();
    expect(find.text('Required'), findsWidgets);

    await tester.enterText(find.byKey(const Key('onboard.empCode')), 'nls900');
    await tester.enterText(find.byKey(const Key('onboard.name')), 'Kiran Deshmukh');
    await tester.enterText(find.byKey(const Key('onboard.phone')), '98765 43210');
    await tester.tap(find.byKey(const Key('onboard.next.0')));
    await tester.pumpAndSettle();

    // Step 2: depot is required.
    await tester.tap(find.byKey(const Key('onboard.next.1')));
    await tester.pumpAndSettle();
    expect(find.text('Required'), findsWidgets);
    await tester.tap(find.byKey(const Key('onboard.depot')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Pune Depot (PUN) · NLS').last);
    await tester.pumpAndSettle();
    // Reporting RM is required.
    await tester.tap(find.byKey(const Key('onboard.reportsTo')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Asha Patil (NLS003)').last);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('onboard.next.1')));
    await tester.pumpAndSettle();

    // Step 3 is optional.
    await tester.tap(find.byKey(const Key('onboard.next.2')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('onboard.review')), findsOneWidget);
    expect(find.text('+91 98765 43210'), findsOneWidget);
    await tester.tap(find.byKey(const Key('onboard.next.3')));
    await tester.pumpAndSettle();

    final body = fakes.employees.created.single;
    expect(body.empCode, 'NLS900');
    expect(body.phone, '+919876543210');
    expect(body.category, EmployeeCategory.DRIVER);
    expect(body.job.depotId, 'd1');
    expect(body.job.reportingToEmployeeId, 'emp-rm');
    expect(body.businessUnitId, 'bu-nls');
    expect(body.pan, isNull);
    expect(find.text('Kiran Deshmukh added'), findsOneWidget);
  });

  testWidgets('HR verifies and rejects documents from the queue', (tester) async {
    final fakes = Fakes(user: hrUser);
    Map<String, dynamic> doc(String id, String name) => {
      'id': id,
      'employeeId': 'e1',
      'type': 'DRIVING_LICENCE',
      'number': 'MH12-$id',
      'licenceClass': null,
      'issueDate': null,
      'expiryDate': '2030-01-01',
      'status': 'PENDING_VERIFICATION',
      'hasFile': false,
      'verifiedAt': null,
      'verifiedByName': null,
      'rejectionReason': null,
      'createdAt': '2026-11-09T05:00:00.000Z',
      'daysToExpiry': 1000,
      'employee': {'id': 'e1', 'empCode': 'D001', 'fullName': name, 'category': 'DRIVER', 'depot': depotJson},
    };
    fakes.employees.queue = [doc('q1', 'Ramesh Pawar'), doc('q2', 'Suresh Jadhav')];
    await _pump(tester, fakes);
    await tester.tap(find.text('More'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('more.documents')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('verify.q1')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('verify.approve')));
    await tester.pumpAndSettle();
    expect(fakes.employees.verified, ['q1']);
    expect(find.byKey(const Key('verify.q1')), findsNothing);

    await tester.tap(find.byKey(const Key('verify.q2')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('verify.reject')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('reason.text')), 'Photo is blurred');
    await tester.pump();
    await tester.tap(find.byKey(const Key('reason.ok')));
    await tester.pumpAndSettle();
    expect(fakes.employees.rejected, {'q2': 'Photo is blurred'});
    expect(find.text('Nothing to verify. 🎉'), findsOneWidget);
  });
}
