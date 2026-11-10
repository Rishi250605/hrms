// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_report_summary.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AttendanceReportSummaryCWProxy {
  AttendanceReportSummary present(int present);

  AttendanceReportSummary absent(int absent);

  AttendanceReportSummary halfDay(int halfDay);

  AttendanceReportSummary leave(int leave);

  AttendanceReportSummary onDuty(int onDuty);

  AttendanceReportSummary weeklyOff(int weeklyOff);

  AttendanceReportSummary holiday(int holiday);

  AttendanceReportSummary pending(int pending);

  AttendanceReportSummary rejected(int rejected);

  AttendanceReportSummary notMarked(int notMarked);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AttendanceReportSummary(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AttendanceReportSummary(...).copyWith(id: 12, name: "My name")
  /// ````
  AttendanceReportSummary call({
    int present,
    int absent,
    int halfDay,
    int leave,
    int onDuty,
    int weeklyOff,
    int holiday,
    int pending,
    int rejected,
    int notMarked,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAttendanceReportSummary.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAttendanceReportSummary.copyWith.fieldName(...)`
class _$AttendanceReportSummaryCWProxyImpl
    implements _$AttendanceReportSummaryCWProxy {
  const _$AttendanceReportSummaryCWProxyImpl(this._value);

  final AttendanceReportSummary _value;

  @override
  AttendanceReportSummary present(int present) => this(present: present);

  @override
  AttendanceReportSummary absent(int absent) => this(absent: absent);

  @override
  AttendanceReportSummary halfDay(int halfDay) => this(halfDay: halfDay);

  @override
  AttendanceReportSummary leave(int leave) => this(leave: leave);

  @override
  AttendanceReportSummary onDuty(int onDuty) => this(onDuty: onDuty);

  @override
  AttendanceReportSummary weeklyOff(int weeklyOff) =>
      this(weeklyOff: weeklyOff);

  @override
  AttendanceReportSummary holiday(int holiday) => this(holiday: holiday);

  @override
  AttendanceReportSummary pending(int pending) => this(pending: pending);

  @override
  AttendanceReportSummary rejected(int rejected) => this(rejected: rejected);

  @override
  AttendanceReportSummary notMarked(int notMarked) =>
      this(notMarked: notMarked);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AttendanceReportSummary(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AttendanceReportSummary(...).copyWith(id: 12, name: "My name")
  /// ````
  AttendanceReportSummary call({
    Object? present = const $CopyWithPlaceholder(),
    Object? absent = const $CopyWithPlaceholder(),
    Object? halfDay = const $CopyWithPlaceholder(),
    Object? leave = const $CopyWithPlaceholder(),
    Object? onDuty = const $CopyWithPlaceholder(),
    Object? weeklyOff = const $CopyWithPlaceholder(),
    Object? holiday = const $CopyWithPlaceholder(),
    Object? pending = const $CopyWithPlaceholder(),
    Object? rejected = const $CopyWithPlaceholder(),
    Object? notMarked = const $CopyWithPlaceholder(),
  }) {
    return AttendanceReportSummary(
      present: present == const $CopyWithPlaceholder()
          ? _value.present
          // ignore: cast_nullable_to_non_nullable
          : present as int,
      absent: absent == const $CopyWithPlaceholder()
          ? _value.absent
          // ignore: cast_nullable_to_non_nullable
          : absent as int,
      halfDay: halfDay == const $CopyWithPlaceholder()
          ? _value.halfDay
          // ignore: cast_nullable_to_non_nullable
          : halfDay as int,
      leave: leave == const $CopyWithPlaceholder()
          ? _value.leave
          // ignore: cast_nullable_to_non_nullable
          : leave as int,
      onDuty: onDuty == const $CopyWithPlaceholder()
          ? _value.onDuty
          // ignore: cast_nullable_to_non_nullable
          : onDuty as int,
      weeklyOff: weeklyOff == const $CopyWithPlaceholder()
          ? _value.weeklyOff
          // ignore: cast_nullable_to_non_nullable
          : weeklyOff as int,
      holiday: holiday == const $CopyWithPlaceholder()
          ? _value.holiday
          // ignore: cast_nullable_to_non_nullable
          : holiday as int,
      pending: pending == const $CopyWithPlaceholder()
          ? _value.pending
          // ignore: cast_nullable_to_non_nullable
          : pending as int,
      rejected: rejected == const $CopyWithPlaceholder()
          ? _value.rejected
          // ignore: cast_nullable_to_non_nullable
          : rejected as int,
      notMarked: notMarked == const $CopyWithPlaceholder()
          ? _value.notMarked
          // ignore: cast_nullable_to_non_nullable
          : notMarked as int,
    );
  }
}

extension $AttendanceReportSummaryCopyWith on AttendanceReportSummary {
  /// Returns a callable class that can be used as follows: `instanceOfAttendanceReportSummary.copyWith(...)` or like so:`instanceOfAttendanceReportSummary.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AttendanceReportSummaryCWProxy get copyWith =>
      _$AttendanceReportSummaryCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceReportSummary _$AttendanceReportSummaryFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AttendanceReportSummary', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'present',
      'absent',
      'halfDay',
      'leave',
      'onDuty',
      'weeklyOff',
      'holiday',
      'pending',
      'rejected',
      'notMarked',
    ],
  );
  final val = AttendanceReportSummary(
    present: $checkedConvert('present', (v) => (v as num).toInt()),
    absent: $checkedConvert('absent', (v) => (v as num).toInt()),
    halfDay: $checkedConvert('halfDay', (v) => (v as num).toInt()),
    leave: $checkedConvert('leave', (v) => (v as num).toInt()),
    onDuty: $checkedConvert('onDuty', (v) => (v as num).toInt()),
    weeklyOff: $checkedConvert('weeklyOff', (v) => (v as num).toInt()),
    holiday: $checkedConvert('holiday', (v) => (v as num).toInt()),
    pending: $checkedConvert('pending', (v) => (v as num).toInt()),
    rejected: $checkedConvert('rejected', (v) => (v as num).toInt()),
    notMarked: $checkedConvert('notMarked', (v) => (v as num).toInt()),
  );
  return val;
});

Map<String, dynamic> _$AttendanceReportSummaryToJson(
  AttendanceReportSummary instance,
) => <String, dynamic>{
  'present': instance.present,
  'absent': instance.absent,
  'halfDay': instance.halfDay,
  'leave': instance.leave,
  'onDuty': instance.onDuty,
  'weeklyOff': instance.weeklyOff,
  'holiday': instance.holiday,
  'pending': instance.pending,
  'rejected': instance.rejected,
  'notMarked': instance.notMarked,
};
