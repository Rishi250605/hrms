//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/compliance_state.dart';
import 'package:hrms_api/src/model/document_type.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'compliance_item.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ComplianceItem {
  /// Returns a new [ComplianceItem] instance.
  ComplianceItem({
    required this.type,

    required this.state,

    required this.documentId,

    required this.expiryDate,
  });

  @JsonKey(name: r'type', required: true, includeIfNull: false)
  final DocumentType type;

  @JsonKey(name: r'state', required: true, includeIfNull: false)
  final ComplianceState state;

  @JsonKey(name: r'documentId', required: true, includeIfNull: true)
  final String? documentId;

  /// Calendar date (IST business date)
  @JsonKey(name: r'expiryDate', required: true, includeIfNull: true)
  final String? expiryDate;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ComplianceItem &&
          other.type == type &&
          other.state == state &&
          other.documentId == documentId &&
          other.expiryDate == expiryDate;

  @override
  int get hashCode =>
      type.hashCode +
      state.hashCode +
      (documentId == null ? 0 : documentId.hashCode) +
      (expiryDate == null ? 0 : expiryDate.hashCode);

  factory ComplianceItem.fromJson(Map<String, dynamic> json) =>
      _$ComplianceItemFromJson(json);

  Map<String, dynamic> toJson() => _$ComplianceItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
