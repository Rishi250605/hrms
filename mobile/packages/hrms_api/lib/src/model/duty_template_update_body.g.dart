// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duty_template_update_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DutyTemplateUpdateBodyCWProxy {
  DutyTemplateUpdateBody name(String? name);

  DutyTemplateUpdateBody startTime(String? startTime);

  DutyTemplateUpdateBody endTime(String? endTime);

  DutyTemplateUpdateBody crossesMidnight(bool? crossesMidnight);

  DutyTemplateUpdateBody routeId(String? routeId);

  DutyTemplateUpdateBody archived(bool? archived);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DutyTemplateUpdateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DutyTemplateUpdateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  DutyTemplateUpdateBody call({
    String? name,
    String? startTime,
    String? endTime,
    bool? crossesMidnight,
    String? routeId,
    bool? archived,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDutyTemplateUpdateBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDutyTemplateUpdateBody.copyWith.fieldName(...)`
class _$DutyTemplateUpdateBodyCWProxyImpl
    implements _$DutyTemplateUpdateBodyCWProxy {
  const _$DutyTemplateUpdateBodyCWProxyImpl(this._value);

  final DutyTemplateUpdateBody _value;

  @override
  DutyTemplateUpdateBody name(String? name) => this(name: name);

  @override
  DutyTemplateUpdateBody startTime(String? startTime) =>
      this(startTime: startTime);

  @override
  DutyTemplateUpdateBody endTime(String? endTime) => this(endTime: endTime);

  @override
  DutyTemplateUpdateBody crossesMidnight(bool? crossesMidnight) =>
      this(crossesMidnight: crossesMidnight);

  @override
  DutyTemplateUpdateBody routeId(String? routeId) => this(routeId: routeId);

  @override
  DutyTemplateUpdateBody archived(bool? archived) => this(archived: archived);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DutyTemplateUpdateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DutyTemplateUpdateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  DutyTemplateUpdateBody call({
    Object? name = const $CopyWithPlaceholder(),
    Object? startTime = const $CopyWithPlaceholder(),
    Object? endTime = const $CopyWithPlaceholder(),
    Object? crossesMidnight = const $CopyWithPlaceholder(),
    Object? routeId = const $CopyWithPlaceholder(),
    Object? archived = const $CopyWithPlaceholder(),
  }) {
    return DutyTemplateUpdateBody(
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
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
      archived: archived == const $CopyWithPlaceholder()
          ? _value.archived
          // ignore: cast_nullable_to_non_nullable
          : archived as bool?,
    );
  }
}

extension $DutyTemplateUpdateBodyCopyWith on DutyTemplateUpdateBody {
  /// Returns a callable class that can be used as follows: `instanceOfDutyTemplateUpdateBody.copyWith(...)` or like so:`instanceOfDutyTemplateUpdateBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DutyTemplateUpdateBodyCWProxy get copyWith =>
      _$DutyTemplateUpdateBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DutyTemplateUpdateBody _$DutyTemplateUpdateBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DutyTemplateUpdateBody', json, ($checkedConvert) {
  final val = DutyTemplateUpdateBody(
    name: $checkedConvert('name', (v) => v as String?),
    startTime: $checkedConvert('startTime', (v) => v as String?),
    endTime: $checkedConvert('endTime', (v) => v as String?),
    crossesMidnight: $checkedConvert('crossesMidnight', (v) => v as bool?),
    routeId: $checkedConvert('routeId', (v) => v as String?),
    archived: $checkedConvert('archived', (v) => v as bool?),
  );
  return val;
});

Map<String, dynamic> _$DutyTemplateUpdateBodyToJson(
  DutyTemplateUpdateBody instance,
) => <String, dynamic>{
  'name': ?instance.name,
  'startTime': ?instance.startTime,
  'endTime': ?instance.endTime,
  'crossesMidnight': ?instance.crossesMidnight,
  'routeId': ?instance.routeId,
  'archived': ?instance.archived,
};
