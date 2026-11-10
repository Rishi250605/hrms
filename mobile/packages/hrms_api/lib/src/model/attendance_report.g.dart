// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_report.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AttendanceReportCWProxy {
  AttendanceReport from(String from);

  AttendanceReport to(String to);

  AttendanceReport days(List<String> days);

  AttendanceReport businessUnits(List<BusinessUnitRef> businessUnits);

  AttendanceReport legend(List<AttendanceReportLegendInner> legend);

  AttendanceReport rows(List<AttendanceReportRowsInner> rows);

  AttendanceReport generatedAt(DateTime generatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AttendanceReport(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AttendanceReport(...).copyWith(id: 12, name: "My name")
  /// ````
  AttendanceReport call({
    String from,
    String to,
    List<String> days,
    List<BusinessUnitRef> businessUnits,
    List<AttendanceReportLegendInner> legend,
    List<AttendanceReportRowsInner> rows,
    DateTime generatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAttendanceReport.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAttendanceReport.copyWith.fieldName(...)`
class _$AttendanceReportCWProxyImpl implements _$AttendanceReportCWProxy {
  const _$AttendanceReportCWProxyImpl(this._value);

  final AttendanceReport _value;

  @override
  AttendanceReport from(String from) => this(from: from);

  @override
  AttendanceReport to(String to) => this(to: to);

  @override
  AttendanceReport days(List<String> days) => this(days: days);

  @override
  AttendanceReport businessUnits(List<BusinessUnitRef> businessUnits) =>
      this(businessUnits: businessUnits);

  @override
  AttendanceReport legend(List<AttendanceReportLegendInner> legend) =>
      this(legend: legend);

  @override
  AttendanceReport rows(List<AttendanceReportRowsInner> rows) =>
      this(rows: rows);

  @override
  AttendanceReport generatedAt(DateTime generatedAt) =>
      this(generatedAt: generatedAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AttendanceReport(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AttendanceReport(...).copyWith(id: 12, name: "My name")
  /// ````
  AttendanceReport call({
    Object? from = const $CopyWithPlaceholder(),
    Object? to = const $CopyWithPlaceholder(),
    Object? days = const $CopyWithPlaceholder(),
    Object? businessUnits = const $CopyWithPlaceholder(),
    Object? legend = const $CopyWithPlaceholder(),
    Object? rows = const $CopyWithPlaceholder(),
    Object? generatedAt = const $CopyWithPlaceholder(),
  }) {
    return AttendanceReport(
      from: from == const $CopyWithPlaceholder()
          ? _value.from
          // ignore: cast_nullable_to_non_nullable
          : from as String,
      to: to == const $CopyWithPlaceholder()
          ? _value.to
          // ignore: cast_nullable_to_non_nullable
          : to as String,
      days: days == const $CopyWithPlaceholder()
          ? _value.days
          // ignore: cast_nullable_to_non_nullable
          : days as List<String>,
      businessUnits: businessUnits == const $CopyWithPlaceholder()
          ? _value.businessUnits
          // ignore: cast_nullable_to_non_nullable
          : businessUnits as List<BusinessUnitRef>,
      legend: legend == const $CopyWithPlaceholder()
          ? _value.legend
          // ignore: cast_nullable_to_non_nullable
          : legend as List<AttendanceReportLegendInner>,
      rows: rows == const $CopyWithPlaceholder()
          ? _value.rows
          // ignore: cast_nullable_to_non_nullable
          : rows as List<AttendanceReportRowsInner>,
      generatedAt: generatedAt == const $CopyWithPlaceholder()
          ? _value.generatedAt
          // ignore: cast_nullable_to_non_nullable
          : generatedAt as DateTime,
    );
  }
}

extension $AttendanceReportCopyWith on AttendanceReport {
  /// Returns a callable class that can be used as follows: `instanceOfAttendanceReport.copyWith(...)` or like so:`instanceOfAttendanceReport.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AttendanceReportCWProxy get copyWith => _$AttendanceReportCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceReport _$AttendanceReportFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AttendanceReport', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'from',
      'to',
      'days',
      'businessUnits',
      'legend',
      'rows',
      'generatedAt',
    ],
  );
  final val = AttendanceReport(
    from: $checkedConvert('from', (v) => v as String),
    to: $checkedConvert('to', (v) => v as String),
    days: $checkedConvert(
      'days',
      (v) => (v as List<dynamic>).map((e) => e as String).toList(),
    ),
    businessUnits: $checkedConvert(
      'businessUnits',
      (v) => (v as List<dynamic>)
          .map((e) => BusinessUnitRef.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    legend: $checkedConvert(
      'legend',
      (v) => (v as List<dynamic>)
          .map(
            (e) =>
                AttendanceReportLegendInner.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    ),
    rows: $checkedConvert(
      'rows',
      (v) => (v as List<dynamic>)
          .map(
            (e) =>
                AttendanceReportRowsInner.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    ),
    generatedAt: $checkedConvert(
      'generatedAt',
      (v) => DateTime.parse(v as String),
    ),
  );
  return val;
});

Map<String, dynamic> _$AttendanceReportToJson(AttendanceReport instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'days': instance.days,
      'businessUnits': instance.businessUnits.map((e) => e.toJson()).toList(),
      'legend': instance.legend.map((e) => e.toJson()).toList(),
      'rows': instance.rows.map((e) => e.toJson()).toList(),
      'generatedAt': instance.generatedAt.toIso8601String(),
    };
