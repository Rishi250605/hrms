//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'presign_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PresignBody {
  /// Returns a new [PresignBody] instance.
  PresignBody({
    this.employeeId,

    required this.purpose,

    required this.contentType,

    required this.sizeBytes,
  });

  /// Required for DOCUMENT and PHOTO; VOICE_NOTE / RECEIPT files belong to the uploader
  @JsonKey(name: r'employeeId', required: false, includeIfNull: false)
  final String? employeeId;

  /// VOICE_NOTE / RECEIPT files belong to the uploader (allowance requests)
  @JsonKey(name: r'purpose', required: true, includeIfNull: false)
  final PresignBodyPurposeEnum purpose;

  @JsonKey(name: r'contentType', required: true, includeIfNull: false)
  final PresignBodyContentTypeEnum contentType;

  // minimum: 0
  @JsonKey(name: r'sizeBytes', required: true, includeIfNull: false)
  final int sizeBytes;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PresignBody &&
          other.employeeId == employeeId &&
          other.purpose == purpose &&
          other.contentType == contentType &&
          other.sizeBytes == sizeBytes;

  @override
  int get hashCode =>
      employeeId.hashCode +
      purpose.hashCode +
      contentType.hashCode +
      sizeBytes.hashCode;

  factory PresignBody.fromJson(Map<String, dynamic> json) =>
      _$PresignBodyFromJson(json);

  Map<String, dynamic> toJson() => _$PresignBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

/// VOICE_NOTE / RECEIPT files belong to the uploader (allowance requests)
enum PresignBodyPurposeEnum {
  @JsonValue(r'DOCUMENT')
  DOCUMENT(r'DOCUMENT'),
  @JsonValue(r'PHOTO')
  PHOTO(r'PHOTO'),
  @JsonValue(r'VOICE_NOTE')
  VOICE_NOTE(r'VOICE_NOTE'),
  @JsonValue(r'RECEIPT')
  RECEIPT(r'RECEIPT');

  const PresignBodyPurposeEnum(this.value);

  final String value;

  @override
  String toString() => value;
}

enum PresignBodyContentTypeEnum {
  @JsonValue(r'image/jpeg')
  imageSlashJpeg(r'image/jpeg'),
  @JsonValue(r'image/png')
  imageSlashPng(r'image/png'),
  @JsonValue(r'image/webp')
  imageSlashWebp(r'image/webp'),
  @JsonValue(r'application/pdf')
  applicationSlashPdf(r'application/pdf'),
  @JsonValue(r'audio/mp4')
  audioSlashMp4(r'audio/mp4'),
  @JsonValue(r'audio/aac')
  audioSlashAac(r'audio/aac'),
  @JsonValue(r'audio/m4a')
  audioSlashM4a(r'audio/m4a'),
  @JsonValue(r'audio/x-m4a')
  audioSlashXM4a(r'audio/x-m4a');

  const PresignBodyContentTypeEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
