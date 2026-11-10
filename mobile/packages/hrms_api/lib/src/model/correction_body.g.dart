// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'correction_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CorrectionBodyCWProxy {
  CorrectionBody employeeId(String employeeId);

  CorrectionBody date(String date);

  CorrectionBody status(AttendanceStatus status);

  CorrectionBody note(String? note);

  CorrectionBody reason(String reason);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CorrectionBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CorrectionBody(...).copyWith(id: 12, name: "My name")
  /// ````
  CorrectionBody call({
    String employeeId,
    String date,
    AttendanceStatus status,
    String? note,
    String reason,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCorrectionBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCorrectionBody.copyWith.fieldName(...)`
class _$CorrectionBodyCWProxyImpl implements _$CorrectionBodyCWProxy {
  const _$CorrectionBodyCWProxyImpl(this._value);

  final CorrectionBody _value;

  @override
  CorrectionBody employeeId(String employeeId) => this(employeeId: employeeId);

  @override
  CorrectionBody date(String date) => this(date: date);

  @override
  CorrectionBody status(AttendanceStatus status) => this(status: status);

  @override
  CorrectionBody note(String? note) => this(note: note);

  @override
  CorrectionBody reason(String reason) => this(reason: reason);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CorrectionBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CorrectionBody(...).copyWith(id: 12, name: "My name")
  /// ````
  CorrectionBody call({
    Object? employeeId = const $CopyWithPlaceholder(),
    Object? date = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? note = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
  }) {
    return CorrectionBody(
      employeeId: employeeId == const $CopyWithPlaceholder()
          ? _value.employeeId
          // ignore: cast_nullable_to_non_nullable
          : employeeId as String,
      date: date == const $CopyWithPlaceholder()
          ? _value.date
          // ignore: cast_nullable_to_non_nullable
          : date as String,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as AttendanceStatus,
      note: note == const $CopyWithPlaceholder()
          ? _value.note
          // ignore: cast_nullable_to_non_nullable
          : note as String?,
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String,
    );
  }
}

extension $CorrectionBodyCopyWith on CorrectionBody {
  /// Returns a callable class that can be used as follows: `instanceOfCorrectionBody.copyWith(...)` or like so:`instanceOfCorrectionBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CorrectionBodyCWProxy get copyWith => _$CorrectionBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CorrectionBody _$CorrectionBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CorrectionBody', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['employeeId', 'date', 'status', 'reason'],
      );
      final val = CorrectionBody(
        employeeId: $checkedConvert('employeeId', (v) => v as String),
        date: $checkedConvert('date', (v) => v as String),
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(_$AttendanceStatusEnumMap, v),
        ),
        note: $checkedConvert('note', (v) => v as String?),
        reason: $checkedConvert('reason', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$CorrectionBodyToJson(CorrectionBody instance) =>
    <String, dynamic>{
      'employeeId': instance.employeeId,
      'date': instance.date,
      'status': _$AttendanceStatusEnumMap[instance.status]!,
      'note': ?instance.note,
      'reason': instance.reason,
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
