// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_input.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$JobInputCWProxy {
  JobInput depotId(String depotId);

  JobInput designation(String designation);

  JobInput grade(String? grade);

  JobInput reportingToEmployeeId(String reportingToEmployeeId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `JobInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// JobInput(...).copyWith(id: 12, name: "My name")
  /// ````
  JobInput call({
    String depotId,
    String designation,
    String? grade,
    String reportingToEmployeeId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfJobInput.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfJobInput.copyWith.fieldName(...)`
class _$JobInputCWProxyImpl implements _$JobInputCWProxy {
  const _$JobInputCWProxyImpl(this._value);

  final JobInput _value;

  @override
  JobInput depotId(String depotId) => this(depotId: depotId);

  @override
  JobInput designation(String designation) => this(designation: designation);

  @override
  JobInput grade(String? grade) => this(grade: grade);

  @override
  JobInput reportingToEmployeeId(String reportingToEmployeeId) =>
      this(reportingToEmployeeId: reportingToEmployeeId);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `JobInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// JobInput(...).copyWith(id: 12, name: "My name")
  /// ````
  JobInput call({
    Object? depotId = const $CopyWithPlaceholder(),
    Object? designation = const $CopyWithPlaceholder(),
    Object? grade = const $CopyWithPlaceholder(),
    Object? reportingToEmployeeId = const $CopyWithPlaceholder(),
  }) {
    return JobInput(
      depotId: depotId == const $CopyWithPlaceholder()
          ? _value.depotId
          // ignore: cast_nullable_to_non_nullable
          : depotId as String,
      designation: designation == const $CopyWithPlaceholder()
          ? _value.designation
          // ignore: cast_nullable_to_non_nullable
          : designation as String,
      grade: grade == const $CopyWithPlaceholder()
          ? _value.grade
          // ignore: cast_nullable_to_non_nullable
          : grade as String?,
      reportingToEmployeeId:
          reportingToEmployeeId == const $CopyWithPlaceholder()
          ? _value.reportingToEmployeeId
          // ignore: cast_nullable_to_non_nullable
          : reportingToEmployeeId as String,
    );
  }
}

extension $JobInputCopyWith on JobInput {
  /// Returns a callable class that can be used as follows: `instanceOfJobInput.copyWith(...)` or like so:`instanceOfJobInput.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$JobInputCWProxy get copyWith => _$JobInputCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobInput _$JobInputFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JobInput', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['depotId', 'designation', 'reportingToEmployeeId'],
      );
      final val = JobInput(
        depotId: $checkedConvert('depotId', (v) => v as String),
        designation: $checkedConvert('designation', (v) => v as String),
        grade: $checkedConvert('grade', (v) => v as String?),
        reportingToEmployeeId: $checkedConvert(
          'reportingToEmployeeId',
          (v) => v as String,
        ),
      );
      return val;
    });

Map<String, dynamic> _$JobInputToJson(JobInput instance) => <String, dynamic>{
  'depotId': instance.depotId,
  'designation': instance.designation,
  'grade': ?instance.grade,
  'reportingToEmployeeId': instance.reportingToEmployeeId,
};
