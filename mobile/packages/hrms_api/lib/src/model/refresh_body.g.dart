// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RefreshBodyCWProxy {
  RefreshBody refreshToken(String refreshToken);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RefreshBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RefreshBody(...).copyWith(id: 12, name: "My name")
  /// ````
  RefreshBody call({String refreshToken});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRefreshBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRefreshBody.copyWith.fieldName(...)`
class _$RefreshBodyCWProxyImpl implements _$RefreshBodyCWProxy {
  const _$RefreshBodyCWProxyImpl(this._value);

  final RefreshBody _value;

  @override
  RefreshBody refreshToken(String refreshToken) =>
      this(refreshToken: refreshToken);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RefreshBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RefreshBody(...).copyWith(id: 12, name: "My name")
  /// ````
  RefreshBody call({Object? refreshToken = const $CopyWithPlaceholder()}) {
    return RefreshBody(
      refreshToken: refreshToken == const $CopyWithPlaceholder()
          ? _value.refreshToken
          // ignore: cast_nullable_to_non_nullable
          : refreshToken as String,
    );
  }
}

extension $RefreshBodyCopyWith on RefreshBody {
  /// Returns a callable class that can be used as follows: `instanceOfRefreshBody.copyWith(...)` or like so:`instanceOfRefreshBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RefreshBodyCWProxy get copyWith => _$RefreshBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefreshBody _$RefreshBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('RefreshBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['refreshToken']);
      final val = RefreshBody(
        refreshToken: $checkedConvert('refreshToken', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$RefreshBodyToJson(RefreshBody instance) =>
    <String, dynamic>{'refreshToken': instance.refreshToken};
