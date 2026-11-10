//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/document_item.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'document_list.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DocumentList {
  /// Returns a new [DocumentList] instance.
  DocumentList({required this.items});

  @JsonKey(name: r'items', required: true, includeIfNull: false)
  final List<DocumentItem> items;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is DocumentList && other.items == items;

  @override
  int get hashCode => items.hashCode;

  factory DocumentList.fromJson(Map<String, dynamic> json) =>
      _$DocumentListFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentListToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
