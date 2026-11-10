//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'team_attendance_row_duties_inner.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class TeamAttendanceRowDutiesInner {
  /// Returns a new [TeamAttendanceRowDutiesInner] instance.
  TeamAttendanceRowDutiesInner({
    required this.dutyId,

    required this.assignmentId,

    required this.startTime,

    required this.endTime,

    required this.routeCode,
  });

  @JsonKey(name: r'dutyId', required: true, includeIfNull: false)
  final String dutyId;

  @JsonKey(name: r'assignmentId', required: true, includeIfNull: false)
  final String assignmentId;

  @JsonKey(name: r'startTime', required: true, includeIfNull: false)
  final String startTime;

  @JsonKey(name: r'endTime', required: true, includeIfNull: false)
  final String endTime;

  @JsonKey(name: r'routeCode', required: true, includeIfNull: true)
  final String? routeCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeamAttendanceRowDutiesInner &&
          other.dutyId == dutyId &&
          other.assignmentId == assignmentId &&
          other.startTime == startTime &&
          other.endTime == endTime &&
          other.routeCode == routeCode;

  @override
  int get hashCode =>
      dutyId.hashCode +
      assignmentId.hashCode +
      startTime.hashCode +
      endTime.hashCode +
      (routeCode == null ? 0 : routeCode.hashCode);

  factory TeamAttendanceRowDutiesInner.fromJson(Map<String, dynamic> json) =>
      _$TeamAttendanceRowDutiesInnerFromJson(json);

  Map<String, dynamic> toJson() => _$TeamAttendanceRowDutiesInnerToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
