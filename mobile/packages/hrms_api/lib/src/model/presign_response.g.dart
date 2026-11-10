// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'presign_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PresignResponseCWProxy {
  PresignResponse url(String url);

  PresignResponse method(PresignResponseMethodEnum method);

  PresignResponse headers(Map<String, String> headers);

  PresignResponse expiresAt(DateTime expiresAt);

  PresignResponse key(String key);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PresignResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PresignResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  PresignResponse call({
    String url,
    PresignResponseMethodEnum method,
    Map<String, String> headers,
    DateTime expiresAt,
    String key,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPresignResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPresignResponse.copyWith.fieldName(...)`
class _$PresignResponseCWProxyImpl implements _$PresignResponseCWProxy {
  const _$PresignResponseCWProxyImpl(this._value);

  final PresignResponse _value;

  @override
  PresignResponse url(String url) => this(url: url);

  @override
  PresignResponse method(PresignResponseMethodEnum method) =>
      this(method: method);

  @override
  PresignResponse headers(Map<String, String> headers) =>
      this(headers: headers);

  @override
  PresignResponse expiresAt(DateTime expiresAt) => this(expiresAt: expiresAt);

  @override
  PresignResponse key(String key) => this(key: key);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PresignResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PresignResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  PresignResponse call({
    Object? url = const $CopyWithPlaceholder(),
    Object? method = const $CopyWithPlaceholder(),
    Object? headers = const $CopyWithPlaceholder(),
    Object? expiresAt = const $CopyWithPlaceholder(),
    Object? key = const $CopyWithPlaceholder(),
  }) {
    return PresignResponse(
      url: url == const $CopyWithPlaceholder()
          ? _value.url
          // ignore: cast_nullable_to_non_nullable
          : url as String,
      method: method == const $CopyWithPlaceholder()
          ? _value.method
          // ignore: cast_nullable_to_non_nullable
          : method as PresignResponseMethodEnum,
      headers: headers == const $CopyWithPlaceholder()
          ? _value.headers
          // ignore: cast_nullable_to_non_nullable
          : headers as Map<String, String>,
      expiresAt: expiresAt == const $CopyWithPlaceholder()
          ? _value.expiresAt
          // ignore: cast_nullable_to_non_nullable
          : expiresAt as DateTime,
      key: key == const $CopyWithPlaceholder()
          ? _value.key
          // ignore: cast_nullable_to_non_nullable
          : key as String,
    );
  }
}

extension $PresignResponseCopyWith on PresignResponse {
  /// Returns a callable class that can be used as follows: `instanceOfPresignResponse.copyWith(...)` or like so:`instanceOfPresignResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PresignResponseCWProxy get copyWith => _$PresignResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PresignResponse _$PresignResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PresignResponse', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['url', 'method', 'headers', 'expiresAt', 'key'],
      );
      final val = PresignResponse(
        url: $checkedConvert('url', (v) => v as String),
        method: $checkedConvert(
          'method',
          (v) => $enumDecode(_$PresignResponseMethodEnumEnumMap, v),
        ),
        headers: $checkedConvert(
          'headers',
          (v) => Map<String, String>.from(v as Map),
        ),
        expiresAt: $checkedConvert(
          'expiresAt',
          (v) => DateTime.parse(v as String),
        ),
        key: $checkedConvert('key', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$PresignResponseToJson(PresignResponse instance) =>
    <String, dynamic>{
      'url': instance.url,
      'method': _$PresignResponseMethodEnumEnumMap[instance.method]!,
      'headers': instance.headers,
      'expiresAt': instance.expiresAt.toIso8601String(),
      'key': instance.key,
    };

const _$PresignResponseMethodEnumEnumMap = {
  PresignResponseMethodEnum.GET: 'GET',
  PresignResponseMethodEnum.PUT: 'PUT',
};
