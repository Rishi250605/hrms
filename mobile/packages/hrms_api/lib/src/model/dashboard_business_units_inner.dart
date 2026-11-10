//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/business_unit_ref.dart';
import 'package:hrms_api/src/model/dashboard_business_units_inner_pending_approvals.dart';
import 'package:hrms_api/src/model/dashboard_business_units_inner_tasks_today_inner.dart';
import 'package:hrms_api/src/model/dashboard_business_units_inner_today.dart';
import 'package:hrms_api/src/model/dashboard_business_units_inner_allowances_this_month.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dashboard_business_units_inner.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DashboardBusinessUnitsInner {
  /// Returns a new [DashboardBusinessUnitsInner] instance.
  DashboardBusinessUnitsInner({
    required this.businessUnit,

    required this.today,

    required this.pendingApprovals,

    required this.allowancesThisMonth,

    required this.tasksToday,
  });

  @JsonKey(name: r'businessUnit', required: true, includeIfNull: false)
  final BusinessUnitRef businessUnit;

  @JsonKey(name: r'today', required: true, includeIfNull: false)
  final DashboardBusinessUnitsInnerToday today;

  @JsonKey(name: r'pendingApprovals', required: true, includeIfNull: false)
  final DashboardBusinessUnitsInnerPendingApprovals pendingApprovals;

  @JsonKey(name: r'allowancesThisMonth', required: true, includeIfNull: false)
  final DashboardBusinessUnitsInnerAllowancesThisMonth allowancesThisMonth;

  @JsonKey(name: r'tasksToday', required: true, includeIfNull: false)
  final List<DashboardBusinessUnitsInnerTasksTodayInner> tasksToday;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DashboardBusinessUnitsInner &&
          other.businessUnit == businessUnit &&
          other.today == today &&
          other.pendingApprovals == pendingApprovals &&
          other.allowancesThisMonth == allowancesThisMonth &&
          other.tasksToday == tasksToday;

  @override
  int get hashCode =>
      businessUnit.hashCode +
      today.hashCode +
      pendingApprovals.hashCode +
      allowancesThisMonth.hashCode +
      tasksToday.hashCode;

  factory DashboardBusinessUnitsInner.fromJson(Map<String, dynamic> json) =>
      _$DashboardBusinessUnitsInnerFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardBusinessUnitsInnerToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
