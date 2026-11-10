// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_attendance_day_summary.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TeamAttendanceDaySummaryCWProxy {
  TeamAttendanceDaySummary employees(int employees);

  TeamAttendanceDaySummary marked(int marked);

  TeamAttendanceDaySummary pending(int pending);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TeamAttendanceDaySummary(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TeamAttendanceDaySummary(...).copyWith(id: 12, name: "My name")
  /// ````
  TeamAttendanceDaySummary call({int employees, int marked, int pending});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTeamAttendanceDaySummary.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTeamAttendanceDaySummary.copyWith.fieldName(...)`
class _$TeamAttendanceDaySummaryCWProxyImpl
    implements _$TeamAttendanceDaySummaryCWProxy {
  const _$TeamAttendanceDaySummaryCWProxyImpl(this._value);

  final TeamAttendanceDaySummary _value;

  @override
  TeamAttendanceDaySummary employees(int employees) =>
      this(employees: employees);

  @override
  TeamAttendanceDaySummary marked(int marked) => this(marked: marked);

  @override
  TeamAttendanceDaySummary pending(int pending) => this(pending: pending);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TeamAttendanceDaySummary(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TeamAttendanceDaySummary(...).copyWith(id: 12, name: "My name")
  /// ````
  TeamAttendanceDaySummary call({
    Object? employees = const $CopyWithPlaceholder(),
    Object? marked = const $CopyWithPlaceholder(),
    Object? pending = const $CopyWithPlaceholder(),
  }) {
    return TeamAttendanceDaySummary(
      employees: employees == const $CopyWithPlaceholder()
          ? _value.employees
          // ignore: cast_nullable_to_non_nullable
          : employees as int,
      marked: marked == const $CopyWithPlaceholder()
          ? _value.marked
          // ignore: cast_nullable_to_non_nullable
          : marked as int,
      pending: pending == const $CopyWithPlaceholder()
          ? _value.pending
          // ignore: cast_nullable_to_non_nullable
          : pending as int,
    );
  }
}

extension $TeamAttendanceDaySummaryCopyWith on TeamAttendanceDaySummary {
  /// Returns a callable class that can be used as follows: `instanceOfTeamAttendanceDaySummary.copyWith(...)` or like so:`instanceOfTeamAttendanceDaySummary.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TeamAttendanceDaySummaryCWProxy get copyWith =>
      _$TeamAttendanceDaySummaryCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamAttendanceDaySummary _$TeamAttendanceDaySummaryFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('TeamAttendanceDaySummary', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['employees', 'marked', 'pending']);
  final val = TeamAttendanceDaySummary(
    employees: $checkedConvert('employees', (v) => (v as num).toInt()),
    marked: $checkedConvert('marked', (v) => (v as num).toInt()),
    pending: $checkedConvert('pending', (v) => (v as num).toInt()),
  );
  return val;
});

Map<String, dynamic> _$TeamAttendanceDaySummaryToJson(
  TeamAttendanceDaySummary instance,
) => <String, dynamic>{
  'employees': instance.employees,
  'marked': instance.marked,
  'pending': instance.pending,
};
