// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'region_update_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RegionUpdateBodyCWProxy {
  RegionUpdateBody name(String name);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RegionUpdateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RegionUpdateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  RegionUpdateBody call({String name});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRegionUpdateBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRegionUpdateBody.copyWith.fieldName(...)`
class _$RegionUpdateBodyCWProxyImpl implements _$RegionUpdateBodyCWProxy {
  const _$RegionUpdateBodyCWProxyImpl(this._value);

  final RegionUpdateBody _value;

  @override
  RegionUpdateBody name(String name) => this(name: name);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RegionUpdateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RegionUpdateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  RegionUpdateBody call({Object? name = const $CopyWithPlaceholder()}) {
    return RegionUpdateBody(
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
    );
  }
}

extension $RegionUpdateBodyCopyWith on RegionUpdateBody {
  /// Returns a callable class that can be used as follows: `instanceOfRegionUpdateBody.copyWith(...)` or like so:`instanceOfRegionUpdateBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RegionUpdateBodyCWProxy get copyWith => _$RegionUpdateBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegionUpdateBody _$RegionUpdateBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('RegionUpdateBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['name']);
      final val = RegionUpdateBody(
        name: $checkedConvert('name', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$RegionUpdateBodyToJson(RegionUpdateBody instance) =>
    <String, dynamic>{'name': instance.name};
