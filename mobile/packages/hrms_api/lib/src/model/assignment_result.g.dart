// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_result.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AssignmentResultCWProxy {
  AssignmentResult assignment(AssignmentItem assignment);

  AssignmentResult warnings(List<RosterWarning> warnings);

  AssignmentResult duty(DutyItem duty);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AssignmentResult(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AssignmentResult(...).copyWith(id: 12, name: "My name")
  /// ````
  AssignmentResult call({
    AssignmentItem assignment,
    List<RosterWarning> warnings,
    DutyItem duty,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAssignmentResult.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAssignmentResult.copyWith.fieldName(...)`
class _$AssignmentResultCWProxyImpl implements _$AssignmentResultCWProxy {
  const _$AssignmentResultCWProxyImpl(this._value);

  final AssignmentResult _value;

  @override
  AssignmentResult assignment(AssignmentItem assignment) =>
      this(assignment: assignment);

  @override
  AssignmentResult warnings(List<RosterWarning> warnings) =>
      this(warnings: warnings);

  @override
  AssignmentResult duty(DutyItem duty) => this(duty: duty);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AssignmentResult(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AssignmentResult(...).copyWith(id: 12, name: "My name")
  /// ````
  AssignmentResult call({
    Object? assignment = const $CopyWithPlaceholder(),
    Object? warnings = const $CopyWithPlaceholder(),
    Object? duty = const $CopyWithPlaceholder(),
  }) {
    return AssignmentResult(
      assignment: assignment == const $CopyWithPlaceholder()
          ? _value.assignment
          // ignore: cast_nullable_to_non_nullable
          : assignment as AssignmentItem,
      warnings: warnings == const $CopyWithPlaceholder()
          ? _value.warnings
          // ignore: cast_nullable_to_non_nullable
          : warnings as List<RosterWarning>,
      duty: duty == const $CopyWithPlaceholder()
          ? _value.duty
          // ignore: cast_nullable_to_non_nullable
          : duty as DutyItem,
    );
  }
}

extension $AssignmentResultCopyWith on AssignmentResult {
  /// Returns a callable class that can be used as follows: `instanceOfAssignmentResult.copyWith(...)` or like so:`instanceOfAssignmentResult.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AssignmentResultCWProxy get copyWith => _$AssignmentResultCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssignmentResult _$AssignmentResultFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AssignmentResult', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['assignment', 'warnings', 'duty']);
      final val = AssignmentResult(
        assignment: $checkedConvert(
          'assignment',
          (v) => AssignmentItem.fromJson(v as Map<String, dynamic>),
        ),
        warnings: $checkedConvert(
          'warnings',
          (v) => (v as List<dynamic>)
              .map((e) => RosterWarning.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        duty: $checkedConvert(
          'duty',
          (v) => DutyItem.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$AssignmentResultToJson(AssignmentResult instance) =>
    <String, dynamic>{
      'assignment': instance.assignment.toJson(),
      'warnings': instance.warnings.map((e) => e.toJson()).toList(),
      'duty': instance.duty.toJson(),
    };
