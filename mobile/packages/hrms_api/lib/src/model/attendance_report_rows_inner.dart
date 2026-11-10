//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/payslip_item_employee.dart';
import 'package:hrms_api/src/model/attendance_report_summary.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attendance_report_rows_inner.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AttendanceReportRowsInner {
  /// Returns a new [AttendanceReportRowsInner] instance.
  AttendanceReportRowsInner({
    required this.employee,

    required this.businessUnitCode,

    required this.codes,

    required this.summary,
  });

  @JsonKey(name: r'employee', required: true, includeIfNull: false)
  final PayslipItemEmployee employee;

  @JsonKey(name: r'businessUnitCode', required: true, includeIfNull: true)
  final String? businessUnitCode;

  /// One per day: P, A, HD, L, OD, WO, H; suffix * = pending approval, ! = rejected; empty = no mark
  @JsonKey(name: r'codes', required: true, includeIfNull: false)
  final List<String> codes;

  @JsonKey(name: r'summary', required: true, includeIfNull: false)
  final AttendanceReportSummary summary;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttendanceReportRowsInner &&
          other.employee == employee &&
          other.businessUnitCode == businessUnitCode &&
          other.codes == codes &&
          other.summary == summary;

  @override
  int get hashCode =>
      employee.hashCode +
      (businessUnitCode == null ? 0 : businessUnitCode.hashCode) +
      codes.hashCode +
      summary.hashCode;

  factory AttendanceReportRowsInner.fromJson(Map<String, dynamic> json) =>
      _$AttendanceReportRowsInnerFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceReportRowsInnerToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
