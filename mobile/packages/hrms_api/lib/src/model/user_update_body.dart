//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_update_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UserUpdateBody {
  /// Returns a new [UserUpdateBody] instance.
  UserUpdateBody({this.name, this.phone, this.email, this.isActive});

  @JsonKey(name: r'name', required: false, includeIfNull: false)
  final String? name;

  /// E.164, or a 10-digit Indian mobile number
  @JsonKey(name: r'phone', required: false, includeIfNull: false)
  final String? phone;

  @JsonKey(name: r'email', required: false, includeIfNull: false)
  final String? email;

  /// Deactivating revokes all sessions
  @JsonKey(name: r'isActive', required: false, includeIfNull: false)
  final bool? isActive;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserUpdateBody &&
          other.name == name &&
          other.phone == phone &&
          other.email == email &&
          other.isActive == isActive;

  @override
  int get hashCode =>
      name.hashCode +
      phone.hashCode +
      (email == null ? 0 : email.hashCode) +
      isActive.hashCode;

  factory UserUpdateBody.fromJson(Map<String, dynamic> json) =>
      _$UserUpdateBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UserUpdateBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
