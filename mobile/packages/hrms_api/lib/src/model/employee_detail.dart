//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/compliance.dart';
import 'package:hrms_api/src/model/role.dart';
import 'package:hrms_api/src/model/business_unit_ref.dart';
import 'package:hrms_api/src/model/employee_category.dart';
import 'package:hrms_api/src/model/employee_job_item.dart';
import 'package:hrms_api/src/model/gender.dart';
import 'package:hrms_api/src/model/depot_summary.dart';
import 'package:hrms_api/src/model/preferred_channel.dart';
import 'package:hrms_api/src/model/person_ref.dart';
import 'package:hrms_api/src/model/employee_status.dart';
import 'package:hrms_api/src/model/employment_type.dart';
import 'package:hrms_api/src/model/business_unit_membership.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'employee_detail.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class EmployeeDetail {
  /// Returns a new [EmployeeDetail] instance.
  EmployeeDetail({
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

    required this.altPhone,

    required this.dob,

    required this.gender,

    required this.joiningDate,

    required this.exitDate,

    required this.exitReason,

    required this.contractorName,

    required this.uan,

    required this.esicNo,

    required this.aadhaarLast4,

    required this.panMasked,

    required this.hasBankDetails,

    required this.preferredChannel,

    required this.hasPhoto,

    required this.hasLogin,

    required this.businessUnits,

    required this.currentJob,

    required this.jobs,

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

  @JsonKey(name: r'altPhone', required: true, includeIfNull: true)
  final String? altPhone;

  /// Calendar date (IST business date)
  @JsonKey(name: r'dob', required: true, includeIfNull: true)
  final String? dob;

  @JsonKey(name: r'gender', required: true, includeIfNull: true)
  final Gender? gender;

  /// Calendar date (IST business date)
  @JsonKey(name: r'joiningDate', required: true, includeIfNull: false)
  final String joiningDate;

  /// Calendar date (IST business date)
  @JsonKey(name: r'exitDate', required: true, includeIfNull: true)
  final String? exitDate;

  @JsonKey(name: r'exitReason', required: true, includeIfNull: true)
  final String? exitReason;

  @JsonKey(name: r'contractorName', required: true, includeIfNull: true)
  final String? contractorName;

  @JsonKey(name: r'uan', required: true, includeIfNull: true)
  final String? uan;

  @JsonKey(name: r'esicNo', required: true, includeIfNull: true)
  final String? esicNo;

  @JsonKey(name: r'aadhaarLast4', required: true, includeIfNull: true)
  final String? aadhaarLast4;

  /// HR / director only
  @JsonKey(name: r'panMasked', required: true, includeIfNull: true)
  final String? panMasked;

  /// HR / director only; false for other roles
  @JsonKey(name: r'hasBankDetails', required: true, includeIfNull: false)
  final bool hasBankDetails;

  @JsonKey(name: r'preferredChannel', required: true, includeIfNull: false)
  final PreferredChannel preferredChannel;

  @JsonKey(name: r'hasPhoto', required: true, includeIfNull: false)
  final bool hasPhoto;

  @JsonKey(name: r'hasLogin', required: true, includeIfNull: false)
  final bool hasLogin;

  @JsonKey(name: r'businessUnits', required: true, includeIfNull: false)
  final List<BusinessUnitMembership> businessUnits;

  @JsonKey(name: r'currentJob', required: true, includeIfNull: true)
  final EmployeeJobItem? currentJob;

  /// Full job history, newest first
  @JsonKey(name: r'jobs', required: true, includeIfNull: false)
  final List<EmployeeJobItem> jobs;

  @JsonKey(name: r'compliance', required: true, includeIfNull: false)
  final Compliance compliance;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmployeeDetail &&
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
          other.altPhone == altPhone &&
          other.dob == dob &&
          other.gender == gender &&
          other.joiningDate == joiningDate &&
          other.exitDate == exitDate &&
          other.exitReason == exitReason &&
          other.contractorName == contractorName &&
          other.uan == uan &&
          other.esicNo == esicNo &&
          other.aadhaarLast4 == aadhaarLast4 &&
          other.panMasked == panMasked &&
          other.hasBankDetails == hasBankDetails &&
          other.preferredChannel == preferredChannel &&
          other.hasPhoto == hasPhoto &&
          other.hasLogin == hasLogin &&
          other.businessUnits == businessUnits &&
          other.currentJob == currentJob &&
          other.jobs == jobs &&
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
      (altPhone == null ? 0 : altPhone.hashCode) +
      (dob == null ? 0 : dob.hashCode) +
      (gender == null ? 0 : gender.hashCode) +
      joiningDate.hashCode +
      (exitDate == null ? 0 : exitDate.hashCode) +
      (exitReason == null ? 0 : exitReason.hashCode) +
      (contractorName == null ? 0 : contractorName.hashCode) +
      (uan == null ? 0 : uan.hashCode) +
      (esicNo == null ? 0 : esicNo.hashCode) +
      (aadhaarLast4 == null ? 0 : aadhaarLast4.hashCode) +
      (panMasked == null ? 0 : panMasked.hashCode) +
      hasBankDetails.hashCode +
      preferredChannel.hashCode +
      hasPhoto.hashCode +
      hasLogin.hashCode +
      businessUnits.hashCode +
      (currentJob == null ? 0 : currentJob.hashCode) +
      jobs.hashCode +
      compliance.hashCode;

  factory EmployeeDetail.fromJson(Map<String, dynamic> json) =>
      _$EmployeeDetailFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeDetailToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
