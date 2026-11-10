// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_attendance_day.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TeamAttendanceDayCWProxy {
  TeamAttendanceDay date(String date);

  TeamAttendanceDay editable(bool editable);

  TeamAttendanceDay editableUntil(DateTime editableUntil);

  TeamAttendanceDay summary(TeamAttendanceDaySummary summary);

  TeamAttendanceDay rows(List<TeamAttendanceRow> rows);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TeamAttendanceDay(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TeamAttendanceDay(...).copyWith(id: 12, name: "My name")
  /// ````
  TeamAttendanceDay call({
    String date,
    bool editable,
    DateTime editableUntil,
    TeamAttendanceDaySummary summary,
    List<TeamAttendanceRow> rows,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTeamAttendanceDay.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTeamAttendanceDay.copyWith.fieldName(...)`
class _$TeamAttendanceDayCWProxyImpl implements _$TeamAttendanceDayCWProxy {
  const _$TeamAttendanceDayCWProxyImpl(this._value);

  final TeamAttendanceDay _value;

  @override
  TeamAttendanceDay date(String date) => this(date: date);

  @override
  TeamAttendanceDay editable(bool editable) => this(editable: editable);

  @override
  TeamAttendanceDay editableUntil(DateTime editableUntil) =>
      this(editableUntil: editableUntil);

  @override
  TeamAttendanceDay summary(TeamAttendanceDaySummary summary) =>
      this(summary: summary);

  @override
  TeamAttendanceDay rows(List<TeamAttendanceRow> rows) => this(rows: rows);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TeamAttendanceDay(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TeamAttendanceDay(...).copyWith(id: 12, name: "My name")
  /// ````
  TeamAttendanceDay call({
    Object? date = const $CopyWithPlaceholder(),
    Object? editable = const $CopyWithPlaceholder(),
    Object? editableUntil = const $CopyWithPlaceholder(),
    Object? summary = const $CopyWithPlaceholder(),
    Object? rows = const $CopyWithPlaceholder(),
  }) {
    return TeamAttendanceDay(
      date: date == const $CopyWithPlaceholder()
          ? _value.date
          // ignore: cast_nullable_to_non_nullable
          : date as String,
      editable: editable == const $CopyWithPlaceholder()
          ? _value.editable
          // ignore: cast_nullable_to_non_nullable
          : editable as bool,
      editableUntil: editableUntil == const $CopyWithPlaceholder()
          ? _value.editableUntil
          // ignore: cast_nullable_to_non_nullable
          : editableUntil as DateTime,
      summary: summary == const $CopyWithPlaceholder()
          ? _value.summary
          // ignore: cast_nullable_to_non_nullable
          : summary as TeamAttendanceDaySummary,
      rows: rows == const $CopyWithPlaceholder()
          ? _value.rows
          // ignore: cast_nullable_to_non_nullable
          : rows as List<TeamAttendanceRow>,
    );
  }
}

extension $TeamAttendanceDayCopyWith on TeamAttendanceDay {
  /// Returns a callable class that can be used as follows: `instanceOfTeamAttendanceDay.copyWith(...)` or like so:`instanceOfTeamAttendanceDay.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TeamAttendanceDayCWProxy get copyWith =>
      _$TeamAttendanceDayCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamAttendanceDay _$TeamAttendanceDayFromJson(Map<String, dynamic> json) =>
    $checkedCreate('TeamAttendanceDay', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'date',
          'editable',
          'editableUntil',
          'summary',
          'rows',
        ],
      );
      final val = TeamAttendanceDay(
        date: $checkedConvert('date', (v) => v as String),
        editable: $checkedConvert('editable', (v) => v as bool),
        editableUntil: $checkedConvert(
          'editableUntil',
          (v) => DateTime.parse(v as String),
        ),
        summary: $checkedConvert(
          'summary',
          (v) => TeamAttendanceDaySummary.fromJson(v as Map<String, dynamic>),
        ),
        rows: $checkedConvert(
          'rows',
          (v) => (v as List<dynamic>)
              .map((e) => TeamAttendanceRow.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$TeamAttendanceDayToJson(TeamAttendanceDay instance) =>
    <String, dynamic>{
      'date': instance.date,
      'editable': instance.editable,
      'editableUntil': instance.editableUntil.toIso8601String(),
      'summary': instance.summary.toJson(),
      'rows': instance.rows.map((e) => e.toJson()).toList(),
    };
