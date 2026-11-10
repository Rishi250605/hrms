// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_report_legend_inner.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AttendanceReportLegendInnerCWProxy {
  AttendanceReportLegendInner code(String code);

  AttendanceReportLegendInner label(String label);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AttendanceReportLegendInner(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AttendanceReportLegendInner(...).copyWith(id: 12, name: "My name")
  /// ````
  AttendanceReportLegendInner call({String code, String label});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAttendanceReportLegendInner.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAttendanceReportLegendInner.copyWith.fieldName(...)`
class _$AttendanceReportLegendInnerCWProxyImpl
    implements _$AttendanceReportLegendInnerCWProxy {
  const _$AttendanceReportLegendInnerCWProxyImpl(this._value);

  final AttendanceReportLegendInner _value;

  @override
  AttendanceReportLegendInner code(String code) => this(code: code);

  @override
  AttendanceReportLegendInner label(String label) => this(label: label);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AttendanceReportLegendInner(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AttendanceReportLegendInner(...).copyWith(id: 12, name: "My name")
  /// ````
  AttendanceReportLegendInner call({
    Object? code = const $CopyWithPlaceholder(),
    Object? label = const $CopyWithPlaceholder(),
  }) {
    return AttendanceReportLegendInner(
      code: code == const $CopyWithPlaceholder()
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String,
      label: label == const $CopyWithPlaceholder()
          ? _value.label
          // ignore: cast_nullable_to_non_nullable
          : label as String,
    );
  }
}

extension $AttendanceReportLegendInnerCopyWith on AttendanceReportLegendInner {
  /// Returns a callable class that can be used as follows: `instanceOfAttendanceReportLegendInner.copyWith(...)` or like so:`instanceOfAttendanceReportLegendInner.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AttendanceReportLegendInnerCWProxy get copyWith =>
      _$AttendanceReportLegendInnerCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceReportLegendInner _$AttendanceReportLegendInnerFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AttendanceReportLegendInner', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['code', 'label']);
  final val = AttendanceReportLegendInner(
    code: $checkedConvert('code', (v) => v as String),
    label: $checkedConvert('label', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$AttendanceReportLegendInnerToJson(
  AttendanceReportLegendInner instance,
) => <String, dynamic>{'code': instance.code, 'label': instance.label};
