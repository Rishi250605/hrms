//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'allowance_type_item.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AllowanceTypeItem {
  /// Returns a new [AllowanceTypeItem] instance.
  AllowanceTypeItem({
    required this.id,

    required this.code,

    required this.name,

    required this.maxAmountPaise,

    required this.isActive,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'code', required: true, includeIfNull: false)
  final String code;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'maxAmountPaise', required: true, includeIfNull: true)
  final int? maxAmountPaise;

  @JsonKey(name: r'isActive', required: true, includeIfNull: false)
  final bool isActive;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AllowanceTypeItem &&
          other.id == id &&
          other.code == code &&
          other.name == name &&
          other.maxAmountPaise == maxAmountPaise &&
          other.isActive == isActive;

  @override
  int get hashCode =>
      id.hashCode +
      code.hashCode +
      name.hashCode +
      (maxAmountPaise == null ? 0 : maxAmountPaise.hashCode) +
      isActive.hashCode;

  factory AllowanceTypeItem.fromJson(Map<String, dynamic> json) =>
      _$AllowanceTypeItemFromJson(json);

  Map<String, dynamic> toJson() => _$AllowanceTypeItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
