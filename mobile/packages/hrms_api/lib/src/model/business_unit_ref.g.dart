// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_unit_ref.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BusinessUnitRefCWProxy {
  BusinessUnitRef id(String id);

  BusinessUnitRef code(String code);

  BusinessUnitRef name(String name);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BusinessUnitRef(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BusinessUnitRef(...).copyWith(id: 12, name: "My name")
  /// ````
  BusinessUnitRef call({String id, String code, String name});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBusinessUnitRef.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBusinessUnitRef.copyWith.fieldName(...)`
class _$BusinessUnitRefCWProxyImpl implements _$BusinessUnitRefCWProxy {
  const _$BusinessUnitRefCWProxyImpl(this._value);

  final BusinessUnitRef _value;

  @override
  BusinessUnitRef id(String id) => this(id: id);

  @override
  BusinessUnitRef code(String code) => this(code: code);

  @override
  BusinessUnitRef name(String name) => this(name: name);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BusinessUnitRef(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BusinessUnitRef(...).copyWith(id: 12, name: "My name")
  /// ````
  BusinessUnitRef call({
    Object? id = const $CopyWithPlaceholder(),
    Object? code = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
  }) {
    return BusinessUnitRef(
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

extension $BusinessUnitRefCopyWith on BusinessUnitRef {
  /// Returns a callable class that can be used as follows: `instanceOfBusinessUnitRef.copyWith(...)` or like so:`instanceOfBusinessUnitRef.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BusinessUnitRefCWProxy get copyWith => _$BusinessUnitRefCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessUnitRef _$BusinessUnitRefFromJson(Map<String, dynamic> json) =>
    $checkedCreate('BusinessUnitRef', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['id', 'code', 'name']);
      final val = BusinessUnitRef(
        id: $checkedConvert('id', (v) => v as String),
        code: $checkedConvert('code', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$BusinessUnitRefToJson(BusinessUnitRef instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
    };
