// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'depot_create_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DepotCreateBodyCWProxy {
  DepotCreateBody regionId(String regionId);

  DepotCreateBody businessUnitId(String businessUnitId);

  DepotCreateBody name(String name);

  DepotCreateBody code(String code);

  DepotCreateBody address(String? address);

  DepotCreateBody state(String state);

  DepotCreateBody lat(num? lat);

  DepotCreateBody lng(num? lng);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DepotCreateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DepotCreateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  DepotCreateBody call({
    String regionId,
    String businessUnitId,
    String name,
    String code,
    String? address,
    String state,
    num? lat,
    num? lng,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDepotCreateBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDepotCreateBody.copyWith.fieldName(...)`
class _$DepotCreateBodyCWProxyImpl implements _$DepotCreateBodyCWProxy {
  const _$DepotCreateBodyCWProxyImpl(this._value);

  final DepotCreateBody _value;

  @override
  DepotCreateBody regionId(String regionId) => this(regionId: regionId);

  @override
  DepotCreateBody businessUnitId(String businessUnitId) =>
      this(businessUnitId: businessUnitId);

  @override
  DepotCreateBody name(String name) => this(name: name);

  @override
  DepotCreateBody code(String code) => this(code: code);

  @override
  DepotCreateBody address(String? address) => this(address: address);

  @override
  DepotCreateBody state(String state) => this(state: state);

  @override
  DepotCreateBody lat(num? lat) => this(lat: lat);

  @override
  DepotCreateBody lng(num? lng) => this(lng: lng);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DepotCreateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DepotCreateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  DepotCreateBody call({
    Object? regionId = const $CopyWithPlaceholder(),
    Object? businessUnitId = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? code = const $CopyWithPlaceholder(),
    Object? address = const $CopyWithPlaceholder(),
    Object? state = const $CopyWithPlaceholder(),
    Object? lat = const $CopyWithPlaceholder(),
    Object? lng = const $CopyWithPlaceholder(),
  }) {
    return DepotCreateBody(
      regionId: regionId == const $CopyWithPlaceholder()
          ? _value.regionId
          // ignore: cast_nullable_to_non_nullable
          : regionId as String,
      businessUnitId: businessUnitId == const $CopyWithPlaceholder()
          ? _value.businessUnitId
          // ignore: cast_nullable_to_non_nullable
          : businessUnitId as String,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      code: code == const $CopyWithPlaceholder()
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String,
      address: address == const $CopyWithPlaceholder()
          ? _value.address
          // ignore: cast_nullable_to_non_nullable
          : address as String?,
      state: state == const $CopyWithPlaceholder()
          ? _value.state
          // ignore: cast_nullable_to_non_nullable
          : state as String,
      lat: lat == const $CopyWithPlaceholder()
          ? _value.lat
          // ignore: cast_nullable_to_non_nullable
          : lat as num?,
      lng: lng == const $CopyWithPlaceholder()
          ? _value.lng
          // ignore: cast_nullable_to_non_nullable
          : lng as num?,
    );
  }
}

extension $DepotCreateBodyCopyWith on DepotCreateBody {
  /// Returns a callable class that can be used as follows: `instanceOfDepotCreateBody.copyWith(...)` or like so:`instanceOfDepotCreateBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DepotCreateBodyCWProxy get copyWith => _$DepotCreateBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepotCreateBody _$DepotCreateBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DepotCreateBody', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'regionId',
          'businessUnitId',
          'name',
          'code',
          'state',
        ],
      );
      final val = DepotCreateBody(
        regionId: $checkedConvert('regionId', (v) => v as String),
        businessUnitId: $checkedConvert('businessUnitId', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        code: $checkedConvert('code', (v) => v as String),
        address: $checkedConvert('address', (v) => v as String?),
        state: $checkedConvert('state', (v) => v as String),
        lat: $checkedConvert('lat', (v) => v as num?),
        lng: $checkedConvert('lng', (v) => v as num?),
      );
      return val;
    });

Map<String, dynamic> _$DepotCreateBodyToJson(DepotCreateBody instance) =>
    <String, dynamic>{
      'regionId': instance.regionId,
      'businessUnitId': instance.businessUnitId,
      'name': instance.name,
      'code': instance.code,
      'address': ?instance.address,
      'state': instance.state,
      'lat': ?instance.lat,
      'lng': ?instance.lng,
    };
