//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'roster_copy_result_skipped_inner.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class RosterCopyResultSkippedInner {
  /// Returns a new [RosterCopyResultSkippedInner] instance.
  RosterCopyResultSkippedInner({
    required this.date,

    required this.employeeId,

    required this.employeeName,

    required this.reason,
  });

  /// Calendar date (IST business date)
  @JsonKey(name: r'date', required: true, includeIfNull: false)
  final String date;

  @JsonKey(name: r'employeeId', required: true, includeIfNull: false)
  final String employeeId;

  @JsonKey(name: r'employeeName', required: true, includeIfNull: false)
  final String employeeName;

  /// Error code, e.g. DOCUMENT_INVALID, EMPLOYEE_ON_LEAVE, ROSTER_RULE_VIOLATION
  @JsonKey(name: r'reason', required: true, includeIfNull: false)
  final String reason;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RosterCopyResultSkippedInner &&
          other.date == date &&
          other.employeeId == employeeId &&
          other.employeeName == employeeName &&
          other.reason == reason;

  @override
  int get hashCode =>
      date.hashCode +
      employeeId.hashCode +
      employeeName.hashCode +
      reason.hashCode;

  factory RosterCopyResultSkippedInner.fromJson(Map<String, dynamic> json) =>
      _$RosterCopyResultSkippedInnerFromJson(json);

  Map<String, dynamic> toJson() => _$RosterCopyResultSkippedInnerToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
