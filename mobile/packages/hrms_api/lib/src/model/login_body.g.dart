// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LoginBodyCWProxy {
  LoginBody empCode(String empCode);

  LoginBody password(String password);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LoginBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LoginBody(...).copyWith(id: 12, name: "My name")
  /// ````
  LoginBody call({String empCode, String password});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfLoginBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfLoginBody.copyWith.fieldName(...)`
class _$LoginBodyCWProxyImpl implements _$LoginBodyCWProxy {
  const _$LoginBodyCWProxyImpl(this._value);

  final LoginBody _value;

  @override
  LoginBody empCode(String empCode) => this(empCode: empCode);

  @override
  LoginBody password(String password) => this(password: password);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LoginBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LoginBody(...).copyWith(id: 12, name: "My name")
  /// ````
  LoginBody call({
    Object? empCode = const $CopyWithPlaceholder(),
    Object? password = const $CopyWithPlaceholder(),
  }) {
    return LoginBody(
      empCode: empCode == const $CopyWithPlaceholder()
          ? _value.empCode
          // ignore: cast_nullable_to_non_nullable
          : empCode as String,
      password: password == const $CopyWithPlaceholder()
          ? _value.password
          // ignore: cast_nullable_to_non_nullable
          : password as String,
    );
  }
}

extension $LoginBodyCopyWith on LoginBody {
  /// Returns a callable class that can be used as follows: `instanceOfLoginBody.copyWith(...)` or like so:`instanceOfLoginBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LoginBodyCWProxy get copyWith => _$LoginBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginBody _$LoginBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('LoginBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['empCode', 'password']);
      final val = LoginBody(
        empCode: $checkedConvert('empCode', (v) => v as String),
        password: $checkedConvert('password', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$LoginBodyToJson(LoginBody instance) => <String, dynamic>{
  'empCode': instance.empCode,
  'password': instance.password,
};
