import 'package:drift/drift.dart';

import 'offline_db.dart';

enum QueuedState { pending, failed }

/// A mark saved on the device and not yet accepted by the API.
class QueuedMark {
  const QueuedMark({
    required this.clientMutationId,
    required this.employeeId,
    required this.employeeName,
    required this.depotId,
    required this.date,
    required this.status,
    this.note,
    this.state = QueuedState.pending,
    this.errorCode,
    this.errorMessage,
    required this.createdAt,
  });

  final String clientMutationId;
  final String employeeId;
  final String employeeName;
  final String depotId;
  final String date;

  /// AttendanceStatus API value (e.g. PRESENT).
  final String status;
  final String? note;
  final QueuedState state;
  final String? errorCode;
  final String? errorMessage;
  final DateTime createdAt;
}

/// Durable queue of attendance marks for offline use.
abstract class AttendanceQueue {
  /// Adds marks; a newer pending mark for the same employee and date replaces the older one.
  Future<void> enqueue(List<QueuedMark> marks);
  Future<List<QueuedMark>> pending({int limit = 500});
  Stream<List<QueuedMark>> watchAll();
  Future<void> remove(List<String> clientMutationIds);
  Future<void> markFailed(String clientMutationId, String code, String message);
  Future<void> discardFailed();
}

class DriftAttendanceQueue implements AttendanceQueue {
  DriftAttendanceQueue(this._db);

  final OfflineDb _db;

  QueuedMark _map(PendingMark r) => QueuedMark(
    clientMutationId: r.clientMutationId,
    employeeId: r.employeeId,
    employeeName: r.employeeName,
    depotId: r.depotId,
    date: r.date,
    status: r.status,
    note: r.note,
    state: r.state == 'FAILED' ? QueuedState.failed : QueuedState.pending,
    errorCode: r.errorCode,
    errorMessage: r.errorMessage,
    createdAt: r.createdAt,
  );

  @override
  Future<void> enqueue(List<QueuedMark> marks) => _db.transaction(() async {
    for (final m in marks) {
      await (_db.delete(_db.pendingMarks)..where((t) => t.employeeId.equals(m.employeeId) & t.date.equals(m.date))).go();
      await _db
          .into(_db.pendingMarks)
          .insert(
            PendingMarksCompanion.insert(
              clientMutationId: m.clientMutationId,
              employeeId: m.employeeId,
              employeeName: m.employeeName,
              depotId: m.depotId,
              date: m.date,
              status: m.status,
              note: Value(m.note),
              createdAt: m.createdAt,
            ),
          );
    }
  });

  @override
  Future<List<QueuedMark>> pending({int limit = 500}) async {
    final rows =
        await (_db.select(_db.pendingMarks)
              ..where((t) => t.state.equals('PENDING'))
              ..orderBy([(t) => OrderingTerm.asc(t.createdAt)])
              ..limit(limit))
            .get();
    return rows.map(_map).toList();
  }

  @override
  Stream<List<QueuedMark>> watchAll() =>
      (_db.select(_db.pendingMarks)..orderBy([(t) => OrderingTerm.asc(t.createdAt)])).watch().map((rows) => rows.map(_map).toList());

  @override
  Future<void> remove(List<String> clientMutationIds) async {
    if (clientMutationIds.isEmpty) return;
    await (_db.delete(_db.pendingMarks)..where((t) => t.clientMutationId.isIn(clientMutationIds))).go();
  }

  @override
  Future<void> markFailed(String clientMutationId, String code, String message) async {
    await (_db.update(_db.pendingMarks)..where((t) => t.clientMutationId.equals(clientMutationId))).write(
      PendingMarksCompanion(state: const Value('FAILED'), errorCode: Value(code), errorMessage: Value(message)),
    );
  }

  @override
  Future<void> discardFailed() async {
    await (_db.delete(_db.pendingMarks)..where((t) => t.state.equals('FAILED'))).go();
  }
}
