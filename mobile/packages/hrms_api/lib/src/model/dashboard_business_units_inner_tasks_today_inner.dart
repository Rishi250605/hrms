//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/person_ref.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dashboard_business_units_inner_tasks_today_inner.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DashboardBusinessUnitsInnerTasksTodayInner {
  /// Returns a new [DashboardBusinessUnitsInnerTasksTodayInner] instance.
  DashboardBusinessUnitsInnerTasksTodayInner({
    required this.om,

    required this.total,

    required this.completed,

    required this.notDone,

    required this.pending,
  });

  @JsonKey(name: r'om', required: true, includeIfNull: false)
  final PersonRef om;

  @JsonKey(name: r'total', required: true, includeIfNull: false)
  final int total;

  @JsonKey(name: r'completed', required: true, includeIfNull: false)
  final int completed;

  @JsonKey(name: r'notDone', required: true, includeIfNull: false)
  final int notDone;

  @JsonKey(name: r'pending', required: true, includeIfNull: false)
  final int pending;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DashboardBusinessUnitsInnerTasksTodayInner &&
          other.om == om &&
          other.total == total &&
          other.completed == completed &&
          other.notDone == notDone &&
          other.pending == pending;

  @override
  int get hashCode =>
      om.hashCode +
      total.hashCode +
      completed.hashCode +
      notDone.hashCode +
      pending.hashCode;

  factory DashboardBusinessUnitsInnerTasksTodayInner.fromJson(
    Map<String, dynamic> json,
  ) => _$DashboardBusinessUnitsInnerTasksTodayInnerFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DashboardBusinessUnitsInnerTasksTodayInnerToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
