// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bulk_approve_result.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BulkApproveResultCWProxy {
  BulkApproveResult approved(List<String> approved);

  BulkApproveResult skipped(List<BulkApproveResultSkippedInner> skipped);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BulkApproveResult(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BulkApproveResult(...).copyWith(id: 12, name: "My name")
  /// ````
  BulkApproveResult call({
    List<String> approved,
    List<BulkApproveResultSkippedInner> skipped,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBulkApproveResult.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBulkApproveResult.copyWith.fieldName(...)`
class _$BulkApproveResultCWProxyImpl implements _$BulkApproveResultCWProxy {
  const _$BulkApproveResultCWProxyImpl(this._value);

  final BulkApproveResult _value;

  @override
  BulkApproveResult approved(List<String> approved) => this(approved: approved);

  @override
  BulkApproveResult skipped(List<BulkApproveResultSkippedInner> skipped) =>
      this(skipped: skipped);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BulkApproveResult(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BulkApproveResult(...).copyWith(id: 12, name: "My name")
  /// ````
  BulkApproveResult call({
    Object? approved = const $CopyWithPlaceholder(),
    Object? skipped = const $CopyWithPlaceholder(),
  }) {
    return BulkApproveResult(
      approved: approved == const $CopyWithPlaceholder()
          ? _value.approved
          // ignore: cast_nullable_to_non_nullable
          : approved as List<String>,
      skipped: skipped == const $CopyWithPlaceholder()
          ? _value.skipped
          // ignore: cast_nullable_to_non_nullable
          : skipped as List<BulkApproveResultSkippedInner>,
    );
  }
}

extension $BulkApproveResultCopyWith on BulkApproveResult {
  /// Returns a callable class that can be used as follows: `instanceOfBulkApproveResult.copyWith(...)` or like so:`instanceOfBulkApproveResult.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BulkApproveResultCWProxy get copyWith =>
      _$BulkApproveResultCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BulkApproveResult _$BulkApproveResultFromJson(Map<String, dynamic> json) =>
    $checkedCreate('BulkApproveResult', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['approved', 'skipped']);
      final val = BulkApproveResult(
        approved: $checkedConvert(
          'approved',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
        skipped: $checkedConvert(
          'skipped',
          (v) => (v as List<dynamic>)
              .map(
                (e) => BulkApproveResultSkippedInner.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$BulkApproveResultToJson(BulkApproveResult instance) =>
    <String, dynamic>{
      'approved': instance.approved,
      'skipped': instance.skipped.map((e) => e.toJson()).toList(),
    };
