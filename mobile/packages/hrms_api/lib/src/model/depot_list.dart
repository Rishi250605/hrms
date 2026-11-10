//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/depot_item.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'depot_list.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DepotList {
  /// Returns a new [DepotList] instance.
  DepotList({required this.items});

  @JsonKey(name: r'items', required: true, includeIfNull: false)
  final List<DepotItem> items;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is DepotList && other.items == items;

  @override
  int get hashCode => items.hashCode;

  factory DepotList.fromJson(Map<String, dynamic> json) =>
      _$DepotListFromJson(json);

  Map<String, dynamic> toJson() => _$DepotListToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
