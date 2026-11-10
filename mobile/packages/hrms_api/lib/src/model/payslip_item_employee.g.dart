// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payslip_item_employee.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PayslipItemEmployeeCWProxy {
  PayslipItemEmployee employeeId(String employeeId);

  PayslipItemEmployee empCode(String empCode);

  PayslipItemEmployee name(String name);

  PayslipItemEmployee role(Role? role);

  PayslipItemEmployee category(String category);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PayslipItemEmployee(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PayslipItemEmployee(...).copyWith(id: 12, name: "My name")
  /// ````
  PayslipItemEmployee call({
    String employeeId,
    String empCode,
    String name,
    Role? role,
    String category,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPayslipItemEmployee.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPayslipItemEmployee.copyWith.fieldName(...)`
class _$PayslipItemEmployeeCWProxyImpl implements _$PayslipItemEmployeeCWProxy {
  const _$PayslipItemEmployeeCWProxyImpl(this._value);

  final PayslipItemEmployee _value;

  @override
  PayslipItemEmployee employeeId(String employeeId) =>
      this(employeeId: employeeId);

  @override
  PayslipItemEmployee empCode(String empCode) => this(empCode: empCode);

  @override
  PayslipItemEmployee name(String name) => this(name: name);

  @override
  PayslipItemEmployee role(Role? role) => this(role: role);

  @override
  PayslipItemEmployee category(String category) => this(category: category);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PayslipItemEmployee(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PayslipItemEmployee(...).copyWith(id: 12, name: "My name")
  /// ````
  PayslipItemEmployee call({
    Object? employeeId = const $CopyWithPlaceholder(),
    Object? empCode = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? role = const $CopyWithPlaceholder(),
    Object? category = const $CopyWithPlaceholder(),
  }) {
    return PayslipItemEmployee(
      employeeId: employeeId == const $CopyWithPlaceholder()
          ? _value.employeeId
          // ignore: cast_nullable_to_non_nullable
          : employeeId as String,
      empCode: empCode == const $CopyWithPlaceholder()
          ? _value.empCode
          // ignore: cast_nullable_to_non_nullable
          : empCode as String,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      role: role == const $CopyWithPlaceholder()
          ? _value.role
          // ignore: cast_nullable_to_non_nullable
          : role as Role?,
      category: category == const $CopyWithPlaceholder()
          ? _value.category
          // ignore: cast_nullable_to_non_nullable
          : category as String,
    );
  }
}

extension $PayslipItemEmployeeCopyWith on PayslipItemEmployee {
  /// Returns a callable class that can be used as follows: `instanceOfPayslipItemEmployee.copyWith(...)` or like so:`instanceOfPayslipItemEmployee.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PayslipItemEmployeeCWProxy get copyWith =>
      _$PayslipItemEmployeeCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayslipItemEmployee _$PayslipItemEmployeeFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('PayslipItemEmployee', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['employeeId', 'empCode', 'name', 'role', 'category'],
  );
  final val = PayslipItemEmployee(
    employeeId: $checkedConvert('employeeId', (v) => v as String),
    empCode: $checkedConvert('empCode', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    role: $checkedConvert('role', (v) => $enumDecodeNullable(_$RoleEnumMap, v)),
    category: $checkedConvert('category', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$PayslipItemEmployeeToJson(
  PayslipItemEmployee instance,
) => <String, dynamic>{
  'employeeId': instance.employeeId,
  'empCode': instance.empCode,
  'name': instance.name,
  'role': _$RoleEnumMap[instance.role],
  'category': instance.category,
};

const _$RoleEnumMap = {
  Role.DIRECTOR: 'DIRECTOR',
  Role.HR: 'HR',
  Role.OPERATIONAL_MANAGER: 'OPERATIONAL_MANAGER',
  Role.REGIONAL_MANAGER: 'REGIONAL_MANAGER',
};
