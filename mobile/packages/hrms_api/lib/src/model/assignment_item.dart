//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/roster_warning.dart';
import 'package:hrms_api/src/model/assignment_role.dart';
import 'package:hrms_api/src/model/roster_employee.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'assignment_item.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AssignmentItem {
  /// Returns a new [AssignmentItem] instance.
  AssignmentItem({
    required this.id,

    required this.dutyId,

    required this.role,

    required this.isSpare,

    required this.warnings,

    required this.employee,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'dutyId', required: true, includeIfNull: false)
  final String dutyId;

  @JsonKey(name: r'role', required: true, includeIfNull: false)
  final AssignmentRole role;

  @JsonKey(name: r'isSpare', required: true, includeIfNull: false)
  final bool isSpare;

  /// Warnings accepted when the assignment was made
  @JsonKey(name: r'warnings', required: true, includeIfNull: false)
  final List<RosterWarning> warnings;

  @JsonKey(name: r'employee', required: true, includeIfNull: false)
  final RosterEmployee employee;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AssignmentItem &&
          other.id == id &&
          other.dutyId == dutyId &&
          other.role == role &&
          other.isSpare == isSpare &&
          other.warnings == warnings &&
          other.employee == employee;

  @override
  int get hashCode =>
      id.hashCode +
      dutyId.hashCode +
      role.hashCode +
      isSpare.hashCode +
      warnings.hashCode +
      employee.hashCode;

  factory AssignmentItem.fromJson(Map<String, dynamic> json) =>
      _$AssignmentItemFromJson(json);

  Map<String, dynamic> toJson() => _$AssignmentItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
