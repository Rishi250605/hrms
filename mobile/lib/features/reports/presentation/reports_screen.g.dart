// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reports_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(attendanceReport)
final attendanceReportProvider = AttendanceReportFamily._();

final class AttendanceReportProvider extends $FunctionalProvider<AsyncValue<AttendanceReport>, AttendanceReport, FutureOr<AttendanceReport>>
    with $FutureModifier<AttendanceReport>, $FutureProvider<AttendanceReport> {
  AttendanceReportProvider._({required AttendanceReportFamily super.from, required ReportFilter super.argument})
    : super(retry: null, name: r'attendanceReportProvider', isAutoDispose: true, dependencies: null, $allTransitiveDependencies: null);

  @override
  String debugGetCreateSourceHash() => _$attendanceReportHash();

  @override
  String toString() {
    return r'attendanceReportProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<AttendanceReport> $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<AttendanceReport> create(Ref ref) {
    final argument = this.argument as ReportFilter;
    return attendanceReport(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AttendanceReportProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$attendanceReportHash() => r'1134ae285b9a8ac1310eed0ba7cbfd54488ef578';

final class AttendanceReportFamily extends $Family with $FunctionalFamilyOverride<FutureOr<AttendanceReport>, ReportFilter> {
  AttendanceReportFamily._() : super(retry: null, name: r'attendanceReportProvider', dependencies: null, $allTransitiveDependencies: null, isAutoDispose: true);

  AttendanceReportProvider call(ReportFilter filter) => AttendanceReportProvider._(argument: filter, from: this);

  @override
  String toString() => r'attendanceReportProvider';
}
