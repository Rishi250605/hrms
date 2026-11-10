//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/duty_item.dart';
import 'package:hrms_api/src/model/depot_summary.dart';
import 'package:hrms_api/src/model/roster_day_summary.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'roster_day.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class RosterDay {
  /// Returns a new [RosterDay] instance.
  RosterDay({
    required this.date,

    required this.depot,

    required this.summary,

    required this.duties,
  });

  /// Calendar date (IST business date)
  @JsonKey(name: r'date', required: true, includeIfNull: false)
  final String date;

  @JsonKey(name: r'depot', required: true, includeIfNull: false)
  final DepotSummary depot;

  @JsonKey(name: r'summary', required: true, includeIfNull: false)
  final RosterDaySummary summary;

  @JsonKey(name: r'duties', required: true, includeIfNull: false)
  final List<DutyItem> duties;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RosterDay &&
          other.date == date &&
          other.depot == depot &&
          other.summary == summary &&
          other.duties == duties;

  @override
  int get hashCode =>
      date.hashCode + depot.hashCode + summary.hashCode + duties.hashCode;

  factory RosterDay.fromJson(Map<String, dynamic> json) =>
      _$RosterDayFromJson(json);

  Map<String, dynamic> toJson() => _$RosterDayToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
