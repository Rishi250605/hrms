//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'team_attendance_row_leave.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class TeamAttendanceRowLeave {
  /// Returns a new [TeamAttendanceRowLeave] instance.
  TeamAttendanceRowLeave({
    required this.leaveRequestId,

    required this.kind,

    required this.code,

    required this.half,
  });

  @JsonKey(name: r'leaveRequestId', required: true, includeIfNull: false)
  final String leaveRequestId;

  @JsonKey(name: r'kind', required: true, includeIfNull: false)
  final TeamAttendanceRowLeaveKindEnum kind;

  @JsonKey(name: r'code', required: true, includeIfNull: true)
  final String? code;

  @JsonKey(name: r'half', required: true, includeIfNull: false)
  final bool half;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeamAttendanceRowLeave &&
          other.leaveRequestId == leaveRequestId &&
          other.kind == kind &&
          other.code == code &&
          other.half == half;

  @override
  int get hashCode =>
      leaveRequestId.hashCode +
      kind.hashCode +
      (code == null ? 0 : code.hashCode) +
      half.hashCode;

  factory TeamAttendanceRowLeave.fromJson(Map<String, dynamic> json) =>
      _$TeamAttendanceRowLeaveFromJson(json);

  Map<String, dynamic> toJson() => _$TeamAttendanceRowLeaveToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum TeamAttendanceRowLeaveKindEnum {
  @JsonValue(r'LEAVE')
  LEAVE(r'LEAVE'),
  @JsonValue(r'OD')
  OD(r'OD');

  const TeamAttendanceRowLeaveKindEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
