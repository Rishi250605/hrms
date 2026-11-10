//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/bulk_mark.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bulk_attendance_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BulkAttendanceBody {
  /// Returns a new [BulkAttendanceBody] instance.
  BulkAttendanceBody({required this.marks});

  @JsonKey(name: r'marks', required: true, includeIfNull: false)
  final List<BulkMark> marks;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BulkAttendanceBody && other.marks == marks;

  @override
  int get hashCode => marks.hashCode;

  factory BulkAttendanceBody.fromJson(Map<String, dynamic> json) =>
      _$BulkAttendanceBodyFromJson(json);

  Map<String, dynamic> toJson() => _$BulkAttendanceBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
