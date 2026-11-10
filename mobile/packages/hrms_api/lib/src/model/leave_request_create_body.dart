//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/leave_kind.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'leave_request_create_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class LeaveRequestCreateBody {
  /// Returns a new [LeaveRequestCreateBody] instance.
  LeaveRequestCreateBody({
    this.subjectEmployeeId,

    required this.kind,

    this.leaveTypeId,

    required this.fromDate,

    required this.toDate,

    this.fromHalf,

    this.toHalf,

    required this.reason,

    this.odLocation,

    this.odPurpose,

    this.odFromTime,

    this.odToTime,

    this.autoApprove,
  });

  /// Whose leave / OD; omit for yourself. RMs raise for their drivers / loadmen.
  @JsonKey(name: r'subjectEmployeeId', required: false, includeIfNull: false)
  final String? subjectEmployeeId;

  @JsonKey(name: r'kind', required: true, includeIfNull: false)
  final LeaveKind kind;

  /// Required for LEAVE
  @JsonKey(name: r'leaveTypeId', required: false, includeIfNull: false)
  final String? leaveTypeId;

  /// Calendar date (IST business date)
  @JsonKey(name: r'fromDate', required: true, includeIfNull: false)
  final String fromDate;

  /// Calendar date (IST business date)
  @JsonKey(name: r'toDate', required: true, includeIfNull: false)
  final String toDate;

  /// Starts at mid-day on fromDate
  @JsonKey(name: r'fromHalf', required: false, includeIfNull: false)
  final bool? fromHalf;

  /// Ends at mid-day on toDate
  @JsonKey(name: r'toHalf', required: false, includeIfNull: false)
  final bool? toHalf;

  @JsonKey(name: r'reason', required: true, includeIfNull: false)
  final String reason;

  /// Required for OD
  @JsonKey(name: r'odLocation', required: false, includeIfNull: false)
  final String? odLocation;

  /// Required for OD
  @JsonKey(name: r'odPurpose', required: false, includeIfNull: false)
  final String? odPurpose;

  @JsonKey(name: r'odFromTime', required: false, includeIfNull: false)
  final String? odFromTime;

  @JsonKey(name: r'odToTime', required: false, includeIfNull: false)
  final String? odToTime;

  /// RM raising for their driver / loadman: \"Submit and approve\"
  @JsonKey(name: r'autoApprove', required: false, includeIfNull: false)
  final bool? autoApprove;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LeaveRequestCreateBody &&
          other.subjectEmployeeId == subjectEmployeeId &&
          other.kind == kind &&
          other.leaveTypeId == leaveTypeId &&
          other.fromDate == fromDate &&
          other.toDate == toDate &&
          other.fromHalf == fromHalf &&
          other.toHalf == toHalf &&
          other.reason == reason &&
          other.odLocation == odLocation &&
          other.odPurpose == odPurpose &&
          other.odFromTime == odFromTime &&
          other.odToTime == odToTime &&
          other.autoApprove == autoApprove;

  @override
  int get hashCode =>
      subjectEmployeeId.hashCode +
      kind.hashCode +
      leaveTypeId.hashCode +
      fromDate.hashCode +
      toDate.hashCode +
      fromHalf.hashCode +
      toHalf.hashCode +
      reason.hashCode +
      odLocation.hashCode +
      odPurpose.hashCode +
      odFromTime.hashCode +
      odToTime.hashCode +
      autoApprove.hashCode;

  factory LeaveRequestCreateBody.fromJson(Map<String, dynamic> json) =>
      _$LeaveRequestCreateBodyFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveRequestCreateBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
