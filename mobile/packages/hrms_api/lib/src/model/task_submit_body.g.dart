// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_submit_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TaskSubmitBodyCWProxy {
  TaskSubmitBody status(TaskSubmitBodyStatusEnum status);

  TaskSubmitBody reason(String? reason);

  TaskSubmitBody comment(String? comment);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TaskSubmitBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TaskSubmitBody(...).copyWith(id: 12, name: "My name")
  /// ````
  TaskSubmitBody call({
    TaskSubmitBodyStatusEnum status,
    String? reason,
    String? comment,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTaskSubmitBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTaskSubmitBody.copyWith.fieldName(...)`
class _$TaskSubmitBodyCWProxyImpl implements _$TaskSubmitBodyCWProxy {
  const _$TaskSubmitBodyCWProxyImpl(this._value);

  final TaskSubmitBody _value;

  @override
  TaskSubmitBody status(TaskSubmitBodyStatusEnum status) =>
      this(status: status);

  @override
  TaskSubmitBody reason(String? reason) => this(reason: reason);

  @override
  TaskSubmitBody comment(String? comment) => this(comment: comment);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TaskSubmitBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TaskSubmitBody(...).copyWith(id: 12, name: "My name")
  /// ````
  TaskSubmitBody call({
    Object? status = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
    Object? comment = const $CopyWithPlaceholder(),
  }) {
    return TaskSubmitBody(
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as TaskSubmitBodyStatusEnum,
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String?,
      comment: comment == const $CopyWithPlaceholder()
          ? _value.comment
          // ignore: cast_nullable_to_non_nullable
          : comment as String?,
    );
  }
}

extension $TaskSubmitBodyCopyWith on TaskSubmitBody {
  /// Returns a callable class that can be used as follows: `instanceOfTaskSubmitBody.copyWith(...)` or like so:`instanceOfTaskSubmitBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TaskSubmitBodyCWProxy get copyWith => _$TaskSubmitBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskSubmitBody _$TaskSubmitBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('TaskSubmitBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['status']);
      final val = TaskSubmitBody(
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(_$TaskSubmitBodyStatusEnumEnumMap, v),
        ),
        reason: $checkedConvert('reason', (v) => v as String?),
        comment: $checkedConvert('comment', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$TaskSubmitBodyToJson(TaskSubmitBody instance) =>
    <String, dynamic>{
      'status': _$TaskSubmitBodyStatusEnumEnumMap[instance.status]!,
      'reason': ?instance.reason,
      'comment': ?instance.comment,
    };

const _$TaskSubmitBodyStatusEnumEnumMap = {
  TaskSubmitBodyStatusEnum.COMPLETED: 'COMPLETED',
  TaskSubmitBodyStatusEnum.NOT_DONE: 'NOT_DONE',
};
