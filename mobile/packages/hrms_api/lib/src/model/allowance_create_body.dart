//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'allowance_create_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AllowanceCreateBody {
  /// Returns a new [AllowanceCreateBody] instance.
  AllowanceCreateBody({
    this.beneficiaryEmployeeIds,

    required this.allowanceTypeId,

    required this.amountPaise,

    required this.fromDate,

    this.toDate,

    this.comment,

    this.voiceNoteKey,

    this.receiptKey,
  });

  /// RM: drivers / loadmen reporting to them (one request each, same batch). Omit for yourself.
  @JsonKey(
    name: r'beneficiaryEmployeeIds',
    required: false,
    includeIfNull: false,
  )
  final List<String>? beneficiaryEmployeeIds;

  @JsonKey(name: r'allowanceTypeId', required: true, includeIfNull: false)
  final String allowanceTypeId;

  /// Per beneficiary, in paise
  // minimum: 0
  @JsonKey(name: r'amountPaise', required: true, includeIfNull: false)
  final int amountPaise;

  /// Calendar date (IST business date)
  @JsonKey(name: r'fromDate', required: true, includeIfNull: false)
  final String fromDate;

  /// Calendar date (IST business date)
  @JsonKey(name: r'toDate', required: false, includeIfNull: false)
  final String? toDate;

  @JsonKey(name: r'comment', required: false, includeIfNull: false)
  final String? comment;

  /// From POST /uploads/presign (purpose VOICE_NOTE), max 2 minutes
  @JsonKey(name: r'voiceNoteKey', required: false, includeIfNull: false)
  final String? voiceNoteKey;

  /// From POST /uploads/presign (purpose RECEIPT)
  @JsonKey(name: r'receiptKey', required: false, includeIfNull: false)
  final String? receiptKey;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AllowanceCreateBody &&
          other.beneficiaryEmployeeIds == beneficiaryEmployeeIds &&
          other.allowanceTypeId == allowanceTypeId &&
          other.amountPaise == amountPaise &&
          other.fromDate == fromDate &&
          other.toDate == toDate &&
          other.comment == comment &&
          other.voiceNoteKey == voiceNoteKey &&
          other.receiptKey == receiptKey;

  @override
  int get hashCode =>
      beneficiaryEmployeeIds.hashCode +
      allowanceTypeId.hashCode +
      amountPaise.hashCode +
      fromDate.hashCode +
      toDate.hashCode +
      comment.hashCode +
      voiceNoteKey.hashCode +
      receiptKey.hashCode;

  factory AllowanceCreateBody.fromJson(Map<String, dynamic> json) =>
      _$AllowanceCreateBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AllowanceCreateBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
