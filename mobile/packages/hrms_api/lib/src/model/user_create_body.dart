//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/role.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_create_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UserCreateBody {
  /// Returns a new [UserCreateBody] instance.
  UserCreateBody({
    this.existingEmployeeId,

    this.empCode,

    this.fullName,

    required this.phone,

    this.email,

    required this.role,

    this.businessUnitIds,

    this.primaryBusinessUnitId,

    this.reportingToEmployeeId,

    this.depotId,

    this.designation,

    this.joiningDate,

    required this.password,
  });

  /// Give a login to an existing employee (e.g. a driver promoted to RM). Omit to create a new employee.
  @JsonKey(name: r'existingEmployeeId', required: false, includeIfNull: false)
  final String? existingEmployeeId;

  /// Required for a new employee: BU code + digits, e.g. NLS001
  @JsonKey(name: r'empCode', required: false, includeIfNull: false)
  final String? empCode;

  @JsonKey(name: r'fullName', required: false, includeIfNull: false)
  final String? fullName;

  /// E.164, or a 10-digit Indian mobile number
  @JsonKey(name: r'phone', required: true, includeIfNull: false)
  final String phone;

  @JsonKey(name: r'email', required: false, includeIfNull: false)
  final String? email;

  @JsonKey(name: r'role', required: true, includeIfNull: false)
  final Role role;

  /// Required except for the director
  @JsonKey(name: r'businessUnitIds', required: false, includeIfNull: false)
  final List<String>? businessUnitIds;

  @JsonKey(
    name: r'primaryBusinessUnitId',
    required: false,
    includeIfNull: false,
  )
  final String? primaryBusinessUnitId;

  /// One role up, sharing a BU (none for the director)
  @JsonKey(
    name: r'reportingToEmployeeId',
    required: false,
    includeIfNull: false,
  )
  final String? reportingToEmployeeId;

  /// Base depot for a new employee (must be in one of the BUs)
  @JsonKey(name: r'depotId', required: false, includeIfNull: false)
  final String? depotId;

  @JsonKey(name: r'designation', required: false, includeIfNull: false)
  final String? designation;

  /// Calendar date (IST business date)
  @JsonKey(name: r'joiningDate', required: false, includeIfNull: false)
  final String? joiningDate;

  @JsonKey(name: r'password', required: true, includeIfNull: false)
  final String password;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserCreateBody &&
          other.existingEmployeeId == existingEmployeeId &&
          other.empCode == empCode &&
          other.fullName == fullName &&
          other.phone == phone &&
          other.email == email &&
          other.role == role &&
          other.businessUnitIds == businessUnitIds &&
          other.primaryBusinessUnitId == primaryBusinessUnitId &&
          other.reportingToEmployeeId == reportingToEmployeeId &&
          other.depotId == depotId &&
          other.designation == designation &&
          other.joiningDate == joiningDate &&
          other.password == password;

  @override
  int get hashCode =>
      existingEmployeeId.hashCode +
      empCode.hashCode +
      fullName.hashCode +
      phone.hashCode +
      email.hashCode +
      role.hashCode +
      businessUnitIds.hashCode +
      primaryBusinessUnitId.hashCode +
      reportingToEmployeeId.hashCode +
      depotId.hashCode +
      designation.hashCode +
      joiningDate.hashCode +
      password.hashCode;

  factory UserCreateBody.fromJson(Map<String, dynamic> json) =>
      _$UserCreateBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UserCreateBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
