// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bulk_approve_result_skipped_inner.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BulkApproveResultSkippedInnerCWProxy {
  BulkApproveResultSkippedInner id(String id);

  BulkApproveResultSkippedInner reason(String reason);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BulkApproveResultSkippedInner(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BulkApproveResultSkippedInner(...).copyWith(id: 12, name: "My name")
  /// ````
  BulkApproveResultSkippedInner call({String id, String reason});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBulkApproveResultSkippedInner.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBulkApproveResultSkippedInner.copyWith.fieldName(...)`
class _$BulkApproveResultSkippedInnerCWProxyImpl
    implements _$BulkApproveResultSkippedInnerCWProxy {
  const _$BulkApproveResultSkippedInnerCWProxyImpl(this._value);

  final BulkApproveResultSkippedInner _value;

  @override
  BulkApproveResultSkippedInner id(String id) => this(id: id);

  @override
  BulkApproveResultSkippedInner reason(String reason) => this(reason: reason);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BulkApproveResultSkippedInner(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BulkApproveResultSkippedInner(...).copyWith(id: 12, name: "My name")
  /// ````
  BulkApproveResultSkippedInner call({
    Object? id = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
  }) {
    return BulkApproveResultSkippedInner(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String,
    );
  }
}

extension $BulkApproveResultSkippedInnerCopyWith
    on BulkApproveResultSkippedInner {
  /// Returns a callable class that can be used as follows: `instanceOfBulkApproveResultSkippedInner.copyWith(...)` or like so:`instanceOfBulkApproveResultSkippedInner.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BulkApproveResultSkippedInnerCWProxy get copyWith =>
      _$BulkApproveResultSkippedInnerCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BulkApproveResultSkippedInner _$BulkApproveResultSkippedInnerFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BulkApproveResultSkippedInner', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['id', 'reason']);
  final val = BulkApproveResultSkippedInner(
    id: $checkedConvert('id', (v) => v as String),
    reason: $checkedConvert('reason', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$BulkApproveResultSkippedInnerToJson(
  BulkApproveResultSkippedInner instance,
) => <String, dynamic>{'id': instance.id, 'reason': instance.reason};
