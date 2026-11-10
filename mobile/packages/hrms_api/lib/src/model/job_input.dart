//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'job_input.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class JobInput {
  /// Returns a new [JobInput] instance.
  JobInput({
    required this.depotId,

    required this.designation,

    this.grade,

    required this.reportingToEmployeeId,
  });

  /// Must belong to the business unit
  @JsonKey(name: r'depotId', required: true, includeIfNull: false)
  final String depotId;

  @JsonKey(name: r'designation', required: true, includeIfNull: false)
  final String designation;

  @JsonKey(name: r'grade', required: false, includeIfNull: false)
  final String? grade;

  /// The regional manager (sharing the business unit)
  @JsonKey(name: r'reportingToEmployeeId', required: true, includeIfNull: false)
  final String reportingToEmployeeId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JobInput &&
          other.depotId == depotId &&
          other.designation == designation &&
          other.grade == grade &&
          other.reportingToEmployeeId == reportingToEmployeeId;

  @override
  int get hashCode =>
      depotId.hashCode +
      designation.hashCode +
      grade.hashCode +
      reportingToEmployeeId.hashCode;

  factory JobInput.fromJson(Map<String, dynamic> json) =>
      _$JobInputFromJson(json);

  Map<String, dynamic> toJson() => _$JobInputToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
