// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roster_copy_result_skipped_inner.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RosterCopyResultSkippedInnerCWProxy {
  RosterCopyResultSkippedInner date(String date);

  RosterCopyResultSkippedInner employeeId(String employeeId);

  RosterCopyResultSkippedInner employeeName(String employeeName);

  RosterCopyResultSkippedInner reason(String reason);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RosterCopyResultSkippedInner(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RosterCopyResultSkippedInner(...).copyWith(id: 12, name: "My name")
  /// ````
  RosterCopyResultSkippedInner call({
    String date,
    String employeeId,
    String employeeName,
    String reason,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRosterCopyResultSkippedInner.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRosterCopyResultSkippedInner.copyWith.fieldName(...)`
class _$RosterCopyResultSkippedInnerCWProxyImpl
    implements _$RosterCopyResultSkippedInnerCWProxy {
  const _$RosterCopyResultSkippedInnerCWProxyImpl(this._value);

  final RosterCopyResultSkippedInner _value;

  @override
  RosterCopyResultSkippedInner date(String date) => this(date: date);

  @override
  RosterCopyResultSkippedInner employeeId(String employeeId) =>
      this(employeeId: employeeId);

  @override
  RosterCopyResultSkippedInner employeeName(String employeeName) =>
      this(employeeName: employeeName);

  @override
  RosterCopyResultSkippedInner reason(String reason) => this(reason: reason);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RosterCopyResultSkippedInner(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RosterCopyResultSkippedInner(...).copyWith(id: 12, name: "My name")
  /// ````
  RosterCopyResultSkippedInner call({
    Object? date = const $CopyWithPlaceholder(),
    Object? employeeId = const $CopyWithPlaceholder(),
    Object? employeeName = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
  }) {
    return RosterCopyResultSkippedInner(
      date: date == const $CopyWithPlaceholder()
          ? _value.date
          // ignore: cast_nullable_to_non_nullable
          : date as String,
      employeeId: employeeId == const $CopyWithPlaceholder()
          ? _value.employeeId
          // ignore: cast_nullable_to_non_nullable
          : employeeId as String,
      employeeName: employeeName == const $CopyWithPlaceholder()
          ? _value.employeeName
          // ignore: cast_nullable_to_non_nullable
          : employeeName as String,
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String,
    );
  }
}

extension $RosterCopyResultSkippedInnerCopyWith
    on RosterCopyResultSkippedInner {
  /// Returns a callable class that can be used as follows: `instanceOfRosterCopyResultSkippedInner.copyWith(...)` or like so:`instanceOfRosterCopyResultSkippedInner.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RosterCopyResultSkippedInnerCWProxy get copyWith =>
      _$RosterCopyResultSkippedInnerCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RosterCopyResultSkippedInner _$RosterCopyResultSkippedInnerFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('RosterCopyResultSkippedInner', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['date', 'employeeId', 'employeeName', 'reason'],
  );
  final val = RosterCopyResultSkippedInner(
    date: $checkedConvert('date', (v) => v as String),
    employeeId: $checkedConvert('employeeId', (v) => v as String),
    employeeName: $checkedConvert('employeeName', (v) => v as String),
    reason: $checkedConvert('reason', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$RosterCopyResultSkippedInnerToJson(
  RosterCopyResultSkippedInner instance,
) => <String, dynamic>{
  'date': instance.date,
  'employeeId': instance.employeeId,
  'employeeName': instance.employeeName,
  'reason': instance.reason,
};
