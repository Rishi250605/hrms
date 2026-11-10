// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'depot_update_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DepotUpdateBodyCWProxy {
  DepotUpdateBody regionId(String? regionId);

  DepotUpdateBody businessUnitId(String? businessUnitId);

  DepotUpdateBody name(String? name);

  DepotUpdateBody address(String? address);

  DepotUpdateBody state(String? state);

  DepotUpdateBody lat(num? lat);

  DepotUpdateBody lng(num? lng);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DepotUpdateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DepotUpdateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  DepotUpdateBody call({
    String? regionId,
    String? businessUnitId,
    String? name,
    String? address,
    String? state,
    num? lat,
    num? lng,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDepotUpdateBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDepotUpdateBody.copyWith.fieldName(...)`
class _$DepotUpdateBodyCWProxyImpl implements _$DepotUpdateBodyCWProxy {
  const _$DepotUpdateBodyCWProxyImpl(this._value);

  final DepotUpdateBody _value;

  @override
  DepotUpdateBody regionId(String? regionId) => this(regionId: regionId);

  @override
  DepotUpdateBody businessUnitId(String? businessUnitId) =>
      this(businessUnitId: businessUnitId);

  @override
  DepotUpdateBody name(String? name) => this(name: name);

  @override
  DepotUpdateBody address(String? address) => this(address: address);

  @override
  DepotUpdateBody state(String? state) => this(state: state);

  @override
  DepotUpdateBody lat(num? lat) => this(lat: lat);

  @override
  DepotUpdateBody lng(num? lng) => this(lng: lng);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DepotUpdateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DepotUpdateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  DepotUpdateBody call({
    Object? regionId = const $CopyWithPlaceholder(),
    Object? businessUnitId = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? address = const $CopyWithPlaceholder(),
    Object? state = const $CopyWithPlaceholder(),
    Object? lat = const $CopyWithPlaceholder(),
    Object? lng = const $CopyWithPlaceholder(),
  }) {
    return DepotUpdateBody(
      regionId: regionId == const $CopyWithPlaceholder()
          ? _value.regionId
          // ignore: cast_nullable_to_non_nullable
          : regionId as String?,
      businessUnitId: businessUnitId == const $CopyWithPlaceholder()
          ? _value.businessUnitId
          // ignore: cast_nullable_to_non_nullable
          : businessUnitId as String?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      address: address == const $CopyWithPlaceholder()
          ? _value.address
          // ignore: cast_nullable_to_non_nullable
          : address as String?,
      state: state == const $CopyWithPlaceholder()
          ? _value.state
          // ignore: cast_nullable_to_non_nullable
          : state as String?,
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

extension $DepotUpdateBodyCopyWith on DepotUpdateBody {
  /// Returns a callable class that can be used as follows: `instanceOfDepotUpdateBody.copyWith(...)` or like so:`instanceOfDepotUpdateBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DepotUpdateBodyCWProxy get copyWith => _$DepotUpdateBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepotUpdateBody _$DepotUpdateBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DepotUpdateBody', json, ($checkedConvert) {
      final val = DepotUpdateBody(
        regionId: $checkedConvert('regionId', (v) => v as String?),
        businessUnitId: $checkedConvert('businessUnitId', (v) => v as String?),
        name: $checkedConvert('name', (v) => v as String?),
        address: $checkedConvert('address', (v) => v as String?),
        state: $checkedConvert('state', (v) => v as String?),
        lat: $checkedConvert('lat', (v) => v as num?),
        lng: $checkedConvert('lng', (v) => v as num?),
      );
      return val;
    });

Map<String, dynamic> _$DepotUpdateBodyToJson(DepotUpdateBody instance) =>
    <String, dynamic>{
      'regionId': ?instance.regionId,
      'businessUnitId': ?instance.businessUnitId,
      'name': ?instance.name,
      'address': ?instance.address,
      'state': ?instance.state,
      'lat': ?instance.lat,
      'lng': ?instance.lng,
    };
