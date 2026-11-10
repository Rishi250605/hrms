// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_reopen_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TaskReopenBodyCWProxy {
  TaskReopenBody comment(String comment);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TaskReopenBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TaskReopenBody(...).copyWith(id: 12, name: "My name")
  /// ````
  TaskReopenBody call({String comment});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTaskReopenBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTaskReopenBody.copyWith.fieldName(...)`
class _$TaskReopenBodyCWProxyImpl implements _$TaskReopenBodyCWProxy {
  const _$TaskReopenBodyCWProxyImpl(this._value);

  final TaskReopenBody _value;

  @override
  TaskReopenBody comment(String comment) => this(comment: comment);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TaskReopenBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TaskReopenBody(...).copyWith(id: 12, name: "My name")
  /// ````
  TaskReopenBody call({Object? comment = const $CopyWithPlaceholder()}) {
    return TaskReopenBody(
      comment: comment == const $CopyWithPlaceholder()
          ? _value.comment
          // ignore: cast_nullable_to_non_nullable
          : comment as String,
    );
  }
}

extension $TaskReopenBodyCopyWith on TaskReopenBody {
  /// Returns a callable class that can be used as follows: `instanceOfTaskReopenBody.copyWith(...)` or like so:`instanceOfTaskReopenBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TaskReopenBodyCWProxy get copyWith => _$TaskReopenBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskReopenBody _$TaskReopenBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('TaskReopenBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['comment']);
      final val = TaskReopenBody(
        comment: $checkedConvert('comment', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$TaskReopenBodyToJson(TaskReopenBody instance) =>
    <String, dynamic>{'comment': instance.comment};
