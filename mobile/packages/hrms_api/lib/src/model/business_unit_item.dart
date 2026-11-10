//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'business_unit_item.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BusinessUnitItem {
  /// Returns a new [BusinessUnitItem] instance.
  BusinessUnitItem({
    required this.id,

    required this.name,

    required this.code,

    required this.isActive,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'code', required: true, includeIfNull: false)
  final String code;

  @JsonKey(name: r'isActive', required: true, includeIfNull: false)
  final bool isActive;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BusinessUnitItem &&
          other.id == id &&
          other.name == name &&
          other.code == code &&
          other.isActive == isActive;

  @override
  int get hashCode =>
      id.hashCode + name.hashCode + code.hashCode + isActive.hashCode;

  factory BusinessUnitItem.fromJson(Map<String, dynamic> json) =>
      _$BusinessUnitItemFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessUnitItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
