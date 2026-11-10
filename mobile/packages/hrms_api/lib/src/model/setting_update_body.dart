//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'setting_update_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class SettingUpdateBody {
  /// Returns a new [SettingUpdateBody] instance.
  SettingUpdateBody({this.value});

  @JsonKey(name: r'value', required: false, includeIfNull: false)
  final Object? value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingUpdateBody && other.value == value;

  @override
  int get hashCode => (value == null ? 0 : value.hashCode);

  factory SettingUpdateBody.fromJson(Map<String, dynamic> json) =>
      _$SettingUpdateBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SettingUpdateBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
