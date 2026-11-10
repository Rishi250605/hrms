// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_sync.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Everything in the offline queue (pending + failed), live.

@ProviderFor(queuedMarks)
final queuedMarksProvider = QueuedMarksProvider._();

/// Everything in the offline queue (pending + failed), live.

final class QueuedMarksProvider extends $FunctionalProvider<AsyncValue<List<QueuedMark>>, List<QueuedMark>, Stream<List<QueuedMark>>>
    with $FutureModifier<List<QueuedMark>>, $StreamProvider<List<QueuedMark>> {
  /// Everything in the offline queue (pending + failed), live.
  QueuedMarksProvider._()
    : super(from: null, argument: null, retry: null, name: r'queuedMarksProvider', isAutoDispose: false, dependencies: null, $allTransitiveDependencies: null);

  @override
  String debugGetCreateSourceHash() => _$queuedMarksHash();

  @$internal
  @override
  $StreamProviderElement<List<QueuedMark>> $createElement($ProviderPointer pointer) => $StreamProviderElement(pointer);

  @override
  Stream<List<QueuedMark>> create(Ref ref) {
    return queuedMarks(ref);
  }
}

String _$queuedMarksHash() => r'9d3e3e2479cee013ead7406b8595a167930dc686';

/// Saves marks to the device first, then sends them (idempotent by clientMutationId). If the network is
/// down the marks stay queued and are retried every [retryEvery] and whenever [sync] is called.

@ProviderFor(AttendanceSync)
final attendanceSyncProvider = AttendanceSyncProvider._();

/// Saves marks to the device first, then sends them (idempotent by clientMutationId). If the network is
/// down the marks stay queued and are retried every [retryEvery] and whenever [sync] is called.
final class AttendanceSyncProvider extends $NotifierProvider<AttendanceSync, SyncState> {
  /// Saves marks to the device first, then sends them (idempotent by clientMutationId). If the network is
  /// down the marks stay queued and are retried every [retryEvery] and whenever [sync] is called.
  AttendanceSyncProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'attendanceSyncProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$attendanceSyncHash();

  @$internal
  @override
  AttendanceSync create() => AttendanceSync();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SyncState value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<SyncState>(value));
  }
}

String _$attendanceSyncHash() => r'be5e0f0e5fd5f7a9088adb7428aef9532f9b3c03';

/// Saves marks to the device first, then sends them (idempotent by clientMutationId). If the network is
/// down the marks stay queued and are retried every [retryEvery] and whenever [sync] is called.

abstract class _$AttendanceSync extends $Notifier<SyncState> {
  SyncState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<SyncState, SyncState>;
    final element = ref.element as $ClassProviderElement<AnyNotifier<SyncState, SyncState>, SyncState, Object?, Object?>;
    return element.handleCreate(ref, build);
  }
}
