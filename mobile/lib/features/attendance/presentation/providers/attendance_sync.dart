import 'dart:async';

import 'package:hrms_api/hrms_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/errors/api_failure.dart';
import '../../data/attendance_repository.dart';
import '../../data/offline/attendance_queue.dart';

part 'attendance_sync.g.dart';

class SyncState {
  const SyncState({this.syncing = false, this.offline = false, this.lastError, this.lastSyncedAt});

  final bool syncing;

  /// The last attempt could not reach the server; marks stay queued and are retried.
  final bool offline;
  final String? lastError;
  final DateTime? lastSyncedAt;

  SyncState copyWith({bool? syncing, bool? offline, String? lastError, bool clearError = false, DateTime? lastSyncedAt}) => SyncState(
    syncing: syncing ?? this.syncing,
    offline: offline ?? this.offline,
    lastError: clearError ? null : (lastError ?? this.lastError),
    lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
  );
}

/// Everything in the offline queue (pending + failed), live.
@Riverpod(keepAlive: true)
Stream<List<QueuedMark>> queuedMarks(Ref ref) => ref.watch(attendanceQueueProvider).watchAll();

/// Saves marks to the device first, then sends them (idempotent by clientMutationId). If the network is
/// down the marks stay queued and are retried every [retryEvery] and whenever [sync] is called.
@Riverpod(keepAlive: true)
class AttendanceSync extends _$AttendanceSync {
  static const retryEvery = Duration(seconds: 30);
  static const _uuid = Uuid();
  Timer? _timer;
  Future<void>? _running;

  @override
  SyncState build() {
    ref.onDispose(() => _timer?.cancel());
    // Flush anything left from a previous session.
    Future.microtask(sync);
    return const SyncState();
  }

  /// Queues the marks and starts a sync. Returns once they are safely on the device.
  /// [businessUnitId] is kept in the queue's depotId column (schema unchanged since phase 1).
  Future<void> submit(List<({String employeeId, String employeeName, String businessUnitId, String date, AttendanceStatus status, String? note})> marks) async {
    final now = DateTime.now();
    await ref.read(attendanceQueueProvider).enqueue([
      for (final m in marks)
        QueuedMark(
          clientMutationId: _uuid.v4(),
          employeeId: m.employeeId,
          employeeName: m.employeeName,
          depotId: m.businessUnitId,
          date: m.date,
          status: m.status.value,
          note: m.note,
          createdAt: now,
        ),
    ]);
    unawaited(sync());
  }

  /// Sends queued marks in batches. Concurrent calls share one run.
  Future<void> sync() => _running ??= _sync().whenComplete(() => _running = null);

  Future<void> _sync() async {
    final queue = ref.read(attendanceQueueProvider);
    final repo = ref.read(attendanceRepositoryProvider);
    if (!ref.mounted) return;
    state = state.copyWith(syncing: true);
    try {
      while (true) {
        final batch = await queue.pending();
        if (batch.isEmpty) break;
        final result = await repo.bulk([
          for (final m in batch)
            BulkMark(
              clientMutationId: m.clientMutationId,
              employeeId: m.employeeId,
              date: m.date,
              status: AttendanceStatus.values.firstWhere((s) => s.value == m.status),
              note: m.note,
            ),
        ]);
        final done = <String>[];
        for (final r in result.results) {
          if (r.outcome == BulkResultItemOutcomeEnum.REJECTED) {
            await queue.markFailed(r.clientMutationId, r.error?.code ?? 'REJECTED', r.error?.message ?? 'Rejected');
          } else {
            done.add(r.clientMutationId);
          }
        }
        await queue.remove(done);
      }
      _timer?.cancel();
      if (ref.mounted) state = state.copyWith(syncing: false, offline: false, clearError: true, lastSyncedAt: DateTime.now());
    } on ApiFailure catch (f) {
      if (!ref.mounted) return;
      state = state.copyWith(syncing: false, offline: f.isNetwork, lastError: f.isNetwork ? null : f.message);
      _scheduleRetry();
    }
  }

  void _scheduleRetry() {
    _timer?.cancel();
    _timer = Timer(retryEvery, () => unawaited(sync()));
  }

  Future<void> discardFailed() => ref.read(attendanceQueueProvider).discardFailed();
}
