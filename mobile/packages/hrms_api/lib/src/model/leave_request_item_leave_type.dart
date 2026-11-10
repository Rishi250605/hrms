//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'leave_request_item_leave_type.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class LeaveRequestItemLeaveType {
  /// Returns a new [LeaveRequestItemLeaveType] instance.
  LeaveRequestItemLeaveType({
    required this.id,

    required this.code,

    required this.name,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'code', required: true, includeIfNull: false)
  final String code;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LeaveRequestItemLeaveType &&
          other.id == id &&
          other.code == code &&
          other.name == name;

  @override
  int get hashCode => id.hashCode + code.hashCode + name.hashCode;

  factory LeaveRequestItemLeaveType.fromJson(Map<String, dynamic> json) =>
      _$LeaveRequestItemLeaveTypeFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveRequestItemLeaveTypeToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
