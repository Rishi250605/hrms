// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duty_template_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DutyTemplateItemCWProxy {
  DutyTemplateItem id(String id);

  DutyTemplateItem name(String name);

  DutyTemplateItem startTime(String startTime);

  DutyTemplateItem endTime(String endTime);

  DutyTemplateItem crossesMidnight(bool crossesMidnight);

  DutyTemplateItem route(LeaveRequestItemLeaveType? route);

  DutyTemplateItem depot(DepotSummary depot);

  DutyTemplateItem archived(bool archived);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DutyTemplateItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DutyTemplateItem(...).copyWith(id: 12, name: "My name")
  /// ````
  DutyTemplateItem call({
    String id,
    String name,
    String startTime,
    String endTime,
    bool crossesMidnight,
    LeaveRequestItemLeaveType? route,
    DepotSummary depot,
    bool archived,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDutyTemplateItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDutyTemplateItem.copyWith.fieldName(...)`
class _$DutyTemplateItemCWProxyImpl implements _$DutyTemplateItemCWProxy {
  const _$DutyTemplateItemCWProxyImpl(this._value);

  final DutyTemplateItem _value;

  @override
  DutyTemplateItem id(String id) => this(id: id);

  @override
  DutyTemplateItem name(String name) => this(name: name);

  @override
  DutyTemplateItem startTime(String startTime) => this(startTime: startTime);

  @override
  DutyTemplateItem endTime(String endTime) => this(endTime: endTime);

  @override
  DutyTemplateItem crossesMidnight(bool crossesMidnight) =>
      this(crossesMidnight: crossesMidnight);

  @override
  DutyTemplateItem route(LeaveRequestItemLeaveType? route) =>
      this(route: route);

  @override
  DutyTemplateItem depot(DepotSummary depot) => this(depot: depot);

  @override
  DutyTemplateItem archived(bool archived) => this(archived: archived);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DutyTemplateItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DutyTemplateItem(...).copyWith(id: 12, name: "My name")
  /// ````
  DutyTemplateItem call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? startTime = const $CopyWithPlaceholder(),
    Object? endTime = const $CopyWithPlaceholder(),
    Object? crossesMidnight = const $CopyWithPlaceholder(),
    Object? route = const $CopyWithPlaceholder(),
    Object? depot = const $CopyWithPlaceholder(),
    Object? archived = const $CopyWithPlaceholder(),
  }) {
    return DutyTemplateItem(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
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
          : crossesMidnight as bool,
      route: route == const $CopyWithPlaceholder()
          ? _value.route
          // ignore: cast_nullable_to_non_nullable
          : route as LeaveRequestItemLeaveType?,
      depot: depot == const $CopyWithPlaceholder()
          ? _value.depot
          // ignore: cast_nullable_to_non_nullable
          : depot as DepotSummary,
      archived: archived == const $CopyWithPlaceholder()
          ? _value.archived
          // ignore: cast_nullable_to_non_nullable
          : archived as bool,
    );
  }
}

extension $DutyTemplateItemCopyWith on DutyTemplateItem {
  /// Returns a callable class that can be used as follows: `instanceOfDutyTemplateItem.copyWith(...)` or like so:`instanceOfDutyTemplateItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DutyTemplateItemCWProxy get copyWith => _$DutyTemplateItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DutyTemplateItem _$DutyTemplateItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DutyTemplateItem', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'name',
          'startTime',
          'endTime',
          'crossesMidnight',
          'route',
          'depot',
          'archived',
        ],
      );
      final val = DutyTemplateItem(
        id: $checkedConvert('id', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        startTime: $checkedConvert('startTime', (v) => v as String),
        endTime: $checkedConvert('endTime', (v) => v as String),
        crossesMidnight: $checkedConvert('crossesMidnight', (v) => v as bool),
        route: $checkedConvert(
          'route',
          (v) => v == null
              ? null
              : LeaveRequestItemLeaveType.fromJson(v as Map<String, dynamic>),
        ),
        depot: $checkedConvert(
          'depot',
          (v) => DepotSummary.fromJson(v as Map<String, dynamic>),
        ),
        archived: $checkedConvert('archived', (v) => v as bool),
      );
      return val;
    });

Map<String, dynamic> _$DutyTemplateItemToJson(DutyTemplateItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'crossesMidnight': instance.crossesMidnight,
      'route': instance.route?.toJson(),
      'depot': instance.depot.toJson(),
      'archived': instance.archived,
    };
