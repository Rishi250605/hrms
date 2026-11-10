//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'job_change_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class JobChangeBody {
  /// Returns a new [JobChangeBody] instance.
  JobChangeBody({
    required this.effectiveFrom,

    this.depotId,

    this.designation,

    this.grade,

    this.reportingToEmployeeId,

    required this.reason,
  });

  /// Calendar date (IST business date)
  @JsonKey(name: r'effectiveFrom', required: true, includeIfNull: false)
  final String effectiveFrom;

  @JsonKey(name: r'depotId', required: false, includeIfNull: false)
  final String? depotId;

  @JsonKey(name: r'designation', required: false, includeIfNull: false)
  final String? designation;

  @JsonKey(name: r'grade', required: false, includeIfNull: false)
  final String? grade;

  @JsonKey(
    name: r'reportingToEmployeeId',
    required: false,
    includeIfNull: false,
  )
  final String? reportingToEmployeeId;

  @JsonKey(name: r'reason', required: true, includeIfNull: false)
  final String reason;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JobChangeBody &&
          other.effectiveFrom == effectiveFrom &&
          other.depotId == depotId &&
          other.designation == designation &&
          other.grade == grade &&
          other.reportingToEmployeeId == reportingToEmployeeId &&
          other.reason == reason;

  @override
  int get hashCode =>
      effectiveFrom.hashCode +
      depotId.hashCode +
      designation.hashCode +
      (grade == null ? 0 : grade.hashCode) +
      reportingToEmployeeId.hashCode +
      reason.hashCode;

  factory JobChangeBody.fromJson(Map<String, dynamic> json) =>
      _$JobChangeBodyFromJson(json);

  Map<String, dynamic> toJson() => _$JobChangeBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
