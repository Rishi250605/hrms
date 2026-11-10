//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/employee_category.dart';
import 'package:hrms_api/src/model/employment_type.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'leave_policy_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class LeavePolicyBody {
  /// Returns a new [LeavePolicyBody] instance.
  LeavePolicyBody({
    required this.leaveTypeId,

    this.category,

    this.employmentType,

    this.state,

    required this.annualQuota,
  });

  @JsonKey(name: r'leaveTypeId', required: true, includeIfNull: false)
  final String leaveTypeId;

  @JsonKey(name: r'category', required: false, includeIfNull: false)
  final EmployeeCategory? category;

  @JsonKey(name: r'employmentType', required: false, includeIfNull: false)
  final EmploymentType? employmentType;

  @JsonKey(name: r'state', required: false, includeIfNull: false)
  final String? state;

  // minimum: 0
  // maximum: 365
  @JsonKey(name: r'annualQuota', required: true, includeIfNull: false)
  final num annualQuota;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LeavePolicyBody &&
          other.leaveTypeId == leaveTypeId &&
          other.category == category &&
          other.employmentType == employmentType &&
          other.state == state &&
          other.annualQuota == annualQuota;

  @override
  int get hashCode =>
      leaveTypeId.hashCode +
      (category == null ? 0 : category.hashCode) +
      (employmentType == null ? 0 : employmentType.hashCode) +
      (state == null ? 0 : state.hashCode) +
      annualQuota.hashCode;

  factory LeavePolicyBody.fromJson(Map<String, dynamic> json) =>
      _$LeavePolicyBodyFromJson(json);

  Map<String, dynamic> toJson() => _$LeavePolicyBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
