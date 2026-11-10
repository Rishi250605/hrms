//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/roster_warning.dart';
import 'package:hrms_api/src/model/compliance_overall.dart';
import 'package:hrms_api/src/model/roster_employee.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'spare_item.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class SpareItem {
  /// Returns a new [SpareItem] instance.
  SpareItem({
    required this.employee,

    required this.designation,

    required this.compliance,

    required this.dutyMinutesLast7Days,

    required this.dutiesOnDate,

    required this.warnings,
  });

  @JsonKey(name: r'employee', required: true, includeIfNull: false)
  final RosterEmployee employee;

  @JsonKey(name: r'designation', required: true, includeIfNull: true)
  final String? designation;

  @JsonKey(name: r'compliance', required: true, includeIfNull: false)
  final ComplianceOverall compliance;

  @JsonKey(name: r'dutyMinutesLast7Days', required: true, includeIfNull: false)
  final int dutyMinutesLast7Days;

  @JsonKey(name: r'dutiesOnDate', required: true, includeIfNull: false)
  final int dutiesOnDate;

  /// Rule warnings if assigned to dutyId (empty when dutyId is not given)
  @JsonKey(name: r'warnings', required: true, includeIfNull: false)
  final List<RosterWarning> warnings;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpareItem &&
          other.employee == employee &&
          other.designation == designation &&
          other.compliance == compliance &&
          other.dutyMinutesLast7Days == dutyMinutesLast7Days &&
          other.dutiesOnDate == dutiesOnDate &&
          other.warnings == warnings;

  @override
  int get hashCode =>
      employee.hashCode +
      (designation == null ? 0 : designation.hashCode) +
      compliance.hashCode +
      dutyMinutesLast7Days.hashCode +
      dutiesOnDate.hashCode +
      warnings.hashCode;

  factory SpareItem.fromJson(Map<String, dynamic> json) =>
      _$SpareItemFromJson(json);

  Map<String, dynamic> toJson() => _$SpareItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
