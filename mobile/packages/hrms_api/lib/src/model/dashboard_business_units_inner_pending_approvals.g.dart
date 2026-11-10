// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_business_units_inner_pending_approvals.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DashboardBusinessUnitsInnerPendingApprovalsCWProxy {
  DashboardBusinessUnitsInnerPendingApprovals attendance(int attendance);

  DashboardBusinessUnitsInnerPendingApprovals corrections(int corrections);

  DashboardBusinessUnitsInnerPendingApprovals leave(int leave);

  DashboardBusinessUnitsInnerPendingApprovals allowances(int allowances);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DashboardBusinessUnitsInnerPendingApprovals(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DashboardBusinessUnitsInnerPendingApprovals(...).copyWith(id: 12, name: "My name")
  /// ````
  DashboardBusinessUnitsInnerPendingApprovals call({
    int attendance,
    int corrections,
    int leave,
    int allowances,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDashboardBusinessUnitsInnerPendingApprovals.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDashboardBusinessUnitsInnerPendingApprovals.copyWith.fieldName(...)`
class _$DashboardBusinessUnitsInnerPendingApprovalsCWProxyImpl
    implements _$DashboardBusinessUnitsInnerPendingApprovalsCWProxy {
  const _$DashboardBusinessUnitsInnerPendingApprovalsCWProxyImpl(this._value);

  final DashboardBusinessUnitsInnerPendingApprovals _value;

  @override
  DashboardBusinessUnitsInnerPendingApprovals attendance(int attendance) =>
      this(attendance: attendance);

  @override
  DashboardBusinessUnitsInnerPendingApprovals corrections(int corrections) =>
      this(corrections: corrections);

  @override
  DashboardBusinessUnitsInnerPendingApprovals leave(int leave) =>
      this(leave: leave);

  @override
  DashboardBusinessUnitsInnerPendingApprovals allowances(int allowances) =>
      this(allowances: allowances);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DashboardBusinessUnitsInnerPendingApprovals(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DashboardBusinessUnitsInnerPendingApprovals(...).copyWith(id: 12, name: "My name")
  /// ````
  DashboardBusinessUnitsInnerPendingApprovals call({
    Object? attendance = const $CopyWithPlaceholder(),
    Object? corrections = const $CopyWithPlaceholder(),
    Object? leave = const $CopyWithPlaceholder(),
    Object? allowances = const $CopyWithPlaceholder(),
  }) {
    return DashboardBusinessUnitsInnerPendingApprovals(
      attendance: attendance == const $CopyWithPlaceholder()
          ? _value.attendance
          // ignore: cast_nullable_to_non_nullable
          : attendance as int,
      corrections: corrections == const $CopyWithPlaceholder()
          ? _value.corrections
          // ignore: cast_nullable_to_non_nullable
          : corrections as int,
      leave: leave == const $CopyWithPlaceholder()
          ? _value.leave
          // ignore: cast_nullable_to_non_nullable
          : leave as int,
      allowances: allowances == const $CopyWithPlaceholder()
          ? _value.allowances
          // ignore: cast_nullable_to_non_nullable
          : allowances as int,
    );
  }
}

extension $DashboardBusinessUnitsInnerPendingApprovalsCopyWith
    on DashboardBusinessUnitsInnerPendingApprovals {
  /// Returns a callable class that can be used as follows: `instanceOfDashboardBusinessUnitsInnerPendingApprovals.copyWith(...)` or like so:`instanceOfDashboardBusinessUnitsInnerPendingApprovals.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DashboardBusinessUnitsInnerPendingApprovalsCWProxy get copyWith =>
      _$DashboardBusinessUnitsInnerPendingApprovalsCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardBusinessUnitsInnerPendingApprovals
_$DashboardBusinessUnitsInnerPendingApprovalsFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DashboardBusinessUnitsInnerPendingApprovals', json, (
  $checkedConvert,
) {
  $checkKeys(
    json,
    requiredKeys: const ['attendance', 'corrections', 'leave', 'allowances'],
  );
  final val = DashboardBusinessUnitsInnerPendingApprovals(
    attendance: $checkedConvert('attendance', (v) => (v as num).toInt()),
    corrections: $checkedConvert('corrections', (v) => (v as num).toInt()),
    leave: $checkedConvert('leave', (v) => (v as num).toInt()),
    allowances: $checkedConvert('allowances', (v) => (v as num).toInt()),
  );
  return val;
});

Map<String, dynamic> _$DashboardBusinessUnitsInnerPendingApprovalsToJson(
  DashboardBusinessUnitsInnerPendingApprovals instance,
) => <String, dynamic>{
  'attendance': instance.attendance,
  'corrections': instance.corrections,
  'leave': instance.leave,
  'allowances': instance.allowances,
};
