// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_create_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TaskCreateBodyCWProxy {
  TaskCreateBody date(String? date);

  TaskCreateBody businessUnitId(String businessUnitId);

  TaskCreateBody title(String title);

  TaskCreateBody details(String? details);

  TaskCreateBody priority(TaskPriority? priority);

  TaskCreateBody assigneeEmployeeIds(List<String> assigneeEmployeeIds);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TaskCreateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TaskCreateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  TaskCreateBody call({
    String? date,
    String businessUnitId,
    String title,
    String? details,
    TaskPriority? priority,
    List<String> assigneeEmployeeIds,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTaskCreateBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTaskCreateBody.copyWith.fieldName(...)`
class _$TaskCreateBodyCWProxyImpl implements _$TaskCreateBodyCWProxy {
  const _$TaskCreateBodyCWProxyImpl(this._value);

  final TaskCreateBody _value;

  @override
  TaskCreateBody date(String? date) => this(date: date);

  @override
  TaskCreateBody businessUnitId(String businessUnitId) =>
      this(businessUnitId: businessUnitId);

  @override
  TaskCreateBody title(String title) => this(title: title);

  @override
  TaskCreateBody details(String? details) => this(details: details);

  @override
  TaskCreateBody priority(TaskPriority? priority) => this(priority: priority);

  @override
  TaskCreateBody assigneeEmployeeIds(List<String> assigneeEmployeeIds) =>
      this(assigneeEmployeeIds: assigneeEmployeeIds);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TaskCreateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TaskCreateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  TaskCreateBody call({
    Object? date = const $CopyWithPlaceholder(),
    Object? businessUnitId = const $CopyWithPlaceholder(),
    Object? title = const $CopyWithPlaceholder(),
    Object? details = const $CopyWithPlaceholder(),
    Object? priority = const $CopyWithPlaceholder(),
    Object? assigneeEmployeeIds = const $CopyWithPlaceholder(),
  }) {
    return TaskCreateBody(
      date: date == const $CopyWithPlaceholder()
          ? _value.date
          // ignore: cast_nullable_to_non_nullable
          : date as String?,
      businessUnitId: businessUnitId == const $CopyWithPlaceholder()
          ? _value.businessUnitId
          // ignore: cast_nullable_to_non_nullable
          : businessUnitId as String,
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
          : priority as TaskPriority?,
      assigneeEmployeeIds: assigneeEmployeeIds == const $CopyWithPlaceholder()
          ? _value.assigneeEmployeeIds
          // ignore: cast_nullable_to_non_nullable
          : assigneeEmployeeIds as List<String>,
    );
  }
}

extension $TaskCreateBodyCopyWith on TaskCreateBody {
  /// Returns a callable class that can be used as follows: `instanceOfTaskCreateBody.copyWith(...)` or like so:`instanceOfTaskCreateBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TaskCreateBodyCWProxy get copyWith => _$TaskCreateBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskCreateBody _$TaskCreateBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('TaskCreateBody', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['businessUnitId', 'title', 'assigneeEmployeeIds'],
      );
      final val = TaskCreateBody(
        date: $checkedConvert('date', (v) => v as String?),
        businessUnitId: $checkedConvert('businessUnitId', (v) => v as String),
        title: $checkedConvert('title', (v) => v as String),
        details: $checkedConvert('details', (v) => v as String?),
        priority: $checkedConvert(
          'priority',
          (v) => $enumDecodeNullable(_$TaskPriorityEnumMap, v),
        ),
        assigneeEmployeeIds: $checkedConvert(
          'assigneeEmployeeIds',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$TaskCreateBodyToJson(TaskCreateBody instance) =>
    <String, dynamic>{
      'date': ?instance.date,
      'businessUnitId': instance.businessUnitId,
      'title': instance.title,
      'details': ?instance.details,
      'priority': ?_$TaskPriorityEnumMap[instance.priority],
      'assigneeEmployeeIds': instance.assigneeEmployeeIds,
    };

const _$TaskPriorityEnumMap = {
  TaskPriority.NORMAL: 'NORMAL',
  TaskPriority.HIGH: 'HIGH',
};
