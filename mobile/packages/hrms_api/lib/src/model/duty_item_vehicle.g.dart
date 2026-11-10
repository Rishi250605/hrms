// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duty_item_vehicle.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DutyItemVehicleCWProxy {
  DutyItemVehicle id(String id);

  DutyItemVehicle regNo(String regNo);

  DutyItemVehicle type(String type);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DutyItemVehicle(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DutyItemVehicle(...).copyWith(id: 12, name: "My name")
  /// ````
  DutyItemVehicle call({String id, String regNo, String type});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDutyItemVehicle.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDutyItemVehicle.copyWith.fieldName(...)`
class _$DutyItemVehicleCWProxyImpl implements _$DutyItemVehicleCWProxy {
  const _$DutyItemVehicleCWProxyImpl(this._value);

  final DutyItemVehicle _value;

  @override
  DutyItemVehicle id(String id) => this(id: id);

  @override
  DutyItemVehicle regNo(String regNo) => this(regNo: regNo);

  @override
  DutyItemVehicle type(String type) => this(type: type);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DutyItemVehicle(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DutyItemVehicle(...).copyWith(id: 12, name: "My name")
  /// ````
  DutyItemVehicle call({
    Object? id = const $CopyWithPlaceholder(),
    Object? regNo = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
  }) {
    return DutyItemVehicle(
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
    );
  }
}

extension $DutyItemVehicleCopyWith on DutyItemVehicle {
  /// Returns a callable class that can be used as follows: `instanceOfDutyItemVehicle.copyWith(...)` or like so:`instanceOfDutyItemVehicle.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DutyItemVehicleCWProxy get copyWith => _$DutyItemVehicleCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DutyItemVehicle _$DutyItemVehicleFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DutyItemVehicle', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['id', 'regNo', 'type']);
      final val = DutyItemVehicle(
        id: $checkedConvert('id', (v) => v as String),
        regNo: $checkedConvert('regNo', (v) => v as String),
        type: $checkedConvert('type', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$DutyItemVehicleToJson(DutyItemVehicle instance) =>
    <String, dynamic>{
      'id': instance.id,
      'regNo': instance.regNo,
      'type': instance.type,
    };
