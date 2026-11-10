//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/vehicle_item.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vehicle_list.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class VehicleList {
  /// Returns a new [VehicleList] instance.
  VehicleList({required this.items});

  @JsonKey(name: r'items', required: true, includeIfNull: false)
  final List<VehicleItem> items;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is VehicleList && other.items == items;

  @override
  int get hashCode => items.hashCode;

  factory VehicleList.fromJson(Map<String, dynamic> json) =>
      _$VehicleListFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleListToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
