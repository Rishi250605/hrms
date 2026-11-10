// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logout_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LogoutBodyCWProxy {
  LogoutBody refreshToken(String refreshToken);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LogoutBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LogoutBody(...).copyWith(id: 12, name: "My name")
  /// ````
  LogoutBody call({String refreshToken});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfLogoutBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfLogoutBody.copyWith.fieldName(...)`
class _$LogoutBodyCWProxyImpl implements _$LogoutBodyCWProxy {
  const _$LogoutBodyCWProxyImpl(this._value);

  final LogoutBody _value;

  @override
  LogoutBody refreshToken(String refreshToken) =>
      this(refreshToken: refreshToken);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LogoutBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LogoutBody(...).copyWith(id: 12, name: "My name")
  /// ````
  LogoutBody call({Object? refreshToken = const $CopyWithPlaceholder()}) {
    return LogoutBody(
      refreshToken: refreshToken == const $CopyWithPlaceholder()
          ? _value.refreshToken
          // ignore: cast_nullable_to_non_nullable
          : refreshToken as String,
    );
  }
}

extension $LogoutBodyCopyWith on LogoutBody {
  /// Returns a callable class that can be used as follows: `instanceOfLogoutBody.copyWith(...)` or like so:`instanceOfLogoutBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LogoutBodyCWProxy get copyWith => _$LogoutBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogoutBody _$LogoutBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('LogoutBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['refreshToken']);
      final val = LogoutBody(
        refreshToken: $checkedConvert('refreshToken', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$LogoutBodyToJson(LogoutBody instance) =>
    <String, dynamic>{'refreshToken': instance.refreshToken};
