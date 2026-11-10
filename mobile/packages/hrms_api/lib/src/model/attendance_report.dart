//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/business_unit_ref.dart';
import 'package:hrms_api/src/model/attendance_report_legend_inner.dart';
import 'package:hrms_api/src/model/attendance_report_rows_inner.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attendance_report.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AttendanceReport {
  /// Returns a new [AttendanceReport] instance.
  AttendanceReport({
    required this.from,

    required this.to,

    required this.days,

    required this.businessUnits,

    required this.legend,

    required this.rows,

    required this.generatedAt,
  });

  /// Calendar date (IST business date)
  @JsonKey(name: r'from', required: true, includeIfNull: false)
  final String from;

  /// Calendar date (IST business date)
  @JsonKey(name: r'to', required: true, includeIfNull: false)
  final String to;

  @JsonKey(name: r'days', required: true, includeIfNull: false)
  final List<String> days;

  @JsonKey(name: r'businessUnits', required: true, includeIfNull: false)
  final List<BusinessUnitRef> businessUnits;

  @JsonKey(name: r'legend', required: true, includeIfNull: false)
  final List<AttendanceReportLegendInner> legend;

  @JsonKey(name: r'rows', required: true, includeIfNull: false)
  final List<AttendanceReportRowsInner> rows;

  @JsonKey(name: r'generatedAt', required: true, includeIfNull: false)
  final DateTime generatedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttendanceReport &&
          other.from == from &&
          other.to == to &&
          other.days == days &&
          other.businessUnits == businessUnits &&
          other.legend == legend &&
          other.rows == rows &&
          other.generatedAt == generatedAt;

  @override
  int get hashCode =>
      from.hashCode +
      to.hashCode +
      days.hashCode +
      businessUnits.hashCode +
      legend.hashCode +
      rows.hashCode +
      generatedAt.hashCode;

  factory AttendanceReport.fromJson(Map<String, dynamic> json) =>
      _$AttendanceReportFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceReportToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
