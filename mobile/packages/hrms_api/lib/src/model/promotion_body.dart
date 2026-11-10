//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'promotion_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PromotionBody {
  /// Returns a new [PromotionBody] instance.
  PromotionBody({
    required this.role,

    required this.reportingToEmployeeId,

    required this.effectiveFrom,

    this.designation,

    required this.reason,
  });

  @JsonKey(name: r'role', required: true, includeIfNull: false)
  final PromotionBodyRoleEnum role;

  /// New reporting manager (one role above the new role)
  @JsonKey(name: r'reportingToEmployeeId', required: true, includeIfNull: false)
  final String reportingToEmployeeId;

  /// Calendar date (IST business date)
  @JsonKey(name: r'effectiveFrom', required: true, includeIfNull: false)
  final String effectiveFrom;

  @JsonKey(name: r'designation', required: false, includeIfNull: false)
  final String? designation;

  @JsonKey(name: r'reason', required: true, includeIfNull: false)
  final String reason;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PromotionBody &&
          other.role == role &&
          other.reportingToEmployeeId == reportingToEmployeeId &&
          other.effectiveFrom == effectiveFrom &&
          other.designation == designation &&
          other.reason == reason;

  @override
  int get hashCode =>
      role.hashCode +
      reportingToEmployeeId.hashCode +
      effectiveFrom.hashCode +
      designation.hashCode +
      reason.hashCode;

  factory PromotionBody.fromJson(Map<String, dynamic> json) =>
      _$PromotionBodyFromJson(json);

  Map<String, dynamic> toJson() => _$PromotionBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum PromotionBodyRoleEnum {
  @JsonValue(r'HR')
  HR(r'HR'),
  @JsonValue(r'OPERATIONAL_MANAGER')
  OPERATIONAL_MANAGER(r'OPERATIONAL_MANAGER'),
  @JsonValue(r'REGIONAL_MANAGER')
  REGIONAL_MANAGER(r'REGIONAL_MANAGER');

  const PromotionBodyRoleEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
