//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/roster_warning.dart';
import 'package:hrms_api/src/model/assignment_item.dart';
import 'package:hrms_api/src/model/duty_item.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'assignment_result.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AssignmentResult {
  /// Returns a new [AssignmentResult] instance.
  AssignmentResult({
    required this.assignment,

    required this.warnings,

    required this.duty,
  });

  @JsonKey(name: r'assignment', required: true, includeIfNull: false)
  final AssignmentItem assignment;

  @JsonKey(name: r'warnings', required: true, includeIfNull: false)
  final List<RosterWarning> warnings;

  @JsonKey(name: r'duty', required: true, includeIfNull: false)
  final DutyItem duty;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AssignmentResult &&
          other.assignment == assignment &&
          other.warnings == warnings &&
          other.duty == duty;

  @override
  int get hashCode => assignment.hashCode + warnings.hashCode + duty.hashCode;

  factory AssignmentResult.fromJson(Map<String, dynamic> json) =>
      _$AssignmentResultFromJson(json);

  Map<String, dynamic> toJson() => _$AssignmentResultToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
