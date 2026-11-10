// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_change_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$JobChangeBodyCWProxy {
  JobChangeBody effectiveFrom(String effectiveFrom);

  JobChangeBody depotId(String? depotId);

  JobChangeBody designation(String? designation);

  JobChangeBody grade(String? grade);

  JobChangeBody reportingToEmployeeId(String? reportingToEmployeeId);

  JobChangeBody reason(String reason);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `JobChangeBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// JobChangeBody(...).copyWith(id: 12, name: "My name")
  /// ````
  JobChangeBody call({
    String effectiveFrom,
    String? depotId,
    String? designation,
    String? grade,
    String? reportingToEmployeeId,
    String reason,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfJobChangeBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfJobChangeBody.copyWith.fieldName(...)`
class _$JobChangeBodyCWProxyImpl implements _$JobChangeBodyCWProxy {
  const _$JobChangeBodyCWProxyImpl(this._value);

  final JobChangeBody _value;

  @override
  JobChangeBody effectiveFrom(String effectiveFrom) =>
      this(effectiveFrom: effectiveFrom);

  @override
  JobChangeBody depotId(String? depotId) => this(depotId: depotId);

  @override
  JobChangeBody designation(String? designation) =>
      this(designation: designation);

  @override
  JobChangeBody grade(String? grade) => this(grade: grade);

  @override
  JobChangeBody reportingToEmployeeId(String? reportingToEmployeeId) =>
      this(reportingToEmployeeId: reportingToEmployeeId);

  @override
  JobChangeBody reason(String reason) => this(reason: reason);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `JobChangeBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// JobChangeBody(...).copyWith(id: 12, name: "My name")
  /// ````
  JobChangeBody call({
    Object? effectiveFrom = const $CopyWithPlaceholder(),
    Object? depotId = const $CopyWithPlaceholder(),
    Object? designation = const $CopyWithPlaceholder(),
    Object? grade = const $CopyWithPlaceholder(),
    Object? reportingToEmployeeId = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
  }) {
    return JobChangeBody(
      effectiveFrom: effectiveFrom == const $CopyWithPlaceholder()
          ? _value.effectiveFrom
          // ignore: cast_nullable_to_non_nullable
          : effectiveFrom as String,
      depotId: depotId == const $CopyWithPlaceholder()
          ? _value.depotId
          // ignore: cast_nullable_to_non_nullable
          : depotId as String?,
      designation: designation == const $CopyWithPlaceholder()
          ? _value.designation
          // ignore: cast_nullable_to_non_nullable
          : designation as String?,
      grade: grade == const $CopyWithPlaceholder()
          ? _value.grade
          // ignore: cast_nullable_to_non_nullable
          : grade as String?,
      reportingToEmployeeId:
          reportingToEmployeeId == const $CopyWithPlaceholder()
          ? _value.reportingToEmployeeId
          // ignore: cast_nullable_to_non_nullable
          : reportingToEmployeeId as String?,
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String,
    );
  }
}

extension $JobChangeBodyCopyWith on JobChangeBody {
  /// Returns a callable class that can be used as follows: `instanceOfJobChangeBody.copyWith(...)` or like so:`instanceOfJobChangeBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$JobChangeBodyCWProxy get copyWith => _$JobChangeBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobChangeBody _$JobChangeBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JobChangeBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['effectiveFrom', 'reason']);
      final val = JobChangeBody(
        effectiveFrom: $checkedConvert('effectiveFrom', (v) => v as String),
        depotId: $checkedConvert('depotId', (v) => v as String?),
        designation: $checkedConvert('designation', (v) => v as String?),
        grade: $checkedConvert('grade', (v) => v as String?),
        reportingToEmployeeId: $checkedConvert(
          'reportingToEmployeeId',
          (v) => v as String?,
        ),
        reason: $checkedConvert('reason', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$JobChangeBodyToJson(JobChangeBody instance) =>
    <String, dynamic>{
      'effectiveFrom': instance.effectiveFrom,
      'depotId': ?instance.depotId,
      'designation': ?instance.designation,
      'grade': ?instance.grade,
      'reportingToEmployeeId': ?instance.reportingToEmployeeId,
      'reason': instance.reason,
    };
