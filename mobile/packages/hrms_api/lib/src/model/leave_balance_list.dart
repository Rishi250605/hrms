//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/leave_balance_item.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'leave_balance_list.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class LeaveBalanceList {
  /// Returns a new [LeaveBalanceList] instance.
  LeaveBalanceList({
    required this.employeeId,

    required this.year,

    required this.items,
  });

  @JsonKey(name: r'employeeId', required: true, includeIfNull: false)
  final String employeeId;

  @JsonKey(name: r'year', required: true, includeIfNull: false)
  final int year;

  @JsonKey(name: r'items', required: true, includeIfNull: false)
  final List<LeaveBalanceItem> items;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LeaveBalanceList &&
          other.employeeId == employeeId &&
          other.year == year &&
          other.items == items;

  @override
  int get hashCode => employeeId.hashCode + year.hashCode + items.hashCode;

  factory LeaveBalanceList.fromJson(Map<String, dynamic> json) =>
      _$LeaveBalanceListFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveBalanceListToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
