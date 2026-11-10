//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/assignment_role.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'assignment_create_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AssignmentCreateBody {
  /// Returns a new [AssignmentCreateBody] instance.
  AssignmentCreateBody({
    required this.employeeId,

    required this.role,

    this.isSpare = false,
  });

  @JsonKey(name: r'employeeId', required: true, includeIfNull: false)
  final String employeeId;

  @JsonKey(name: r'role', required: true, includeIfNull: false)
  final AssignmentRole role;

  @JsonKey(
    defaultValue: false,
    name: r'isSpare',
    required: false,
    includeIfNull: false,
  )
  final bool? isSpare;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AssignmentCreateBody &&
          other.employeeId == employeeId &&
          other.role == role &&
          other.isSpare == isSpare;

  @override
  int get hashCode => employeeId.hashCode + role.hashCode + isSpare.hashCode;

  factory AssignmentCreateBody.fromJson(Map<String, dynamic> json) =>
      _$AssignmentCreateBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AssignmentCreateBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
