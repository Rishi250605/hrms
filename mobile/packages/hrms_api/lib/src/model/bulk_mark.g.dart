// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bulk_mark.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BulkMarkCWProxy {
  BulkMark clientMutationId(String clientMutationId);

  BulkMark employeeId(String employeeId);

  BulkMark date(String date);

  BulkMark status(AttendanceStatus status);

  BulkMark dutyAssignmentId(String? dutyAssignmentId);

  BulkMark note(String? note);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BulkMark(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BulkMark(...).copyWith(id: 12, name: "My name")
  /// ````
  BulkMark call({
    String clientMutationId,
    String employeeId,
    String date,
    AttendanceStatus status,
    String? dutyAssignmentId,
    String? note,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBulkMark.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBulkMark.copyWith.fieldName(...)`
class _$BulkMarkCWProxyImpl implements _$BulkMarkCWProxy {
  const _$BulkMarkCWProxyImpl(this._value);

  final BulkMark _value;

  @override
  BulkMark clientMutationId(String clientMutationId) =>
      this(clientMutationId: clientMutationId);

  @override
  BulkMark employeeId(String employeeId) => this(employeeId: employeeId);

  @override
  BulkMark date(String date) => this(date: date);

  @override
  BulkMark status(AttendanceStatus status) => this(status: status);

  @override
  BulkMark dutyAssignmentId(String? dutyAssignmentId) =>
      this(dutyAssignmentId: dutyAssignmentId);

  @override
  BulkMark note(String? note) => this(note: note);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BulkMark(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BulkMark(...).copyWith(id: 12, name: "My name")
  /// ````
  BulkMark call({
    Object? clientMutationId = const $CopyWithPlaceholder(),
    Object? employeeId = const $CopyWithPlaceholder(),
    Object? date = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? dutyAssignmentId = const $CopyWithPlaceholder(),
    Object? note = const $CopyWithPlaceholder(),
  }) {
    return BulkMark(
      clientMutationId: clientMutationId == const $CopyWithPlaceholder()
          ? _value.clientMutationId
          // ignore: cast_nullable_to_non_nullable
          : clientMutationId as String,
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
      dutyAssignmentId: dutyAssignmentId == const $CopyWithPlaceholder()
          ? _value.dutyAssignmentId
          // ignore: cast_nullable_to_non_nullable
          : dutyAssignmentId as String?,
      note: note == const $CopyWithPlaceholder()
          ? _value.note
          // ignore: cast_nullable_to_non_nullable
          : note as String?,
    );
  }
}

extension $BulkMarkCopyWith on BulkMark {
  /// Returns a callable class that can be used as follows: `instanceOfBulkMark.copyWith(...)` or like so:`instanceOfBulkMark.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BulkMarkCWProxy get copyWith => _$BulkMarkCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BulkMark _$BulkMarkFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BulkMark', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['clientMutationId', 'employeeId', 'date', 'status'],
  );
  final val = BulkMark(
    clientMutationId: $checkedConvert('clientMutationId', (v) => v as String),
    employeeId: $checkedConvert('employeeId', (v) => v as String),
    date: $checkedConvert('date', (v) => v as String),
    status: $checkedConvert(
      'status',
      (v) => $enumDecode(_$AttendanceStatusEnumMap, v),
    ),
    dutyAssignmentId: $checkedConvert('dutyAssignmentId', (v) => v as String?),
    note: $checkedConvert('note', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$BulkMarkToJson(BulkMark instance) => <String, dynamic>{
  'clientMutationId': instance.clientMutationId,
  'employeeId': instance.employeeId,
  'date': instance.date,
  'status': _$AttendanceStatusEnumMap[instance.status]!,
  'dutyAssignmentId': ?instance.dutyAssignmentId,
  'note': ?instance.note,
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
