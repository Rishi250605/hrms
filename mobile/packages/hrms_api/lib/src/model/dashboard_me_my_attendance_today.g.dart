// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_me_my_attendance_today.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DashboardMeMyAttendanceTodayCWProxy {
  DashboardMeMyAttendanceToday status(AttendanceStatus status);

  DashboardMeMyAttendanceToday approvalState(ApprovalState approvalState);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DashboardMeMyAttendanceToday(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DashboardMeMyAttendanceToday(...).copyWith(id: 12, name: "My name")
  /// ````
  DashboardMeMyAttendanceToday call({
    AttendanceStatus status,
    ApprovalState approvalState,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDashboardMeMyAttendanceToday.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDashboardMeMyAttendanceToday.copyWith.fieldName(...)`
class _$DashboardMeMyAttendanceTodayCWProxyImpl
    implements _$DashboardMeMyAttendanceTodayCWProxy {
  const _$DashboardMeMyAttendanceTodayCWProxyImpl(this._value);

  final DashboardMeMyAttendanceToday _value;

  @override
  DashboardMeMyAttendanceToday status(AttendanceStatus status) =>
      this(status: status);

  @override
  DashboardMeMyAttendanceToday approvalState(ApprovalState approvalState) =>
      this(approvalState: approvalState);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DashboardMeMyAttendanceToday(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DashboardMeMyAttendanceToday(...).copyWith(id: 12, name: "My name")
  /// ````
  DashboardMeMyAttendanceToday call({
    Object? status = const $CopyWithPlaceholder(),
    Object? approvalState = const $CopyWithPlaceholder(),
  }) {
    return DashboardMeMyAttendanceToday(
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as AttendanceStatus,
      approvalState: approvalState == const $CopyWithPlaceholder()
          ? _value.approvalState
          // ignore: cast_nullable_to_non_nullable
          : approvalState as ApprovalState,
    );
  }
}

extension $DashboardMeMyAttendanceTodayCopyWith
    on DashboardMeMyAttendanceToday {
  /// Returns a callable class that can be used as follows: `instanceOfDashboardMeMyAttendanceToday.copyWith(...)` or like so:`instanceOfDashboardMeMyAttendanceToday.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DashboardMeMyAttendanceTodayCWProxy get copyWith =>
      _$DashboardMeMyAttendanceTodayCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardMeMyAttendanceToday _$DashboardMeMyAttendanceTodayFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DashboardMeMyAttendanceToday', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['status', 'approvalState']);
  final val = DashboardMeMyAttendanceToday(
    status: $checkedConvert(
      'status',
      (v) => $enumDecode(_$AttendanceStatusEnumMap, v),
    ),
    approvalState: $checkedConvert(
      'approvalState',
      (v) => $enumDecode(_$ApprovalStateEnumMap, v),
    ),
  );
  return val;
});

Map<String, dynamic> _$DashboardMeMyAttendanceTodayToJson(
  DashboardMeMyAttendanceToday instance,
) => <String, dynamic>{
  'status': _$AttendanceStatusEnumMap[instance.status]!,
  'approvalState': _$ApprovalStateEnumMap[instance.approvalState]!,
};

const _$AttendanceStatusEnumMap = {
  AttendanceStatus.PRESENT: 'PRESENT',
  AttendanceStatus.ABSENT: 'ABSENT',
  AttendanceStatus.HALF_DAY: 'HALF_DAY',
  AttendanceStatus.ON_LEAVE: 'ON_LEAVE',
  AttendanceStatus.ON_DUTY: 'ON_DUTY',
  AttendanceStatus.WEEKLY_OFF: 'WEEKLY_OFF',
  AttendanceStatus.HOLIDAY: 'HOLIDAY',
};

const _$ApprovalStateEnumMap = {
  ApprovalState.PENDING_APPROVAL: 'PENDING_APPROVAL',
  ApprovalState.APPROVED: 'APPROVED',
  ApprovalState.REJECTED: 'REJECTED',
};
