// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duty_template_create_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DutyTemplateCreateBodyCWProxy {
  DutyTemplateCreateBody depotId(String depotId);

  DutyTemplateCreateBody name(String name);

  DutyTemplateCreateBody startTime(String startTime);

  DutyTemplateCreateBody endTime(String endTime);

  DutyTemplateCreateBody crossesMidnight(bool? crossesMidnight);

  DutyTemplateCreateBody routeId(String? routeId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DutyTemplateCreateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DutyTemplateCreateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  DutyTemplateCreateBody call({
    String depotId,
    String name,
    String startTime,
    String endTime,
    bool? crossesMidnight,
    String? routeId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDutyTemplateCreateBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDutyTemplateCreateBody.copyWith.fieldName(...)`
class _$DutyTemplateCreateBodyCWProxyImpl
    implements _$DutyTemplateCreateBodyCWProxy {
  const _$DutyTemplateCreateBodyCWProxyImpl(this._value);

  final DutyTemplateCreateBody _value;

  @override
  DutyTemplateCreateBody depotId(String depotId) => this(depotId: depotId);

  @override
  DutyTemplateCreateBody name(String name) => this(name: name);

  @override
  DutyTemplateCreateBody startTime(String startTime) =>
      this(startTime: startTime);

  @override
  DutyTemplateCreateBody endTime(String endTime) => this(endTime: endTime);

  @override
  DutyTemplateCreateBody crossesMidnight(bool? crossesMidnight) =>
      this(crossesMidnight: crossesMidnight);

  @override
  DutyTemplateCreateBody routeId(String? routeId) => this(routeId: routeId);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DutyTemplateCreateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DutyTemplateCreateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  DutyTemplateCreateBody call({
    Object? depotId = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? startTime = const $CopyWithPlaceholder(),
    Object? endTime = const $CopyWithPlaceholder(),
    Object? crossesMidnight = const $CopyWithPlaceholder(),
    Object? routeId = const $CopyWithPlaceholder(),
  }) {
    return DutyTemplateCreateBody(
      depotId: depotId == const $CopyWithPlaceholder()
          ? _value.depotId
          // ignore: cast_nullable_to_non_nullable
          : depotId as String,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      startTime: startTime == const $CopyWithPlaceholder()
          ? _value.startTime
          // ignore: cast_nullable_to_non_nullable
          : startTime as String,
      endTime: endTime == const $CopyWithPlaceholder()
          ? _value.endTime
          // ignore: cast_nullable_to_non_nullable
          : endTime as String,
      crossesMidnight: crossesMidnight == const $CopyWithPlaceholder()
          ? _value.crossesMidnight
          // ignore: cast_nullable_to_non_nullable
          : crossesMidnight as bool?,
      routeId: routeId == const $CopyWithPlaceholder()
          ? _value.routeId
          // ignore: cast_nullable_to_non_nullable
          : routeId as String?,
    );
  }
}

extension $DutyTemplateCreateBodyCopyWith on DutyTemplateCreateBody {
  /// Returns a callable class that can be used as follows: `instanceOfDutyTemplateCreateBody.copyWith(...)` or like so:`instanceOfDutyTemplateCreateBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DutyTemplateCreateBodyCWProxy get copyWith =>
      _$DutyTemplateCreateBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DutyTemplateCreateBody _$DutyTemplateCreateBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DutyTemplateCreateBody', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['depotId', 'name', 'startTime', 'endTime'],
  );
  final val = DutyTemplateCreateBody(
    depotId: $checkedConvert('depotId', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    startTime: $checkedConvert('startTime', (v) => v as String),
    endTime: $checkedConvert('endTime', (v) => v as String),
    crossesMidnight: $checkedConvert('crossesMidnight', (v) => v as bool?),
    routeId: $checkedConvert('routeId', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$DutyTemplateCreateBodyToJson(
  DutyTemplateCreateBody instance,
) => <String, dynamic>{
  'depotId': instance.depotId,
  'name': instance.name,
  'startTime': instance.startTime,
  'endTime': instance.endTime,
  'crossesMidnight': ?instance.crossesMidnight,
  'routeId': ?instance.routeId,
};
