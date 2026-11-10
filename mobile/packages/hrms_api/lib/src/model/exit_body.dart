//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exit_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ExitBody {
  /// Returns a new [ExitBody] instance.
  ExitBody({required this.exitDate, required this.reason});

  /// Calendar date (IST business date)
  @JsonKey(name: r'exitDate', required: true, includeIfNull: false)
  final String exitDate;

  @JsonKey(name: r'reason', required: true, includeIfNull: false)
  final String reason;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExitBody && other.exitDate == exitDate && other.reason == reason;

  @override
  int get hashCode => exitDate.hashCode + reason.hashCode;

  factory ExitBody.fromJson(Map<String, dynamic> json) =>
      _$ExitBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ExitBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
