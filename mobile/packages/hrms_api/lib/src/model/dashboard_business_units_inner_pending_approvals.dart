//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dashboard_business_units_inner_pending_approvals.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DashboardBusinessUnitsInnerPendingApprovals {
  /// Returns a new [DashboardBusinessUnitsInnerPendingApprovals] instance.
  DashboardBusinessUnitsInnerPendingApprovals({
    required this.attendance,

    required this.corrections,

    required this.leave,

    required this.allowances,
  });

  @JsonKey(name: r'attendance', required: true, includeIfNull: false)
  final int attendance;

  @JsonKey(name: r'corrections', required: true, includeIfNull: false)
  final int corrections;

  @JsonKey(name: r'leave', required: true, includeIfNull: false)
  final int leave;

  @JsonKey(name: r'allowances', required: true, includeIfNull: false)
  final int allowances;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DashboardBusinessUnitsInnerPendingApprovals &&
          other.attendance == attendance &&
          other.corrections == corrections &&
          other.leave == leave &&
          other.allowances == allowances;

  @override
  int get hashCode =>
      attendance.hashCode +
      corrections.hashCode +
      leave.hashCode +
      allowances.hashCode;

  factory DashboardBusinessUnitsInnerPendingApprovals.fromJson(
    Map<String, dynamic> json,
  ) => _$DashboardBusinessUnitsInnerPendingApprovalsFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DashboardBusinessUnitsInnerPendingApprovalsToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
