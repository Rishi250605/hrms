// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duty_create_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DutyCreateBodyCWProxy {
  DutyCreateBody depotId(String depotId);

  DutyCreateBody dutyDate(String dutyDate);

  DutyCreateBody templateId(String? templateId);

  DutyCreateBody startTime(String? startTime);

  DutyCreateBody endTime(String? endTime);

  DutyCreateBody crossesMidnight(bool? crossesMidnight);

  DutyCreateBody routeId(String? routeId);

  DutyCreateBody vehicleId(String? vehicleId);

  DutyCreateBody notes(String? notes);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DutyCreateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DutyCreateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  DutyCreateBody call({
    String depotId,
    String dutyDate,
    String? templateId,
    String? startTime,
    String? endTime,
    bool? crossesMidnight,
    String? routeId,
    String? vehicleId,
    String? notes,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDutyCreateBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDutyCreateBody.copyWith.fieldName(...)`
class _$DutyCreateBodyCWProxyImpl implements _$DutyCreateBodyCWProxy {
  const _$DutyCreateBodyCWProxyImpl(this._value);

  final DutyCreateBody _value;

  @override
  DutyCreateBody depotId(String depotId) => this(depotId: depotId);

  @override
  DutyCreateBody dutyDate(String dutyDate) => this(dutyDate: dutyDate);

  @override
  DutyCreateBody templateId(String? templateId) => this(templateId: templateId);

  @override
  DutyCreateBody startTime(String? startTime) => this(startTime: startTime);

  @override
  DutyCreateBody endTime(String? endTime) => this(endTime: endTime);

  @override
  DutyCreateBody crossesMidnight(bool? crossesMidnight) =>
      this(crossesMidnight: crossesMidnight);

  @override
  DutyCreateBody routeId(String? routeId) => this(routeId: routeId);

  @override
  DutyCreateBody vehicleId(String? vehicleId) => this(vehicleId: vehicleId);

  @override
  DutyCreateBody notes(String? notes) => this(notes: notes);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DutyCreateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DutyCreateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  DutyCreateBody call({
    Object? depotId = const $CopyWithPlaceholder(),
    Object? dutyDate = const $CopyWithPlaceholder(),
    Object? templateId = const $CopyWithPlaceholder(),
    Object? startTime = const $CopyWithPlaceholder(),
    Object? endTime = const $CopyWithPlaceholder(),
    Object? crossesMidnight = const $CopyWithPlaceholder(),
    Object? routeId = const $CopyWithPlaceholder(),
    Object? vehicleId = const $CopyWithPlaceholder(),
    Object? notes = const $CopyWithPlaceholder(),
  }) {
    return DutyCreateBody(
      depotId: depotId == const $CopyWithPlaceholder()
          ? _value.depotId
          // ignore: cast_nullable_to_non_nullable
          : depotId as String,
      dutyDate: dutyDate == const $CopyWithPlaceholder()
          ? _value.dutyDate
          // ignore: cast_nullable_to_non_nullable
          : dutyDate as String,
      templateId: templateId == const $CopyWithPlaceholder()
          ? _value.templateId
          // ignore: cast_nullable_to_non_nullable
          : templateId as String?,
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
      notes: notes == const $CopyWithPlaceholder()
          ? _value.notes
          // ignore: cast_nullable_to_non_nullable
          : notes as String?,
    );
  }
}

extension $DutyCreateBodyCopyWith on DutyCreateBody {
  /// Returns a callable class that can be used as follows: `instanceOfDutyCreateBody.copyWith(...)` or like so:`instanceOfDutyCreateBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DutyCreateBodyCWProxy get copyWith => _$DutyCreateBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DutyCreateBody _$DutyCreateBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DutyCreateBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['depotId', 'dutyDate']);
      final val = DutyCreateBody(
        depotId: $checkedConvert('depotId', (v) => v as String),
        dutyDate: $checkedConvert('dutyDate', (v) => v as String),
        templateId: $checkedConvert('templateId', (v) => v as String?),
        startTime: $checkedConvert('startTime', (v) => v as String?),
        endTime: $checkedConvert('endTime', (v) => v as String?),
        crossesMidnight: $checkedConvert('crossesMidnight', (v) => v as bool?),
        routeId: $checkedConvert('routeId', (v) => v as String?),
        vehicleId: $checkedConvert('vehicleId', (v) => v as String?),
        notes: $checkedConvert('notes', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$DutyCreateBodyToJson(DutyCreateBody instance) =>
    <String, dynamic>{
      'depotId': instance.depotId,
      'dutyDate': instance.dutyDate,
      'templateId': ?instance.templateId,
      'startTime': ?instance.startTime,
      'endTime': ?instance.endTime,
      'crossesMidnight': ?instance.crossesMidnight,
      'routeId': ?instance.routeId,
      'vehicleId': ?instance.vehicleId,
      'notes': ?instance.notes,
    };
