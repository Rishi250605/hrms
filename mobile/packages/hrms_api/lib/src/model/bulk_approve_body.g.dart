// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bulk_approve_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BulkApproveBodyCWProxy {
  BulkApproveBody ids(List<String> ids);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BulkApproveBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BulkApproveBody(...).copyWith(id: 12, name: "My name")
  /// ````
  BulkApproveBody call({List<String> ids});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBulkApproveBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBulkApproveBody.copyWith.fieldName(...)`
class _$BulkApproveBodyCWProxyImpl implements _$BulkApproveBodyCWProxy {
  const _$BulkApproveBodyCWProxyImpl(this._value);

  final BulkApproveBody _value;

  @override
  BulkApproveBody ids(List<String> ids) => this(ids: ids);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BulkApproveBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BulkApproveBody(...).copyWith(id: 12, name: "My name")
  /// ````
  BulkApproveBody call({Object? ids = const $CopyWithPlaceholder()}) {
    return BulkApproveBody(
      ids: ids == const $CopyWithPlaceholder()
          ? _value.ids
          // ignore: cast_nullable_to_non_nullable
          : ids as List<String>,
    );
  }
}

extension $BulkApproveBodyCopyWith on BulkApproveBody {
  /// Returns a callable class that can be used as follows: `instanceOfBulkApproveBody.copyWith(...)` or like so:`instanceOfBulkApproveBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BulkApproveBodyCWProxy get copyWith => _$BulkApproveBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BulkApproveBody _$BulkApproveBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('BulkApproveBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['ids']);
      final val = BulkApproveBody(
        ids: $checkedConvert(
          'ids',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$BulkApproveBodyToJson(BulkApproveBody instance) =>
    <String, dynamic>{'ids': instance.ids};
