//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/dashboard_business_units_inner.dart';
import 'package:hrms_api/src/model/dashboard_me.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dashboard.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Dashboard {
  /// Returns a new [Dashboard] instance.
  Dashboard({
    required this.date,

    required this.month,

    required this.businessUnits,

    required this.me,
  });

  /// Calendar date (IST business date)
  @JsonKey(name: r'date', required: true, includeIfNull: false)
  final String date;

  @JsonKey(name: r'month', required: true, includeIfNull: false)
  final String month;

  @JsonKey(name: r'businessUnits', required: true, includeIfNull: false)
  final List<DashboardBusinessUnitsInner> businessUnits;

  @JsonKey(name: r'me', required: true, includeIfNull: false)
  final DashboardMe me;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Dashboard &&
          other.date == date &&
          other.month == month &&
          other.businessUnits == businessUnits &&
          other.me == me;

  @override
  int get hashCode =>
      date.hashCode + month.hashCode + businessUnits.hashCode + me.hashCode;

  factory Dashboard.fromJson(Map<String, dynamic> json) =>
      _$DashboardFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
