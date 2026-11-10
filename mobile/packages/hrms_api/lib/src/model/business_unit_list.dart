//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/business_unit_item.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'business_unit_list.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BusinessUnitList {
  /// Returns a new [BusinessUnitList] instance.
  BusinessUnitList({required this.items});

  @JsonKey(name: r'items', required: true, includeIfNull: false)
  final List<BusinessUnitItem> items;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BusinessUnitList && other.items == items;

  @override
  int get hashCode => items.hashCode;

  factory BusinessUnitList.fromJson(Map<String, dynamic> json) =>
      _$BusinessUnitListFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessUnitListToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
