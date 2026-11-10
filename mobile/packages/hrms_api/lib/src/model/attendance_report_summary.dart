//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attendance_report_summary.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AttendanceReportSummary {
  /// Returns a new [AttendanceReportSummary] instance.
  AttendanceReportSummary({
    required this.present,

    required this.absent,

    required this.halfDay,

    required this.leave,

    required this.onDuty,

    required this.weeklyOff,

    required this.holiday,

    required this.pending,

    required this.rejected,

    required this.notMarked,
  });

  @JsonKey(name: r'present', required: true, includeIfNull: false)
  final int present;

  @JsonKey(name: r'absent', required: true, includeIfNull: false)
  final int absent;

  @JsonKey(name: r'halfDay', required: true, includeIfNull: false)
  final int halfDay;

  @JsonKey(name: r'leave', required: true, includeIfNull: false)
  final int leave;

  @JsonKey(name: r'onDuty', required: true, includeIfNull: false)
  final int onDuty;

  @JsonKey(name: r'weeklyOff', required: true, includeIfNull: false)
  final int weeklyOff;

  @JsonKey(name: r'holiday', required: true, includeIfNull: false)
  final int holiday;

  /// Self-marks waiting for approval
  @JsonKey(name: r'pending', required: true, includeIfNull: false)
  final int pending;

  @JsonKey(name: r'rejected', required: true, includeIfNull: false)
  final int rejected;

  /// Past days (from joining) with no mark
  @JsonKey(name: r'notMarked', required: true, includeIfNull: false)
  final int notMarked;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttendanceReportSummary &&
          other.present == present &&
          other.absent == absent &&
          other.halfDay == halfDay &&
          other.leave == leave &&
          other.onDuty == onDuty &&
          other.weeklyOff == weeklyOff &&
          other.holiday == holiday &&
          other.pending == pending &&
          other.rejected == rejected &&
          other.notMarked == notMarked;

  @override
  int get hashCode =>
      present.hashCode +
      absent.hashCode +
      halfDay.hashCode +
      leave.hashCode +
      onDuty.hashCode +
      weeklyOff.hashCode +
      holiday.hashCode +
      pending.hashCode +
      rejected.hashCode +
      notMarked.hashCode;

  factory AttendanceReportSummary.fromJson(Map<String, dynamic> json) =>
      _$AttendanceReportSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceReportSummaryToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
