//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/document_type.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'document_requirement_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DocumentRequirementBody {
  /// Returns a new [DocumentRequirementBody] instance.
  DocumentRequirementBody({required this.documentTypes});

  @JsonKey(name: r'documentTypes', required: true, includeIfNull: false)
  final List<DocumentType> documentTypes;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DocumentRequirementBody && other.documentTypes == documentTypes;

  @override
  int get hashCode => documentTypes.hashCode;

  factory DocumentRequirementBody.fromJson(Map<String, dynamic> json) =>
      _$DocumentRequirementBodyFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentRequirementBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
