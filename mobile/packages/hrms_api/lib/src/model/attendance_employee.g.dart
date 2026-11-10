// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_employee.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AttendanceEmployeeCWProxy {
  AttendanceEmployee id(String id);

  AttendanceEmployee empCode(String empCode);

  AttendanceEmployee fullName(String fullName);

  AttendanceEmployee category(EmployeeCategory category);

  AttendanceEmployee role(Role? role);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AttendanceEmployee(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AttendanceEmployee(...).copyWith(id: 12, name: "My name")
  /// ````
  AttendanceEmployee call({
    String id,
    String empCode,
    String fullName,
    EmployeeCategory category,
    Role? role,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAttendanceEmployee.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAttendanceEmployee.copyWith.fieldName(...)`
class _$AttendanceEmployeeCWProxyImpl implements _$AttendanceEmployeeCWProxy {
  const _$AttendanceEmployeeCWProxyImpl(this._value);

  final AttendanceEmployee _value;

  @override
  AttendanceEmployee id(String id) => this(id: id);

  @override
  AttendanceEmployee empCode(String empCode) => this(empCode: empCode);

  @override
  AttendanceEmployee fullName(String fullName) => this(fullName: fullName);

  @override
  AttendanceEmployee category(EmployeeCategory category) =>
      this(category: category);

  @override
  AttendanceEmployee role(Role? role) => this(role: role);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AttendanceEmployee(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AttendanceEmployee(...).copyWith(id: 12, name: "My name")
  /// ````
  AttendanceEmployee call({
    Object? id = const $CopyWithPlaceholder(),
    Object? empCode = const $CopyWithPlaceholder(),
    Object? fullName = const $CopyWithPlaceholder(),
    Object? category = const $CopyWithPlaceholder(),
    Object? role = const $CopyWithPlaceholder(),
  }) {
    return AttendanceEmployee(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      empCode: empCode == const $CopyWithPlaceholder()
          ? _value.empCode
          // ignore: cast_nullable_to_non_nullable
          : empCode as String,
      fullName: fullName == const $CopyWithPlaceholder()
          ? _value.fullName
          // ignore: cast_nullable_to_non_nullable
          : fullName as String,
      category: category == const $CopyWithPlaceholder()
          ? _value.category
          // ignore: cast_nullable_to_non_nullable
          : category as EmployeeCategory,
      role: role == const $CopyWithPlaceholder()
          ? _value.role
          // ignore: cast_nullable_to_non_nullable
          : role as Role?,
    );
  }
}

extension $AttendanceEmployeeCopyWith on AttendanceEmployee {
  /// Returns a callable class that can be used as follows: `instanceOfAttendanceEmployee.copyWith(...)` or like so:`instanceOfAttendanceEmployee.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AttendanceEmployeeCWProxy get copyWith =>
      _$AttendanceEmployeeCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceEmployee _$AttendanceEmployeeFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AttendanceEmployee', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['id', 'empCode', 'fullName', 'category', 'role'],
      );
      final val = AttendanceEmployee(
        id: $checkedConvert('id', (v) => v as String),
        empCode: $checkedConvert('empCode', (v) => v as String),
        fullName: $checkedConvert('fullName', (v) => v as String),
        category: $checkedConvert(
          'category',
          (v) => $enumDecode(_$EmployeeCategoryEnumMap, v),
        ),
        role: $checkedConvert(
          'role',
          (v) => $enumDecodeNullable(_$RoleEnumMap, v),
        ),
      );
      return val;
    });

Map<String, dynamic> _$AttendanceEmployeeToJson(AttendanceEmployee instance) =>
    <String, dynamic>{
      'id': instance.id,
      'empCode': instance.empCode,
      'fullName': instance.fullName,
      'category': _$EmployeeCategoryEnumMap[instance.category]!,
      'role': _$RoleEnumMap[instance.role],
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

const _$RoleEnumMap = {
  Role.DIRECTOR: 'DIRECTOR',
  Role.HR: 'HR',
  Role.OPERATIONAL_MANAGER: 'OPERATIONAL_MANAGER',
  Role.REGIONAL_MANAGER: 'REGIONAL_MANAGER',
};
