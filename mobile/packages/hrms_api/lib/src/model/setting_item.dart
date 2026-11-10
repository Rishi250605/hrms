//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/role.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'setting_item.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class SettingItem {
  /// Returns a new [SettingItem] instance.
  SettingItem({
    required this.key,

    required this.description,

    this.value,

    this.defaultValue,

    required this.isDefault,

    required this.editableBy,

    required this.updatedAt,
  });

  @JsonKey(name: r'key', required: true, includeIfNull: false)
  final String key;

  @JsonKey(name: r'description', required: true, includeIfNull: false)
  final String description;

  /// JSON value; its shape depends on the key
  @JsonKey(name: r'value', required: false, includeIfNull: false)
  final Object? value;

  @JsonKey(name: r'defaultValue', required: false, includeIfNull: false)
  final Object? defaultValue;

  @JsonKey(name: r'isDefault', required: true, includeIfNull: false)
  final bool isDefault;

  @JsonKey(name: r'editableBy', required: true, includeIfNull: false)
  final List<Role> editableBy;

  @JsonKey(name: r'updatedAt', required: true, includeIfNull: true)
  final DateTime? updatedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingItem &&
          other.key == key &&
          other.description == description &&
          other.value == value &&
          other.defaultValue == defaultValue &&
          other.isDefault == isDefault &&
          other.editableBy == editableBy &&
          other.updatedAt == updatedAt;

  @override
  int get hashCode =>
      key.hashCode +
      description.hashCode +
      (value == null ? 0 : value.hashCode) +
      (defaultValue == null ? 0 : defaultValue.hashCode) +
      isDefault.hashCode +
      editableBy.hashCode +
      (updatedAt == null ? 0 : updatedAt.hashCode);

  factory SettingItem.fromJson(Map<String, dynamic> json) =>
      _$SettingItemFromJson(json);

  Map<String, dynamic> toJson() => _$SettingItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
