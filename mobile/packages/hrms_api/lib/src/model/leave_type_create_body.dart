//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/accrual_rule.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'leave_type_create_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class LeaveTypeCreateBody {
  /// Returns a new [LeaveTypeCreateBody] instance.
  LeaveTypeCreateBody({
    required this.code,

    required this.name,

    required this.paid,

    required this.accrualRule,

    this.carryForwardMax = 0,

    this.encashable = false,
  });

  @JsonKey(name: r'code', required: true, includeIfNull: false)
  final String code;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'paid', required: true, includeIfNull: false)
  final bool paid;

  @JsonKey(name: r'accrualRule', required: true, includeIfNull: false)
  final AccrualRule accrualRule;

  // minimum: 0
  // maximum: 365
  @JsonKey(
    defaultValue: 0,
    name: r'carryForwardMax',
    required: false,
    includeIfNull: false,
  )
  final num? carryForwardMax;

  @JsonKey(
    defaultValue: false,
    name: r'encashable',
    required: false,
    includeIfNull: false,
  )
  final bool? encashable;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LeaveTypeCreateBody &&
          other.code == code &&
          other.name == name &&
          other.paid == paid &&
          other.accrualRule == accrualRule &&
          other.carryForwardMax == carryForwardMax &&
          other.encashable == encashable;

  @override
  int get hashCode =>
      code.hashCode +
      name.hashCode +
      paid.hashCode +
      accrualRule.hashCode +
      carryForwardMax.hashCode +
      encashable.hashCode;

  factory LeaveTypeCreateBody.fromJson(Map<String, dynamic> json) =>
      _$LeaveTypeCreateBodyFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveTypeCreateBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
