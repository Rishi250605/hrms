//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'allowance_type_create_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AllowanceTypeCreateBody {
  /// Returns a new [AllowanceTypeCreateBody] instance.
  AllowanceTypeCreateBody({
    required this.code,

    required this.name,

    this.maxAmountPaise,
  });

  @JsonKey(name: r'code', required: true, includeIfNull: false)
  final String code;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  // minimum: 0
  @JsonKey(name: r'maxAmountPaise', required: false, includeIfNull: false)
  final int? maxAmountPaise;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AllowanceTypeCreateBody &&
          other.code == code &&
          other.name == name &&
          other.maxAmountPaise == maxAmountPaise;

  @override
  int get hashCode => code.hashCode + name.hashCode + maxAmountPaise.hashCode;

  factory AllowanceTypeCreateBody.fromJson(Map<String, dynamic> json) =>
      _$AllowanceTypeCreateBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AllowanceTypeCreateBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
