//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/performance_week_body_values_inner.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'performance_week_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PerformanceWeekBody {
  /// Returns a new [PerformanceWeekBody] instance.
  PerformanceWeekBody({required this.values});

  @JsonKey(name: r'values', required: true, includeIfNull: false)
  final List<PerformanceWeekBodyValuesInner> values;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PerformanceWeekBody && other.values == values;

  @override
  int get hashCode => values.hashCode;

  factory PerformanceWeekBody.fromJson(Map<String, dynamic> json) =>
      _$PerformanceWeekBodyFromJson(json);

  Map<String, dynamic> toJson() => _$PerformanceWeekBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
