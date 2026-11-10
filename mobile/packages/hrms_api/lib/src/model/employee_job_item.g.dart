// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_job_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$EmployeeJobItemCWProxy {
  EmployeeJobItem id(String id);

  EmployeeJobItem depot(DepotSummary depot);

  EmployeeJobItem designation(String designation);

  EmployeeJobItem grade(String? grade);

  EmployeeJobItem reportingTo(PersonRef? reportingTo);

  EmployeeJobItem effectiveFrom(String effectiveFrom);

  EmployeeJobItem effectiveTo(String? effectiveTo);

  EmployeeJobItem changeReason(String? changeReason);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `EmployeeJobItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// EmployeeJobItem(...).copyWith(id: 12, name: "My name")
  /// ````
  EmployeeJobItem call({
    String id,
    DepotSummary depot,
    String designation,
    String? grade,
    PersonRef? reportingTo,
    String effectiveFrom,
    String? effectiveTo,
    String? changeReason,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfEmployeeJobItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfEmployeeJobItem.copyWith.fieldName(...)`
class _$EmployeeJobItemCWProxyImpl implements _$EmployeeJobItemCWProxy {
  const _$EmployeeJobItemCWProxyImpl(this._value);

  final EmployeeJobItem _value;

  @override
  EmployeeJobItem id(String id) => this(id: id);

  @override
  EmployeeJobItem depot(DepotSummary depot) => this(depot: depot);

  @override
  EmployeeJobItem designation(String designation) =>
      this(designation: designation);

  @override
  EmployeeJobItem grade(String? grade) => this(grade: grade);

  @override
  EmployeeJobItem reportingTo(PersonRef? reportingTo) =>
      this(reportingTo: reportingTo);

  @override
  EmployeeJobItem effectiveFrom(String effectiveFrom) =>
      this(effectiveFrom: effectiveFrom);

  @override
  EmployeeJobItem effectiveTo(String? effectiveTo) =>
      this(effectiveTo: effectiveTo);

  @override
  EmployeeJobItem changeReason(String? changeReason) =>
      this(changeReason: changeReason);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `EmployeeJobItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// EmployeeJobItem(...).copyWith(id: 12, name: "My name")
  /// ````
  EmployeeJobItem call({
    Object? id = const $CopyWithPlaceholder(),
    Object? depot = const $CopyWithPlaceholder(),
    Object? designation = const $CopyWithPlaceholder(),
    Object? grade = const $CopyWithPlaceholder(),
    Object? reportingTo = const $CopyWithPlaceholder(),
    Object? effectiveFrom = const $CopyWithPlaceholder(),
    Object? effectiveTo = const $CopyWithPlaceholder(),
    Object? changeReason = const $CopyWithPlaceholder(),
  }) {
    return EmployeeJobItem(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      depot: depot == const $CopyWithPlaceholder()
          ? _value.depot
          // ignore: cast_nullable_to_non_nullable
          : depot as DepotSummary,
      designation: designation == const $CopyWithPlaceholder()
          ? _value.designation
          // ignore: cast_nullable_to_non_nullable
          : designation as String,
      grade: grade == const $CopyWithPlaceholder()
          ? _value.grade
          // ignore: cast_nullable_to_non_nullable
          : grade as String?,
      reportingTo: reportingTo == const $CopyWithPlaceholder()
          ? _value.reportingTo
          // ignore: cast_nullable_to_non_nullable
          : reportingTo as PersonRef?,
      effectiveFrom: effectiveFrom == const $CopyWithPlaceholder()
          ? _value.effectiveFrom
          // ignore: cast_nullable_to_non_nullable
          : effectiveFrom as String,
      effectiveTo: effectiveTo == const $CopyWithPlaceholder()
          ? _value.effectiveTo
          // ignore: cast_nullable_to_non_nullable
          : effectiveTo as String?,
      changeReason: changeReason == const $CopyWithPlaceholder()
          ? _value.changeReason
          // ignore: cast_nullable_to_non_nullable
          : changeReason as String?,
    );
  }
}

extension $EmployeeJobItemCopyWith on EmployeeJobItem {
  /// Returns a callable class that can be used as follows: `instanceOfEmployeeJobItem.copyWith(...)` or like so:`instanceOfEmployeeJobItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$EmployeeJobItemCWProxy get copyWith => _$EmployeeJobItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeJobItem _$EmployeeJobItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate('EmployeeJobItem', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'depot',
          'designation',
          'grade',
          'reportingTo',
          'effectiveFrom',
          'effectiveTo',
          'changeReason',
        ],
      );
      final val = EmployeeJobItem(
        id: $checkedConvert('id', (v) => v as String),
        depot: $checkedConvert(
          'depot',
          (v) => DepotSummary.fromJson(v as Map<String, dynamic>),
        ),
        designation: $checkedConvert('designation', (v) => v as String),
        grade: $checkedConvert('grade', (v) => v as String?),
        reportingTo: $checkedConvert(
          'reportingTo',
          (v) =>
              v == null ? null : PersonRef.fromJson(v as Map<String, dynamic>),
        ),
        effectiveFrom: $checkedConvert('effectiveFrom', (v) => v as String),
        effectiveTo: $checkedConvert('effectiveTo', (v) => v as String?),
        changeReason: $checkedConvert('changeReason', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$EmployeeJobItemToJson(EmployeeJobItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'depot': instance.depot.toJson(),
      'designation': instance.designation,
      'grade': instance.grade,
      'reportingTo': instance.reportingTo?.toJson(),
      'effectiveFrom': instance.effectiveFrom,
      'effectiveTo': instance.effectiveTo,
      'changeReason': instance.changeReason,
    };
