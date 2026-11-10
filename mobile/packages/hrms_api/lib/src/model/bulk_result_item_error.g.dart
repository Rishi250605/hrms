// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bulk_result_item_error.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BulkResultItemErrorCWProxy {
  BulkResultItemError code(String code);

  BulkResultItemError message(String message);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BulkResultItemError(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BulkResultItemError(...).copyWith(id: 12, name: "My name")
  /// ````
  BulkResultItemError call({String code, String message});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBulkResultItemError.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBulkResultItemError.copyWith.fieldName(...)`
class _$BulkResultItemErrorCWProxyImpl implements _$BulkResultItemErrorCWProxy {
  const _$BulkResultItemErrorCWProxyImpl(this._value);

  final BulkResultItemError _value;

  @override
  BulkResultItemError code(String code) => this(code: code);

  @override
  BulkResultItemError message(String message) => this(message: message);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BulkResultItemError(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BulkResultItemError(...).copyWith(id: 12, name: "My name")
  /// ````
  BulkResultItemError call({
    Object? code = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
  }) {
    return BulkResultItemError(
      code: code == const $CopyWithPlaceholder()
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String,
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
    );
  }
}

extension $BulkResultItemErrorCopyWith on BulkResultItemError {
  /// Returns a callable class that can be used as follows: `instanceOfBulkResultItemError.copyWith(...)` or like so:`instanceOfBulkResultItemError.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BulkResultItemErrorCWProxy get copyWith =>
      _$BulkResultItemErrorCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BulkResultItemError _$BulkResultItemErrorFromJson(Map<String, dynamic> json) =>
    $checkedCreate('BulkResultItemError', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['code', 'message']);
      final val = BulkResultItemError(
        code: $checkedConvert('code', (v) => v as String),
        message: $checkedConvert('message', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$BulkResultItemErrorToJson(
  BulkResultItemError instance,
) => <String, dynamic>{'code': instance.code, 'message': instance.message};
