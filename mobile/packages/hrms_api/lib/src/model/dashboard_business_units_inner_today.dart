//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dashboard_business_units_inner_today.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DashboardBusinessUnitsInnerToday {
  /// Returns a new [DashboardBusinessUnitsInnerToday] instance.
  DashboardBusinessUnitsInnerToday({
    required this.headcount,

    required this.present,

    required this.absent,

    required this.halfDay,

    required this.onLeave,

    required this.onDuty,

    required this.weeklyOff,

    required this.notMarked,

    required this.pendingApproval,

    required this.presentPct,
  });

  @JsonKey(name: r'headcount', required: true, includeIfNull: false)
  final int headcount;

  @JsonKey(name: r'present', required: true, includeIfNull: false)
  final int present;

  @JsonKey(name: r'absent', required: true, includeIfNull: false)
  final int absent;

  @JsonKey(name: r'halfDay', required: true, includeIfNull: false)
  final int halfDay;

  @JsonKey(name: r'onLeave', required: true, includeIfNull: false)
  final int onLeave;

  @JsonKey(name: r'onDuty', required: true, includeIfNull: false)
  final int onDuty;

  @JsonKey(name: r'weeklyOff', required: true, includeIfNull: false)
  final int weeklyOff;

  @JsonKey(name: r'notMarked', required: true, includeIfNull: false)
  final int notMarked;

  @JsonKey(name: r'pendingApproval', required: true, includeIfNull: false)
  final int pendingApproval;

  /// (present + onDuty + ½ halfDay) / (headcount − leave − weekly off) × 100
  @JsonKey(name: r'presentPct', required: true, includeIfNull: false)
  final num presentPct;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DashboardBusinessUnitsInnerToday &&
          other.headcount == headcount &&
          other.present == present &&
          other.absent == absent &&
          other.halfDay == halfDay &&
          other.onLeave == onLeave &&
          other.onDuty == onDuty &&
          other.weeklyOff == weeklyOff &&
          other.notMarked == notMarked &&
          other.pendingApproval == pendingApproval &&
          other.presentPct == presentPct;

  @override
  int get hashCode =>
      headcount.hashCode +
      present.hashCode +
      absent.hashCode +
      halfDay.hashCode +
      onLeave.hashCode +
      onDuty.hashCode +
      weeklyOff.hashCode +
      notMarked.hashCode +
      pendingApproval.hashCode +
      presentPct.hashCode;

  factory DashboardBusinessUnitsInnerToday.fromJson(
    Map<String, dynamic> json,
  ) => _$DashboardBusinessUnitsInnerTodayFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DashboardBusinessUnitsInnerTodayToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
