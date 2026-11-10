// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ResetPasswordBodyCWProxy {
  ResetPasswordBody password(String password);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ResetPasswordBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ResetPasswordBody(...).copyWith(id: 12, name: "My name")
  /// ````
  ResetPasswordBody call({String password});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfResetPasswordBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfResetPasswordBody.copyWith.fieldName(...)`
class _$ResetPasswordBodyCWProxyImpl implements _$ResetPasswordBodyCWProxy {
  const _$ResetPasswordBodyCWProxyImpl(this._value);

  final ResetPasswordBody _value;

  @override
  ResetPasswordBody password(String password) => this(password: password);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ResetPasswordBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ResetPasswordBody(...).copyWith(id: 12, name: "My name")
  /// ````
  ResetPasswordBody call({Object? password = const $CopyWithPlaceholder()}) {
    return ResetPasswordBody(
      password: password == const $CopyWithPlaceholder()
          ? _value.password
          // ignore: cast_nullable_to_non_nullable
          : password as String,
    );
  }
}

extension $ResetPasswordBodyCopyWith on ResetPasswordBody {
  /// Returns a callable class that can be used as follows: `instanceOfResetPasswordBody.copyWith(...)` or like so:`instanceOfResetPasswordBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ResetPasswordBodyCWProxy get copyWith =>
      _$ResetPasswordBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResetPasswordBody _$ResetPasswordBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ResetPasswordBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['password']);
      final val = ResetPasswordBody(
        password: $checkedConvert('password', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$ResetPasswordBodyToJson(ResetPasswordBody instance) =>
    <String, dynamic>{'password': instance.password};
