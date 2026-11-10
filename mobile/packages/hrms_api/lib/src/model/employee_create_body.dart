//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/employee_category.dart';
import 'package:hrms_api/src/model/gender.dart';
import 'package:hrms_api/src/model/job_input.dart';
import 'package:hrms_api/src/model/preferred_channel.dart';
import 'package:hrms_api/src/model/employment_type.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'employee_create_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class EmployeeCreateBody {
  /// Returns a new [EmployeeCreateBody] instance.
  EmployeeCreateBody({
    required this.empCode,

    required this.fullName,

    required this.phone,

    this.altPhone,

    this.dob,

    this.gender,

    required this.joiningDate,

    required this.category,

    required this.employmentType,

    this.contractorName,

    this.preferredChannel,

    required this.businessUnitId,

    this.uan,

    this.esicNo,

    this.pan,

    this.aadhaarLast4,

    this.bankAccount,

    this.ifsc,

    required this.job,
  });

  /// BU code + digits, e.g. NLS001 (GET /employees/next-code suggests one)
  @JsonKey(name: r'empCode', required: true, includeIfNull: false)
  final String empCode;

  @JsonKey(name: r'fullName', required: true, includeIfNull: false)
  final String fullName;

  /// E.164, or a 10-digit Indian mobile number
  @JsonKey(name: r'phone', required: true, includeIfNull: false)
  final String phone;

  /// E.164, or a 10-digit Indian mobile number
  @JsonKey(name: r'altPhone', required: false, includeIfNull: false)
  final String? altPhone;

  /// Calendar date (IST business date)
  @JsonKey(name: r'dob', required: false, includeIfNull: false)
  final String? dob;

  @JsonKey(name: r'gender', required: false, includeIfNull: false)
  final Gender? gender;

  /// Calendar date (IST business date)
  @JsonKey(name: r'joiningDate', required: true, includeIfNull: false)
  final String joiningDate;

  @JsonKey(name: r'category', required: true, includeIfNull: false)
  final EmployeeCategory category;

  @JsonKey(name: r'employmentType', required: true, includeIfNull: false)
  final EmploymentType employmentType;

  @JsonKey(name: r'contractorName', required: false, includeIfNull: false)
  final String? contractorName;

  @JsonKey(name: r'preferredChannel', required: false, includeIfNull: false)
  final PreferredChannel? preferredChannel;

  /// Drivers / loadmen belong to exactly one business unit
  @JsonKey(name: r'businessUnitId', required: true, includeIfNull: false)
  final String businessUnitId;

  @JsonKey(name: r'uan', required: false, includeIfNull: false)
  final String? uan;

  @JsonKey(name: r'esicNo', required: false, includeIfNull: false)
  final String? esicNo;

  @JsonKey(name: r'pan', required: false, includeIfNull: false)
  final String? pan;

  @JsonKey(name: r'aadhaarLast4', required: false, includeIfNull: false)
  final String? aadhaarLast4;

  @JsonKey(name: r'bankAccount', required: false, includeIfNull: false)
  final String? bankAccount;

  @JsonKey(name: r'ifsc', required: false, includeIfNull: false)
  final String? ifsc;

  @JsonKey(name: r'job', required: true, includeIfNull: false)
  final JobInput job;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmployeeCreateBody &&
          other.empCode == empCode &&
          other.fullName == fullName &&
          other.phone == phone &&
          other.altPhone == altPhone &&
          other.dob == dob &&
          other.gender == gender &&
          other.joiningDate == joiningDate &&
          other.category == category &&
          other.employmentType == employmentType &&
          other.contractorName == contractorName &&
          other.preferredChannel == preferredChannel &&
          other.businessUnitId == businessUnitId &&
          other.uan == uan &&
          other.esicNo == esicNo &&
          other.pan == pan &&
          other.aadhaarLast4 == aadhaarLast4 &&
          other.bankAccount == bankAccount &&
          other.ifsc == ifsc &&
          other.job == job;

  @override
  int get hashCode =>
      empCode.hashCode +
      fullName.hashCode +
      phone.hashCode +
      altPhone.hashCode +
      dob.hashCode +
      gender.hashCode +
      joiningDate.hashCode +
      category.hashCode +
      employmentType.hashCode +
      contractorName.hashCode +
      preferredChannel.hashCode +
      businessUnitId.hashCode +
      uan.hashCode +
      esicNo.hashCode +
      pan.hashCode +
      aadhaarLast4.hashCode +
      bankAccount.hashCode +
      ifsc.hashCode +
      job.hashCode;

  factory EmployeeCreateBody.fromJson(Map<String, dynamic> json) =>
      _$EmployeeCreateBodyFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeCreateBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
