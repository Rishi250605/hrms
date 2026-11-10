//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/document_with_employee.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expiring_document_list.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ExpiringDocumentList {
  /// Returns a new [ExpiringDocumentList] instance.
  ExpiringDocumentList({required this.items});

  @JsonKey(name: r'items', required: true, includeIfNull: false)
  final List<DocumentWithEmployee> items;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpiringDocumentList && other.items == items;

  @override
  int get hashCode => items.hashCode;

  factory ExpiringDocumentList.fromJson(Map<String, dynamic> json) =>
      _$ExpiringDocumentListFromJson(json);

  Map<String, dynamic> toJson() => _$ExpiringDocumentListToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
