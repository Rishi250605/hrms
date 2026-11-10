//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'roster_warning.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class RosterWarning {
  /// Returns a new [RosterWarning] instance.
  RosterWarning({required this.code, required this.message});

  @JsonKey(name: r'code', required: true, includeIfNull: false)
  final RosterWarningCodeEnum code;

  @JsonKey(name: r'message', required: true, includeIfNull: false)
  final String message;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RosterWarning && other.code == code && other.message == message;

  @override
  int get hashCode => code.hashCode + message.hashCode;

  factory RosterWarning.fromJson(Map<String, dynamic> json) =>
      _$RosterWarningFromJson(json);

  Map<String, dynamic> toJson() => _$RosterWarningToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum RosterWarningCodeEnum {
  @JsonValue(r'DUTY_HOURS_EXCEEDED')
  DUTY_HOURS_EXCEEDED(r'DUTY_HOURS_EXCEEDED'),
  @JsonValue(r'MIN_REST_VIOLATED')
  MIN_REST_VIOLATED(r'MIN_REST_VIOLATED'),
  @JsonValue(r'NO_WEEKLY_OFF')
  NO_WEEKLY_OFF(r'NO_WEEKLY_OFF'),
  @JsonValue(r'DOCUMENT_EXPIRING')
  DOCUMENT_EXPIRING(r'DOCUMENT_EXPIRING');

  const RosterWarningCodeEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
