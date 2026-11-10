//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/employee_category.dart';
import 'package:hrms_api/src/model/document_type.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'document_requirement_item.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DocumentRequirementItem {
  /// Returns a new [DocumentRequirementItem] instance.
  DocumentRequirementItem({
    required this.category,

    required this.documentTypes,
  });

  @JsonKey(name: r'category', required: true, includeIfNull: false)
  final EmployeeCategory category;

  @JsonKey(name: r'documentTypes', required: true, includeIfNull: false)
  final List<DocumentType> documentTypes;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DocumentRequirementItem &&
          other.category == category &&
          other.documentTypes == documentTypes;

  @override
  int get hashCode => category.hashCode + documentTypes.hashCode;

  factory DocumentRequirementItem.fromJson(Map<String, dynamic> json) =>
      _$DocumentRequirementItemFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentRequirementItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
