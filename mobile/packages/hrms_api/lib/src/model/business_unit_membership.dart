//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'business_unit_membership.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BusinessUnitMembership {
  /// Returns a new [BusinessUnitMembership] instance.
  BusinessUnitMembership({
    required this.id,

    required this.code,

    required this.name,

    required this.isPrimary,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'code', required: true, includeIfNull: false)
  final String code;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'isPrimary', required: true, includeIfNull: false)
  final bool isPrimary;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BusinessUnitMembership &&
          other.id == id &&
          other.code == code &&
          other.name == name &&
          other.isPrimary == isPrimary;

  @override
  int get hashCode =>
      id.hashCode + code.hashCode + name.hashCode + isPrimary.hashCode;

  factory BusinessUnitMembership.fromJson(Map<String, dynamic> json) =>
      _$BusinessUnitMembershipFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessUnitMembershipToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
