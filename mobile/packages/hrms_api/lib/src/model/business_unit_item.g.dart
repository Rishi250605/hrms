// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_unit_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BusinessUnitItemCWProxy {
  BusinessUnitItem id(String id);

  BusinessUnitItem name(String name);

  BusinessUnitItem code(String code);

  BusinessUnitItem isActive(bool isActive);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BusinessUnitItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BusinessUnitItem(...).copyWith(id: 12, name: "My name")
  /// ````
  BusinessUnitItem call({String id, String name, String code, bool isActive});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBusinessUnitItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBusinessUnitItem.copyWith.fieldName(...)`
class _$BusinessUnitItemCWProxyImpl implements _$BusinessUnitItemCWProxy {
  const _$BusinessUnitItemCWProxyImpl(this._value);

  final BusinessUnitItem _value;

  @override
  BusinessUnitItem id(String id) => this(id: id);

  @override
  BusinessUnitItem name(String name) => this(name: name);

  @override
  BusinessUnitItem code(String code) => this(code: code);

  @override
  BusinessUnitItem isActive(bool isActive) => this(isActive: isActive);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BusinessUnitItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BusinessUnitItem(...).copyWith(id: 12, name: "My name")
  /// ````
  BusinessUnitItem call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? code = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
  }) {
    return BusinessUnitItem(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      code: code == const $CopyWithPlaceholder()
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool,
    );
  }
}

extension $BusinessUnitItemCopyWith on BusinessUnitItem {
  /// Returns a callable class that can be used as follows: `instanceOfBusinessUnitItem.copyWith(...)` or like so:`instanceOfBusinessUnitItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BusinessUnitItemCWProxy get copyWith => _$BusinessUnitItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessUnitItem _$BusinessUnitItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate('BusinessUnitItem', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['id', 'name', 'code', 'isActive']);
      final val = BusinessUnitItem(
        id: $checkedConvert('id', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        code: $checkedConvert('code', (v) => v as String),
        isActive: $checkedConvert('isActive', (v) => v as bool),
      );
      return val;
    });

Map<String, dynamic> _$BusinessUnitItemToJson(BusinessUnitItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'isActive': instance.isActive,
    };
