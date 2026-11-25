//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/performance_week_value.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'performance_week.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PerformanceWeek {
  /// Returns a new [PerformanceWeek] instance.
  PerformanceWeek({required this.weekStart, required this.values});

  /// Monday of the week (IST)
  @JsonKey(name: r'weekStart', required: true, includeIfNull: false)
  final String weekStart;

  /// One entry per active metric, in display order; value null = not entered
  @JsonKey(name: r'values', required: true, includeIfNull: false)
  final List<PerformanceWeekValue> values;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PerformanceWeek &&
          other.weekStart == weekStart &&
          other.values == values;

  @override
  int get hashCode => weekStart.hashCode + values.hashCode;

  factory PerformanceWeek.fromJson(Map<String, dynamic> json) =>
      _$PerformanceWeekFromJson(json);

  Map<String, dynamic> toJson() => _$PerformanceWeekToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
