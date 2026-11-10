// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_create_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$VehicleCreateBodyCWProxy {
  VehicleCreateBody regNo(String regNo);

  VehicleCreateBody type(String type);

  VehicleCreateBody capacity(int? capacity);

  VehicleCreateBody depotId(String depotId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VehicleCreateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VehicleCreateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  VehicleCreateBody call({
    String regNo,
    String type,
    int? capacity,
    String depotId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfVehicleCreateBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfVehicleCreateBody.copyWith.fieldName(...)`
class _$VehicleCreateBodyCWProxyImpl implements _$VehicleCreateBodyCWProxy {
  const _$VehicleCreateBodyCWProxyImpl(this._value);

  final VehicleCreateBody _value;

  @override
  VehicleCreateBody regNo(String regNo) => this(regNo: regNo);

  @override
  VehicleCreateBody type(String type) => this(type: type);

  @override
  VehicleCreateBody capacity(int? capacity) => this(capacity: capacity);

  @override
  VehicleCreateBody depotId(String depotId) => this(depotId: depotId);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VehicleCreateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VehicleCreateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  VehicleCreateBody call({
    Object? regNo = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? capacity = const $CopyWithPlaceholder(),
    Object? depotId = const $CopyWithPlaceholder(),
  }) {
    return VehicleCreateBody(
      regNo: regNo == const $CopyWithPlaceholder()
          ? _value.regNo
          // ignore: cast_nullable_to_non_nullable
          : regNo as String,
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as String,
      capacity: capacity == const $CopyWithPlaceholder()
          ? _value.capacity
          // ignore: cast_nullable_to_non_nullable
          : capacity as int?,
      depotId: depotId == const $CopyWithPlaceholder()
          ? _value.depotId
          // ignore: cast_nullable_to_non_nullable
          : depotId as String,
    );
  }
}

extension $VehicleCreateBodyCopyWith on VehicleCreateBody {
  /// Returns a callable class that can be used as follows: `instanceOfVehicleCreateBody.copyWith(...)` or like so:`instanceOfVehicleCreateBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$VehicleCreateBodyCWProxy get copyWith =>
      _$VehicleCreateBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleCreateBody _$VehicleCreateBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('VehicleCreateBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['regNo', 'type', 'depotId']);
      final val = VehicleCreateBody(
        regNo: $checkedConvert('regNo', (v) => v as String),
        type: $checkedConvert('type', (v) => v as String),
        capacity: $checkedConvert('capacity', (v) => (v as num?)?.toInt()),
        depotId: $checkedConvert('depotId', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$VehicleCreateBodyToJson(VehicleCreateBody instance) =>
    <String, dynamic>{
      'regNo': instance.regNo,
      'type': instance.type,
      'capacity': ?instance.capacity,
      'depotId': instance.depotId,
    };
