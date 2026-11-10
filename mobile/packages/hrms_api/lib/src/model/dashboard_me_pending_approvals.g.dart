// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_me_pending_approvals.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DashboardMePendingApprovalsCWProxy {
  DashboardMePendingApprovals attendance(int attendance);

  DashboardMePendingApprovals corrections(int corrections);

  DashboardMePendingApprovals leave(int leave);

  DashboardMePendingApprovals allowances(int allowances);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DashboardMePendingApprovals(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DashboardMePendingApprovals(...).copyWith(id: 12, name: "My name")
  /// ````
  DashboardMePendingApprovals call({
    int attendance,
    int corrections,
    int leave,
    int allowances,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDashboardMePendingApprovals.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDashboardMePendingApprovals.copyWith.fieldName(...)`
class _$DashboardMePendingApprovalsCWProxyImpl
    implements _$DashboardMePendingApprovalsCWProxy {
  const _$DashboardMePendingApprovalsCWProxyImpl(this._value);

  final DashboardMePendingApprovals _value;

  @override
  DashboardMePendingApprovals attendance(int attendance) =>
      this(attendance: attendance);

  @override
  DashboardMePendingApprovals corrections(int corrections) =>
      this(corrections: corrections);

  @override
  DashboardMePendingApprovals leave(int leave) => this(leave: leave);

  @override
  DashboardMePendingApprovals allowances(int allowances) =>
      this(allowances: allowances);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DashboardMePendingApprovals(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DashboardMePendingApprovals(...).copyWith(id: 12, name: "My name")
  /// ````
  DashboardMePendingApprovals call({
    Object? attendance = const $CopyWithPlaceholder(),
    Object? corrections = const $CopyWithPlaceholder(),
    Object? leave = const $CopyWithPlaceholder(),
    Object? allowances = const $CopyWithPlaceholder(),
  }) {
    return DashboardMePendingApprovals(
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

extension $DashboardMePendingApprovalsCopyWith on DashboardMePendingApprovals {
  /// Returns a callable class that can be used as follows: `instanceOfDashboardMePendingApprovals.copyWith(...)` or like so:`instanceOfDashboardMePendingApprovals.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DashboardMePendingApprovalsCWProxy get copyWith =>
      _$DashboardMePendingApprovalsCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardMePendingApprovals _$DashboardMePendingApprovalsFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DashboardMePendingApprovals', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['attendance', 'corrections', 'leave', 'allowances'],
  );
  final val = DashboardMePendingApprovals(
    attendance: $checkedConvert('attendance', (v) => (v as num).toInt()),
    corrections: $checkedConvert('corrections', (v) => (v as num).toInt()),
    leave: $checkedConvert('leave', (v) => (v as num).toInt()),
    allowances: $checkedConvert('allowances', (v) => (v as num).toInt()),
  );
  return val;
});

Map<String, dynamic> _$DashboardMePendingApprovalsToJson(
  DashboardMePendingApprovals instance,
) => <String, dynamic>{
  'attendance': instance.attendance,
  'corrections': instance.corrections,
  'leave': instance.leave,
  'allowances': instance.allowances,
};
