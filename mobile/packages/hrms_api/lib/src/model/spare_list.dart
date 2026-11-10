//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/spare_item.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'spare_list.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class SpareList {
  /// Returns a new [SpareList] instance.
  SpareList({required this.items});

  @JsonKey(name: r'items', required: true, includeIfNull: false)
  final List<SpareItem> items;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is SpareList && other.items == items;

  @override
  int get hashCode => items.hashCode;

  factory SpareList.fromJson(Map<String, dynamic> json) =>
      _$SpareListFromJson(json);

  Map<String, dynamic> toJson() => _$SpareListToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
