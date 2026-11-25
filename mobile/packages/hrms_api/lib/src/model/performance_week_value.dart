//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'performance_week_value.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PerformanceWeekValue {
  /// Returns a new [PerformanceWeekValue] instance.
  PerformanceWeekValue({
    required this.metricId,

    required this.code,

    required this.name,

    required this.unit,

    required this.value,
  });

  @JsonKey(name: r'metricId', required: true, includeIfNull: false)
  final String metricId;

  @JsonKey(name: r'code', required: true, includeIfNull: false)
  final String code;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'unit', required: true, includeIfNull: true)
  final String? unit;

  @JsonKey(name: r'value', required: true, includeIfNull: true)
  final num? value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PerformanceWeekValue &&
          other.metricId == metricId &&
          other.code == code &&
          other.name == name &&
          other.unit == unit &&
          other.value == value;

  @override
  int get hashCode =>
      metricId.hashCode +
      code.hashCode +
      name.hashCode +
      (unit == null ? 0 : unit.hashCode) +
      (value == null ? 0 : value.hashCode);

  factory PerformanceWeekValue.fromJson(Map<String, dynamic> json) =>
      _$PerformanceWeekValueFromJson(json);

  Map<String, dynamic> toJson() => _$PerformanceWeekValueToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
