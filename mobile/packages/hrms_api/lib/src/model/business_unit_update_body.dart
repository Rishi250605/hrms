//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'business_unit_update_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BusinessUnitUpdateBody {
  /// Returns a new [BusinessUnitUpdateBody] instance.
  BusinessUnitUpdateBody({this.name, this.code, this.isActive});

  @JsonKey(name: r'name', required: false, includeIfNull: false)
  final String? name;

  @JsonKey(name: r'code', required: false, includeIfNull: false)
  final String? code;

  @JsonKey(name: r'isActive', required: false, includeIfNull: false)
  final bool? isActive;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BusinessUnitUpdateBody &&
          other.name == name &&
          other.code == code &&
          other.isActive == isActive;

  @override
  int get hashCode => name.hashCode + code.hashCode + isActive.hashCode;

  factory BusinessUnitUpdateBody.fromJson(Map<String, dynamic> json) =>
      _$BusinessUnitUpdateBodyFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessUnitUpdateBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
