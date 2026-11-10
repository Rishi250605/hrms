// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_pair.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TokenPairCWProxy {
  TokenPair accessToken(String accessToken);

  TokenPair accessTokenExpiresAt(DateTime accessTokenExpiresAt);

  TokenPair refreshToken(String refreshToken);

  TokenPair refreshTokenExpiresAt(DateTime refreshTokenExpiresAt);

  TokenPair tokenType(TokenPairTokenTypeEnum tokenType);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TokenPair(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TokenPair(...).copyWith(id: 12, name: "My name")
  /// ````
  TokenPair call({
    String accessToken,
    DateTime accessTokenExpiresAt,
    String refreshToken,
    DateTime refreshTokenExpiresAt,
    TokenPairTokenTypeEnum tokenType,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTokenPair.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTokenPair.copyWith.fieldName(...)`
class _$TokenPairCWProxyImpl implements _$TokenPairCWProxy {
  const _$TokenPairCWProxyImpl(this._value);

  final TokenPair _value;

  @override
  TokenPair accessToken(String accessToken) => this(accessToken: accessToken);

  @override
  TokenPair accessTokenExpiresAt(DateTime accessTokenExpiresAt) =>
      this(accessTokenExpiresAt: accessTokenExpiresAt);

  @override
  TokenPair refreshToken(String refreshToken) =>
      this(refreshToken: refreshToken);

  @override
  TokenPair refreshTokenExpiresAt(DateTime refreshTokenExpiresAt) =>
      this(refreshTokenExpiresAt: refreshTokenExpiresAt);

  @override
  TokenPair tokenType(TokenPairTokenTypeEnum tokenType) =>
      this(tokenType: tokenType);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TokenPair(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TokenPair(...).copyWith(id: 12, name: "My name")
  /// ````
  TokenPair call({
    Object? accessToken = const $CopyWithPlaceholder(),
    Object? accessTokenExpiresAt = const $CopyWithPlaceholder(),
    Object? refreshToken = const $CopyWithPlaceholder(),
    Object? refreshTokenExpiresAt = const $CopyWithPlaceholder(),
    Object? tokenType = const $CopyWithPlaceholder(),
  }) {
    return TokenPair(
      accessToken: accessToken == const $CopyWithPlaceholder()
          ? _value.accessToken
          // ignore: cast_nullable_to_non_nullable
          : accessToken as String,
      accessTokenExpiresAt: accessTokenExpiresAt == const $CopyWithPlaceholder()
          ? _value.accessTokenExpiresAt
          // ignore: cast_nullable_to_non_nullable
          : accessTokenExpiresAt as DateTime,
      refreshToken: refreshToken == const $CopyWithPlaceholder()
          ? _value.refreshToken
          // ignore: cast_nullable_to_non_nullable
          : refreshToken as String,
      refreshTokenExpiresAt:
          refreshTokenExpiresAt == const $CopyWithPlaceholder()
          ? _value.refreshTokenExpiresAt
          // ignore: cast_nullable_to_non_nullable
          : refreshTokenExpiresAt as DateTime,
      tokenType: tokenType == const $CopyWithPlaceholder()
          ? _value.tokenType
          // ignore: cast_nullable_to_non_nullable
          : tokenType as TokenPairTokenTypeEnum,
    );
  }
}

extension $TokenPairCopyWith on TokenPair {
  /// Returns a callable class that can be used as follows: `instanceOfTokenPair.copyWith(...)` or like so:`instanceOfTokenPair.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TokenPairCWProxy get copyWith => _$TokenPairCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenPair _$TokenPairFromJson(Map<String, dynamic> json) =>
    $checkedCreate('TokenPair', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'accessToken',
          'accessTokenExpiresAt',
          'refreshToken',
          'refreshTokenExpiresAt',
          'tokenType',
        ],
      );
      final val = TokenPair(
        accessToken: $checkedConvert('accessToken', (v) => v as String),
        accessTokenExpiresAt: $checkedConvert(
          'accessTokenExpiresAt',
          (v) => DateTime.parse(v as String),
        ),
        refreshToken: $checkedConvert('refreshToken', (v) => v as String),
        refreshTokenExpiresAt: $checkedConvert(
          'refreshTokenExpiresAt',
          (v) => DateTime.parse(v as String),
        ),
        tokenType: $checkedConvert(
          'tokenType',
          (v) => $enumDecode(_$TokenPairTokenTypeEnumEnumMap, v),
        ),
      );
      return val;
    });

Map<String, dynamic> _$TokenPairToJson(TokenPair instance) => <String, dynamic>{
  'accessToken': instance.accessToken,
  'accessTokenExpiresAt': instance.accessTokenExpiresAt.toIso8601String(),
  'refreshToken': instance.refreshToken,
  'refreshTokenExpiresAt': instance.refreshTokenExpiresAt.toIso8601String(),
  'tokenType': _$TokenPairTokenTypeEnumEnumMap[instance.tokenType]!,
};

const _$TokenPairTokenTypeEnumEnumMap = {
  TokenPairTokenTypeEnum.bearer: 'Bearer',
};
