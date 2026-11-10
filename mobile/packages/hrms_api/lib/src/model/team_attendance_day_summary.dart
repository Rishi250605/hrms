//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'team_attendance_day_summary.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class TeamAttendanceDaySummary {
  /// Returns a new [TeamAttendanceDaySummary] instance.
  TeamAttendanceDaySummary({
    required this.employees,

    required this.marked,

    required this.pending,
  });

  @JsonKey(name: r'employees', required: true, includeIfNull: false)
  final int employees;

  @JsonKey(name: r'marked', required: true, includeIfNull: false)
  final int marked;

  @JsonKey(name: r'pending', required: true, includeIfNull: false)
  final int pending;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeamAttendanceDaySummary &&
          other.employees == employees &&
          other.marked == marked &&
          other.pending == pending;

  @override
  int get hashCode => employees.hashCode + marked.hashCode + pending.hashCode;

  factory TeamAttendanceDaySummary.fromJson(Map<String, dynamic> json) =>
      _$TeamAttendanceDaySummaryFromJson(json);

  Map<String, dynamic> toJson() => _$TeamAttendanceDaySummaryToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
