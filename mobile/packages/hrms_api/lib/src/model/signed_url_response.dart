//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'signed_url_response.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class SignedUrlResponse {
  /// Returns a new [SignedUrlResponse] instance.
  SignedUrlResponse({
    required this.url,

    required this.method,

    required this.headers,

    required this.expiresAt,
  });

  @JsonKey(name: r'url', required: true, includeIfNull: false)
  final String url;

  @JsonKey(name: r'method', required: true, includeIfNull: false)
  final SignedUrlResponseMethodEnum method;

  @JsonKey(name: r'headers', required: true, includeIfNull: false)
  final Map<String, String> headers;

  @JsonKey(name: r'expiresAt', required: true, includeIfNull: false)
  final DateTime expiresAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignedUrlResponse &&
          other.url == url &&
          other.method == method &&
          other.headers == headers &&
          other.expiresAt == expiresAt;

  @override
  int get hashCode =>
      url.hashCode + method.hashCode + headers.hashCode + expiresAt.hashCode;

  factory SignedUrlResponse.fromJson(Map<String, dynamic> json) =>
      _$SignedUrlResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignedUrlResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum SignedUrlResponseMethodEnum {
  @JsonValue(r'GET')
  GET(r'GET'),
  @JsonValue(r'PUT')
  PUT(r'PUT');

  const SignedUrlResponseMethodEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
