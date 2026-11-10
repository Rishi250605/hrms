//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/attendance_status.dart';
import 'package:hrms_api/src/model/approval_state.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dashboard_me_my_attendance_today.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DashboardMeMyAttendanceToday {
  /// Returns a new [DashboardMeMyAttendanceToday] instance.
  DashboardMeMyAttendanceToday({
    required this.status,

    required this.approvalState,
  });

  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final AttendanceStatus status;

  @JsonKey(name: r'approvalState', required: true, includeIfNull: false)
  final ApprovalState approvalState;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DashboardMeMyAttendanceToday &&
          other.status == status &&
          other.approvalState == approvalState;

  @override
  int get hashCode => status.hashCode + approvalState.hashCode;

  factory DashboardMeMyAttendanceToday.fromJson(Map<String, dynamic> json) =>
      _$DashboardMeMyAttendanceTodayFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardMeMyAttendanceTodayToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
