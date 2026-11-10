//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'logout_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class LogoutBody {
  /// Returns a new [LogoutBody] instance.
  LogoutBody({required this.refreshToken});

  @JsonKey(name: r'refreshToken', required: true, includeIfNull: false)
  final String refreshToken;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LogoutBody && other.refreshToken == refreshToken;

  @override
  int get hashCode => refreshToken.hashCode;

  factory LogoutBody.fromJson(Map<String, dynamic> json) =>
      _$LogoutBodyFromJson(json);

  Map<String, dynamic> toJson() => _$LogoutBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
