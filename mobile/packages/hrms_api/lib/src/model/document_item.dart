//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/document_type.dart';
import 'package:hrms_api/src/model/document_status.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'document_item.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DocumentItem {
  /// Returns a new [DocumentItem] instance.
  DocumentItem({
    required this.id,

    required this.employeeId,

    required this.type,

    required this.number,

    required this.licenceClass,

    required this.issueDate,

    required this.expiryDate,

    required this.status,

    required this.hasFile,

    required this.verifiedAt,

    required this.verifiedByName,

    required this.rejectionReason,

    required this.createdAt,

    required this.daysToExpiry,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'employeeId', required: true, includeIfNull: false)
  final String employeeId;

  @JsonKey(name: r'type', required: true, includeIfNull: false)
  final DocumentType type;

  /// Masked for PAN; last 4 digits for Aadhaar
  @JsonKey(name: r'number', required: true, includeIfNull: false)
  final String number;

  @JsonKey(name: r'licenceClass', required: true, includeIfNull: true)
  final String? licenceClass;

  /// Calendar date (IST business date)
  @JsonKey(name: r'issueDate', required: true, includeIfNull: true)
  final String? issueDate;

  /// Calendar date (IST business date)
  @JsonKey(name: r'expiryDate', required: true, includeIfNull: true)
  final String? expiryDate;

  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final DocumentStatus status;

  @JsonKey(name: r'hasFile', required: true, includeIfNull: false)
  final bool hasFile;

  @JsonKey(name: r'verifiedAt', required: true, includeIfNull: true)
  final DateTime? verifiedAt;

  @JsonKey(name: r'verifiedByName', required: true, includeIfNull: true)
  final String? verifiedByName;

  @JsonKey(name: r'rejectionReason', required: true, includeIfNull: true)
  final String? rejectionReason;

  @JsonKey(name: r'createdAt', required: true, includeIfNull: false)
  final DateTime createdAt;

  /// From today (IST); negative when already expired
  @JsonKey(name: r'daysToExpiry', required: true, includeIfNull: true)
  final int? daysToExpiry;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DocumentItem &&
          other.id == id &&
          other.employeeId == employeeId &&
          other.type == type &&
          other.number == number &&
          other.licenceClass == licenceClass &&
          other.issueDate == issueDate &&
          other.expiryDate == expiryDate &&
          other.status == status &&
          other.hasFile == hasFile &&
          other.verifiedAt == verifiedAt &&
          other.verifiedByName == verifiedByName &&
          other.rejectionReason == rejectionReason &&
          other.createdAt == createdAt &&
          other.daysToExpiry == daysToExpiry;

  @override
  int get hashCode =>
      id.hashCode +
      employeeId.hashCode +
      type.hashCode +
      number.hashCode +
      (licenceClass == null ? 0 : licenceClass.hashCode) +
      (issueDate == null ? 0 : issueDate.hashCode) +
      (expiryDate == null ? 0 : expiryDate.hashCode) +
      status.hashCode +
      hasFile.hashCode +
      (verifiedAt == null ? 0 : verifiedAt.hashCode) +
      (verifiedByName == null ? 0 : verifiedByName.hashCode) +
      (rejectionReason == null ? 0 : rejectionReason.hashCode) +
      createdAt.hashCode +
      (daysToExpiry == null ? 0 : daysToExpiry.hashCode);

  factory DocumentItem.fromJson(Map<String, dynamic> json) =>
      _$DocumentItemFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
