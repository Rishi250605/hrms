//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/role.dart';
import 'package:hrms_api/src/model/person_ref.dart';
import 'package:hrms_api/src/model/business_unit_membership.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_item.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UserItem {
  /// Returns a new [UserItem] instance.
  UserItem({
    required this.id,

    required this.employeeId,

    required this.empCode,

    required this.name,

    required this.phone,

    required this.email,

    required this.role,

    required this.isActive,

    required this.hasPassword,

    required this.lockedUntil,

    required this.lastLoginAt,

    required this.reportingTo,

    required this.businessUnits,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'employeeId', required: true, includeIfNull: false)
  final String employeeId;

  @JsonKey(name: r'empCode', required: true, includeIfNull: false)
  final String empCode;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'phone', required: true, includeIfNull: false)
  final String phone;

  @JsonKey(name: r'email', required: true, includeIfNull: true)
  final String? email;

  @JsonKey(name: r'role', required: true, includeIfNull: false)
  final Role role;

  @JsonKey(name: r'isActive', required: true, includeIfNull: false)
  final bool isActive;

  @JsonKey(name: r'hasPassword', required: true, includeIfNull: false)
  final bool hasPassword;

  @JsonKey(name: r'lockedUntil', required: true, includeIfNull: true)
  final DateTime? lockedUntil;

  @JsonKey(name: r'lastLoginAt', required: true, includeIfNull: true)
  final DateTime? lastLoginAt;

  @JsonKey(name: r'reportingTo', required: true, includeIfNull: true)
  final PersonRef? reportingTo;

  @JsonKey(name: r'businessUnits', required: true, includeIfNull: false)
  final List<BusinessUnitMembership> businessUnits;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserItem &&
          other.id == id &&
          other.employeeId == employeeId &&
          other.empCode == empCode &&
          other.name == name &&
          other.phone == phone &&
          other.email == email &&
          other.role == role &&
          other.isActive == isActive &&
          other.hasPassword == hasPassword &&
          other.lockedUntil == lockedUntil &&
          other.lastLoginAt == lastLoginAt &&
          other.reportingTo == reportingTo &&
          other.businessUnits == businessUnits;

  @override
  int get hashCode =>
      id.hashCode +
      employeeId.hashCode +
      empCode.hashCode +
      name.hashCode +
      phone.hashCode +
      (email == null ? 0 : email.hashCode) +
      role.hashCode +
      isActive.hashCode +
      hasPassword.hashCode +
      (lockedUntil == null ? 0 : lockedUntil.hashCode) +
      (lastLoginAt == null ? 0 : lastLoginAt.hashCode) +
      (reportingTo == null ? 0 : reportingTo.hashCode) +
      businessUnits.hashCode;

  factory UserItem.fromJson(Map<String, dynamic> json) =>
      _$UserItemFromJson(json);

  Map<String, dynamic> toJson() => _$UserItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
