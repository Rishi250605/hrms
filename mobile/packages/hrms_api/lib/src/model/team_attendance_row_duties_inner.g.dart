// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_attendance_row_duties_inner.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TeamAttendanceRowDutiesInnerCWProxy {
  TeamAttendanceRowDutiesInner dutyId(String dutyId);

  TeamAttendanceRowDutiesInner assignmentId(String assignmentId);

  TeamAttendanceRowDutiesInner startTime(String startTime);

  TeamAttendanceRowDutiesInner endTime(String endTime);

  TeamAttendanceRowDutiesInner routeCode(String? routeCode);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TeamAttendanceRowDutiesInner(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TeamAttendanceRowDutiesInner(...).copyWith(id: 12, name: "My name")
  /// ````
  TeamAttendanceRowDutiesInner call({
    String dutyId,
    String assignmentId,
    String startTime,
    String endTime,
    String? routeCode,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTeamAttendanceRowDutiesInner.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTeamAttendanceRowDutiesInner.copyWith.fieldName(...)`
class _$TeamAttendanceRowDutiesInnerCWProxyImpl
    implements _$TeamAttendanceRowDutiesInnerCWProxy {
  const _$TeamAttendanceRowDutiesInnerCWProxyImpl(this._value);

  final TeamAttendanceRowDutiesInner _value;

  @override
  TeamAttendanceRowDutiesInner dutyId(String dutyId) => this(dutyId: dutyId);

  @override
  TeamAttendanceRowDutiesInner assignmentId(String assignmentId) =>
      this(assignmentId: assignmentId);

  @override
  TeamAttendanceRowDutiesInner startTime(String startTime) =>
      this(startTime: startTime);

  @override
  TeamAttendanceRowDutiesInner endTime(String endTime) =>
      this(endTime: endTime);

  @override
  TeamAttendanceRowDutiesInner routeCode(String? routeCode) =>
      this(routeCode: routeCode);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TeamAttendanceRowDutiesInner(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TeamAttendanceRowDutiesInner(...).copyWith(id: 12, name: "My name")
  /// ````
  TeamAttendanceRowDutiesInner call({
    Object? dutyId = const $CopyWithPlaceholder(),
    Object? assignmentId = const $CopyWithPlaceholder(),
    Object? startTime = const $CopyWithPlaceholder(),
    Object? endTime = const $CopyWithPlaceholder(),
    Object? routeCode = const $CopyWithPlaceholder(),
  }) {
    return TeamAttendanceRowDutiesInner(
      dutyId: dutyId == const $CopyWithPlaceholder()
          ? _value.dutyId
          // ignore: cast_nullable_to_non_nullable
          : dutyId as String,
      assignmentId: assignmentId == const $CopyWithPlaceholder()
          ? _value.assignmentId
          // ignore: cast_nullable_to_non_nullable
          : assignmentId as String,
      startTime: startTime == const $CopyWithPlaceholder()
          ? _value.startTime
          // ignore: cast_nullable_to_non_nullable
          : startTime as String,
      endTime: endTime == const $CopyWithPlaceholder()
          ? _value.endTime
          // ignore: cast_nullable_to_non_nullable
          : endTime as String,
      routeCode: routeCode == const $CopyWithPlaceholder()
          ? _value.routeCode
          // ignore: cast_nullable_to_non_nullable
          : routeCode as String?,
    );
  }
}

extension $TeamAttendanceRowDutiesInnerCopyWith
    on TeamAttendanceRowDutiesInner {
  /// Returns a callable class that can be used as follows: `instanceOfTeamAttendanceRowDutiesInner.copyWith(...)` or like so:`instanceOfTeamAttendanceRowDutiesInner.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TeamAttendanceRowDutiesInnerCWProxy get copyWith =>
      _$TeamAttendanceRowDutiesInnerCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamAttendanceRowDutiesInner _$TeamAttendanceRowDutiesInnerFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('TeamAttendanceRowDutiesInner', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'dutyId',
      'assignmentId',
      'startTime',
      'endTime',
      'routeCode',
    ],
  );
  final val = TeamAttendanceRowDutiesInner(
    dutyId: $checkedConvert('dutyId', (v) => v as String),
    assignmentId: $checkedConvert('assignmentId', (v) => v as String),
    startTime: $checkedConvert('startTime', (v) => v as String),
    endTime: $checkedConvert('endTime', (v) => v as String),
    routeCode: $checkedConvert('routeCode', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$TeamAttendanceRowDutiesInnerToJson(
  TeamAttendanceRowDutiesInner instance,
) => <String, dynamic>{
  'dutyId': instance.dutyId,
  'assignmentId': instance.assignmentId,
  'startTime': instance.startTime,
  'endTime': instance.endTime,
  'routeCode': instance.routeCode,
};
