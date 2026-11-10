// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AttendanceDate)
final attendanceDateProvider = AttendanceDateProvider._();

final class AttendanceDateProvider extends $NotifierProvider<AttendanceDate, String> {
  AttendanceDateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'attendanceDateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$attendanceDateHash();

  @$internal
  @override
  AttendanceDate create() => AttendanceDate();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<String>(value));
  }
}

String _$attendanceDateHash() => r'73240517c2e1b041bb7c67e6edd993d42cb5f8d5';

abstract class _$AttendanceDate extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element = ref.element as $ClassProviderElement<AnyNotifier<String, String>, String, Object?, Object?>;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(teamAttendance)
final teamAttendanceProvider = TeamAttendanceFamily._();

final class TeamAttendanceProvider extends $FunctionalProvider<AsyncValue<TeamAttendanceDay>, TeamAttendanceDay, FutureOr<TeamAttendanceDay>>
    with $FutureModifier<TeamAttendanceDay>, $FutureProvider<TeamAttendanceDay> {
  TeamAttendanceProvider._({required TeamAttendanceFamily super.from, required String super.argument})
    : super(retry: null, name: r'teamAttendanceProvider', isAutoDispose: true, dependencies: null, $allTransitiveDependencies: null);

  @override
  String debugGetCreateSourceHash() => _$teamAttendanceHash();

  @override
  String toString() {
    return r'teamAttendanceProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<TeamAttendanceDay> $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<TeamAttendanceDay> create(Ref ref) {
    final argument = this.argument as String;
    return teamAttendance(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TeamAttendanceProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$teamAttendanceHash() => r'6e5b55fa9bdfad62b73289839aa400fd3b7781d2';

final class TeamAttendanceFamily extends $Family with $FunctionalFamilyOverride<FutureOr<TeamAttendanceDay>, String> {
  TeamAttendanceFamily._() : super(retry: null, name: r'teamAttendanceProvider', dependencies: null, $allTransitiveDependencies: null, isAutoDispose: true);

  TeamAttendanceProvider call(String date) => TeamAttendanceProvider._(argument: date, from: this);

  @override
  String toString() => r'teamAttendanceProvider';
}

/// My own marks of the last 31 days.

@ProviderFor(myAttendance)
final myAttendanceProvider = MyAttendanceProvider._();

/// My own marks of the last 31 days.

final class MyAttendanceProvider extends $FunctionalProvider<AsyncValue<List<AttendanceMarkItem>>, List<AttendanceMarkItem>, FutureOr<List<AttendanceMarkItem>>>
    with $FutureModifier<List<AttendanceMarkItem>>, $FutureProvider<List<AttendanceMarkItem>> {
  /// My own marks of the last 31 days.
  MyAttendanceProvider._()
    : super(from: null, argument: null, retry: null, name: r'myAttendanceProvider', isAutoDispose: true, dependencies: null, $allTransitiveDependencies: null);

  @override
  String debugGetCreateSourceHash() => _$myAttendanceHash();

  @$internal
  @override
  $FutureProviderElement<List<AttendanceMarkItem>> $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<AttendanceMarkItem>> create(Ref ref) {
    return myAttendance(ref);
  }
}

String _$myAttendanceHash() => r'e363713bfe5d2eafd603260db99fd3de2c9c9417';

/// Self-marks and corrections waiting for my decision.

@ProviderFor(attendanceApprovals)
final attendanceApprovalsProvider = AttendanceApprovalsProvider._();

/// Self-marks and corrections waiting for my decision.

final class AttendanceApprovalsProvider
    extends
        $FunctionalProvider<
          AsyncValue<({List<CorrectionItem> corrections, List<AttendanceMarkItem> marks})>,
          ({List<CorrectionItem> corrections, List<AttendanceMarkItem> marks}),
          FutureOr<({List<CorrectionItem> corrections, List<AttendanceMarkItem> marks})>
        >
    with
        $FutureModifier<({List<CorrectionItem> corrections, List<AttendanceMarkItem> marks})>,
        $FutureProvider<({List<CorrectionItem> corrections, List<AttendanceMarkItem> marks})> {
  /// Self-marks and corrections waiting for my decision.
  AttendanceApprovalsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'attendanceApprovalsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$attendanceApprovalsHash();

  @$internal
  @override
  $FutureProviderElement<({List<CorrectionItem> corrections, List<AttendanceMarkItem> marks})> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<({List<CorrectionItem> corrections, List<AttendanceMarkItem> marks})> create(Ref ref) {
    return attendanceApprovals(ref);
  }
}

String _$attendanceApprovalsHash() => r'84ba39e9c0a378633f7ab5e6d1e973fadd32078b';
