// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duty_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DutyItemCWProxy {
  DutyItem id(String id);

  DutyItem depotId(String depotId);

  DutyItem dutyDate(String dutyDate);

  DutyItem status(DutyStatus status);

  DutyItem scheduledStart(DateTime scheduledStart);

  DutyItem scheduledEnd(DateTime scheduledEnd);

  DutyItem startTime(String startTime);

  DutyItem endTime(String endTime);

  DutyItem crossesMidnight(bool crossesMidnight);

  DutyItem durationMinutes(int durationMinutes);

  DutyItem route(LeaveRequestItemLeaveType? route);

  DutyItem vehicle(DutyItemVehicle? vehicle);

  DutyItem template(DutyItemTemplate? template);

  DutyItem notes(String? notes);

  DutyItem filled(bool filled);

  DutyItem assignments(List<AssignmentItem> assignments);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DutyItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DutyItem(...).copyWith(id: 12, name: "My name")
  /// ````
  DutyItem call({
    String id,
    String depotId,
    String dutyDate,
    DutyStatus status,
    DateTime scheduledStart,
    DateTime scheduledEnd,
    String startTime,
    String endTime,
    bool crossesMidnight,
    int durationMinutes,
    LeaveRequestItemLeaveType? route,
    DutyItemVehicle? vehicle,
    DutyItemTemplate? template,
    String? notes,
    bool filled,
    List<AssignmentItem> assignments,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDutyItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDutyItem.copyWith.fieldName(...)`
class _$DutyItemCWProxyImpl implements _$DutyItemCWProxy {
  const _$DutyItemCWProxyImpl(this._value);

  final DutyItem _value;

  @override
  DutyItem id(String id) => this(id: id);

  @override
  DutyItem depotId(String depotId) => this(depotId: depotId);

  @override
  DutyItem dutyDate(String dutyDate) => this(dutyDate: dutyDate);

  @override
  DutyItem status(DutyStatus status) => this(status: status);

  @override
  DutyItem scheduledStart(DateTime scheduledStart) =>
      this(scheduledStart: scheduledStart);

  @override
  DutyItem scheduledEnd(DateTime scheduledEnd) =>
      this(scheduledEnd: scheduledEnd);

  @override
  DutyItem startTime(String startTime) => this(startTime: startTime);

  @override
  DutyItem endTime(String endTime) => this(endTime: endTime);

  @override
  DutyItem crossesMidnight(bool crossesMidnight) =>
      this(crossesMidnight: crossesMidnight);

  @override
  DutyItem durationMinutes(int durationMinutes) =>
      this(durationMinutes: durationMinutes);

  @override
  DutyItem route(LeaveRequestItemLeaveType? route) => this(route: route);

  @override
  DutyItem vehicle(DutyItemVehicle? vehicle) => this(vehicle: vehicle);

  @override
  DutyItem template(DutyItemTemplate? template) => this(template: template);

  @override
  DutyItem notes(String? notes) => this(notes: notes);

  @override
  DutyItem filled(bool filled) => this(filled: filled);

  @override
  DutyItem assignments(List<AssignmentItem> assignments) =>
      this(assignments: assignments);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DutyItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DutyItem(...).copyWith(id: 12, name: "My name")
  /// ````
  DutyItem call({
    Object? id = const $CopyWithPlaceholder(),
    Object? depotId = const $CopyWithPlaceholder(),
    Object? dutyDate = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? scheduledStart = const $CopyWithPlaceholder(),
    Object? scheduledEnd = const $CopyWithPlaceholder(),
    Object? startTime = const $CopyWithPlaceholder(),
    Object? endTime = const $CopyWithPlaceholder(),
    Object? crossesMidnight = const $CopyWithPlaceholder(),
    Object? durationMinutes = const $CopyWithPlaceholder(),
    Object? route = const $CopyWithPlaceholder(),
    Object? vehicle = const $CopyWithPlaceholder(),
    Object? template = const $CopyWithPlaceholder(),
    Object? notes = const $CopyWithPlaceholder(),
    Object? filled = const $CopyWithPlaceholder(),
    Object? assignments = const $CopyWithPlaceholder(),
  }) {
    return DutyItem(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      depotId: depotId == const $CopyWithPlaceholder()
          ? _value.depotId
          // ignore: cast_nullable_to_non_nullable
          : depotId as String,
      dutyDate: dutyDate == const $CopyWithPlaceholder()
          ? _value.dutyDate
          // ignore: cast_nullable_to_non_nullable
          : dutyDate as String,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as DutyStatus,
      scheduledStart: scheduledStart == const $CopyWithPlaceholder()
          ? _value.scheduledStart
          // ignore: cast_nullable_to_non_nullable
          : scheduledStart as DateTime,
      scheduledEnd: scheduledEnd == const $CopyWithPlaceholder()
          ? _value.scheduledEnd
          // ignore: cast_nullable_to_non_nullable
          : scheduledEnd as DateTime,
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
      durationMinutes: durationMinutes == const $CopyWithPlaceholder()
          ? _value.durationMinutes
          // ignore: cast_nullable_to_non_nullable
          : durationMinutes as int,
      route: route == const $CopyWithPlaceholder()
          ? _value.route
          // ignore: cast_nullable_to_non_nullable
          : route as LeaveRequestItemLeaveType?,
      vehicle: vehicle == const $CopyWithPlaceholder()
          ? _value.vehicle
          // ignore: cast_nullable_to_non_nullable
          : vehicle as DutyItemVehicle?,
      template: template == const $CopyWithPlaceholder()
          ? _value.template
          // ignore: cast_nullable_to_non_nullable
          : template as DutyItemTemplate?,
      notes: notes == const $CopyWithPlaceholder()
          ? _value.notes
          // ignore: cast_nullable_to_non_nullable
          : notes as String?,
      filled: filled == const $CopyWithPlaceholder()
          ? _value.filled
          // ignore: cast_nullable_to_non_nullable
          : filled as bool,
      assignments: assignments == const $CopyWithPlaceholder()
          ? _value.assignments
          // ignore: cast_nullable_to_non_nullable
          : assignments as List<AssignmentItem>,
    );
  }
}

extension $DutyItemCopyWith on DutyItem {
  /// Returns a callable class that can be used as follows: `instanceOfDutyItem.copyWith(...)` or like so:`instanceOfDutyItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DutyItemCWProxy get copyWith => _$DutyItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DutyItem _$DutyItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DutyItem', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'depotId',
          'dutyDate',
          'status',
          'scheduledStart',
          'scheduledEnd',
          'startTime',
          'endTime',
          'crossesMidnight',
          'durationMinutes',
          'route',
          'vehicle',
          'template',
          'notes',
          'filled',
          'assignments',
        ],
      );
      final val = DutyItem(
        id: $checkedConvert('id', (v) => v as String),
        depotId: $checkedConvert('depotId', (v) => v as String),
        dutyDate: $checkedConvert('dutyDate', (v) => v as String),
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(_$DutyStatusEnumMap, v),
        ),
        scheduledStart: $checkedConvert(
          'scheduledStart',
          (v) => DateTime.parse(v as String),
        ),
        scheduledEnd: $checkedConvert(
          'scheduledEnd',
          (v) => DateTime.parse(v as String),
        ),
        startTime: $checkedConvert('startTime', (v) => v as String),
        endTime: $checkedConvert('endTime', (v) => v as String),
        crossesMidnight: $checkedConvert('crossesMidnight', (v) => v as bool),
        durationMinutes: $checkedConvert(
          'durationMinutes',
          (v) => (v as num).toInt(),
        ),
        route: $checkedConvert(
          'route',
          (v) => v == null
              ? null
              : LeaveRequestItemLeaveType.fromJson(v as Map<String, dynamic>),
        ),
        vehicle: $checkedConvert(
          'vehicle',
          (v) => v == null
              ? null
              : DutyItemVehicle.fromJson(v as Map<String, dynamic>),
        ),
        template: $checkedConvert(
          'template',
          (v) => v == null
              ? null
              : DutyItemTemplate.fromJson(v as Map<String, dynamic>),
        ),
        notes: $checkedConvert('notes', (v) => v as String?),
        filled: $checkedConvert('filled', (v) => v as bool),
        assignments: $checkedConvert(
          'assignments',
          (v) => (v as List<dynamic>)
              .map((e) => AssignmentItem.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$DutyItemToJson(DutyItem instance) => <String, dynamic>{
  'id': instance.id,
  'depotId': instance.depotId,
  'dutyDate': instance.dutyDate,
  'status': _$DutyStatusEnumMap[instance.status]!,
  'scheduledStart': instance.scheduledStart.toIso8601String(),
  'scheduledEnd': instance.scheduledEnd.toIso8601String(),
  'startTime': instance.startTime,
  'endTime': instance.endTime,
  'crossesMidnight': instance.crossesMidnight,
  'durationMinutes': instance.durationMinutes,
  'route': instance.route?.toJson(),
  'vehicle': instance.vehicle?.toJson(),
  'template': instance.template?.toJson(),
  'notes': instance.notes,
  'filled': instance.filled,
  'assignments': instance.assignments.map((e) => e.toJson()).toList(),
};

const _$DutyStatusEnumMap = {
  DutyStatus.PLANNED: 'PLANNED',
  DutyStatus.CONFIRMED: 'CONFIRMED',
  DutyStatus.COMPLETED: 'COMPLETED',
  DutyStatus.CANCELLED: 'CANCELLED',
};
