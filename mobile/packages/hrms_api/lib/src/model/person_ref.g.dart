// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_ref.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PersonRefCWProxy {
  PersonRef employeeId(String employeeId);

  PersonRef empCode(String empCode);

  PersonRef name(String name);

  PersonRef role(Role? role);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PersonRef(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PersonRef(...).copyWith(id: 12, name: "My name")
  /// ````
  PersonRef call({String employeeId, String empCode, String name, Role? role});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPersonRef.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPersonRef.copyWith.fieldName(...)`
class _$PersonRefCWProxyImpl implements _$PersonRefCWProxy {
  const _$PersonRefCWProxyImpl(this._value);

  final PersonRef _value;

  @override
  PersonRef employeeId(String employeeId) => this(employeeId: employeeId);

  @override
  PersonRef empCode(String empCode) => this(empCode: empCode);

  @override
  PersonRef name(String name) => this(name: name);

  @override
  PersonRef role(Role? role) => this(role: role);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PersonRef(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PersonRef(...).copyWith(id: 12, name: "My name")
  /// ````
  PersonRef call({
    Object? employeeId = const $CopyWithPlaceholder(),
    Object? empCode = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? role = const $CopyWithPlaceholder(),
  }) {
    return PersonRef(
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
    );
  }
}

extension $PersonRefCopyWith on PersonRef {
  /// Returns a callable class that can be used as follows: `instanceOfPersonRef.copyWith(...)` or like so:`instanceOfPersonRef.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PersonRefCWProxy get copyWith => _$PersonRefCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonRef _$PersonRefFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PersonRef', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['employeeId', 'empCode', 'name', 'role'],
      );
      final val = PersonRef(
        employeeId: $checkedConvert('employeeId', (v) => v as String),
        empCode: $checkedConvert('empCode', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        role: $checkedConvert(
          'role',
          (v) => $enumDecodeNullable(_$RoleEnumMap, v),
        ),
      );
      return val;
    });

Map<String, dynamic> _$PersonRefToJson(PersonRef instance) => <String, dynamic>{
  'employeeId': instance.employeeId,
  'empCode': instance.empCode,
  'name': instance.name,
  'role': _$RoleEnumMap[instance.role],
};

const _$RoleEnumMap = {
  Role.DIRECTOR: 'DIRECTOR',
  Role.HR: 'HR',
  Role.OPERATIONAL_MANAGER: 'OPERATIONAL_MANAGER',
  Role.REGIONAL_MANAGER: 'REGIONAL_MANAGER',
};
