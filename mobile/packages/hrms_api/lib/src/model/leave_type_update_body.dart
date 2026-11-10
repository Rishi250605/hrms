//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/accrual_rule.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'leave_type_update_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class LeaveTypeUpdateBody {
  /// Returns a new [LeaveTypeUpdateBody] instance.
  LeaveTypeUpdateBody({
    this.name,

    this.paid,

    this.accrualRule,

    this.carryForwardMax,

    this.encashable,

    this.isActive,
  });

  @JsonKey(name: r'name', required: false, includeIfNull: false)
  final String? name;

  @JsonKey(name: r'paid', required: false, includeIfNull: false)
  final bool? paid;

  @JsonKey(name: r'accrualRule', required: false, includeIfNull: false)
  final AccrualRule? accrualRule;

  // minimum: 0
  // maximum: 365
  @JsonKey(name: r'carryForwardMax', required: false, includeIfNull: false)
  final num? carryForwardMax;

  @JsonKey(name: r'encashable', required: false, includeIfNull: false)
  final bool? encashable;

  @JsonKey(name: r'isActive', required: false, includeIfNull: false)
  final bool? isActive;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LeaveTypeUpdateBody &&
          other.name == name &&
          other.paid == paid &&
          other.accrualRule == accrualRule &&
          other.carryForwardMax == carryForwardMax &&
          other.encashable == encashable &&
          other.isActive == isActive;

  @override
  int get hashCode =>
      name.hashCode +
      paid.hashCode +
      accrualRule.hashCode +
      carryForwardMax.hashCode +
      encashable.hashCode +
      isActive.hashCode;

  factory LeaveTypeUpdateBody.fromJson(Map<String, dynamic> json) =>
      _$LeaveTypeUpdateBodyFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveTypeUpdateBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
