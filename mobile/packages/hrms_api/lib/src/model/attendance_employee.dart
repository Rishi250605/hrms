//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/role.dart';
import 'package:hrms_api/src/model/employee_category.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attendance_employee.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AttendanceEmployee {
  /// Returns a new [AttendanceEmployee] instance.
  AttendanceEmployee({
    required this.id,

    required this.empCode,

    required this.fullName,

    required this.category,

    required this.role,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'empCode', required: true, includeIfNull: false)
  final String empCode;

  @JsonKey(name: r'fullName', required: true, includeIfNull: false)
  final String fullName;

  @JsonKey(name: r'category', required: true, includeIfNull: false)
  final EmployeeCategory category;

  @JsonKey(name: r'role', required: true, includeIfNull: true)
  final Role? role;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttendanceEmployee &&
          other.id == id &&
          other.empCode == empCode &&
          other.fullName == fullName &&
          other.category == category &&
          other.role == role;

  @override
  int get hashCode =>
      id.hashCode +
      empCode.hashCode +
      fullName.hashCode +
      category.hashCode +
      (role == null ? 0 : role.hashCode);

  factory AttendanceEmployee.fromJson(Map<String, dynamic> json) =>
      _$AttendanceEmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceEmployeeToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
