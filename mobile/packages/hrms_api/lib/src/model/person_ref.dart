//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/role.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'person_ref.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PersonRef {
  /// Returns a new [PersonRef] instance.
  PersonRef({
    required this.employeeId,

    required this.empCode,

    required this.name,

    required this.role,
  });

  @JsonKey(name: r'employeeId', required: true, includeIfNull: false)
  final String employeeId;

  @JsonKey(name: r'empCode', required: true, includeIfNull: false)
  final String empCode;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  /// Null for non-login staff
  @JsonKey(name: r'role', required: true, includeIfNull: true)
  final Role? role;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonRef &&
          other.employeeId == employeeId &&
          other.empCode == empCode &&
          other.name == name &&
          other.role == role;

  @override
  int get hashCode =>
      employeeId.hashCode +
      empCode.hashCode +
      name.hashCode +
      (role == null ? 0 : role.hashCode);

  factory PersonRef.fromJson(Map<String, dynamic> json) =>
      _$PersonRefFromJson(json);

  Map<String, dynamic> toJson() => _$PersonRefToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
