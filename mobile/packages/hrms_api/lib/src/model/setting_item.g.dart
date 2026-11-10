// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SettingItemCWProxy {
  SettingItem key(String key);

  SettingItem description(String description);

  SettingItem value(Object? value);

  SettingItem defaultValue(Object? defaultValue);

  SettingItem isDefault(bool isDefault);

  SettingItem editableBy(List<Role> editableBy);

  SettingItem updatedAt(DateTime? updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SettingItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SettingItem(...).copyWith(id: 12, name: "My name")
  /// ````
  SettingItem call({
    String key,
    String description,
    Object? value,
    Object? defaultValue,
    bool isDefault,
    List<Role> editableBy,
    DateTime? updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSettingItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSettingItem.copyWith.fieldName(...)`
class _$SettingItemCWProxyImpl implements _$SettingItemCWProxy {
  const _$SettingItemCWProxyImpl(this._value);

  final SettingItem _value;

  @override
  SettingItem key(String key) => this(key: key);

  @override
  SettingItem description(String description) => this(description: description);

  @override
  SettingItem value(Object? value) => this(value: value);

  @override
  SettingItem defaultValue(Object? defaultValue) =>
      this(defaultValue: defaultValue);

  @override
  SettingItem isDefault(bool isDefault) => this(isDefault: isDefault);

  @override
  SettingItem editableBy(List<Role> editableBy) => this(editableBy: editableBy);

  @override
  SettingItem updatedAt(DateTime? updatedAt) => this(updatedAt: updatedAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SettingItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SettingItem(...).copyWith(id: 12, name: "My name")
  /// ````
  SettingItem call({
    Object? key = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? value = const $CopyWithPlaceholder(),
    Object? defaultValue = const $CopyWithPlaceholder(),
    Object? isDefault = const $CopyWithPlaceholder(),
    Object? editableBy = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return SettingItem(
      key: key == const $CopyWithPlaceholder()
          ? _value.key
          // ignore: cast_nullable_to_non_nullable
          : key as String,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String,
      value: value == const $CopyWithPlaceholder()
          ? _value.value
          // ignore: cast_nullable_to_non_nullable
          : value as Object?,
      defaultValue: defaultValue == const $CopyWithPlaceholder()
          ? _value.defaultValue
          // ignore: cast_nullable_to_non_nullable
          : defaultValue as Object?,
      isDefault: isDefault == const $CopyWithPlaceholder()
          ? _value.isDefault
          // ignore: cast_nullable_to_non_nullable
          : isDefault as bool,
      editableBy: editableBy == const $CopyWithPlaceholder()
          ? _value.editableBy
          // ignore: cast_nullable_to_non_nullable
          : editableBy as List<Role>,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime?,
    );
  }
}

extension $SettingItemCopyWith on SettingItem {
  /// Returns a callable class that can be used as follows: `instanceOfSettingItem.copyWith(...)` or like so:`instanceOfSettingItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SettingItemCWProxy get copyWith => _$SettingItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingItem _$SettingItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SettingItem', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'key',
          'description',
          'isDefault',
          'editableBy',
          'updatedAt',
        ],
      );
      final val = SettingItem(
        key: $checkedConvert('key', (v) => v as String),
        description: $checkedConvert('description', (v) => v as String),
        value: $checkedConvert('value', (v) => v),
        defaultValue: $checkedConvert('defaultValue', (v) => v),
        isDefault: $checkedConvert('isDefault', (v) => v as bool),
        editableBy: $checkedConvert(
          'editableBy',
          (v) => (v as List<dynamic>)
              .map((e) => $enumDecode(_$RoleEnumMap, e))
              .toList(),
        ),
        updatedAt: $checkedConvert(
          'updatedAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$SettingItemToJson(SettingItem instance) =>
    <String, dynamic>{
      'key': instance.key,
      'description': instance.description,
      'value': ?instance.value,
      'defaultValue': ?instance.defaultValue,
      'isDefault': instance.isDefault,
      'editableBy': instance.editableBy.map((e) => _$RoleEnumMap[e]!).toList(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$RoleEnumMap = {
  Role.DIRECTOR: 'DIRECTOR',
  Role.HR: 'HR',
  Role.OPERATIONAL_MANAGER: 'OPERATIONAL_MANAGER',
  Role.REGIONAL_MANAGER: 'REGIONAL_MANAGER',
};
