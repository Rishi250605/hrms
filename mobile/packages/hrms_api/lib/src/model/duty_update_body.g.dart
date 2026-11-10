// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duty_update_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DutyUpdateBodyCWProxy {
  DutyUpdateBody startTime(String? startTime);

  DutyUpdateBody endTime(String? endTime);

  DutyUpdateBody crossesMidnight(bool? crossesMidnight);

  DutyUpdateBody routeId(String? routeId);

  DutyUpdateBody vehicleId(String? vehicleId);

  DutyUpdateBody status(DutyStatus? status);

  DutyUpdateBody notes(String? notes);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DutyUpdateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DutyUpdateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  DutyUpdateBody call({
    String? startTime,
    String? endTime,
    bool? crossesMidnight,
    String? routeId,
    String? vehicleId,
    DutyStatus? status,
    String? notes,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDutyUpdateBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDutyUpdateBody.copyWith.fieldName(...)`
class _$DutyUpdateBodyCWProxyImpl implements _$DutyUpdateBodyCWProxy {
  const _$DutyUpdateBodyCWProxyImpl(this._value);

  final DutyUpdateBody _value;

  @override
  DutyUpdateBody startTime(String? startTime) => this(startTime: startTime);

  @override
  DutyUpdateBody endTime(String? endTime) => this(endTime: endTime);

  @override
  DutyUpdateBody crossesMidnight(bool? crossesMidnight) =>
      this(crossesMidnight: crossesMidnight);

  @override
  DutyUpdateBody routeId(String? routeId) => this(routeId: routeId);

  @override
  DutyUpdateBody vehicleId(String? vehicleId) => this(vehicleId: vehicleId);

  @override
  DutyUpdateBody status(DutyStatus? status) => this(status: status);

  @override
  DutyUpdateBody notes(String? notes) => this(notes: notes);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DutyUpdateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DutyUpdateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  DutyUpdateBody call({
    Object? startTime = const $CopyWithPlaceholder(),
    Object? endTime = const $CopyWithPlaceholder(),
    Object? crossesMidnight = const $CopyWithPlaceholder(),
    Object? routeId = const $CopyWithPlaceholder(),
    Object? vehicleId = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? notes = const $CopyWithPlaceholder(),
  }) {
    return DutyUpdateBody(
      startTime: startTime == const $CopyWithPlaceholder()
          ? _value.startTime
          // ignore: cast_nullable_to_non_nullable
          : startTime as String?,
      endTime: endTime == const $CopyWithPlaceholder()
          ? _value.endTime
          // ignore: cast_nullable_to_non_nullable
          : endTime as String?,
      crossesMidnight: crossesMidnight == const $CopyWithPlaceholder()
          ? _value.crossesMidnight
          // ignore: cast_nullable_to_non_nullable
          : crossesMidnight as bool?,
      routeId: routeId == const $CopyWithPlaceholder()
          ? _value.routeId
          // ignore: cast_nullable_to_non_nullable
          : routeId as String?,
      vehicleId: vehicleId == const $CopyWithPlaceholder()
          ? _value.vehicleId
          // ignore: cast_nullable_to_non_nullable
          : vehicleId as String?,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as DutyStatus?,
      notes: notes == const $CopyWithPlaceholder()
          ? _value.notes
          // ignore: cast_nullable_to_non_nullable
          : notes as String?,
    );
  }
}

extension $DutyUpdateBodyCopyWith on DutyUpdateBody {
  /// Returns a callable class that can be used as follows: `instanceOfDutyUpdateBody.copyWith(...)` or like so:`instanceOfDutyUpdateBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DutyUpdateBodyCWProxy get copyWith => _$DutyUpdateBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DutyUpdateBody _$DutyUpdateBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DutyUpdateBody', json, ($checkedConvert) {
      final val = DutyUpdateBody(
        startTime: $checkedConvert('startTime', (v) => v as String?),
        endTime: $checkedConvert('endTime', (v) => v as String?),
        crossesMidnight: $checkedConvert('crossesMidnight', (v) => v as bool?),
        routeId: $checkedConvert('routeId', (v) => v as String?),
        vehicleId: $checkedConvert('vehicleId', (v) => v as String?),
        status: $checkedConvert(
          'status',
          (v) => $enumDecodeNullable(_$DutyStatusEnumMap, v),
        ),
        notes: $checkedConvert('notes', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$DutyUpdateBodyToJson(DutyUpdateBody instance) =>
    <String, dynamic>{
      'startTime': ?instance.startTime,
      'endTime': ?instance.endTime,
      'crossesMidnight': ?instance.crossesMidnight,
      'routeId': ?instance.routeId,
      'vehicleId': ?instance.vehicleId,
      'status': ?_$DutyStatusEnumMap[instance.status],
      'notes': ?instance.notes,
    };

const _$DutyStatusEnumMap = {
  DutyStatus.PLANNED: 'PLANNED',
  DutyStatus.CONFIRMED: 'CONFIRMED',
  DutyStatus.COMPLETED: 'COMPLETED',
  DutyStatus.CANCELLED: 'CANCELLED',
};
