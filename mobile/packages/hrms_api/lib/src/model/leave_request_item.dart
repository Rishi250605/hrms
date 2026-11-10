//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/leave_request_item_leave_type.dart';
import 'package:hrms_api/src/model/business_unit_ref.dart';
import 'package:hrms_api/src/model/leave_kind.dart';
import 'package:hrms_api/src/model/person_ref.dart';
import 'package:hrms_api/src/model/request_status.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'leave_request_item.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class LeaveRequestItem {
  /// Returns a new [LeaveRequestItem] instance.
  LeaveRequestItem({
    required this.id,

    required this.kind,

    required this.employee,

    required this.businessUnit,

    required this.leaveType,

    required this.fromDate,

    required this.toDate,

    required this.fromHalf,

    required this.toHalf,

    required this.days,

    required this.reason,

    required this.odLocation,

    required this.odPurpose,

    required this.odFromTime,

    required this.odToTime,

    required this.status,

    required this.raisedByName,

    required this.approver,

    required this.decidedAt,

    required this.decidedByName,

    required this.rejectionReason,

    required this.canDecide,

    required this.canCancel,

    required this.warnings,

    required this.createdAt,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'kind', required: true, includeIfNull: false)
  final LeaveKind kind;

  @JsonKey(name: r'employee', required: true, includeIfNull: false)
  final PersonRef employee;

  @JsonKey(name: r'businessUnit', required: true, includeIfNull: false)
  final BusinessUnitRef businessUnit;

  @JsonKey(name: r'leaveType', required: true, includeIfNull: true)
  final LeaveRequestItemLeaveType? leaveType;

  /// Calendar date (IST business date)
  @JsonKey(name: r'fromDate', required: true, includeIfNull: false)
  final String fromDate;

  /// Calendar date (IST business date)
  @JsonKey(name: r'toDate', required: true, includeIfNull: false)
  final String toDate;

  @JsonKey(name: r'fromHalf', required: true, includeIfNull: false)
  final bool fromHalf;

  @JsonKey(name: r'toHalf', required: true, includeIfNull: false)
  final bool toHalf;

  @JsonKey(name: r'days', required: true, includeIfNull: false)
  final num days;

  @JsonKey(name: r'reason', required: true, includeIfNull: false)
  final String reason;

  @JsonKey(name: r'odLocation', required: true, includeIfNull: true)
  final String? odLocation;

  @JsonKey(name: r'odPurpose', required: true, includeIfNull: true)
  final String? odPurpose;

  @JsonKey(name: r'odFromTime', required: true, includeIfNull: true)
  final String? odFromTime;

  @JsonKey(name: r'odToTime', required: true, includeIfNull: true)
  final String? odToTime;

  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final RequestStatus status;

  @JsonKey(name: r'raisedByName', required: true, includeIfNull: false)
  final String raisedByName;

  @JsonKey(name: r'approver', required: true, includeIfNull: true)
  final PersonRef? approver;

  @JsonKey(name: r'decidedAt', required: true, includeIfNull: true)
  final DateTime? decidedAt;

  @JsonKey(name: r'decidedByName', required: true, includeIfNull: true)
  final String? decidedByName;

  @JsonKey(name: r'rejectionReason', required: true, includeIfNull: true)
  final String? rejectionReason;

  @JsonKey(name: r'canDecide', required: true, includeIfNull: false)
  final bool canDecide;

  @JsonKey(name: r'canCancel', required: true, includeIfNull: false)
  final bool canCancel;

  /// e.g. INSUFFICIENT_BALANCE when the balance setting is WARN
  @JsonKey(name: r'warnings', required: true, includeIfNull: false)
  final List<String> warnings;

  @JsonKey(name: r'createdAt', required: true, includeIfNull: false)
  final DateTime createdAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LeaveRequestItem &&
          other.id == id &&
          other.kind == kind &&
          other.employee == employee &&
          other.businessUnit == businessUnit &&
          other.leaveType == leaveType &&
          other.fromDate == fromDate &&
          other.toDate == toDate &&
          other.fromHalf == fromHalf &&
          other.toHalf == toHalf &&
          other.days == days &&
          other.reason == reason &&
          other.odLocation == odLocation &&
          other.odPurpose == odPurpose &&
          other.odFromTime == odFromTime &&
          other.odToTime == odToTime &&
          other.status == status &&
          other.raisedByName == raisedByName &&
          other.approver == approver &&
          other.decidedAt == decidedAt &&
          other.decidedByName == decidedByName &&
          other.rejectionReason == rejectionReason &&
          other.canDecide == canDecide &&
          other.canCancel == canCancel &&
          other.warnings == warnings &&
          other.createdAt == createdAt;

  @override
  int get hashCode =>
      id.hashCode +
      kind.hashCode +
      employee.hashCode +
      businessUnit.hashCode +
      (leaveType == null ? 0 : leaveType.hashCode) +
      fromDate.hashCode +
      toDate.hashCode +
      fromHalf.hashCode +
      toHalf.hashCode +
      days.hashCode +
      reason.hashCode +
      (odLocation == null ? 0 : odLocation.hashCode) +
      (odPurpose == null ? 0 : odPurpose.hashCode) +
      (odFromTime == null ? 0 : odFromTime.hashCode) +
      (odToTime == null ? 0 : odToTime.hashCode) +
      status.hashCode +
      raisedByName.hashCode +
      (approver == null ? 0 : approver.hashCode) +
      (decidedAt == null ? 0 : decidedAt.hashCode) +
      (decidedByName == null ? 0 : decidedByName.hashCode) +
      (rejectionReason == null ? 0 : rejectionReason.hashCode) +
      canDecide.hashCode +
      canCancel.hashCode +
      warnings.hashCode +
      createdAt.hashCode;

  factory LeaveRequestItem.fromJson(Map<String, dynamic> json) =>
      _$LeaveRequestItemFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveRequestItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
