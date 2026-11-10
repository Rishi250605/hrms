//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/duty_template_item.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'duty_template_list.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DutyTemplateList {
  /// Returns a new [DutyTemplateList] instance.
  DutyTemplateList({required this.items});

  @JsonKey(name: r'items', required: true, includeIfNull: false)
  final List<DutyTemplateItem> items;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DutyTemplateList && other.items == items;

  @override
  int get hashCode => items.hashCode;

  factory DutyTemplateList.fromJson(Map<String, dynamic> json) =>
      _$DutyTemplateListFromJson(json);

  Map<String, dynamic> toJson() => _$DutyTemplateListToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
