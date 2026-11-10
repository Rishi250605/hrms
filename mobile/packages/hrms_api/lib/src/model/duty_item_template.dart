//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'duty_item_template.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DutyItemTemplate {
  /// Returns a new [DutyItemTemplate] instance.
  DutyItemTemplate({required this.id, required this.name});

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DutyItemTemplate && other.id == id && other.name == name;

  @override
  int get hashCode => id.hashCode + name.hashCode;

  factory DutyItemTemplate.fromJson(Map<String, dynamic> json) =>
      _$DutyItemTemplateFromJson(json);

  Map<String, dynamic> toJson() => _$DutyItemTemplateToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
