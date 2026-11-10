// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allowance_item_allowance_type.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AllowanceItemAllowanceTypeCWProxy {
  AllowanceItemAllowanceType id(String id);

  AllowanceItemAllowanceType code(String code);

  AllowanceItemAllowanceType name(String name);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AllowanceItemAllowanceType(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AllowanceItemAllowanceType(...).copyWith(id: 12, name: "My name")
  /// ````
  AllowanceItemAllowanceType call({String id, String code, String name});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAllowanceItemAllowanceType.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAllowanceItemAllowanceType.copyWith.fieldName(...)`
class _$AllowanceItemAllowanceTypeCWProxyImpl
    implements _$AllowanceItemAllowanceTypeCWProxy {
  const _$AllowanceItemAllowanceTypeCWProxyImpl(this._value);

  final AllowanceItemAllowanceType _value;

  @override
  AllowanceItemAllowanceType id(String id) => this(id: id);

  @override
  AllowanceItemAllowanceType code(String code) => this(code: code);

  @override
  AllowanceItemAllowanceType name(String name) => this(name: name);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AllowanceItemAllowanceType(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AllowanceItemAllowanceType(...).copyWith(id: 12, name: "My name")
  /// ````
  AllowanceItemAllowanceType call({
    Object? id = const $CopyWithPlaceholder(),
    Object? code = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
  }) {
    return AllowanceItemAllowanceType(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      code: code == const $CopyWithPlaceholder()
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
    );
  }
}

extension $AllowanceItemAllowanceTypeCopyWith on AllowanceItemAllowanceType {
  /// Returns a callable class that can be used as follows: `instanceOfAllowanceItemAllowanceType.copyWith(...)` or like so:`instanceOfAllowanceItemAllowanceType.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AllowanceItemAllowanceTypeCWProxy get copyWith =>
      _$AllowanceItemAllowanceTypeCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllowanceItemAllowanceType _$AllowanceItemAllowanceTypeFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AllowanceItemAllowanceType', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['id', 'code', 'name']);
  final val = AllowanceItemAllowanceType(
    id: $checkedConvert('id', (v) => v as String),
    code: $checkedConvert('code', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$AllowanceItemAllowanceTypeToJson(
  AllowanceItemAllowanceType instance,
) => <String, dynamic>{
  'id': instance.id,
  'code': instance.code,
  'name': instance.name,
};
