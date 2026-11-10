//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/role.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payslip_item_employee.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PayslipItemEmployee {
  /// Returns a new [PayslipItemEmployee] instance.
  PayslipItemEmployee({
    required this.employeeId,

    required this.empCode,

    required this.name,

    required this.role,

    required this.category,
  });

  @JsonKey(name: r'employeeId', required: true, includeIfNull: false)
  final String employeeId;

  @JsonKey(name: r'empCode', required: true, includeIfNull: false)
  final String empCode;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  /// Null for non-login staff
  @JsonKey(name: r'role', required: true, includeIfNull: true)
  final Role? role;

  @JsonKey(name: r'category', required: true, includeIfNull: false)
  final String category;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PayslipItemEmployee &&
          other.employeeId == employeeId &&
          other.empCode == empCode &&
          other.name == name &&
          other.role == role &&
          other.category == category;

  @override
  int get hashCode =>
      employeeId.hashCode +
      empCode.hashCode +
      name.hashCode +
      (role == null ? 0 : role.hashCode) +
      category.hashCode;

  factory PayslipItemEmployee.fromJson(Map<String, dynamic> json) =>
      _$PayslipItemEmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$PayslipItemEmployeeToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
