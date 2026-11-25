//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'performance_week_body_values_inner.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PerformanceWeekBodyValuesInner {
  /// Returns a new [PerformanceWeekBodyValuesInner] instance.
  PerformanceWeekBodyValuesInner({required this.metricId, required this.value});

  @JsonKey(name: r'metricId', required: true, includeIfNull: false)
  final String metricId;

  /// null removes the value
  // minimum: 0
  // maximum: 1000000000000
  @JsonKey(name: r'value', required: true, includeIfNull: true)
  final num? value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PerformanceWeekBodyValuesInner &&
          other.metricId == metricId &&
          other.value == value;

  @override
  int get hashCode => metricId.hashCode + (value == null ? 0 : value.hashCode);

  factory PerformanceWeekBodyValuesInner.fromJson(Map<String, dynamic> json) =>
      _$PerformanceWeekBodyValuesInnerFromJson(json);

  Map<String, dynamic> toJson() => _$PerformanceWeekBodyValuesInnerToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
