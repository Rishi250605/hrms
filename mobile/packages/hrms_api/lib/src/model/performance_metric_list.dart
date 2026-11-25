//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/performance_metric_item.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'performance_metric_list.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PerformanceMetricList {
  /// Returns a new [PerformanceMetricList] instance.
  PerformanceMetricList({required this.items});

  @JsonKey(name: r'items', required: true, includeIfNull: false)
  final List<PerformanceMetricItem> items;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PerformanceMetricList && other.items == items;

  @override
  int get hashCode => items.hashCode;

  factory PerformanceMetricList.fromJson(Map<String, dynamic> json) =>
      _$PerformanceMetricListFromJson(json);

  Map<String, dynamic> toJson() => _$PerformanceMetricListToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
