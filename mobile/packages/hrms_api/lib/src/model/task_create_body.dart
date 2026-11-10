//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/task_priority.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task_create_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class TaskCreateBody {
  /// Returns a new [TaskCreateBody] instance.
  TaskCreateBody({
    this.date,

    required this.businessUnitId,

    required this.title,

    this.details,

    this.priority,

    required this.assigneeEmployeeIds,
  });

  /// Default today (IST); future dates allowed
  @JsonKey(name: r'date', required: false, includeIfNull: false)
  final String? date;

  @JsonKey(name: r'businessUnitId', required: true, includeIfNull: false)
  final String businessUnitId;

  @JsonKey(name: r'title', required: true, includeIfNull: false)
  final String title;

  @JsonKey(name: r'details', required: false, includeIfNull: false)
  final String? details;

  @JsonKey(name: r'priority', required: false, includeIfNull: false)
  final TaskPriority? priority;

  /// RMs reporting to you in this business unit; one task each
  @JsonKey(name: r'assigneeEmployeeIds', required: true, includeIfNull: false)
  final List<String> assigneeEmployeeIds;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskCreateBody &&
          other.date == date &&
          other.businessUnitId == businessUnitId &&
          other.title == title &&
          other.details == details &&
          other.priority == priority &&
          other.assigneeEmployeeIds == assigneeEmployeeIds;

  @override
  int get hashCode =>
      date.hashCode +
      businessUnitId.hashCode +
      title.hashCode +
      details.hashCode +
      priority.hashCode +
      assigneeEmployeeIds.hashCode;

  factory TaskCreateBody.fromJson(Map<String, dynamic> json) =>
      _$TaskCreateBodyFromJson(json);

  Map<String, dynamic> toJson() => _$TaskCreateBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
