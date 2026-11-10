import 'package:drift/drift.dart' show DatabaseConnection;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hrms_api/hrms_api.dart';
import 'package:hrms_app/core/format.dart';
import 'package:hrms_app/features/attendance/data/attendance_repository.dart';
import 'package:hrms_app/features/attendance/data/offline/attendance_queue.dart';
import 'package:hrms_app/features/attendance/data/offline/offline_db.dart';
import 'package:hrms_app/features/attendance/presentation/providers/attendance_sync.dart';

import '../../support/fakes.dart';

Map<String, dynamic> _day() => emptyTeamDay(
  date: todayIso(),
  rows: [
    teamRowJson('e1', 'Ramesh Pawar'),
    teamRowJson('e2', 'Vijay More', leave: {'leaveRequestId': 'lr1', 'kind': 'LEAVE', 'code': 'CL', 'half': false}, suggested: 'ON_LEAVE'),
    teamRowJson('e3', 'Raju Gaikwad', category: 'LOADMAN'),
  ],
);

QueuedMark _mark(String id, String employeeId, String status, {String date = '2026-11-09'}) =>
    QueuedMark(clientMutationId: id, employeeId: employeeId, employeeName: employeeId, depotId: 'bu-nls', date: date, status: status, createdAt: DateTime(2026, 11, 9));

void main() {
  group('drift offline queue', () {
    late OfflineDb db;
    late DriftAttendanceQueue queue;
    setUp(() {
      db = OfflineDb(DatabaseConnection(NativeDatabase.memory(), closeStreamsSynchronously: true));
      queue = DriftAttendanceQueue(db);
    });
    tearDown(() => db.close());

    test('a newer mark for the same employee and day replaces the older one', () async {
      await queue.enqueue([_mark('m1', 'e1', 'PRESENT'), _mark('m2', 'e2', 'ABSENT')]);
      await queue.enqueue([_mark('m3', 'e1', 'HALF_DAY')]);
      final pending = await queue.pending();
      expect(pending.map((m) => '${m.employeeId}:${m.status}'), unorderedEquals(['e2:ABSENT', 'e1:HALF_DAY']));
    });

    test('failed marks leave the pending list until discarded', () async {
      await queue.enqueue([_mark('m1', 'e1', 'PRESENT'), _mark('m2', 'e2', 'PRESENT')]);
      await queue.markFailed('m2', 'EDIT_WINDOW_CLOSED', 'closed');
      expect((await queue.pending()).map((m) => m.clientMutationId), ['m1']);
      final all = await queue.watchAll().first;
      expect(all.firstWhere((m) => m.clientMutationId == 'm2').state, QueuedState.failed);
      await queue.discardFailed();
      await queue.remove(['m1']);
      expect(await queue.watchAll().first, isEmpty);
    });
  });

  group('attendance sync', () {
    test('keeps marks queued while offline, then sends them once (idempotent ids) and drops accepted ones', () async {
      final repo = FakeAttendanceRepository(dayJson: _day())..offline = true;
      final queue = MemoryAttendanceQueue();
      final container = ProviderContainer(
        overrides: [attendanceRepositoryProvider.overrideWithValue(repo), attendanceQueueProvider.overrideWithValue(queue)],
        retry: (_, _) => null,
      );
      addTearDown(container.dispose);
      final sync = container.read(attendanceSyncProvider.notifier);

      await sync.submit([
        (employeeId: 'e1', employeeName: 'Ramesh', businessUnitId: 'bu-nls', date: '2026-11-09', status: AttendanceStatus.PRESENT, note: null),
        (employeeId: 'e3', employeeName: 'Raju', businessUnitId: 'bu-nls', date: '2026-11-09', status: AttendanceStatus.ABSENT, note: null),
      ]);
      await sync.sync();
      expect(container.read(attendanceSyncProvider).offline, isTrue);
      expect(queue.items, hasLength(2));
      final ids = queue.items.map((m) => m.clientMutationId).toList();

      repo
        ..offline = false
        ..rejectFor['e3'] = 'EDIT_WINDOW_CLOSED';
      await sync.sync();
      expect(container.read(attendanceSyncProvider).offline, isFalse);
      expect(repo.sent.single.map((m) => m.clientMutationId), ids);
      expect(queue.items.single.employeeId, 'e3');
      expect(queue.items.single.state, QueuedState.failed);
    });
  });

  testWidgets('RM team tab: leave pre-filled, all present, one exception, queued offline with a pending badge', (tester) async {
    final fakes = Fakes(user: rmUser, teamDay: _day());
    fakes.attendance.offline = true;
    await pumpApp(tester, fakes);
    await tester.tap(find.text('Attendance'));
    await tester.pumpAndSettle();

    ChoiceChip chip(String employee, String status) => tester.widget<ChoiceChip>(find.byKey(Key('att.$employee.$status')));
    expect(chip('e1', 'PRESENT').selected, isTrue);
    expect(chip('e2', 'ON_LEAVE').selected, isTrue);

    await tester.tap(find.byKey(const Key('attendance.allPresent')));
    await tester.pumpAndSettle();
    expect(chip('e3', 'PRESENT').selected, isTrue);
    await tester.tap(find.byKey(const Key('att.e1.ABSENT')));
    await tester.pumpAndSettle();
    expect(find.text('Submit 3 marks'), findsOneWidget);

    await tester.tap(find.byKey(const Key('attendance.submit')));
    await tester.pumpAndSettle();

    expect(fakes.queue.items.map((m) => '${m.employeeId}:${m.status}'), unorderedEquals(['e1:ABSENT', 'e2:ON_LEAVE', 'e3:PRESENT']));
    expect(fakes.queue.items.every((m) => m.depotId == 'bu-nls'), isTrue);
    expect(find.byKey(const Key('att.pending.e1')), findsOneWidget);
    expect(find.textContaining('Offline: 3 marks'), findsOneWidget);
    expect(find.text('Nothing to submit'), findsOneWidget);

    // My attendance tab: self-mark goes for approval.
    await tester.tap(find.byKey(const Key('attendance.tab.mine')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('self.ON_DUTY')));
    await tester.tap(find.byKey(const Key('self.submit')));
    await tester.pumpAndSettle();
    expect(fakes.attendance.selfMarks, [SelfMarkBodyStatusEnum.ON_DUTY]);

    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('OM approvals tab approves all pending self-marks of their RMs in one action', (tester) async {
    final fakes = Fakes(user: omUser);
    fakes.attendance.approvalItems = [markJson('m1', canDecide: true), markJson('m2', name: 'Rahul Desai', canDecide: true)];
    await pumpApp(tester, fakes);
    await tester.tap(find.text('Attendance'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('attendance.tab.approvals')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('approval.mark.m1')), findsOneWidget);
    await tester.tap(find.byKey(const Key('approvals.approveAll')));
    await tester.pumpAndSettle();
    expect(fakes.attendance.approved, ['m1', 'm2']);
    expect(find.text('Nothing waiting for you.'), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
  });
}
