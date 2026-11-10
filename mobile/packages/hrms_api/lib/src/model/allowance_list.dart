//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/allowance_item.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'allowance_list.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AllowanceList {
  /// Returns a new [AllowanceList] instance.
  AllowanceList({required this.items});

  @JsonKey(name: r'items', required: true, includeIfNull: false)
  final List<AllowanceItem> items;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is AllowanceList && other.items == items;

  @override
  int get hashCode => items.hashCode;

  factory AllowanceList.fromJson(Map<String, dynamic> json) =>
      _$AllowanceListFromJson(json);

  Map<String, dynamic> toJson() => _$AllowanceListToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
