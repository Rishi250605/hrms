//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/employee_category.dart';
import 'package:hrms_api/src/model/employment_type.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'leave_policy_item.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class LeavePolicyItem {
  /// Returns a new [LeavePolicyItem] instance.
  LeavePolicyItem({
    required this.id,

    required this.leaveTypeId,

    required this.leaveTypeCode,

    required this.category,

    required this.employmentType,

    required this.state,

    required this.annualQuota,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'leaveTypeId', required: true, includeIfNull: false)
  final String leaveTypeId;

  @JsonKey(name: r'leaveTypeCode', required: true, includeIfNull: false)
  final String leaveTypeCode;

  @JsonKey(name: r'category', required: true, includeIfNull: true)
  final EmployeeCategory? category;

  @JsonKey(name: r'employmentType', required: true, includeIfNull: true)
  final EmploymentType? employmentType;

  @JsonKey(name: r'state', required: true, includeIfNull: true)
  final String? state;

  @JsonKey(name: r'annualQuota', required: true, includeIfNull: false)
  final num annualQuota;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LeavePolicyItem &&
          other.id == id &&
          other.leaveTypeId == leaveTypeId &&
          other.leaveTypeCode == leaveTypeCode &&
          other.category == category &&
          other.employmentType == employmentType &&
          other.state == state &&
          other.annualQuota == annualQuota;

  @override
  int get hashCode =>
      id.hashCode +
      leaveTypeId.hashCode +
      leaveTypeCode.hashCode +
      (category == null ? 0 : category.hashCode) +
      (employmentType == null ? 0 : employmentType.hashCode) +
      (state == null ? 0 : state.hashCode) +
      annualQuota.hashCode;

  factory LeavePolicyItem.fromJson(Map<String, dynamic> json) =>
      _$LeavePolicyItemFromJson(json);

  Map<String, dynamic> toJson() => _$LeavePolicyItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
