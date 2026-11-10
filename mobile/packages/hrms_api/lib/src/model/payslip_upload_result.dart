//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/payslip_upload_result_invalid_inner.dart';
import 'package:hrms_api/src/model/payslip_upload_match.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payslip_upload_result.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PayslipUploadResult {
  /// Returns a new [PayslipUploadResult] instance.
  PayslipUploadResult({
    required this.period,

    required this.matched,

    required this.replaced,

    required this.unmatched,

    required this.invalid,

    required this.duplicates,
  });

  @JsonKey(name: r'period', required: true, includeIfNull: false)
  final String period;

  @JsonKey(name: r'matched', required: true, includeIfNull: false)
  final List<PayslipUploadMatch> matched;

  /// Matched files that replaced an earlier upload (new version)
  @JsonKey(name: r'replaced', required: true, includeIfNull: false)
  final List<PayslipUploadMatch> replaced;

  /// File names whose employee code is unknown or outside your business units
  @JsonKey(name: r'unmatched', required: true, includeIfNull: false)
  final List<String> unmatched;

  @JsonKey(name: r'invalid', required: true, includeIfNull: false)
  final List<PayslipUploadResultInvalidInner> invalid;

  /// Several files for the same employee in one upload; none of them was stored
  @JsonKey(name: r'duplicates', required: true, includeIfNull: false)
  final List<String> duplicates;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PayslipUploadResult &&
          other.period == period &&
          other.matched == matched &&
          other.replaced == replaced &&
          other.unmatched == unmatched &&
          other.invalid == invalid &&
          other.duplicates == duplicates;

  @override
  int get hashCode =>
      period.hashCode +
      matched.hashCode +
      replaced.hashCode +
      unmatched.hashCode +
      invalid.hashCode +
      duplicates.hashCode;

  factory PayslipUploadResult.fromJson(Map<String, dynamic> json) =>
      _$PayslipUploadResultFromJson(json);

  Map<String, dynamic> toJson() => _$PayslipUploadResultToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
