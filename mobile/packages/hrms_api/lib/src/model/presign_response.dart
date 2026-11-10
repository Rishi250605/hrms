//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'presign_response.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PresignResponse {
  /// Returns a new [PresignResponse] instance.
  PresignResponse({
    required this.url,

    required this.method,

    required this.headers,

    required this.expiresAt,

    required this.key,
  });

  @JsonKey(name: r'url', required: true, includeIfNull: false)
  final String url;

  @JsonKey(name: r'method', required: true, includeIfNull: false)
  final PresignResponseMethodEnum method;

  @JsonKey(name: r'headers', required: true, includeIfNull: false)
  final Map<String, String> headers;

  @JsonKey(name: r'expiresAt', required: true, includeIfNull: false)
  final DateTime expiresAt;

  /// Send this as fileKey when creating the document
  @JsonKey(name: r'key', required: true, includeIfNull: false)
  final String key;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PresignResponse &&
          other.url == url &&
          other.method == method &&
          other.headers == headers &&
          other.expiresAt == expiresAt &&
          other.key == key;

  @override
  int get hashCode =>
      url.hashCode +
      method.hashCode +
      headers.hashCode +
      expiresAt.hashCode +
      key.hashCode;

  factory PresignResponse.fromJson(Map<String, dynamic> json) =>
      _$PresignResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PresignResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum PresignResponseMethodEnum {
  @JsonValue(r'GET')
  GET(r'GET'),
  @JsonValue(r'PUT')
  PUT(r'PUT');

  const PresignResponseMethodEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
