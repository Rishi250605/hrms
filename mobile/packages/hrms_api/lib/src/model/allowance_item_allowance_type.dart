//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'allowance_item_allowance_type.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AllowanceItemAllowanceType {
  /// Returns a new [AllowanceItemAllowanceType] instance.
  AllowanceItemAllowanceType({
    required this.id,

    required this.code,

    required this.name,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'code', required: true, includeIfNull: false)
  final String code;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AllowanceItemAllowanceType &&
          other.id == id &&
          other.code == code &&
          other.name == name;

  @override
  int get hashCode => id.hashCode + code.hashCode + name.hashCode;

  factory AllowanceItemAllowanceType.fromJson(Map<String, dynamic> json) =>
      _$AllowanceItemAllowanceTypeFromJson(json);

  Map<String, dynamic> toJson() => _$AllowanceItemAllowanceTypeToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
