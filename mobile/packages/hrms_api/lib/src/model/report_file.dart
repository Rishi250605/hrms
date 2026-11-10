//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'report_file.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ReportFile {
  /// Returns a new [ReportFile] instance.
  ReportFile({
    required this.url,

    required this.method,

    required this.headers,

    required this.expiresAt,

    required this.fileName,

    required this.contentType,
  });

  @JsonKey(name: r'url', required: true, includeIfNull: false)
  final String url;

  @JsonKey(name: r'method', required: true, includeIfNull: false)
  final ReportFileMethodEnum method;

  @JsonKey(name: r'headers', required: true, includeIfNull: false)
  final Map<String, String> headers;

  @JsonKey(name: r'expiresAt', required: true, includeIfNull: false)
  final DateTime expiresAt;

  @JsonKey(name: r'fileName', required: true, includeIfNull: false)
  final String fileName;

  @JsonKey(name: r'contentType', required: true, includeIfNull: false)
  final String contentType;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReportFile &&
          other.url == url &&
          other.method == method &&
          other.headers == headers &&
          other.expiresAt == expiresAt &&
          other.fileName == fileName &&
          other.contentType == contentType;

  @override
  int get hashCode =>
      url.hashCode +
      method.hashCode +
      headers.hashCode +
      expiresAt.hashCode +
      fileName.hashCode +
      contentType.hashCode;

  factory ReportFile.fromJson(Map<String, dynamic> json) =>
      _$ReportFileFromJson(json);

  Map<String, dynamic> toJson() => _$ReportFileToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum ReportFileMethodEnum {
  @JsonValue(r'GET')
  GET(r'GET'),
  @JsonValue(r'PUT')
  PUT(r'PUT');

  const ReportFileMethodEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
