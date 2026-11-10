// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reject_reason_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RejectReasonBodyCWProxy {
  RejectReasonBody reason(String reason);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RejectReasonBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RejectReasonBody(...).copyWith(id: 12, name: "My name")
  /// ````
  RejectReasonBody call({String reason});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRejectReasonBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRejectReasonBody.copyWith.fieldName(...)`
class _$RejectReasonBodyCWProxyImpl implements _$RejectReasonBodyCWProxy {
  const _$RejectReasonBodyCWProxyImpl(this._value);

  final RejectReasonBody _value;

  @override
  RejectReasonBody reason(String reason) => this(reason: reason);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RejectReasonBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RejectReasonBody(...).copyWith(id: 12, name: "My name")
  /// ````
  RejectReasonBody call({Object? reason = const $CopyWithPlaceholder()}) {
    return RejectReasonBody(
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String,
    );
  }
}

extension $RejectReasonBodyCopyWith on RejectReasonBody {
  /// Returns a callable class that can be used as follows: `instanceOfRejectReasonBody.copyWith(...)` or like so:`instanceOfRejectReasonBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RejectReasonBodyCWProxy get copyWith => _$RejectReasonBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RejectReasonBody _$RejectReasonBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('RejectReasonBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['reason']);
      final val = RejectReasonBody(
        reason: $checkedConvert('reason', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$RejectReasonBodyToJson(RejectReasonBody instance) =>
    <String, dynamic>{'reason': instance.reason};
