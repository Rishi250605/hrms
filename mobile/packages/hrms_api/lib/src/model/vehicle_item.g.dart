// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$VehicleItemCWProxy {
  VehicleItem id(String id);

  VehicleItem regNo(String regNo);

  VehicleItem type(String type);

  VehicleItem capacity(int? capacity);

  VehicleItem status(VehicleStatus status);

  VehicleItem depot(DepotSummary depot);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VehicleItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VehicleItem(...).copyWith(id: 12, name: "My name")
  /// ````
  VehicleItem call({
    String id,
    String regNo,
    String type,
    int? capacity,
    VehicleStatus status,
    DepotSummary depot,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfVehicleItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfVehicleItem.copyWith.fieldName(...)`
class _$VehicleItemCWProxyImpl implements _$VehicleItemCWProxy {
  const _$VehicleItemCWProxyImpl(this._value);

  final VehicleItem _value;

  @override
  VehicleItem id(String id) => this(id: id);

  @override
  VehicleItem regNo(String regNo) => this(regNo: regNo);

  @override
  VehicleItem type(String type) => this(type: type);

  @override
  VehicleItem capacity(int? capacity) => this(capacity: capacity);

  @override
  VehicleItem status(VehicleStatus status) => this(status: status);

  @override
  VehicleItem depot(DepotSummary depot) => this(depot: depot);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VehicleItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VehicleItem(...).copyWith(id: 12, name: "My name")
  /// ````
  VehicleItem call({
    Object? id = const $CopyWithPlaceholder(),
    Object? regNo = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? capacity = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? depot = const $CopyWithPlaceholder(),
  }) {
    return VehicleItem(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
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
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as VehicleStatus,
      depot: depot == const $CopyWithPlaceholder()
          ? _value.depot
          // ignore: cast_nullable_to_non_nullable
          : depot as DepotSummary,
    );
  }
}

extension $VehicleItemCopyWith on VehicleItem {
  /// Returns a callable class that can be used as follows: `instanceOfVehicleItem.copyWith(...)` or like so:`instanceOfVehicleItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$VehicleItemCWProxy get copyWith => _$VehicleItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleItem _$VehicleItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate('VehicleItem', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'regNo',
          'type',
          'capacity',
          'status',
          'depot',
        ],
      );
      final val = VehicleItem(
        id: $checkedConvert('id', (v) => v as String),
        regNo: $checkedConvert('regNo', (v) => v as String),
        type: $checkedConvert('type', (v) => v as String),
        capacity: $checkedConvert('capacity', (v) => (v as num?)?.toInt()),
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(_$VehicleStatusEnumMap, v),
        ),
        depot: $checkedConvert(
          'depot',
          (v) => DepotSummary.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$VehicleItemToJson(VehicleItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'regNo': instance.regNo,
      'type': instance.type,
      'capacity': instance.capacity,
      'status': _$VehicleStatusEnumMap[instance.status]!,
      'depot': instance.depot.toJson(),
    };

const _$VehicleStatusEnumMap = {
  VehicleStatus.ACTIVE: 'ACTIVE',
  VehicleStatus.IN_WORKSHOP: 'IN_WORKSHOP',
  VehicleStatus.RETIRED: 'RETIRED',
};
