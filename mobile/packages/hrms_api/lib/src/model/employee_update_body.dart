//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/employee_category.dart';
import 'package:hrms_api/src/model/gender.dart';
import 'package:hrms_api/src/model/preferred_channel.dart';
import 'package:hrms_api/src/model/employment_type.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'employee_update_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class EmployeeUpdateBody {
  /// Returns a new [EmployeeUpdateBody] instance.
  EmployeeUpdateBody({
    this.fullName,

    this.phone,

    this.altPhone,

    this.dob,

    this.gender,

    this.category,

    this.employmentType,

    this.contractorName,

    this.preferredChannel,

    this.uan,

    this.esicNo,

    this.pan,

    this.aadhaarLast4,

    this.status,
  });

  @JsonKey(name: r'fullName', required: false, includeIfNull: false)
  final String? fullName;

  /// E.164, or a 10-digit Indian mobile number
  @JsonKey(name: r'phone', required: false, includeIfNull: false)
  final String? phone;

  /// E.164, or a 10-digit Indian mobile number
  @JsonKey(name: r'altPhone', required: false, includeIfNull: false)
  final String? altPhone;

  /// Calendar date (IST business date)
  @JsonKey(name: r'dob', required: false, includeIfNull: false)
  final String? dob;

  @JsonKey(name: r'gender', required: false, includeIfNull: false)
  final Gender? gender;

  @JsonKey(name: r'category', required: false, includeIfNull: false)
  final EmployeeCategory? category;

  @JsonKey(name: r'employmentType', required: false, includeIfNull: false)
  final EmploymentType? employmentType;

  @JsonKey(name: r'contractorName', required: false, includeIfNull: false)
  final String? contractorName;

  @JsonKey(name: r'preferredChannel', required: false, includeIfNull: false)
  final PreferredChannel? preferredChannel;

  @JsonKey(name: r'uan', required: false, includeIfNull: false)
  final String? uan;

  @JsonKey(name: r'esicNo', required: false, includeIfNull: false)
  final String? esicNo;

  @JsonKey(name: r'pan', required: false, includeIfNull: false)
  final String? pan;

  @JsonKey(name: r'aadhaarLast4', required: false, includeIfNull: false)
  final String? aadhaarLast4;

  /// Suspend / reinstate. Exits go through POST /employees/{id}/exit.
  @JsonKey(name: r'status', required: false, includeIfNull: false)
  final EmployeeUpdateBodyStatusEnum? status;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmployeeUpdateBody &&
          other.fullName == fullName &&
          other.phone == phone &&
          other.altPhone == altPhone &&
          other.dob == dob &&
          other.gender == gender &&
          other.category == category &&
          other.employmentType == employmentType &&
          other.contractorName == contractorName &&
          other.preferredChannel == preferredChannel &&
          other.uan == uan &&
          other.esicNo == esicNo &&
          other.pan == pan &&
          other.aadhaarLast4 == aadhaarLast4 &&
          other.status == status;

  @override
  int get hashCode =>
      fullName.hashCode +
      phone.hashCode +
      altPhone.hashCode +
      (dob == null ? 0 : dob.hashCode) +
      (gender == null ? 0 : gender.hashCode) +
      category.hashCode +
      employmentType.hashCode +
      (contractorName == null ? 0 : contractorName.hashCode) +
      preferredChannel.hashCode +
      (uan == null ? 0 : uan.hashCode) +
      (esicNo == null ? 0 : esicNo.hashCode) +
      (pan == null ? 0 : pan.hashCode) +
      (aadhaarLast4 == null ? 0 : aadhaarLast4.hashCode) +
      status.hashCode;

  factory EmployeeUpdateBody.fromJson(Map<String, dynamic> json) =>
      _$EmployeeUpdateBodyFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeUpdateBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

/// Suspend / reinstate. Exits go through POST /employees/{id}/exit.
enum EmployeeUpdateBodyStatusEnum {
  @JsonValue(r'ACTIVE')
  ACTIVE(r'ACTIVE'),
  @JsonValue(r'SUSPENDED')
  SUSPENDED(r'SUSPENDED');

  const EmployeeUpdateBodyStatusEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
