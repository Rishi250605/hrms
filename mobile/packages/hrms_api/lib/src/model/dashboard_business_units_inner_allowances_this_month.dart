//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dashboard_business_units_inner_allowances_this_month.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DashboardBusinessUnitsInnerAllowancesThisMonth {
  /// Returns a new [DashboardBusinessUnitsInnerAllowancesThisMonth] instance.
  DashboardBusinessUnitsInnerAllowancesThisMonth({
    required this.requestedPaise,

    required this.approvedPaise,
  });

  @JsonKey(name: r'requestedPaise', required: true, includeIfNull: false)
  final int requestedPaise;

  @JsonKey(name: r'approvedPaise', required: true, includeIfNull: false)
  final int approvedPaise;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DashboardBusinessUnitsInnerAllowancesThisMonth &&
          other.requestedPaise == requestedPaise &&
          other.approvedPaise == approvedPaise;

  @override
  int get hashCode => requestedPaise.hashCode + approvedPaise.hashCode;

  factory DashboardBusinessUnitsInnerAllowancesThisMonth.fromJson(
    Map<String, dynamic> json,
  ) => _$DashboardBusinessUnitsInnerAllowancesThisMonthFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DashboardBusinessUnitsInnerAllowancesThisMonthToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
