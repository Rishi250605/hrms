//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'refresh_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class RefreshBody {
  /// Returns a new [RefreshBody] instance.
  RefreshBody({required this.refreshToken});

  @JsonKey(name: r'refreshToken', required: true, includeIfNull: false)
  final String refreshToken;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RefreshBody && other.refreshToken == refreshToken;

  @override
  int get hashCode => refreshToken.hashCode;

  factory RefreshBody.fromJson(Map<String, dynamic> json) =>
      _$RefreshBodyFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
