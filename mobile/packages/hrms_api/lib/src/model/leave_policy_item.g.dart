// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_policy_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LeavePolicyItemCWProxy {
  LeavePolicyItem id(String id);

  LeavePolicyItem leaveTypeId(String leaveTypeId);

  LeavePolicyItem leaveTypeCode(String leaveTypeCode);

  LeavePolicyItem category(EmployeeCategory? category);

  LeavePolicyItem employmentType(EmploymentType? employmentType);

  LeavePolicyItem state(String? state);

  LeavePolicyItem annualQuota(num annualQuota);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LeavePolicyItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LeavePolicyItem(...).copyWith(id: 12, name: "My name")
  /// ````
  LeavePolicyItem call({
    String id,
    String leaveTypeId,
    String leaveTypeCode,
    EmployeeCategory? category,
    EmploymentType? employmentType,
    String? state,
    num annualQuota,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfLeavePolicyItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfLeavePolicyItem.copyWith.fieldName(...)`
class _$LeavePolicyItemCWProxyImpl implements _$LeavePolicyItemCWProxy {
  const _$LeavePolicyItemCWProxyImpl(this._value);

  final LeavePolicyItem _value;

  @override
  LeavePolicyItem id(String id) => this(id: id);

  @override
  LeavePolicyItem leaveTypeId(String leaveTypeId) =>
      this(leaveTypeId: leaveTypeId);

  @override
  LeavePolicyItem leaveTypeCode(String leaveTypeCode) =>
      this(leaveTypeCode: leaveTypeCode);

  @override
  LeavePolicyItem category(EmployeeCategory? category) =>
      this(category: category);

  @override
  LeavePolicyItem employmentType(EmploymentType? employmentType) =>
      this(employmentType: employmentType);

  @override
  LeavePolicyItem state(String? state) => this(state: state);

  @override
  LeavePolicyItem annualQuota(num annualQuota) =>
      this(annualQuota: annualQuota);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LeavePolicyItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LeavePolicyItem(...).copyWith(id: 12, name: "My name")
  /// ````
  LeavePolicyItem call({
    Object? id = const $CopyWithPlaceholder(),
    Object? leaveTypeId = const $CopyWithPlaceholder(),
    Object? leaveTypeCode = const $CopyWithPlaceholder(),
    Object? category = const $CopyWithPlaceholder(),
    Object? employmentType = const $CopyWithPlaceholder(),
    Object? state = const $CopyWithPlaceholder(),
    Object? annualQuota = const $CopyWithPlaceholder(),
  }) {
    return LeavePolicyItem(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      leaveTypeId: leaveTypeId == const $CopyWithPlaceholder()
          ? _value.leaveTypeId
          // ignore: cast_nullable_to_non_nullable
          : leaveTypeId as String,
      leaveTypeCode: leaveTypeCode == const $CopyWithPlaceholder()
          ? _value.leaveTypeCode
          // ignore: cast_nullable_to_non_nullable
          : leaveTypeCode as String,
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

extension $LeavePolicyItemCopyWith on LeavePolicyItem {
  /// Returns a callable class that can be used as follows: `instanceOfLeavePolicyItem.copyWith(...)` or like so:`instanceOfLeavePolicyItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LeavePolicyItemCWProxy get copyWith => _$LeavePolicyItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeavePolicyItem _$LeavePolicyItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate('LeavePolicyItem', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'leaveTypeId',
          'leaveTypeCode',
          'category',
          'employmentType',
          'state',
          'annualQuota',
        ],
      );
      final val = LeavePolicyItem(
        id: $checkedConvert('id', (v) => v as String),
        leaveTypeId: $checkedConvert('leaveTypeId', (v) => v as String),
        leaveTypeCode: $checkedConvert('leaveTypeCode', (v) => v as String),
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

Map<String, dynamic> _$LeavePolicyItemToJson(LeavePolicyItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'leaveTypeId': instance.leaveTypeId,
      'leaveTypeCode': instance.leaveTypeCode,
      'category': _$EmployeeCategoryEnumMap[instance.category],
      'employmentType': _$EmploymentTypeEnumMap[instance.employmentType],
      'state': instance.state,
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
