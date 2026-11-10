//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/business_unit_ref.dart';
import 'package:hrms_api/src/model/person_ref.dart';
import 'package:hrms_api/src/model/request_status.dart';
import 'package:hrms_api/src/model/allowance_item_allowance_type.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'allowance_item.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AllowanceItem {
  /// Returns a new [AllowanceItem] instance.
  AllowanceItem({
    required this.id,

    required this.batchId,

    required this.beneficiary,

    required this.raisedBy,

    required this.businessUnit,

    required this.allowanceType,

    required this.requestedAmountPaise,

    required this.approvedAmountPaise,

    required this.fromDate,

    required this.toDate,

    required this.comment,

    required this.hasVoiceNote,

    required this.hasReceipt,

    required this.status,

    required this.approver,

    required this.decidedAt,

    required this.decidedByName,

    required this.decisionComment,

    required this.rejectionReason,

    required this.canDecide,

    required this.createdAt,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'batchId', required: true, includeIfNull: false)
  final String batchId;

  @JsonKey(name: r'beneficiary', required: true, includeIfNull: false)
  final PersonRef beneficiary;

  @JsonKey(name: r'raisedBy', required: true, includeIfNull: false)
  final PersonRef raisedBy;

  @JsonKey(name: r'businessUnit', required: true, includeIfNull: false)
  final BusinessUnitRef businessUnit;

  @JsonKey(name: r'allowanceType', required: true, includeIfNull: false)
  final AllowanceItemAllowanceType allowanceType;

  @JsonKey(name: r'requestedAmountPaise', required: true, includeIfNull: false)
  final int requestedAmountPaise;

  @JsonKey(name: r'approvedAmountPaise', required: true, includeIfNull: true)
  final int? approvedAmountPaise;

  /// Calendar date (IST business date)
  @JsonKey(name: r'fromDate', required: true, includeIfNull: false)
  final String fromDate;

  /// Calendar date (IST business date)
  @JsonKey(name: r'toDate', required: true, includeIfNull: false)
  final String toDate;

  @JsonKey(name: r'comment', required: true, includeIfNull: true)
  final String? comment;

  @JsonKey(name: r'hasVoiceNote', required: true, includeIfNull: false)
  final bool hasVoiceNote;

  @JsonKey(name: r'hasReceipt', required: true, includeIfNull: false)
  final bool hasReceipt;

  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final RequestStatus status;

  @JsonKey(name: r'approver', required: true, includeIfNull: true)
  final PersonRef? approver;

  @JsonKey(name: r'decidedAt', required: true, includeIfNull: true)
  final DateTime? decidedAt;

  @JsonKey(name: r'decidedByName', required: true, includeIfNull: true)
  final String? decidedByName;

  @JsonKey(name: r'decisionComment', required: true, includeIfNull: true)
  final String? decisionComment;

  @JsonKey(name: r'rejectionReason', required: true, includeIfNull: true)
  final String? rejectionReason;

  @JsonKey(name: r'canDecide', required: true, includeIfNull: false)
  final bool canDecide;

  @JsonKey(name: r'createdAt', required: true, includeIfNull: false)
  final DateTime createdAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AllowanceItem &&
          other.id == id &&
          other.batchId == batchId &&
          other.beneficiary == beneficiary &&
          other.raisedBy == raisedBy &&
          other.businessUnit == businessUnit &&
          other.allowanceType == allowanceType &&
          other.requestedAmountPaise == requestedAmountPaise &&
          other.approvedAmountPaise == approvedAmountPaise &&
          other.fromDate == fromDate &&
          other.toDate == toDate &&
          other.comment == comment &&
          other.hasVoiceNote == hasVoiceNote &&
          other.hasReceipt == hasReceipt &&
          other.status == status &&
          other.approver == approver &&
          other.decidedAt == decidedAt &&
          other.decidedByName == decidedByName &&
          other.decisionComment == decisionComment &&
          other.rejectionReason == rejectionReason &&
          other.canDecide == canDecide &&
          other.createdAt == createdAt;

  @override
  int get hashCode =>
      id.hashCode +
      batchId.hashCode +
      beneficiary.hashCode +
      raisedBy.hashCode +
      businessUnit.hashCode +
      allowanceType.hashCode +
      requestedAmountPaise.hashCode +
      (approvedAmountPaise == null ? 0 : approvedAmountPaise.hashCode) +
      fromDate.hashCode +
      toDate.hashCode +
      (comment == null ? 0 : comment.hashCode) +
      hasVoiceNote.hashCode +
      hasReceipt.hashCode +
      status.hashCode +
      (approver == null ? 0 : approver.hashCode) +
      (decidedAt == null ? 0 : decidedAt.hashCode) +
      (decidedByName == null ? 0 : decidedByName.hashCode) +
      (decisionComment == null ? 0 : decisionComment.hashCode) +
      (rejectionReason == null ? 0 : rejectionReason.hashCode) +
      canDecide.hashCode +
      createdAt.hashCode;

  factory AllowanceItem.fromJson(Map<String, dynamic> json) =>
      _$AllowanceItemFromJson(json);

  Map<String, dynamic> toJson() => _$AllowanceItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
