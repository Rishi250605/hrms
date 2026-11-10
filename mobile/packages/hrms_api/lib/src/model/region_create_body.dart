//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'region_create_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class RegionCreateBody {
  /// Returns a new [RegionCreateBody] instance.
  RegionCreateBody({required this.name, required this.code});

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'code', required: true, includeIfNull: false)
  final String code;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegionCreateBody && other.name == name && other.code == code;

  @override
  int get hashCode => name.hashCode + code.hashCode;

  factory RegionCreateBody.fromJson(Map<String, dynamic> json) =>
      _$RegionCreateBodyFromJson(json);

  Map<String, dynamic> toJson() => _$RegionCreateBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
