//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/dashboard_me_pending_approvals.dart';
import 'package:hrms_api/src/model/dashboard_me_my_attendance_today.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dashboard_me.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DashboardMe {
  /// Returns a new [DashboardMe] instance.
  DashboardMe({
    required this.pendingApprovals,

    required this.tasksOpen,

    required this.tasksOverdue,

    required this.myAttendanceToday,

    required this.unreadNotifications,
  });

  @JsonKey(name: r'pendingApprovals', required: true, includeIfNull: false)
  final DashboardMePendingApprovals pendingApprovals;

  @JsonKey(name: r'tasksOpen', required: true, includeIfNull: false)
  final int tasksOpen;

  @JsonKey(name: r'tasksOverdue', required: true, includeIfNull: false)
  final int tasksOverdue;

  @JsonKey(name: r'myAttendanceToday', required: true, includeIfNull: true)
  final DashboardMeMyAttendanceToday? myAttendanceToday;

  @JsonKey(name: r'unreadNotifications', required: true, includeIfNull: false)
  final int unreadNotifications;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DashboardMe &&
          other.pendingApprovals == pendingApprovals &&
          other.tasksOpen == tasksOpen &&
          other.tasksOverdue == tasksOverdue &&
          other.myAttendanceToday == myAttendanceToday &&
          other.unreadNotifications == unreadNotifications;

  @override
  int get hashCode =>
      pendingApprovals.hashCode +
      tasksOpen.hashCode +
      tasksOverdue.hashCode +
      (myAttendanceToday == null ? 0 : myAttendanceToday.hashCode) +
      unreadNotifications.hashCode;

  factory DashboardMe.fromJson(Map<String, dynamic> json) =>
      _$DashboardMeFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardMeToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
