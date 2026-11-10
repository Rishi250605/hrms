// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'depot_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DepotItemCWProxy {
  DepotItem id(String id);

  DepotItem regionId(String regionId);

  DepotItem regionName(String regionName);

  DepotItem businessUnitId(String businessUnitId);

  DepotItem businessUnitCode(String businessUnitCode);

  DepotItem name(String name);

  DepotItem code(String code);

  DepotItem address(String? address);

  DepotItem state(String state);

  DepotItem lat(num? lat);

  DepotItem lng(num? lng);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DepotItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DepotItem(...).copyWith(id: 12, name: "My name")
  /// ````
  DepotItem call({
    String id,
    String regionId,
    String regionName,
    String businessUnitId,
    String businessUnitCode,
    String name,
    String code,
    String? address,
    String state,
    num? lat,
    num? lng,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDepotItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDepotItem.copyWith.fieldName(...)`
class _$DepotItemCWProxyImpl implements _$DepotItemCWProxy {
  const _$DepotItemCWProxyImpl(this._value);

  final DepotItem _value;

  @override
  DepotItem id(String id) => this(id: id);

  @override
  DepotItem regionId(String regionId) => this(regionId: regionId);

  @override
  DepotItem regionName(String regionName) => this(regionName: regionName);

  @override
  DepotItem businessUnitId(String businessUnitId) =>
      this(businessUnitId: businessUnitId);

  @override
  DepotItem businessUnitCode(String businessUnitCode) =>
      this(businessUnitCode: businessUnitCode);

  @override
  DepotItem name(String name) => this(name: name);

  @override
  DepotItem code(String code) => this(code: code);

  @override
  DepotItem address(String? address) => this(address: address);

  @override
  DepotItem state(String state) => this(state: state);

  @override
  DepotItem lat(num? lat) => this(lat: lat);

  @override
  DepotItem lng(num? lng) => this(lng: lng);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DepotItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DepotItem(...).copyWith(id: 12, name: "My name")
  /// ````
  DepotItem call({
    Object? id = const $CopyWithPlaceholder(),
    Object? regionId = const $CopyWithPlaceholder(),
    Object? regionName = const $CopyWithPlaceholder(),
    Object? businessUnitId = const $CopyWithPlaceholder(),
    Object? businessUnitCode = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? code = const $CopyWithPlaceholder(),
    Object? address = const $CopyWithPlaceholder(),
    Object? state = const $CopyWithPlaceholder(),
    Object? lat = const $CopyWithPlaceholder(),
    Object? lng = const $CopyWithPlaceholder(),
  }) {
    return DepotItem(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      regionId: regionId == const $CopyWithPlaceholder()
          ? _value.regionId
          // ignore: cast_nullable_to_non_nullable
          : regionId as String,
      regionName: regionName == const $CopyWithPlaceholder()
          ? _value.regionName
          // ignore: cast_nullable_to_non_nullable
          : regionName as String,
      businessUnitId: businessUnitId == const $CopyWithPlaceholder()
          ? _value.businessUnitId
          // ignore: cast_nullable_to_non_nullable
          : businessUnitId as String,
      businessUnitCode: businessUnitCode == const $CopyWithPlaceholder()
          ? _value.businessUnitCode
          // ignore: cast_nullable_to_non_nullable
          : businessUnitCode as String,
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

extension $DepotItemCopyWith on DepotItem {
  /// Returns a callable class that can be used as follows: `instanceOfDepotItem.copyWith(...)` or like so:`instanceOfDepotItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DepotItemCWProxy get copyWith => _$DepotItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepotItem _$DepotItemFromJson(Map<String, dynamic> json) => $checkedCreate(
  'DepotItem',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'id',
        'regionId',
        'regionName',
        'businessUnitId',
        'businessUnitCode',
        'name',
        'code',
        'address',
        'state',
        'lat',
        'lng',
      ],
    );
    final val = DepotItem(
      id: $checkedConvert('id', (v) => v as String),
      regionId: $checkedConvert('regionId', (v) => v as String),
      regionName: $checkedConvert('regionName', (v) => v as String),
      businessUnitId: $checkedConvert('businessUnitId', (v) => v as String),
      businessUnitCode: $checkedConvert('businessUnitCode', (v) => v as String),
      name: $checkedConvert('name', (v) => v as String),
      code: $checkedConvert('code', (v) => v as String),
      address: $checkedConvert('address', (v) => v as String?),
      state: $checkedConvert('state', (v) => v as String),
      lat: $checkedConvert('lat', (v) => v as num?),
      lng: $checkedConvert('lng', (v) => v as num?),
    );
    return val;
  },
);

Map<String, dynamic> _$DepotItemToJson(DepotItem instance) => <String, dynamic>{
  'id': instance.id,
  'regionId': instance.regionId,
  'regionName': instance.regionName,
  'businessUnitId': instance.businessUnitId,
  'businessUnitCode': instance.businessUnitCode,
  'name': instance.name,
  'code': instance.code,
  'address': instance.address,
  'state': instance.state,
  'lat': instance.lat,
  'lng': instance.lng,
};
