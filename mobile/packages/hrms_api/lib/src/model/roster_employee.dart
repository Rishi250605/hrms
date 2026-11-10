//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/employee_category.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'roster_employee.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class RosterEmployee {
  /// Returns a new [RosterEmployee] instance.
  RosterEmployee({
    required this.id,

    required this.empCode,

    required this.fullName,

    required this.category,

    required this.phone,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'empCode', required: true, includeIfNull: false)
  final String empCode;

  @JsonKey(name: r'fullName', required: true, includeIfNull: false)
  final String fullName;

  @JsonKey(name: r'category', required: true, includeIfNull: false)
  final EmployeeCategory category;

  @JsonKey(name: r'phone', required: true, includeIfNull: false)
  final String phone;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RosterEmployee &&
          other.id == id &&
          other.empCode == empCode &&
          other.fullName == fullName &&
          other.category == category &&
          other.phone == phone;

  @override
  int get hashCode =>
      id.hashCode +
      empCode.hashCode +
      fullName.hashCode +
      category.hashCode +
      phone.hashCode;

  factory RosterEmployee.fromJson(Map<String, dynamic> json) =>
      _$RosterEmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$RosterEmployeeToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
