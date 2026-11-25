//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'performance_metric_create_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PerformanceMetricCreateBody {
  /// Returns a new [PerformanceMetricCreateBody] instance.
  PerformanceMetricCreateBody({
    required this.code,

    required this.name,

    this.unit,

    this.sortOrder,
  });

  @JsonKey(name: r'code', required: true, includeIfNull: false)
  final String code;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'unit', required: false, includeIfNull: false)
  final String? unit;

  // minimum: 0
  // maximum: 1000
  @JsonKey(name: r'sortOrder', required: false, includeIfNull: false)
  final int? sortOrder;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PerformanceMetricCreateBody &&
          other.code == code &&
          other.name == name &&
          other.unit == unit &&
          other.sortOrder == sortOrder;

  @override
  int get hashCode =>
      code.hashCode + name.hashCode + unit.hashCode + sortOrder.hashCode;

  factory PerformanceMetricCreateBody.fromJson(Map<String, dynamic> json) =>
      _$PerformanceMetricCreateBodyFromJson(json);

  Map<String, dynamic> toJson() => _$PerformanceMetricCreateBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
