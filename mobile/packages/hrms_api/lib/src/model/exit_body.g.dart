// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exit_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ExitBodyCWProxy {
  ExitBody exitDate(String exitDate);

  ExitBody reason(String reason);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExitBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExitBody(...).copyWith(id: 12, name: "My name")
  /// ````
  ExitBody call({String exitDate, String reason});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfExitBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfExitBody.copyWith.fieldName(...)`
class _$ExitBodyCWProxyImpl implements _$ExitBodyCWProxy {
  const _$ExitBodyCWProxyImpl(this._value);

  final ExitBody _value;

  @override
  ExitBody exitDate(String exitDate) => this(exitDate: exitDate);

  @override
  ExitBody reason(String reason) => this(reason: reason);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExitBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExitBody(...).copyWith(id: 12, name: "My name")
  /// ````
  ExitBody call({
    Object? exitDate = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
  }) {
    return ExitBody(
      exitDate: exitDate == const $CopyWithPlaceholder()
          ? _value.exitDate
          // ignore: cast_nullable_to_non_nullable
          : exitDate as String,
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String,
    );
  }
}

extension $ExitBodyCopyWith on ExitBody {
  /// Returns a callable class that can be used as follows: `instanceOfExitBody.copyWith(...)` or like so:`instanceOfExitBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ExitBodyCWProxy get copyWith => _$ExitBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExitBody _$ExitBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ExitBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['exitDate', 'reason']);
      final val = ExitBody(
        exitDate: $checkedConvert('exitDate', (v) => v as String),
        reason: $checkedConvert('reason', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$ExitBodyToJson(ExitBody instance) => <String, dynamic>{
  'exitDate': instance.exitDate,
  'reason': instance.reason,
};
