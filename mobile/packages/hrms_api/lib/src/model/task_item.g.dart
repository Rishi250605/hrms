// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TaskItemCWProxy {
  TaskItem id(String id);

  TaskItem groupId(String groupId);

  TaskItem date(String date);

  TaskItem businessUnit(BusinessUnitRef businessUnit);

  TaskItem title(String title);

  TaskItem details(String? details);

  TaskItem priority(TaskPriority priority);

  TaskItem allottedBy(PersonRef allottedBy);

  TaskItem assignee(PersonRef assignee);

  TaskItem status(TaskStatus status);

  TaskItem overdue(bool overdue);

  TaskItem reason(String? reason);

  TaskItem comment(String? comment);

  TaskItem submittedAt(DateTime? submittedAt);

  TaskItem reopenedAt(DateTime? reopenedAt);

  TaskItem reopenComment(String? reopenComment);

  TaskItem reopenCount(int reopenCount);

  TaskItem canSubmit(bool canSubmit);

  TaskItem canReopen(bool canReopen);

  TaskItem createdAt(DateTime createdAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TaskItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TaskItem(...).copyWith(id: 12, name: "My name")
  /// ````
  TaskItem call({
    String id,
    String groupId,
    String date,
    BusinessUnitRef businessUnit,
    String title,
    String? details,
    TaskPriority priority,
    PersonRef allottedBy,
    PersonRef assignee,
    TaskStatus status,
    bool overdue,
    String? reason,
    String? comment,
    DateTime? submittedAt,
    DateTime? reopenedAt,
    String? reopenComment,
    int reopenCount,
    bool canSubmit,
    bool canReopen,
    DateTime createdAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTaskItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTaskItem.copyWith.fieldName(...)`
class _$TaskItemCWProxyImpl implements _$TaskItemCWProxy {
  const _$TaskItemCWProxyImpl(this._value);

  final TaskItem _value;

  @override
  TaskItem id(String id) => this(id: id);

  @override
  TaskItem groupId(String groupId) => this(groupId: groupId);

  @override
  TaskItem date(String date) => this(date: date);

  @override
  TaskItem businessUnit(BusinessUnitRef businessUnit) =>
      this(businessUnit: businessUnit);

  @override
  TaskItem title(String title) => this(title: title);

  @override
  TaskItem details(String? details) => this(details: details);

  @override
  TaskItem priority(TaskPriority priority) => this(priority: priority);

  @override
  TaskItem allottedBy(PersonRef allottedBy) => this(allottedBy: allottedBy);

  @override
  TaskItem assignee(PersonRef assignee) => this(assignee: assignee);

  @override
  TaskItem status(TaskStatus status) => this(status: status);

  @override
  TaskItem overdue(bool overdue) => this(overdue: overdue);

  @override
  TaskItem reason(String? reason) => this(reason: reason);

  @override
  TaskItem comment(String? comment) => this(comment: comment);

  @override
  TaskItem submittedAt(DateTime? submittedAt) => this(submittedAt: submittedAt);

  @override
  TaskItem reopenedAt(DateTime? reopenedAt) => this(reopenedAt: reopenedAt);

  @override
  TaskItem reopenComment(String? reopenComment) =>
      this(reopenComment: reopenComment);

  @override
  TaskItem reopenCount(int reopenCount) => this(reopenCount: reopenCount);

  @override
  TaskItem canSubmit(bool canSubmit) => this(canSubmit: canSubmit);

  @override
  TaskItem canReopen(bool canReopen) => this(canReopen: canReopen);

  @override
  TaskItem createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TaskItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TaskItem(...).copyWith(id: 12, name: "My name")
  /// ````
  TaskItem call({
    Object? id = const $CopyWithPlaceholder(),
    Object? groupId = const $CopyWithPlaceholder(),
    Object? date = const $CopyWithPlaceholder(),
    Object? businessUnit = const $CopyWithPlaceholder(),
    Object? title = const $CopyWithPlaceholder(),
    Object? details = const $CopyWithPlaceholder(),
    Object? priority = const $CopyWithPlaceholder(),
    Object? allottedBy = const $CopyWithPlaceholder(),
    Object? assignee = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? overdue = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
    Object? comment = const $CopyWithPlaceholder(),
    Object? submittedAt = const $CopyWithPlaceholder(),
    Object? reopenedAt = const $CopyWithPlaceholder(),
    Object? reopenComment = const $CopyWithPlaceholder(),
    Object? reopenCount = const $CopyWithPlaceholder(),
    Object? canSubmit = const $CopyWithPlaceholder(),
    Object? canReopen = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
  }) {
    return TaskItem(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      groupId: groupId == const $CopyWithPlaceholder()
          ? _value.groupId
          // ignore: cast_nullable_to_non_nullable
          : groupId as String,
      date: date == const $CopyWithPlaceholder()
          ? _value.date
          // ignore: cast_nullable_to_non_nullable
          : date as String,
      businessUnit: businessUnit == const $CopyWithPlaceholder()
          ? _value.businessUnit
          // ignore: cast_nullable_to_non_nullable
          : businessUnit as BusinessUnitRef,
      title: title == const $CopyWithPlaceholder()
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String,
      details: details == const $CopyWithPlaceholder()
          ? _value.details
          // ignore: cast_nullable_to_non_nullable
          : details as String?,
      priority: priority == const $CopyWithPlaceholder()
          ? _value.priority
          // ignore: cast_nullable_to_non_nullable
          : priority as TaskPriority,
      allottedBy: allottedBy == const $CopyWithPlaceholder()
          ? _value.allottedBy
          // ignore: cast_nullable_to_non_nullable
          : allottedBy as PersonRef,
      assignee: assignee == const $CopyWithPlaceholder()
          ? _value.assignee
          // ignore: cast_nullable_to_non_nullable
          : assignee as PersonRef,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as TaskStatus,
      overdue: overdue == const $CopyWithPlaceholder()
          ? _value.overdue
          // ignore: cast_nullable_to_non_nullable
          : overdue as bool,
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String?,
      comment: comment == const $CopyWithPlaceholder()
          ? _value.comment
          // ignore: cast_nullable_to_non_nullable
          : comment as String?,
      submittedAt: submittedAt == const $CopyWithPlaceholder()
          ? _value.submittedAt
          // ignore: cast_nullable_to_non_nullable
          : submittedAt as DateTime?,
      reopenedAt: reopenedAt == const $CopyWithPlaceholder()
          ? _value.reopenedAt
          // ignore: cast_nullable_to_non_nullable
          : reopenedAt as DateTime?,
      reopenComment: reopenComment == const $CopyWithPlaceholder()
          ? _value.reopenComment
          // ignore: cast_nullable_to_non_nullable
          : reopenComment as String?,
      reopenCount: reopenCount == const $CopyWithPlaceholder()
          ? _value.reopenCount
          // ignore: cast_nullable_to_non_nullable
          : reopenCount as int,
      canSubmit: canSubmit == const $CopyWithPlaceholder()
          ? _value.canSubmit
          // ignore: cast_nullable_to_non_nullable
          : canSubmit as bool,
      canReopen: canReopen == const $CopyWithPlaceholder()
          ? _value.canReopen
          // ignore: cast_nullable_to_non_nullable
          : canReopen as bool,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
    );
  }
}

extension $TaskItemCopyWith on TaskItem {
  /// Returns a callable class that can be used as follows: `instanceOfTaskItem.copyWith(...)` or like so:`instanceOfTaskItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TaskItemCWProxy get copyWith => _$TaskItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskItem _$TaskItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate('TaskItem', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'groupId',
          'date',
          'businessUnit',
          'title',
          'details',
          'priority',
          'allottedBy',
          'assignee',
          'status',
          'overdue',
          'reason',
          'comment',
          'submittedAt',
          'reopenedAt',
          'reopenComment',
          'reopenCount',
          'canSubmit',
          'canReopen',
          'createdAt',
        ],
      );
      final val = TaskItem(
        id: $checkedConvert('id', (v) => v as String),
        groupId: $checkedConvert('groupId', (v) => v as String),
        date: $checkedConvert('date', (v) => v as String),
        businessUnit: $checkedConvert(
          'businessUnit',
          (v) => BusinessUnitRef.fromJson(v as Map<String, dynamic>),
        ),
        title: $checkedConvert('title', (v) => v as String),
        details: $checkedConvert('details', (v) => v as String?),
        priority: $checkedConvert(
          'priority',
          (v) => $enumDecode(_$TaskPriorityEnumMap, v),
        ),
        allottedBy: $checkedConvert(
          'allottedBy',
          (v) => PersonRef.fromJson(v as Map<String, dynamic>),
        ),
        assignee: $checkedConvert(
          'assignee',
          (v) => PersonRef.fromJson(v as Map<String, dynamic>),
        ),
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(_$TaskStatusEnumMap, v),
        ),
        overdue: $checkedConvert('overdue', (v) => v as bool),
        reason: $checkedConvert('reason', (v) => v as String?),
        comment: $checkedConvert('comment', (v) => v as String?),
        submittedAt: $checkedConvert(
          'submittedAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        reopenedAt: $checkedConvert(
          'reopenedAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        reopenComment: $checkedConvert('reopenComment', (v) => v as String?),
        reopenCount: $checkedConvert('reopenCount', (v) => (v as num).toInt()),
        canSubmit: $checkedConvert('canSubmit', (v) => v as bool),
        canReopen: $checkedConvert('canReopen', (v) => v as bool),
        createdAt: $checkedConvert(
          'createdAt',
          (v) => DateTime.parse(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$TaskItemToJson(TaskItem instance) => <String, dynamic>{
  'id': instance.id,
  'groupId': instance.groupId,
  'date': instance.date,
  'businessUnit': instance.businessUnit.toJson(),
  'title': instance.title,
  'details': instance.details,
  'priority': _$TaskPriorityEnumMap[instance.priority]!,
  'allottedBy': instance.allottedBy.toJson(),
  'assignee': instance.assignee.toJson(),
  'status': _$TaskStatusEnumMap[instance.status]!,
  'overdue': instance.overdue,
  'reason': instance.reason,
  'comment': instance.comment,
  'submittedAt': instance.submittedAt?.toIso8601String(),
  'reopenedAt': instance.reopenedAt?.toIso8601String(),
  'reopenComment': instance.reopenComment,
  'reopenCount': instance.reopenCount,
  'canSubmit': instance.canSubmit,
  'canReopen': instance.canReopen,
  'createdAt': instance.createdAt.toIso8601String(),
};

const _$TaskPriorityEnumMap = {
  TaskPriority.NORMAL: 'NORMAL',
  TaskPriority.HIGH: 'HIGH',
};

const _$TaskStatusEnumMap = {
  TaskStatus.PENDING: 'PENDING',
  TaskStatus.COMPLETED: 'COMPLETED',
  TaskStatus.NOT_DONE: 'NOT_DONE',
};
