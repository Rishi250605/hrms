//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'performance_metric_item.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PerformanceMetricItem {
  /// Returns a new [PerformanceMetricItem] instance.
  PerformanceMetricItem({
    required this.id,

    required this.code,

    required this.name,

    required this.unit,

    required this.sortOrder,

    required this.isActive,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'code', required: true, includeIfNull: false)
  final String code;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'unit', required: true, includeIfNull: true)
  final String? unit;

  @JsonKey(name: r'sortOrder', required: true, includeIfNull: false)
  final int sortOrder;

  @JsonKey(name: r'isActive', required: true, includeIfNull: false)
  final bool isActive;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PerformanceMetricItem &&
          other.id == id &&
          other.code == code &&
          other.name == name &&
          other.unit == unit &&
          other.sortOrder == sortOrder &&
          other.isActive == isActive;

  @override
  int get hashCode =>
      id.hashCode +
      code.hashCode +
      name.hashCode +
      (unit == null ? 0 : unit.hashCode) +
      sortOrder.hashCode +
      isActive.hashCode;

  factory PerformanceMetricItem.fromJson(Map<String, dynamic> json) =>
      _$PerformanceMetricItemFromJson(json);

  Map<String, dynamic> toJson() => _$PerformanceMetricItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
