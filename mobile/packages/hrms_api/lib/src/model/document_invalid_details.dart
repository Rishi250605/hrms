//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/spare_item.dart';
import 'package:hrms_api/src/model/compliance_item.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'document_invalid_details.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DocumentInvalidDetails {
  /// Returns a new [DocumentInvalidDetails] instance.
  DocumentInvalidDetails({required this.failing, required this.spares});

  @JsonKey(name: r'failing', required: true, includeIfNull: false)
  final List<ComplianceItem> failing;

  @JsonKey(name: r'spares', required: true, includeIfNull: false)
  final List<SpareItem> spares;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DocumentInvalidDetails &&
          other.failing == failing &&
          other.spares == spares;

  @override
  int get hashCode => failing.hashCode + spares.hashCode;

  factory DocumentInvalidDetails.fromJson(Map<String, dynamic> json) =>
      _$DocumentInvalidDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentInvalidDetailsToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
