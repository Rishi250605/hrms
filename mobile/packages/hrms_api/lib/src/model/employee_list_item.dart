//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/compliance_overall.dart';
import 'package:hrms_api/src/model/role.dart';
import 'package:hrms_api/src/model/business_unit_ref.dart';
import 'package:hrms_api/src/model/employee_category.dart';
import 'package:hrms_api/src/model/depot_summary.dart';
import 'package:hrms_api/src/model/person_ref.dart';
import 'package:hrms_api/src/model/employee_status.dart';
import 'package:hrms_api/src/model/employment_type.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'employee_list_item.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class EmployeeListItem {
  /// Returns a new [EmployeeListItem] instance.
  EmployeeListItem({
    required this.id,

    required this.empCode,

    required this.fullName,

    required this.phone,

    required this.category,

    required this.role,

    required this.employmentType,

    required this.status,

    required this.designation,

    required this.depot,

    required this.businessUnit,

    required this.reportingTo,

    required this.compliance,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'empCode', required: true, includeIfNull: false)
  final String empCode;

  @JsonKey(name: r'fullName', required: true, includeIfNull: false)
  final String fullName;

  @JsonKey(name: r'phone', required: true, includeIfNull: false)
  final String phone;

  @JsonKey(name: r'category', required: true, includeIfNull: false)
  final EmployeeCategory category;

  /// Login role; null for drivers / loadmen and other non-login staff
  @JsonKey(name: r'role', required: true, includeIfNull: true)
  final Role? role;

  @JsonKey(name: r'employmentType', required: true, includeIfNull: false)
  final EmploymentType employmentType;

  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final EmployeeStatus status;

  @JsonKey(name: r'designation', required: true, includeIfNull: true)
  final String? designation;

  @JsonKey(name: r'depot', required: true, includeIfNull: true)
  final DepotSummary? depot;

  /// Primary business unit
  @JsonKey(name: r'businessUnit', required: true, includeIfNull: true)
  final BusinessUnitRef? businessUnit;

  @JsonKey(name: r'reportingTo', required: true, includeIfNull: true)
  final PersonRef? reportingTo;

  @JsonKey(name: r'compliance', required: true, includeIfNull: false)
  final ComplianceOverall compliance;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmployeeListItem &&
          other.id == id &&
          other.empCode == empCode &&
          other.fullName == fullName &&
          other.phone == phone &&
          other.category == category &&
          other.role == role &&
          other.employmentType == employmentType &&
          other.status == status &&
          other.designation == designation &&
          other.depot == depot &&
          other.businessUnit == businessUnit &&
          other.reportingTo == reportingTo &&
          other.compliance == compliance;

  @override
  int get hashCode =>
      id.hashCode +
      empCode.hashCode +
      fullName.hashCode +
      phone.hashCode +
      category.hashCode +
      (role == null ? 0 : role.hashCode) +
      employmentType.hashCode +
      status.hashCode +
      (designation == null ? 0 : designation.hashCode) +
      (depot == null ? 0 : depot.hashCode) +
      (businessUnit == null ? 0 : businessUnit.hashCode) +
      (reportingTo == null ? 0 : reportingTo.hashCode) +
      compliance.hashCode;

  factory EmployeeListItem.fromJson(Map<String, dynamic> json) =>
      _$EmployeeListItemFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeListItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
