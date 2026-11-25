//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'performance_metric_update_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PerformanceMetricUpdateBody {
  /// Returns a new [PerformanceMetricUpdateBody] instance.
  PerformanceMetricUpdateBody({
    this.name,

    this.unit,

    this.sortOrder,

    this.isActive,
  });

  @JsonKey(name: r'name', required: false, includeIfNull: false)
  final String? name;

  @JsonKey(name: r'unit', required: false, includeIfNull: false)
  final String? unit;

  // minimum: 0
  // maximum: 1000
  @JsonKey(name: r'sortOrder', required: false, includeIfNull: false)
  final int? sortOrder;

  @JsonKey(name: r'isActive', required: false, includeIfNull: false)
  final bool? isActive;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PerformanceMetricUpdateBody &&
          other.name == name &&
          other.unit == unit &&
          other.sortOrder == sortOrder &&
          other.isActive == isActive;

  @override
  int get hashCode =>
      name.hashCode +
      (unit == null ? 0 : unit.hashCode) +
      sortOrder.hashCode +
      isActive.hashCode;

  factory PerformanceMetricUpdateBody.fromJson(Map<String, dynamic> json) =>
      _$PerformanceMetricUpdateBodyFromJson(json);

  Map<String, dynamic> toJson() => _$PerformanceMetricUpdateBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
