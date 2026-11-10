import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'offline_db.g.dart';

/// Attendance marks waiting to reach the API (CLAUDE.md §5 Offline). One row per client mutation.
class PendingMarks extends Table {
  TextColumn get clientMutationId => text()();
  TextColumn get employeeId => text()();
  TextColumn get employeeName => text()();
  TextColumn get depotId => text()();
  TextColumn get date => text()();
  TextColumn get status => text()();
  TextColumn get note => text().nullable()();

  /// PENDING (to send) or FAILED (the API rejected it; needs the manager's attention).
  TextColumn get state => text().withDefault(const Constant('PENDING'))();
  TextColumn get errorCode => text().nullable()();
  TextColumn get errorMessage => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {clientMutationId};
}

@DriftDatabase(tables: [PendingMarks])
class OfflineDb extends _$OfflineDb {
  OfflineDb(super.executor);

  /// On-device database (SQLite on Android/iOS/desktop, IndexedDB/OPFS on web).
  factory OfflineDb.open() => OfflineDb(driftDatabase(name: 'hrms_offline'));

  @override
  int get schemaVersion => 1;
}
