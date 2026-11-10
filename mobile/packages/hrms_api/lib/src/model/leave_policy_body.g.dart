// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_policy_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LeavePolicyBodyCWProxy {
  LeavePolicyBody leaveTypeId(String leaveTypeId);

  LeavePolicyBody category(EmployeeCategory? category);

  LeavePolicyBody employmentType(EmploymentType? employmentType);

  LeavePolicyBody state(String? state);

  LeavePolicyBody annualQuota(num annualQuota);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LeavePolicyBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LeavePolicyBody(...).copyWith(id: 12, name: "My name")
  /// ````
  LeavePolicyBody call({
    String leaveTypeId,
    EmployeeCategory? category,
    EmploymentType? employmentType,
    String? state,
    num annualQuota,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfLeavePolicyBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfLeavePolicyBody.copyWith.fieldName(...)`
class _$LeavePolicyBodyCWProxyImpl implements _$LeavePolicyBodyCWProxy {
  const _$LeavePolicyBodyCWProxyImpl(this._value);

  final LeavePolicyBody _value;

  @override
  LeavePolicyBody leaveTypeId(String leaveTypeId) =>
      this(leaveTypeId: leaveTypeId);

  @override
  LeavePolicyBody category(EmployeeCategory? category) =>
      this(category: category);

  @override
  LeavePolicyBody employmentType(EmploymentType? employmentType) =>
      this(employmentType: employmentType);

  @override
  LeavePolicyBody state(String? state) => this(state: state);

  @override
  LeavePolicyBody annualQuota(num annualQuota) =>
      this(annualQuota: annualQuota);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LeavePolicyBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LeavePolicyBody(...).copyWith(id: 12, name: "My name")
  /// ````
  LeavePolicyBody call({
    Object? leaveTypeId = const $CopyWithPlaceholder(),
    Object? category = const $CopyWithPlaceholder(),
    Object? employmentType = const $CopyWithPlaceholder(),
    Object? state = const $CopyWithPlaceholder(),
    Object? annualQuota = const $CopyWithPlaceholder(),
  }) {
    return LeavePolicyBody(
      leaveTypeId: leaveTypeId == const $CopyWithPlaceholder()
          ? _value.leaveTypeId
          // ignore: cast_nullable_to_non_nullable
          : leaveTypeId as String,
      category: category == const $CopyWithPlaceholder()
          ? _value.category
          // ignore: cast_nullable_to_non_nullable
          : category as EmployeeCategory?,
      employmentType: employmentType == const $CopyWithPlaceholder()
          ? _value.employmentType
          // ignore: cast_nullable_to_non_nullable
          : employmentType as EmploymentType?,
      state: state == const $CopyWithPlaceholder()
          ? _value.state
          // ignore: cast_nullable_to_non_nullable
          : state as String?,
      annualQuota: annualQuota == const $CopyWithPlaceholder()
          ? _value.annualQuota
          // ignore: cast_nullable_to_non_nullable
          : annualQuota as num,
    );
  }
}

extension $LeavePolicyBodyCopyWith on LeavePolicyBody {
  /// Returns a callable class that can be used as follows: `instanceOfLeavePolicyBody.copyWith(...)` or like so:`instanceOfLeavePolicyBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LeavePolicyBodyCWProxy get copyWith => _$LeavePolicyBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeavePolicyBody _$LeavePolicyBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('LeavePolicyBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['leaveTypeId', 'annualQuota']);
      final val = LeavePolicyBody(
        leaveTypeId: $checkedConvert('leaveTypeId', (v) => v as String),
        category: $checkedConvert(
          'category',
          (v) => $enumDecodeNullable(_$EmployeeCategoryEnumMap, v),
        ),
        employmentType: $checkedConvert(
          'employmentType',
          (v) => $enumDecodeNullable(_$EmploymentTypeEnumMap, v),
        ),
        state: $checkedConvert('state', (v) => v as String?),
        annualQuota: $checkedConvert('annualQuota', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$LeavePolicyBodyToJson(LeavePolicyBody instance) =>
    <String, dynamic>{
      'leaveTypeId': instance.leaveTypeId,
      'category': ?_$EmployeeCategoryEnumMap[instance.category],
      'employmentType': ?_$EmploymentTypeEnumMap[instance.employmentType],
      'state': ?instance.state,
      'annualQuota': instance.annualQuota,
    };

const _$EmployeeCategoryEnumMap = {
  EmployeeCategory.DRIVER: 'DRIVER',
  EmployeeCategory.LOADMAN: 'LOADMAN',
  EmployeeCategory.CONDUCTOR: 'CONDUCTOR',
  EmployeeCategory.HELPER: 'HELPER',
  EmployeeCategory.MECHANIC: 'MECHANIC',
  EmployeeCategory.DEPOT_STAFF: 'DEPOT_STAFF',
  EmployeeCategory.OFFICE: 'OFFICE',
};

const _$EmploymentTypeEnumMap = {
  EmploymentType.PERMANENT: 'PERMANENT',
  EmploymentType.FIXED_TERM: 'FIXED_TERM',
  EmploymentType.CONTRACT: 'CONTRACT',
};
