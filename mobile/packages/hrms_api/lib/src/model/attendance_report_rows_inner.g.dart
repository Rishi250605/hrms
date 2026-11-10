// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_report_rows_inner.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AttendanceReportRowsInnerCWProxy {
  AttendanceReportRowsInner employee(PayslipItemEmployee employee);

  AttendanceReportRowsInner businessUnitCode(String? businessUnitCode);

  AttendanceReportRowsInner codes(List<String> codes);

  AttendanceReportRowsInner summary(AttendanceReportSummary summary);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AttendanceReportRowsInner(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AttendanceReportRowsInner(...).copyWith(id: 12, name: "My name")
  /// ````
  AttendanceReportRowsInner call({
    PayslipItemEmployee employee,
    String? businessUnitCode,
    List<String> codes,
    AttendanceReportSummary summary,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAttendanceReportRowsInner.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAttendanceReportRowsInner.copyWith.fieldName(...)`
class _$AttendanceReportRowsInnerCWProxyImpl
    implements _$AttendanceReportRowsInnerCWProxy {
  const _$AttendanceReportRowsInnerCWProxyImpl(this._value);

  final AttendanceReportRowsInner _value;

  @override
  AttendanceReportRowsInner employee(PayslipItemEmployee employee) =>
      this(employee: employee);

  @override
  AttendanceReportRowsInner businessUnitCode(String? businessUnitCode) =>
      this(businessUnitCode: businessUnitCode);

  @override
  AttendanceReportRowsInner codes(List<String> codes) => this(codes: codes);

  @override
  AttendanceReportRowsInner summary(AttendanceReportSummary summary) =>
      this(summary: summary);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AttendanceReportRowsInner(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AttendanceReportRowsInner(...).copyWith(id: 12, name: "My name")
  /// ````
  AttendanceReportRowsInner call({
    Object? employee = const $CopyWithPlaceholder(),
    Object? businessUnitCode = const $CopyWithPlaceholder(),
    Object? codes = const $CopyWithPlaceholder(),
    Object? summary = const $CopyWithPlaceholder(),
  }) {
    return AttendanceReportRowsInner(
      employee: employee == const $CopyWithPlaceholder()
          ? _value.employee
          // ignore: cast_nullable_to_non_nullable
          : employee as PayslipItemEmployee,
      businessUnitCode: businessUnitCode == const $CopyWithPlaceholder()
          ? _value.businessUnitCode
          // ignore: cast_nullable_to_non_nullable
          : businessUnitCode as String?,
      codes: codes == const $CopyWithPlaceholder()
          ? _value.codes
          // ignore: cast_nullable_to_non_nullable
          : codes as List<String>,
      summary: summary == const $CopyWithPlaceholder()
          ? _value.summary
          // ignore: cast_nullable_to_non_nullable
          : summary as AttendanceReportSummary,
    );
  }
}

extension $AttendanceReportRowsInnerCopyWith on AttendanceReportRowsInner {
  /// Returns a callable class that can be used as follows: `instanceOfAttendanceReportRowsInner.copyWith(...)` or like so:`instanceOfAttendanceReportRowsInner.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AttendanceReportRowsInnerCWProxy get copyWith =>
      _$AttendanceReportRowsInnerCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceReportRowsInner _$AttendanceReportRowsInnerFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AttendanceReportRowsInner', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['employee', 'businessUnitCode', 'codes', 'summary'],
  );
  final val = AttendanceReportRowsInner(
    employee: $checkedConvert(
      'employee',
      (v) => PayslipItemEmployee.fromJson(v as Map<String, dynamic>),
    ),
    businessUnitCode: $checkedConvert('businessUnitCode', (v) => v as String?),
    codes: $checkedConvert(
      'codes',
      (v) => (v as List<dynamic>).map((e) => e as String).toList(),
    ),
    summary: $checkedConvert(
      'summary',
      (v) => AttendanceReportSummary.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$AttendanceReportRowsInnerToJson(
  AttendanceReportRowsInner instance,
) => <String, dynamic>{
  'employee': instance.employee.toJson(),
  'businessUnitCode': instance.businessUnitCode,
  'codes': instance.codes,
  'summary': instance.summary.toJson(),
};
