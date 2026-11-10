// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'region_create_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RegionCreateBodyCWProxy {
  RegionCreateBody name(String name);

  RegionCreateBody code(String code);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RegionCreateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RegionCreateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  RegionCreateBody call({String name, String code});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRegionCreateBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRegionCreateBody.copyWith.fieldName(...)`
class _$RegionCreateBodyCWProxyImpl implements _$RegionCreateBodyCWProxy {
  const _$RegionCreateBodyCWProxyImpl(this._value);

  final RegionCreateBody _value;

  @override
  RegionCreateBody name(String name) => this(name: name);

  @override
  RegionCreateBody code(String code) => this(code: code);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RegionCreateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RegionCreateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  RegionCreateBody call({
    Object? name = const $CopyWithPlaceholder(),
    Object? code = const $CopyWithPlaceholder(),
  }) {
    return RegionCreateBody(
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

extension $RegionCreateBodyCopyWith on RegionCreateBody {
  /// Returns a callable class that can be used as follows: `instanceOfRegionCreateBody.copyWith(...)` or like so:`instanceOfRegionCreateBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RegionCreateBodyCWProxy get copyWith => _$RegionCreateBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegionCreateBody _$RegionCreateBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('RegionCreateBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['name', 'code']);
      final val = RegionCreateBody(
        name: $checkedConvert('name', (v) => v as String),
        code: $checkedConvert('code', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$RegionCreateBodyToJson(RegionCreateBody instance) =>
    <String, dynamic>{'name': instance.name, 'code': instance.code};
