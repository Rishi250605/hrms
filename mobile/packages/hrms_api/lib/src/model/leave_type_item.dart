//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/accrual_rule.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'leave_type_item.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class LeaveTypeItem {
  /// Returns a new [LeaveTypeItem] instance.
  LeaveTypeItem({
    required this.id,

    required this.code,

    required this.name,

    required this.paid,

    required this.accrualRule,

    required this.carryForwardMax,

    required this.encashable,

    required this.isActive,

    required this.tracksBalance,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'code', required: true, includeIfNull: false)
  final String code;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'paid', required: true, includeIfNull: false)
  final bool paid;

  @JsonKey(name: r'accrualRule', required: true, includeIfNull: false)
  final AccrualRule accrualRule;

  @JsonKey(name: r'carryForwardMax', required: true, includeIfNull: false)
  final num carryForwardMax;

  @JsonKey(name: r'encashable', required: true, includeIfNull: false)
  final bool encashable;

  @JsonKey(name: r'isActive', required: true, includeIfNull: false)
  final bool isActive;

  @JsonKey(name: r'tracksBalance', required: true, includeIfNull: false)
  final bool tracksBalance;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LeaveTypeItem &&
          other.id == id &&
          other.code == code &&
          other.name == name &&
          other.paid == paid &&
          other.accrualRule == accrualRule &&
          other.carryForwardMax == carryForwardMax &&
          other.encashable == encashable &&
          other.isActive == isActive &&
          other.tracksBalance == tracksBalance;

  @override
  int get hashCode =>
      id.hashCode +
      code.hashCode +
      name.hashCode +
      paid.hashCode +
      accrualRule.hashCode +
      carryForwardMax.hashCode +
      encashable.hashCode +
      isActive.hashCode +
      tracksBalance.hashCode;

  factory LeaveTypeItem.fromJson(Map<String, dynamic> json) =>
      _$LeaveTypeItemFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveTypeItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
