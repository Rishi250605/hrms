//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/performance_person_item.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'performance_person_list.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PerformancePersonList {
  /// Returns a new [PerformancePersonList] instance.
  PerformancePersonList({required this.items});

  @JsonKey(name: r'items', required: true, includeIfNull: false)
  final List<PerformancePersonItem> items;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PerformancePersonList && other.items == items;

  @override
  int get hashCode => items.hashCode;

  factory PerformancePersonList.fromJson(Map<String, dynamic> json) =>
      _$PerformancePersonListFromJson(json);

  Map<String, dynamic> toJson() => _$PerformancePersonListToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
