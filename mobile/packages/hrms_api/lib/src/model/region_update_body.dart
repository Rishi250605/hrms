//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'region_update_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class RegionUpdateBody {
  /// Returns a new [RegionUpdateBody] instance.
  RegionUpdateBody({required this.name});

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is RegionUpdateBody && other.name == name;

  @override
  int get hashCode => name.hashCode;

  factory RegionUpdateBody.fromJson(Map<String, dynamic> json) =>
      _$RegionUpdateBodyFromJson(json);

  Map<String, dynamic> toJson() => _$RegionUpdateBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
