import 'package:hrms_api/hrms_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/api/api_providers.dart';
import '../../../core/api/guard.dart';

part 'reports_repository.g.dart';

/// Filters of the attendance report (PHASE-2-FEATURES §9.1).
class ReportFilter {
  const ReportFilter({required this.from, required this.to, this.businessUnitId, this.group});

  final String from;
  final String to;
  final String? businessUnitId;
  final ReportGroup? group;

  @override
  bool operator ==(Object other) =>
      other is ReportFilter && other.from == from && other.to == to && other.businessUnitId == businessUnitId && other.group == group;

  @override
  int get hashCode => Object.hash(from, to, businessUnitId, group);
}

class ReportsRepository {
  ReportsRepository(this._api);

  final HrmsApi _api;

  Future<AttendanceReport> attendance(ReportFilter f) =>
      guardApi(() async => (await _api.getReportsApi().attendanceReport(from: f.from, to: f.to, businessUnitId: f.businessUnitId, role: f.group)).data!);

  /// [format]: xlsx | pdf. Returns a short-lived signed URL.
  Future<ReportFile> export(ReportFilter f, String format) => guardApi(
    () async =>
        (await _api.getReportsApi().exportAttendanceReport(format: format, from: f.from, to: f.to, businessUnitId: f.businessUnitId, role: f.group)).data!,
  );
}

@Riverpod(keepAlive: true)
ReportsRepository reportsRepository(Ref ref) => ReportsRepository(ref.watch(hrmsApiProvider));
