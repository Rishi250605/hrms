// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signed_url_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SignedUrlResponseCWProxy {
  SignedUrlResponse url(String url);

  SignedUrlResponse method(SignedUrlResponseMethodEnum method);

  SignedUrlResponse headers(Map<String, String> headers);

  SignedUrlResponse expiresAt(DateTime expiresAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SignedUrlResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SignedUrlResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  SignedUrlResponse call({
    String url,
    SignedUrlResponseMethodEnum method,
    Map<String, String> headers,
    DateTime expiresAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSignedUrlResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSignedUrlResponse.copyWith.fieldName(...)`
class _$SignedUrlResponseCWProxyImpl implements _$SignedUrlResponseCWProxy {
  const _$SignedUrlResponseCWProxyImpl(this._value);

  final SignedUrlResponse _value;

  @override
  SignedUrlResponse url(String url) => this(url: url);

  @override
  SignedUrlResponse method(SignedUrlResponseMethodEnum method) =>
      this(method: method);

  @override
  SignedUrlResponse headers(Map<String, String> headers) =>
      this(headers: headers);

  @override
  SignedUrlResponse expiresAt(DateTime expiresAt) => this(expiresAt: expiresAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SignedUrlResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SignedUrlResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  SignedUrlResponse call({
    Object? url = const $CopyWithPlaceholder(),
    Object? method = const $CopyWithPlaceholder(),
    Object? headers = const $CopyWithPlaceholder(),
    Object? expiresAt = const $CopyWithPlaceholder(),
  }) {
    return SignedUrlResponse(
      url: url == const $CopyWithPlaceholder()
          ? _value.url
          // ignore: cast_nullable_to_non_nullable
          : url as String,
      method: method == const $CopyWithPlaceholder()
          ? _value.method
          // ignore: cast_nullable_to_non_nullable
          : method as SignedUrlResponseMethodEnum,
      headers: headers == const $CopyWithPlaceholder()
          ? _value.headers
          // ignore: cast_nullable_to_non_nullable
          : headers as Map<String, String>,
      expiresAt: expiresAt == const $CopyWithPlaceholder()
          ? _value.expiresAt
          // ignore: cast_nullable_to_non_nullable
          : expiresAt as DateTime,
    );
  }
}

extension $SignedUrlResponseCopyWith on SignedUrlResponse {
  /// Returns a callable class that can be used as follows: `instanceOfSignedUrlResponse.copyWith(...)` or like so:`instanceOfSignedUrlResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SignedUrlResponseCWProxy get copyWith =>
      _$SignedUrlResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignedUrlResponse _$SignedUrlResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SignedUrlResponse', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['url', 'method', 'headers', 'expiresAt'],
      );
      final val = SignedUrlResponse(
        url: $checkedConvert('url', (v) => v as String),
        method: $checkedConvert(
          'method',
          (v) => $enumDecode(_$SignedUrlResponseMethodEnumEnumMap, v),
        ),
        headers: $checkedConvert(
          'headers',
          (v) => Map<String, String>.from(v as Map),
        ),
        expiresAt: $checkedConvert(
          'expiresAt',
          (v) => DateTime.parse(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$SignedUrlResponseToJson(SignedUrlResponse instance) =>
    <String, dynamic>{
      'url': instance.url,
      'method': _$SignedUrlResponseMethodEnumEnumMap[instance.method]!,
      'headers': instance.headers,
      'expiresAt': instance.expiresAt.toIso8601String(),
    };

const _$SignedUrlResponseMethodEnumEnumMap = {
  SignedUrlResponseMethodEnum.GET: 'GET',
  SignedUrlResponseMethodEnum.PUT: 'PUT',
};
