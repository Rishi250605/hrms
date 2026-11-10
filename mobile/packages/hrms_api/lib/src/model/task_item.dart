//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/task_priority.dart';
import 'package:hrms_api/src/model/business_unit_ref.dart';
import 'package:hrms_api/src/model/person_ref.dart';
import 'package:hrms_api/src/model/task_status.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task_item.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class TaskItem {
  /// Returns a new [TaskItem] instance.
  TaskItem({
    required this.id,

    required this.groupId,

    required this.date,

    required this.businessUnit,

    required this.title,

    required this.details,

    required this.priority,

    required this.allottedBy,

    required this.assignee,

    required this.status,

    required this.overdue,

    required this.reason,

    required this.comment,

    required this.submittedAt,

    required this.reopenedAt,

    required this.reopenComment,

    required this.reopenCount,

    required this.canSubmit,

    required this.canReopen,

    required this.createdAt,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'groupId', required: true, includeIfNull: false)
  final String groupId;

  /// Calendar date (IST business date)
  @JsonKey(name: r'date', required: true, includeIfNull: false)
  final String date;

  @JsonKey(name: r'businessUnit', required: true, includeIfNull: false)
  final BusinessUnitRef businessUnit;

  @JsonKey(name: r'title', required: true, includeIfNull: false)
  final String title;

  @JsonKey(name: r'details', required: true, includeIfNull: true)
  final String? details;

  @JsonKey(name: r'priority', required: true, includeIfNull: false)
  final TaskPriority priority;

  @JsonKey(name: r'allottedBy', required: true, includeIfNull: false)
  final PersonRef allottedBy;

  @JsonKey(name: r'assignee', required: true, includeIfNull: false)
  final PersonRef assignee;

  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final TaskStatus status;

  /// Still PENDING after its date (IST)
  @JsonKey(name: r'overdue', required: true, includeIfNull: false)
  final bool overdue;

  @JsonKey(name: r'reason', required: true, includeIfNull: true)
  final String? reason;

  @JsonKey(name: r'comment', required: true, includeIfNull: true)
  final String? comment;

  @JsonKey(name: r'submittedAt', required: true, includeIfNull: true)
  final DateTime? submittedAt;

  @JsonKey(name: r'reopenedAt', required: true, includeIfNull: true)
  final DateTime? reopenedAt;

  @JsonKey(name: r'reopenComment', required: true, includeIfNull: true)
  final String? reopenComment;

  @JsonKey(name: r'reopenCount', required: true, includeIfNull: false)
  final int reopenCount;

  @JsonKey(name: r'canSubmit', required: true, includeIfNull: false)
  final bool canSubmit;

  @JsonKey(name: r'canReopen', required: true, includeIfNull: false)
  final bool canReopen;

  @JsonKey(name: r'createdAt', required: true, includeIfNull: false)
  final DateTime createdAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskItem &&
          other.id == id &&
          other.groupId == groupId &&
          other.date == date &&
          other.businessUnit == businessUnit &&
          other.title == title &&
          other.details == details &&
          other.priority == priority &&
          other.allottedBy == allottedBy &&
          other.assignee == assignee &&
          other.status == status &&
          other.overdue == overdue &&
          other.reason == reason &&
          other.comment == comment &&
          other.submittedAt == submittedAt &&
          other.reopenedAt == reopenedAt &&
          other.reopenComment == reopenComment &&
          other.reopenCount == reopenCount &&
          other.canSubmit == canSubmit &&
          other.canReopen == canReopen &&
          other.createdAt == createdAt;

  @override
  int get hashCode =>
      id.hashCode +
      groupId.hashCode +
      date.hashCode +
      businessUnit.hashCode +
      title.hashCode +
      (details == null ? 0 : details.hashCode) +
      priority.hashCode +
      allottedBy.hashCode +
      assignee.hashCode +
      status.hashCode +
      overdue.hashCode +
      (reason == null ? 0 : reason.hashCode) +
      (comment == null ? 0 : comment.hashCode) +
      (submittedAt == null ? 0 : submittedAt.hashCode) +
      (reopenedAt == null ? 0 : reopenedAt.hashCode) +
      (reopenComment == null ? 0 : reopenComment.hashCode) +
      reopenCount.hashCode +
      canSubmit.hashCode +
      canReopen.hashCode +
      createdAt.hashCode;

  factory TaskItem.fromJson(Map<String, dynamic> json) =>
      _$TaskItemFromJson(json);

  Map<String, dynamic> toJson() => _$TaskItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
