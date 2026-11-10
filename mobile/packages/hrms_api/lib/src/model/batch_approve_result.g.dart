// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'batch_approve_result.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BatchApproveResultCWProxy {
  BatchApproveResult approved(List<String> approved);

  BatchApproveResult skipped(List<String> skipped);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BatchApproveResult(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BatchApproveResult(...).copyWith(id: 12, name: "My name")
  /// ````
  BatchApproveResult call({List<String> approved, List<String> skipped});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBatchApproveResult.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBatchApproveResult.copyWith.fieldName(...)`
class _$BatchApproveResultCWProxyImpl implements _$BatchApproveResultCWProxy {
  const _$BatchApproveResultCWProxyImpl(this._value);

  final BatchApproveResult _value;

  @override
  BatchApproveResult approved(List<String> approved) =>
      this(approved: approved);

  @override
  BatchApproveResult skipped(List<String> skipped) => this(skipped: skipped);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BatchApproveResult(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BatchApproveResult(...).copyWith(id: 12, name: "My name")
  /// ````
  BatchApproveResult call({
    Object? approved = const $CopyWithPlaceholder(),
    Object? skipped = const $CopyWithPlaceholder(),
  }) {
    return BatchApproveResult(
      approved: approved == const $CopyWithPlaceholder()
          ? _value.approved
          // ignore: cast_nullable_to_non_nullable
          : approved as List<String>,
      skipped: skipped == const $CopyWithPlaceholder()
          ? _value.skipped
          // ignore: cast_nullable_to_non_nullable
          : skipped as List<String>,
    );
  }
}

extension $BatchApproveResultCopyWith on BatchApproveResult {
  /// Returns a callable class that can be used as follows: `instanceOfBatchApproveResult.copyWith(...)` or like so:`instanceOfBatchApproveResult.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BatchApproveResultCWProxy get copyWith =>
      _$BatchApproveResultCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BatchApproveResult _$BatchApproveResultFromJson(Map<String, dynamic> json) =>
    $checkedCreate('BatchApproveResult', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['approved', 'skipped']);
      final val = BatchApproveResult(
        approved: $checkedConvert(
          'approved',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
        skipped: $checkedConvert(
          'skipped',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$BatchApproveResultToJson(BatchApproveResult instance) =>
    <String, dynamic>{
      'approved': instance.approved,
      'skipped': instance.skipped,
    };
