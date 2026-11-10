//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/correction_item.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'correction_list.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CorrectionList {
  /// Returns a new [CorrectionList] instance.
  CorrectionList({required this.items});

  @JsonKey(name: r'items', required: true, includeIfNull: false)
  final List<CorrectionItem> items;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is CorrectionList && other.items == items;

  @override
  int get hashCode => items.hashCode;

  factory CorrectionList.fromJson(Map<String, dynamic> json) =>
      _$CorrectionListFromJson(json);

  Map<String, dynamic> toJson() => _$CorrectionListToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
