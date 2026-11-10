//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/setting_item.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'setting_list.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class SettingList {
  /// Returns a new [SettingList] instance.
  SettingList({required this.items});

  @JsonKey(name: r'items', required: true, includeIfNull: false)
  final List<SettingItem> items;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is SettingList && other.items == items;

  @override
  int get hashCode => items.hashCode;

  factory SettingList.fromJson(Map<String, dynamic> json) =>
      _$SettingListFromJson(json);

  Map<String, dynamic> toJson() => _$SettingListToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
