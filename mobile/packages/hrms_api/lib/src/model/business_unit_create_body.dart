//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'business_unit_create_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BusinessUnitCreateBody {
  /// Returns a new [BusinessUnitCreateBody] instance.
  BusinessUnitCreateBody({required this.name, required this.code});

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'code', required: true, includeIfNull: false)
  final String code;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BusinessUnitCreateBody &&
          other.name == name &&
          other.code == code;

  @override
  int get hashCode => name.hashCode + code.hashCode;

  factory BusinessUnitCreateBody.fromJson(Map<String, dynamic> json) =>
      _$BusinessUnitCreateBodyFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessUnitCreateBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
