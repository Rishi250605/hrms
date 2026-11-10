// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bulk_attendance_result.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BulkAttendanceResultCWProxy {
  BulkAttendanceResult applied(int applied);

  BulkAttendanceResult duplicates(int duplicates);

  BulkAttendanceResult rejected(int rejected);

  BulkAttendanceResult results(List<BulkResultItem> results);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BulkAttendanceResult(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BulkAttendanceResult(...).copyWith(id: 12, name: "My name")
  /// ````
  BulkAttendanceResult call({
    int applied,
    int duplicates,
    int rejected,
    List<BulkResultItem> results,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBulkAttendanceResult.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBulkAttendanceResult.copyWith.fieldName(...)`
class _$BulkAttendanceResultCWProxyImpl
    implements _$BulkAttendanceResultCWProxy {
  const _$BulkAttendanceResultCWProxyImpl(this._value);

  final BulkAttendanceResult _value;

  @override
  BulkAttendanceResult applied(int applied) => this(applied: applied);

  @override
  BulkAttendanceResult duplicates(int duplicates) =>
      this(duplicates: duplicates);

  @override
  BulkAttendanceResult rejected(int rejected) => this(rejected: rejected);

  @override
  BulkAttendanceResult results(List<BulkResultItem> results) =>
      this(results: results);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BulkAttendanceResult(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BulkAttendanceResult(...).copyWith(id: 12, name: "My name")
  /// ````
  BulkAttendanceResult call({
    Object? applied = const $CopyWithPlaceholder(),
    Object? duplicates = const $CopyWithPlaceholder(),
    Object? rejected = const $CopyWithPlaceholder(),
    Object? results = const $CopyWithPlaceholder(),
  }) {
    return BulkAttendanceResult(
      applied: applied == const $CopyWithPlaceholder()
          ? _value.applied
          // ignore: cast_nullable_to_non_nullable
          : applied as int,
      duplicates: duplicates == const $CopyWithPlaceholder()
          ? _value.duplicates
          // ignore: cast_nullable_to_non_nullable
          : duplicates as int,
      rejected: rejected == const $CopyWithPlaceholder()
          ? _value.rejected
          // ignore: cast_nullable_to_non_nullable
          : rejected as int,
      results: results == const $CopyWithPlaceholder()
          ? _value.results
          // ignore: cast_nullable_to_non_nullable
          : results as List<BulkResultItem>,
    );
  }
}

extension $BulkAttendanceResultCopyWith on BulkAttendanceResult {
  /// Returns a callable class that can be used as follows: `instanceOfBulkAttendanceResult.copyWith(...)` or like so:`instanceOfBulkAttendanceResult.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BulkAttendanceResultCWProxy get copyWith =>
      _$BulkAttendanceResultCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BulkAttendanceResult _$BulkAttendanceResultFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BulkAttendanceResult', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['applied', 'duplicates', 'rejected', 'results'],
  );
  final val = BulkAttendanceResult(
    applied: $checkedConvert('applied', (v) => (v as num).toInt()),
    duplicates: $checkedConvert('duplicates', (v) => (v as num).toInt()),
    rejected: $checkedConvert('rejected', (v) => (v as num).toInt()),
    results: $checkedConvert(
      'results',
      (v) => (v as List<dynamic>)
          .map((e) => BulkResultItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$BulkAttendanceResultToJson(
  BulkAttendanceResult instance,
) => <String, dynamic>{
  'applied': instance.applied,
  'duplicates': instance.duplicates,
  'rejected': instance.rejected,
  'results': instance.results.map((e) => e.toJson()).toList(),
};
