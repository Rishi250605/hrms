//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/business_unit_ref.dart';
import 'package:hrms_api/src/model/attendance_status.dart';
import 'package:hrms_api/src/model/approval_state.dart';
import 'package:hrms_api/src/model/person_ref.dart';
import 'package:hrms_api/src/model/attendance_employee.dart';
import 'package:hrms_api/src/model/attendance_source.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attendance_mark_item.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AttendanceMarkItem {
  /// Returns a new [AttendanceMarkItem] instance.
  AttendanceMarkItem({
    required this.id,

    required this.employee,

    required this.businessUnit,

    required this.date,

    required this.status,

    required this.approvalState,

    required this.source_,

    required this.note,

    required this.markedAt,

    required this.markedByName,

    required this.approver,

    required this.decidedAt,

    required this.decidedByName,

    required this.rejectionReason,

    required this.canDecide,

    required this.clientMutationId,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'employee', required: true, includeIfNull: false)
  final AttendanceEmployee employee;

  @JsonKey(name: r'businessUnit', required: true, includeIfNull: false)
  final BusinessUnitRef businessUnit;

  /// Calendar date (IST business date)
  @JsonKey(name: r'date', required: true, includeIfNull: false)
  final String date;

  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final AttendanceStatus status;

  @JsonKey(name: r'approvalState', required: true, includeIfNull: false)
  final ApprovalState approvalState;

  @JsonKey(name: r'source', required: true, includeIfNull: false)
  final AttendanceSource source_;

  @JsonKey(name: r'note', required: true, includeIfNull: true)
  final String? note;

  @JsonKey(name: r'markedAt', required: true, includeIfNull: false)
  final DateTime markedAt;

  @JsonKey(name: r'markedByName', required: true, includeIfNull: false)
  final String markedByName;

  @JsonKey(name: r'approver', required: true, includeIfNull: true)
  final PersonRef? approver;

  @JsonKey(name: r'decidedAt', required: true, includeIfNull: true)
  final DateTime? decidedAt;

  @JsonKey(name: r'decidedByName', required: true, includeIfNull: true)
  final String? decidedByName;

  @JsonKey(name: r'rejectionReason', required: true, includeIfNull: true)
  final String? rejectionReason;

  /// True when the caller may approve / reject it
  @JsonKey(name: r'canDecide', required: true, includeIfNull: false)
  final bool canDecide;

  @JsonKey(name: r'clientMutationId', required: true, includeIfNull: true)
  final String? clientMutationId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttendanceMarkItem &&
          other.id == id &&
          other.employee == employee &&
          other.businessUnit == businessUnit &&
          other.date == date &&
          other.status == status &&
          other.approvalState == approvalState &&
          other.source_ == source_ &&
          other.note == note &&
          other.markedAt == markedAt &&
          other.markedByName == markedByName &&
          other.approver == approver &&
          other.decidedAt == decidedAt &&
          other.decidedByName == decidedByName &&
          other.rejectionReason == rejectionReason &&
          other.canDecide == canDecide &&
          other.clientMutationId == clientMutationId;

  @override
  int get hashCode =>
      id.hashCode +
      employee.hashCode +
      businessUnit.hashCode +
      date.hashCode +
      status.hashCode +
      approvalState.hashCode +
      source_.hashCode +
      (note == null ? 0 : note.hashCode) +
      markedAt.hashCode +
      markedByName.hashCode +
      (approver == null ? 0 : approver.hashCode) +
      (decidedAt == null ? 0 : decidedAt.hashCode) +
      (decidedByName == null ? 0 : decidedByName.hashCode) +
      (rejectionReason == null ? 0 : rejectionReason.hashCode) +
      canDecide.hashCode +
      (clientMutationId == null ? 0 : clientMutationId.hashCode);

  factory AttendanceMarkItem.fromJson(Map<String, dynamic> json) =>
      _$AttendanceMarkItemFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceMarkItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
