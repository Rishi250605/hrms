//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/depot_summary.dart';
import 'package:hrms_api/src/model/person_ref.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'employee_job_item.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class EmployeeJobItem {
  /// Returns a new [EmployeeJobItem] instance.
  EmployeeJobItem({
    required this.id,

    required this.depot,

    required this.designation,

    required this.grade,

    required this.reportingTo,

    required this.effectiveFrom,

    required this.effectiveTo,

    required this.changeReason,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'depot', required: true, includeIfNull: false)
  final DepotSummary depot;

  @JsonKey(name: r'designation', required: true, includeIfNull: false)
  final String designation;

  @JsonKey(name: r'grade', required: true, includeIfNull: true)
  final String? grade;

  @JsonKey(name: r'reportingTo', required: true, includeIfNull: true)
  final PersonRef? reportingTo;

  /// Calendar date (IST business date)
  @JsonKey(name: r'effectiveFrom', required: true, includeIfNull: false)
  final String effectiveFrom;

  /// Exclusive; null = open
  @JsonKey(name: r'effectiveTo', required: true, includeIfNull: true)
  final String? effectiveTo;

  @JsonKey(name: r'changeReason', required: true, includeIfNull: true)
  final String? changeReason;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmployeeJobItem &&
          other.id == id &&
          other.depot == depot &&
          other.designation == designation &&
          other.grade == grade &&
          other.reportingTo == reportingTo &&
          other.effectiveFrom == effectiveFrom &&
          other.effectiveTo == effectiveTo &&
          other.changeReason == changeReason;

  @override
  int get hashCode =>
      id.hashCode +
      depot.hashCode +
      designation.hashCode +
      (grade == null ? 0 : grade.hashCode) +
      (reportingTo == null ? 0 : reportingTo.hashCode) +
      effectiveFrom.hashCode +
      (effectiveTo == null ? 0 : effectiveTo.hashCode) +
      (changeReason == null ? 0 : changeReason.hashCode);

  factory EmployeeJobItem.fromJson(Map<String, dynamic> json) =>
      _$EmployeeJobItemFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeJobItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
