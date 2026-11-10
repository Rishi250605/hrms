//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/leave_policy_item.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'leave_policy_list.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class LeavePolicyList {
  /// Returns a new [LeavePolicyList] instance.
  LeavePolicyList({required this.items});

  @JsonKey(name: r'items', required: true, includeIfNull: false)
  final List<LeavePolicyItem> items;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LeavePolicyList && other.items == items;

  @override
  int get hashCode => items.hashCode;

  factory LeavePolicyList.fromJson(Map<String, dynamic> json) =>
      _$LeavePolicyListFromJson(json);

  Map<String, dynamic> toJson() => _$LeavePolicyListToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
