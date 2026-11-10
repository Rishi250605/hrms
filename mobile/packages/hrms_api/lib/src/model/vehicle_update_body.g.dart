// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_update_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$VehicleUpdateBodyCWProxy {
  VehicleUpdateBody type(String? type);

  VehicleUpdateBody capacity(int? capacity);

  VehicleUpdateBody depotId(String? depotId);

  VehicleUpdateBody status(VehicleStatus? status);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VehicleUpdateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VehicleUpdateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  VehicleUpdateBody call({
    String? type,
    int? capacity,
    String? depotId,
    VehicleStatus? status,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfVehicleUpdateBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfVehicleUpdateBody.copyWith.fieldName(...)`
class _$VehicleUpdateBodyCWProxyImpl implements _$VehicleUpdateBodyCWProxy {
  const _$VehicleUpdateBodyCWProxyImpl(this._value);

  final VehicleUpdateBody _value;

  @override
  VehicleUpdateBody type(String? type) => this(type: type);

  @override
  VehicleUpdateBody capacity(int? capacity) => this(capacity: capacity);

  @override
  VehicleUpdateBody depotId(String? depotId) => this(depotId: depotId);

  @override
  VehicleUpdateBody status(VehicleStatus? status) => this(status: status);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VehicleUpdateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VehicleUpdateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  VehicleUpdateBody call({
    Object? type = const $CopyWithPlaceholder(),
    Object? capacity = const $CopyWithPlaceholder(),
    Object? depotId = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
  }) {
    return VehicleUpdateBody(
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as String?,
      capacity: capacity == const $CopyWithPlaceholder()
          ? _value.capacity
          // ignore: cast_nullable_to_non_nullable
          : capacity as int?,
      depotId: depotId == const $CopyWithPlaceholder()
          ? _value.depotId
          // ignore: cast_nullable_to_non_nullable
          : depotId as String?,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as VehicleStatus?,
    );
  }
}

extension $VehicleUpdateBodyCopyWith on VehicleUpdateBody {
  /// Returns a callable class that can be used as follows: `instanceOfVehicleUpdateBody.copyWith(...)` or like so:`instanceOfVehicleUpdateBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$VehicleUpdateBodyCWProxy get copyWith =>
      _$VehicleUpdateBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleUpdateBody _$VehicleUpdateBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('VehicleUpdateBody', json, ($checkedConvert) {
      final val = VehicleUpdateBody(
        type: $checkedConvert('type', (v) => v as String?),
        capacity: $checkedConvert('capacity', (v) => (v as num?)?.toInt()),
        depotId: $checkedConvert('depotId', (v) => v as String?),
        status: $checkedConvert(
          'status',
          (v) => $enumDecodeNullable(_$VehicleStatusEnumMap, v),
        ),
      );
      return val;
    });

Map<String, dynamic> _$VehicleUpdateBodyToJson(VehicleUpdateBody instance) =>
    <String, dynamic>{
      'type': ?instance.type,
      'capacity': ?instance.capacity,
      'depotId': ?instance.depotId,
      'status': ?_$VehicleStatusEnumMap[instance.status],
    };

const _$VehicleStatusEnumMap = {
  VehicleStatus.ACTIVE: 'ACTIVE',
  VehicleStatus.IN_WORKSHOP: 'IN_WORKSHOP',
  VehicleStatus.RETIRED: 'RETIRED',
};
