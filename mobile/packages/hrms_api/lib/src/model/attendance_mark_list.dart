//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/attendance_mark_item.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attendance_mark_list.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AttendanceMarkList {
  /// Returns a new [AttendanceMarkList] instance.
  AttendanceMarkList({required this.items});

  @JsonKey(name: r'items', required: true, includeIfNull: false)
  final List<AttendanceMarkItem> items;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttendanceMarkList && other.items == items;

  @override
  int get hashCode => items.hashCode;

  factory AttendanceMarkList.fromJson(Map<String, dynamic> json) =>
      _$AttendanceMarkListFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceMarkListToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
