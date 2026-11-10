// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_attendance_row.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TeamAttendanceRowCWProxy {
  TeamAttendanceRow employee(AttendanceEmployee employee);

  TeamAttendanceRow designation(String? designation);

  TeamAttendanceRow depot(DepotSummary? depot);

  TeamAttendanceRow businessUnit(BusinessUnitRef businessUnit);

  TeamAttendanceRow duties(List<TeamAttendanceRowDutiesInner> duties);

  TeamAttendanceRow leave(TeamAttendanceRowLeave? leave);

  TeamAttendanceRow mark(AttendanceMarkItem? mark);

  TeamAttendanceRow suggestedStatus(AttendanceStatus suggestedStatus);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TeamAttendanceRow(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TeamAttendanceRow(...).copyWith(id: 12, name: "My name")
  /// ````
  TeamAttendanceRow call({
    AttendanceEmployee employee,
    String? designation,
    DepotSummary? depot,
    BusinessUnitRef businessUnit,
    List<TeamAttendanceRowDutiesInner> duties,
    TeamAttendanceRowLeave? leave,
    AttendanceMarkItem? mark,
    AttendanceStatus suggestedStatus,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTeamAttendanceRow.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTeamAttendanceRow.copyWith.fieldName(...)`
class _$TeamAttendanceRowCWProxyImpl implements _$TeamAttendanceRowCWProxy {
  const _$TeamAttendanceRowCWProxyImpl(this._value);

  final TeamAttendanceRow _value;

  @override
  TeamAttendanceRow employee(AttendanceEmployee employee) =>
      this(employee: employee);

  @override
  TeamAttendanceRow designation(String? designation) =>
      this(designation: designation);

  @override
  TeamAttendanceRow depot(DepotSummary? depot) => this(depot: depot);

  @override
  TeamAttendanceRow businessUnit(BusinessUnitRef businessUnit) =>
      this(businessUnit: businessUnit);

  @override
  TeamAttendanceRow duties(List<TeamAttendanceRowDutiesInner> duties) =>
      this(duties: duties);

  @override
  TeamAttendanceRow leave(TeamAttendanceRowLeave? leave) => this(leave: leave);

  @override
  TeamAttendanceRow mark(AttendanceMarkItem? mark) => this(mark: mark);

  @override
  TeamAttendanceRow suggestedStatus(AttendanceStatus suggestedStatus) =>
      this(suggestedStatus: suggestedStatus);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TeamAttendanceRow(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TeamAttendanceRow(...).copyWith(id: 12, name: "My name")
  /// ````
  TeamAttendanceRow call({
    Object? employee = const $CopyWithPlaceholder(),
    Object? designation = const $CopyWithPlaceholder(),
    Object? depot = const $CopyWithPlaceholder(),
    Object? businessUnit = const $CopyWithPlaceholder(),
    Object? duties = const $CopyWithPlaceholder(),
    Object? leave = const $CopyWithPlaceholder(),
    Object? mark = const $CopyWithPlaceholder(),
    Object? suggestedStatus = const $CopyWithPlaceholder(),
  }) {
    return TeamAttendanceRow(
      employee: employee == const $CopyWithPlaceholder()
          ? _value.employee
          // ignore: cast_nullable_to_non_nullable
          : employee as AttendanceEmployee,
      designation: designation == const $CopyWithPlaceholder()
          ? _value.designation
          // ignore: cast_nullable_to_non_nullable
          : designation as String?,
      depot: depot == const $CopyWithPlaceholder()
          ? _value.depot
          // ignore: cast_nullable_to_non_nullable
          : depot as DepotSummary?,
      businessUnit: businessUnit == const $CopyWithPlaceholder()
          ? _value.businessUnit
          // ignore: cast_nullable_to_non_nullable
          : businessUnit as BusinessUnitRef,
      duties: duties == const $CopyWithPlaceholder()
          ? _value.duties
          // ignore: cast_nullable_to_non_nullable
          : duties as List<TeamAttendanceRowDutiesInner>,
      leave: leave == const $CopyWithPlaceholder()
          ? _value.leave
          // ignore: cast_nullable_to_non_nullable
          : leave as TeamAttendanceRowLeave?,
      mark: mark == const $CopyWithPlaceholder()
          ? _value.mark
          // ignore: cast_nullable_to_non_nullable
          : mark as AttendanceMarkItem?,
      suggestedStatus: suggestedStatus == const $CopyWithPlaceholder()
          ? _value.suggestedStatus
          // ignore: cast_nullable_to_non_nullable
          : suggestedStatus as AttendanceStatus,
    );
  }
}

extension $TeamAttendanceRowCopyWith on TeamAttendanceRow {
  /// Returns a callable class that can be used as follows: `instanceOfTeamAttendanceRow.copyWith(...)` or like so:`instanceOfTeamAttendanceRow.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TeamAttendanceRowCWProxy get copyWith =>
      _$TeamAttendanceRowCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamAttendanceRow _$TeamAttendanceRowFromJson(Map<String, dynamic> json) =>
    $checkedCreate('TeamAttendanceRow', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'employee',
          'designation',
          'depot',
          'businessUnit',
          'duties',
          'leave',
          'mark',
          'suggestedStatus',
        ],
      );
      final val = TeamAttendanceRow(
        employee: $checkedConvert(
          'employee',
          (v) => AttendanceEmployee.fromJson(v as Map<String, dynamic>),
        ),
        designation: $checkedConvert('designation', (v) => v as String?),
        depot: $checkedConvert(
          'depot',
          (v) => v == null
              ? null
              : DepotSummary.fromJson(v as Map<String, dynamic>),
        ),
        businessUnit: $checkedConvert(
          'businessUnit',
          (v) => BusinessUnitRef.fromJson(v as Map<String, dynamic>),
        ),
        duties: $checkedConvert(
          'duties',
          (v) => (v as List<dynamic>)
              .map(
                (e) => TeamAttendanceRowDutiesInner.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList(),
        ),
        leave: $checkedConvert(
          'leave',
          (v) => v == null
              ? null
              : TeamAttendanceRowLeave.fromJson(v as Map<String, dynamic>),
        ),
        mark: $checkedConvert(
          'mark',
          (v) => v == null
              ? null
              : AttendanceMarkItem.fromJson(v as Map<String, dynamic>),
        ),
        suggestedStatus: $checkedConvert(
          'suggestedStatus',
          (v) => $enumDecode(_$AttendanceStatusEnumMap, v),
        ),
      );
      return val;
    });

Map<String, dynamic> _$TeamAttendanceRowToJson(TeamAttendanceRow instance) =>
    <String, dynamic>{
      'employee': instance.employee.toJson(),
      'designation': instance.designation,
      'depot': instance.depot?.toJson(),
      'businessUnit': instance.businessUnit.toJson(),
      'duties': instance.duties.map((e) => e.toJson()).toList(),
      'leave': instance.leave?.toJson(),
      'mark': instance.mark?.toJson(),
      'suggestedStatus': _$AttendanceStatusEnumMap[instance.suggestedStatus]!,
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
