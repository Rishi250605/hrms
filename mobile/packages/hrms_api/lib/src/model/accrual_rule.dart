//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'accrual_rule.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AccrualRule {
  /// Returns a new [AccrualRule] instance.
  AccrualRule({required this.type});

  /// MONTHLY: quota/12 each month; ANNUAL: full quota once a year; NONE: no balance kept (e.g. LOP)
  @JsonKey(name: r'type', required: true, includeIfNull: false)
  final AccrualRuleTypeEnum type;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is AccrualRule && other.type == type;

  @override
  int get hashCode => type.hashCode;

  factory AccrualRule.fromJson(Map<String, dynamic> json) =>
      _$AccrualRuleFromJson(json);

  Map<String, dynamic> toJson() => _$AccrualRuleToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

/// MONTHLY: quota/12 each month; ANNUAL: full quota once a year; NONE: no balance kept (e.g. LOP)
enum AccrualRuleTypeEnum {
  @JsonValue(r'MONTHLY')
  MONTHLY(r'MONTHLY'),
  @JsonValue(r'ANNUAL')
  ANNUAL(r'ANNUAL'),
  @JsonValue(r'NONE')
  NONE(r'NONE');

  const AccrualRuleTypeEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
