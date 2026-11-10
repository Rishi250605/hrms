// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(attendanceRepository)
final attendanceRepositoryProvider = AttendanceRepositoryProvider._();

final class AttendanceRepositoryProvider extends $FunctionalProvider<AttendanceRepository, AttendanceRepository, AttendanceRepository>
    with $Provider<AttendanceRepository> {
  AttendanceRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'attendanceRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$attendanceRepositoryHash();

  @$internal
  @override
  $ProviderElement<AttendanceRepository> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  AttendanceRepository create(Ref ref) {
    return attendanceRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AttendanceRepository value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<AttendanceRepository>(value));
  }
}

String _$attendanceRepositoryHash() => r'f382fb5e90b749dfa27883b66d31e80558cbccdc';

@ProviderFor(offlineDb)
final offlineDbProvider = OfflineDbProvider._();

final class OfflineDbProvider extends $FunctionalProvider<OfflineDb, OfflineDb, OfflineDb> with $Provider<OfflineDb> {
  OfflineDbProvider._()
    : super(from: null, argument: null, retry: null, name: r'offlineDbProvider', isAutoDispose: false, dependencies: null, $allTransitiveDependencies: null);

  @override
  String debugGetCreateSourceHash() => _$offlineDbHash();

  @$internal
  @override
  $ProviderElement<OfflineDb> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  OfflineDb create(Ref ref) {
    return offlineDb(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OfflineDb value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<OfflineDb>(value));
  }
}

String _$offlineDbHash() => r'01504a27764e3a4c36333bc8d070da3f80968fe7';

@ProviderFor(attendanceQueue)
final attendanceQueueProvider = AttendanceQueueProvider._();

final class AttendanceQueueProvider extends $FunctionalProvider<AttendanceQueue, AttendanceQueue, AttendanceQueue> with $Provider<AttendanceQueue> {
  AttendanceQueueProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'attendanceQueueProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$attendanceQueueHash();

  @$internal
  @override
  $ProviderElement<AttendanceQueue> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  AttendanceQueue create(Ref ref) {
    return attendanceQueue(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AttendanceQueue value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<AttendanceQueue>(value));
  }
}

String _$attendanceQueueHash() => r'fa14ed1554e9755963927afcdfaf17265f1c47ac';
