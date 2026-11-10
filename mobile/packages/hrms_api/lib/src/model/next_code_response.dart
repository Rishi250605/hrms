//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'next_code_response.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class NextCodeResponse {
  /// Returns a new [NextCodeResponse] instance.
  NextCodeResponse({required this.empCode});

  @JsonKey(name: r'empCode', required: true, includeIfNull: false)
  final String empCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NextCodeResponse && other.empCode == empCode;

  @override
  int get hashCode => empCode.hashCode;

  factory NextCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$NextCodeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NextCodeResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
