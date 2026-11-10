//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'device_register_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DeviceRegisterBody {
  /// Returns a new [DeviceRegisterBody] instance.
  DeviceRegisterBody({required this.token, required this.platform});

  @JsonKey(name: r'token', required: true, includeIfNull: false)
  final String token;

  @JsonKey(name: r'platform', required: true, includeIfNull: false)
  final DeviceRegisterBodyPlatformEnum platform;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceRegisterBody &&
          other.token == token &&
          other.platform == platform;

  @override
  int get hashCode => token.hashCode + platform.hashCode;

  factory DeviceRegisterBody.fromJson(Map<String, dynamic> json) =>
      _$DeviceRegisterBodyFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceRegisterBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum DeviceRegisterBodyPlatformEnum {
  @JsonValue(r'android')
  android(r'android'),
  @JsonValue(r'ios')
  ios(r'ios'),
  @JsonValue(r'web')
  web(r'web');

  const DeviceRegisterBodyPlatformEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
