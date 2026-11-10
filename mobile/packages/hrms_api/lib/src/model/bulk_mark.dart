//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/attendance_status.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bulk_mark.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BulkMark {
  /// Returns a new [BulkMark] instance.
  BulkMark({
    required this.clientMutationId,

    required this.employeeId,

    required this.date,

    required this.status,

    this.dutyAssignmentId,

    this.note,
  });

  /// Client-generated id (UUID); replays of the same id are no-ops
  @JsonKey(name: r'clientMutationId', required: true, includeIfNull: false)
  final String clientMutationId;

  @JsonKey(name: r'employeeId', required: true, includeIfNull: false)
  final String employeeId;

  /// Calendar date (IST business date)
  @JsonKey(name: r'date', required: true, includeIfNull: false)
  final String date;

  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final AttendanceStatus status;

  @JsonKey(name: r'dutyAssignmentId', required: false, includeIfNull: false)
  final String? dutyAssignmentId;

  @JsonKey(name: r'note', required: false, includeIfNull: false)
  final String? note;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BulkMark &&
          other.clientMutationId == clientMutationId &&
          other.employeeId == employeeId &&
          other.date == date &&
          other.status == status &&
          other.dutyAssignmentId == dutyAssignmentId &&
          other.note == note;

  @override
  int get hashCode =>
      clientMutationId.hashCode +
      employeeId.hashCode +
      date.hashCode +
      status.hashCode +
      dutyAssignmentId.hashCode +
      note.hashCode;

  factory BulkMark.fromJson(Map<String, dynamic> json) =>
      _$BulkMarkFromJson(json);

  Map<String, dynamic> toJson() => _$BulkMarkToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
