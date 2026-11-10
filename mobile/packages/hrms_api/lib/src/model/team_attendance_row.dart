//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/attendance_mark_item.dart';
import 'package:hrms_api/src/model/business_unit_ref.dart';
import 'package:hrms_api/src/model/attendance_status.dart';
import 'package:hrms_api/src/model/team_attendance_row_duties_inner.dart';
import 'package:hrms_api/src/model/depot_summary.dart';
import 'package:hrms_api/src/model/attendance_employee.dart';
import 'package:hrms_api/src/model/team_attendance_row_leave.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'team_attendance_row.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class TeamAttendanceRow {
  /// Returns a new [TeamAttendanceRow] instance.
  TeamAttendanceRow({
    required this.employee,

    required this.designation,

    required this.depot,

    required this.businessUnit,

    required this.duties,

    required this.leave,

    required this.mark,

    required this.suggestedStatus,
  });

  @JsonKey(name: r'employee', required: true, includeIfNull: false)
  final AttendanceEmployee employee;

  @JsonKey(name: r'designation', required: true, includeIfNull: true)
  final String? designation;

  @JsonKey(name: r'depot', required: true, includeIfNull: true)
  final DepotSummary? depot;

  @JsonKey(name: r'businessUnit', required: true, includeIfNull: false)
  final BusinessUnitRef businessUnit;

  @JsonKey(name: r'duties', required: true, includeIfNull: false)
  final List<TeamAttendanceRowDutiesInner> duties;

  @JsonKey(name: r'leave', required: true, includeIfNull: true)
  final TeamAttendanceRowLeave? leave;

  @JsonKey(name: r'mark', required: true, includeIfNull: true)
  final AttendanceMarkItem? mark;

  @JsonKey(name: r'suggestedStatus', required: true, includeIfNull: false)
  final AttendanceStatus suggestedStatus;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeamAttendanceRow &&
          other.employee == employee &&
          other.designation == designation &&
          other.depot == depot &&
          other.businessUnit == businessUnit &&
          other.duties == duties &&
          other.leave == leave &&
          other.mark == mark &&
          other.suggestedStatus == suggestedStatus;

  @override
  int get hashCode =>
      employee.hashCode +
      (designation == null ? 0 : designation.hashCode) +
      (depot == null ? 0 : depot.hashCode) +
      businessUnit.hashCode +
      duties.hashCode +
      (leave == null ? 0 : leave.hashCode) +
      (mark == null ? 0 : mark.hashCode) +
      suggestedStatus.hashCode;

  factory TeamAttendanceRow.fromJson(Map<String, dynamic> json) =>
      _$TeamAttendanceRowFromJson(json);

  Map<String, dynamic> toJson() => _$TeamAttendanceRowToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
