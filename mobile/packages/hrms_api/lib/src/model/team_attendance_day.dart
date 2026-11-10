//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/team_attendance_day_summary.dart';
import 'package:hrms_api/src/model/team_attendance_row.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'team_attendance_day.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class TeamAttendanceDay {
  /// Returns a new [TeamAttendanceDay] instance.
  TeamAttendanceDay({
    required this.date,

    required this.editable,

    required this.editableUntil,

    required this.summary,

    required this.rows,
  });

  /// Calendar date (IST business date)
  @JsonKey(name: r'date', required: true, includeIfNull: false)
  final String date;

  /// False once the edit window closed (use a correction)
  @JsonKey(name: r'editable', required: true, includeIfNull: false)
  final bool editable;

  @JsonKey(name: r'editableUntil', required: true, includeIfNull: false)
  final DateTime editableUntil;

  @JsonKey(name: r'summary', required: true, includeIfNull: false)
  final TeamAttendanceDaySummary summary;

  @JsonKey(name: r'rows', required: true, includeIfNull: false)
  final List<TeamAttendanceRow> rows;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeamAttendanceDay &&
          other.date == date &&
          other.editable == editable &&
          other.editableUntil == editableUntil &&
          other.summary == summary &&
          other.rows == rows;

  @override
  int get hashCode =>
      date.hashCode +
      editable.hashCode +
      editableUntil.hashCode +
      summary.hashCode +
      rows.hashCode;

  factory TeamAttendanceDay.fromJson(Map<String, dynamic> json) =>
      _$TeamAttendanceDayFromJson(json);

  Map<String, dynamic> toJson() => _$TeamAttendanceDayToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
