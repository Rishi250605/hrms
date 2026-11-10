//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/person_ref.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payslip_upload_match.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PayslipUploadMatch {
  /// Returns a new [PayslipUploadMatch] instance.
  PayslipUploadMatch({
    required this.fileName,

    required this.payslipId,

    required this.employee,

    required this.version,
  });

  @JsonKey(name: r'fileName', required: true, includeIfNull: false)
  final String fileName;

  @JsonKey(name: r'payslipId', required: true, includeIfNull: false)
  final String payslipId;

  @JsonKey(name: r'employee', required: true, includeIfNull: false)
  final PersonRef employee;

  @JsonKey(name: r'version', required: true, includeIfNull: false)
  final int version;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PayslipUploadMatch &&
          other.fileName == fileName &&
          other.payslipId == payslipId &&
          other.employee == employee &&
          other.version == version;

  @override
  int get hashCode =>
      fileName.hashCode +
      payslipId.hashCode +
      employee.hashCode +
      version.hashCode;

  factory PayslipUploadMatch.fromJson(Map<String, dynamic> json) =>
      _$PayslipUploadMatchFromJson(json);

  Map<String, dynamic> toJson() => _$PayslipUploadMatchToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
