//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/allowance_type_item.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'allowance_type_list.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AllowanceTypeList {
  /// Returns a new [AllowanceTypeList] instance.
  AllowanceTypeList({required this.items});

  @JsonKey(name: r'items', required: true, includeIfNull: false)
  final List<AllowanceTypeItem> items;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AllowanceTypeList && other.items == items;

  @override
  int get hashCode => items.hashCode;

  factory AllowanceTypeList.fromJson(Map<String, dynamic> json) =>
      _$AllowanceTypeListFromJson(json);

  Map<String, dynamic> toJson() => _$AllowanceTypeListToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
