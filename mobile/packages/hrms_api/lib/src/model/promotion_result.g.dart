// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion_result.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PromotionResultCWProxy {
  PromotionResult employee(EmployeeDetail employee);

  PromotionResult reportsNeedingReassignment(
    List<PersonRef> reportsNeedingReassignment,
  );

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PromotionResult(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PromotionResult(...).copyWith(id: 12, name: "My name")
  /// ````
  PromotionResult call({
    EmployeeDetail employee,
    List<PersonRef> reportsNeedingReassignment,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPromotionResult.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPromotionResult.copyWith.fieldName(...)`
class _$PromotionResultCWProxyImpl implements _$PromotionResultCWProxy {
  const _$PromotionResultCWProxyImpl(this._value);

  final PromotionResult _value;

  @override
  PromotionResult employee(EmployeeDetail employee) => this(employee: employee);

  @override
  PromotionResult reportsNeedingReassignment(
    List<PersonRef> reportsNeedingReassignment,
  ) => this(reportsNeedingReassignment: reportsNeedingReassignment);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PromotionResult(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PromotionResult(...).copyWith(id: 12, name: "My name")
  /// ````
  PromotionResult call({
    Object? employee = const $CopyWithPlaceholder(),
    Object? reportsNeedingReassignment = const $CopyWithPlaceholder(),
  }) {
    return PromotionResult(
      employee: employee == const $CopyWithPlaceholder()
          ? _value.employee
          // ignore: cast_nullable_to_non_nullable
          : employee as EmployeeDetail,
      reportsNeedingReassignment:
          reportsNeedingReassignment == const $CopyWithPlaceholder()
          ? _value.reportsNeedingReassignment
          // ignore: cast_nullable_to_non_nullable
          : reportsNeedingReassignment as List<PersonRef>,
    );
  }
}

extension $PromotionResultCopyWith on PromotionResult {
  /// Returns a callable class that can be used as follows: `instanceOfPromotionResult.copyWith(...)` or like so:`instanceOfPromotionResult.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PromotionResultCWProxy get copyWith => _$PromotionResultCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromotionResult _$PromotionResultFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PromotionResult', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['employee', 'reportsNeedingReassignment'],
      );
      final val = PromotionResult(
        employee: $checkedConvert(
          'employee',
          (v) => EmployeeDetail.fromJson(v as Map<String, dynamic>),
        ),
        reportsNeedingReassignment: $checkedConvert(
          'reportsNeedingReassignment',
          (v) => (v as List<dynamic>)
              .map((e) => PersonRef.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$PromotionResultToJson(PromotionResult instance) =>
    <String, dynamic>{
      'employee': instance.employee.toJson(),
      'reportsNeedingReassignment': instance.reportsNeedingReassignment
          .map((e) => e.toJson())
          .toList(),
    };
