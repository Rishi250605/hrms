//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/document_type.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'document_create_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DocumentCreateBody {
  /// Returns a new [DocumentCreateBody] instance.
  DocumentCreateBody({
    required this.type,

    required this.number,

    this.licenceClass,

    this.issueDate,

    this.expiryDate,

    required this.fileKey,
  });

  @JsonKey(name: r'type', required: true, includeIfNull: false)
  final DocumentType type;

  /// For AADHAAR send the last 4 digits (a 12-digit number is truncated to its last 4). For PAN the full PAN (stored encrypted).
  @JsonKey(name: r'number', required: true, includeIfNull: false)
  final String number;

  @JsonKey(name: r'licenceClass', required: false, includeIfNull: false)
  final String? licenceClass;

  /// Calendar date (IST business date)
  @JsonKey(name: r'issueDate', required: false, includeIfNull: false)
  final String? issueDate;

  /// Calendar date (IST business date)
  @JsonKey(name: r'expiryDate', required: false, includeIfNull: false)
  final String? expiryDate;

  /// Key returned by POST /uploads/presign after the file was uploaded
  @JsonKey(name: r'fileKey', required: true, includeIfNull: false)
  final String fileKey;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DocumentCreateBody &&
          other.type == type &&
          other.number == number &&
          other.licenceClass == licenceClass &&
          other.issueDate == issueDate &&
          other.expiryDate == expiryDate &&
          other.fileKey == fileKey;

  @override
  int get hashCode =>
      type.hashCode +
      number.hashCode +
      licenceClass.hashCode +
      issueDate.hashCode +
      expiryDate.hashCode +
      fileKey.hashCode;

  factory DocumentCreateBody.fromJson(Map<String, dynamic> json) =>
      _$DocumentCreateBodyFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentCreateBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
