//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/business_unit_ref.dart';
import 'package:hrms_api/src/model/attendance_status.dart';
import 'package:hrms_api/src/model/person_ref.dart';
import 'package:hrms_api/src/model/attendance_employee.dart';
import 'package:hrms_api/src/model/request_status.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'correction_item.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CorrectionItem {
  /// Returns a new [CorrectionItem] instance.
  CorrectionItem({
    required this.id,

    required this.employee,

    required this.businessUnit,

    required this.date,

    required this.fromStatus,

    required this.toStatus,

    required this.reason,

    required this.status,

    required this.raisedByName,

    required this.approver,

    required this.decidedAt,

    required this.rejectionReason,

    required this.canDecide,

    required this.createdAt,
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

  @JsonKey(name: r'fromStatus', required: true, includeIfNull: true)
  final AttendanceStatus? fromStatus;

  @JsonKey(name: r'toStatus', required: true, includeIfNull: false)
  final AttendanceStatus toStatus;

  @JsonKey(name: r'reason', required: true, includeIfNull: false)
  final String reason;

  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final RequestStatus status;

  @JsonKey(name: r'raisedByName', required: true, includeIfNull: false)
  final String raisedByName;

  @JsonKey(name: r'approver', required: true, includeIfNull: true)
  final PersonRef? approver;

  @JsonKey(name: r'decidedAt', required: true, includeIfNull: true)
  final DateTime? decidedAt;

  @JsonKey(name: r'rejectionReason', required: true, includeIfNull: true)
  final String? rejectionReason;

  @JsonKey(name: r'canDecide', required: true, includeIfNull: false)
  final bool canDecide;

  @JsonKey(name: r'createdAt', required: true, includeIfNull: false)
  final DateTime createdAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CorrectionItem &&
          other.id == id &&
          other.employee == employee &&
          other.businessUnit == businessUnit &&
          other.date == date &&
          other.fromStatus == fromStatus &&
          other.toStatus == toStatus &&
          other.reason == reason &&
          other.status == status &&
          other.raisedByName == raisedByName &&
          other.approver == approver &&
          other.decidedAt == decidedAt &&
          other.rejectionReason == rejectionReason &&
          other.canDecide == canDecide &&
          other.createdAt == createdAt;

  @override
  int get hashCode =>
      id.hashCode +
      employee.hashCode +
      businessUnit.hashCode +
      date.hashCode +
      (fromStatus == null ? 0 : fromStatus.hashCode) +
      toStatus.hashCode +
      reason.hashCode +
      status.hashCode +
      raisedByName.hashCode +
      (approver == null ? 0 : approver.hashCode) +
      (decidedAt == null ? 0 : decidedAt.hashCode) +
      (rejectionReason == null ? 0 : rejectionReason.hashCode) +
      canDecide.hashCode +
      createdAt.hashCode;

  factory CorrectionItem.fromJson(Map<String, dynamic> json) =>
      _$CorrectionItemFromJson(json);

  Map<String, dynamic> toJson() => _$CorrectionItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
