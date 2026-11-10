// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_unit_create_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BusinessUnitCreateBodyCWProxy {
  BusinessUnitCreateBody name(String name);

  BusinessUnitCreateBody code(String code);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BusinessUnitCreateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BusinessUnitCreateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  BusinessUnitCreateBody call({String name, String code});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBusinessUnitCreateBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBusinessUnitCreateBody.copyWith.fieldName(...)`
class _$BusinessUnitCreateBodyCWProxyImpl
    implements _$BusinessUnitCreateBodyCWProxy {
  const _$BusinessUnitCreateBodyCWProxyImpl(this._value);

  final BusinessUnitCreateBody _value;

  @override
  BusinessUnitCreateBody name(String name) => this(name: name);

  @override
  BusinessUnitCreateBody code(String code) => this(code: code);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BusinessUnitCreateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BusinessUnitCreateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  BusinessUnitCreateBody call({
    Object? name = const $CopyWithPlaceholder(),
    Object? code = const $CopyWithPlaceholder(),
  }) {
    return BusinessUnitCreateBody(
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      code: code == const $CopyWithPlaceholder()
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String,
    );
  }
}

extension $BusinessUnitCreateBodyCopyWith on BusinessUnitCreateBody {
  /// Returns a callable class that can be used as follows: `instanceOfBusinessUnitCreateBody.copyWith(...)` or like so:`instanceOfBusinessUnitCreateBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BusinessUnitCreateBodyCWProxy get copyWith =>
      _$BusinessUnitCreateBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessUnitCreateBody _$BusinessUnitCreateBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BusinessUnitCreateBody', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['name', 'code']);
  final val = BusinessUnitCreateBody(
    name: $checkedConvert('name', (v) => v as String),
    code: $checkedConvert('code', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$BusinessUnitCreateBodyToJson(
  BusinessUnitCreateBody instance,
) => <String, dynamic>{'name': instance.name, 'code': instance.code};
