//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'device_unregister_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DeviceUnregisterBody {
  /// Returns a new [DeviceUnregisterBody] instance.
  DeviceUnregisterBody({required this.token});

  @JsonKey(name: r'token', required: true, includeIfNull: false)
  final String token;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceUnregisterBody && other.token == token;

  @override
  int get hashCode => token.hashCode;

  factory DeviceUnregisterBody.fromJson(Map<String, dynamic> json) =>
      _$DeviceUnregisterBodyFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceUnregisterBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
