//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/region_item.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'region_list.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class RegionList {
  /// Returns a new [RegionList] instance.
  RegionList({required this.items});

  @JsonKey(name: r'items', required: true, includeIfNull: false)
  final List<RegionItem> items;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is RegionList && other.items == items;

  @override
  int get hashCode => items.hashCode;

  factory RegionList.fromJson(Map<String, dynamic> json) =>
      _$RegionListFromJson(json);

  Map<String, dynamic> toJson() => _$RegionListToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
