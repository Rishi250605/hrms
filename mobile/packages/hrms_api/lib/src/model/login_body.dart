//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class LoginBody {
  /// Returns a new [LoginBody] instance.
  LoginBody({required this.empCode, required this.password});

  @JsonKey(name: r'empCode', required: true, includeIfNull: false)
  final String empCode;

  @JsonKey(name: r'password', required: true, includeIfNull: false)
  final String password;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginBody &&
          other.empCode == empCode &&
          other.password == password;

  @override
  int get hashCode => empCode.hashCode + password.hashCode;

  factory LoginBody.fromJson(Map<String, dynamic> json) =>
      _$LoginBodyFromJson(json);

  Map<String, dynamic> toJson() => _$LoginBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
