//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payslip_upload_result_invalid_inner.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PayslipUploadResultInvalidInner {
  /// Returns a new [PayslipUploadResultInvalidInner] instance.
  PayslipUploadResultInvalidInner({
    required this.fileName,

    required this.reason,
  });

  @JsonKey(name: r'fileName', required: true, includeIfNull: false)
  final String fileName;

  @JsonKey(name: r'reason', required: true, includeIfNull: false)
  final PayslipUploadResultInvalidInnerReasonEnum reason;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PayslipUploadResultInvalidInner &&
          other.fileName == fileName &&
          other.reason == reason;

  @override
  int get hashCode => fileName.hashCode + reason.hashCode;

  factory PayslipUploadResultInvalidInner.fromJson(Map<String, dynamic> json) =>
      _$PayslipUploadResultInvalidInnerFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PayslipUploadResultInvalidInnerToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum PayslipUploadResultInvalidInnerReasonEnum {
  @JsonValue(r'NAME_FORMAT')
  NAME_FORMAT(r'NAME_FORMAT'),
  @JsonValue(r'NOT_PDF')
  NOT_PDF(r'NOT_PDF'),
  @JsonValue(r'TOO_LARGE')
  TOO_LARGE(r'TOO_LARGE'),
  @JsonValue(r'EMPTY')
  EMPTY(r'EMPTY');

  const PayslipUploadResultInvalidInnerReasonEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
