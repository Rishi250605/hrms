//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'region_item.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class RegionItem {
  /// Returns a new [RegionItem] instance.
  RegionItem({
    required this.id,

    required this.name,

    required this.code,

    required this.depotCount,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'code', required: true, includeIfNull: false)
  final String code;

  @JsonKey(name: r'depotCount', required: true, includeIfNull: false)
  final int depotCount;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegionItem &&
          other.id == id &&
          other.name == name &&
          other.code == code &&
          other.depotCount == depotCount;

  @override
  int get hashCode =>
      id.hashCode + name.hashCode + code.hashCode + depotCount.hashCode;

  factory RegionItem.fromJson(Map<String, dynamic> json) =>
      _$RegionItemFromJson(json);

  Map<String, dynamic> toJson() => _$RegionItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
