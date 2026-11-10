//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'allowance_type_update_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AllowanceTypeUpdateBody {
  /// Returns a new [AllowanceTypeUpdateBody] instance.
  AllowanceTypeUpdateBody({this.name, this.maxAmountPaise, this.isActive});

  @JsonKey(name: r'name', required: false, includeIfNull: false)
  final String? name;

  // minimum: 0
  @JsonKey(name: r'maxAmountPaise', required: false, includeIfNull: false)
  final int? maxAmountPaise;

  @JsonKey(name: r'isActive', required: false, includeIfNull: false)
  final bool? isActive;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AllowanceTypeUpdateBody &&
          other.name == name &&
          other.maxAmountPaise == maxAmountPaise &&
          other.isActive == isActive;

  @override
  int get hashCode =>
      name.hashCode +
      (maxAmountPaise == null ? 0 : maxAmountPaise.hashCode) +
      isActive.hashCode;

  factory AllowanceTypeUpdateBody.fromJson(Map<String, dynamic> json) =>
      _$AllowanceTypeUpdateBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AllowanceTypeUpdateBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
