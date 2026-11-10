// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserItemCWProxy {
  UserItem id(String id);

  UserItem employeeId(String employeeId);

  UserItem empCode(String empCode);

  UserItem name(String name);

  UserItem phone(String phone);

  UserItem email(String? email);

  UserItem role(Role role);

  UserItem isActive(bool isActive);

  UserItem hasPassword(bool hasPassword);

  UserItem lockedUntil(DateTime? lockedUntil);

  UserItem lastLoginAt(DateTime? lastLoginAt);

  UserItem reportingTo(PersonRef? reportingTo);

  UserItem businessUnits(List<BusinessUnitMembership> businessUnits);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserItem(...).copyWith(id: 12, name: "My name")
  /// ````
  UserItem call({
    String id,
    String employeeId,
    String empCode,
    String name,
    String phone,
    String? email,
    Role role,
    bool isActive,
    bool hasPassword,
    DateTime? lockedUntil,
    DateTime? lastLoginAt,
    PersonRef? reportingTo,
    List<BusinessUnitMembership> businessUnits,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUserItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUserItem.copyWith.fieldName(...)`
class _$UserItemCWProxyImpl implements _$UserItemCWProxy {
  const _$UserItemCWProxyImpl(this._value);

  final UserItem _value;

  @override
  UserItem id(String id) => this(id: id);

  @override
  UserItem employeeId(String employeeId) => this(employeeId: employeeId);

  @override
  UserItem empCode(String empCode) => this(empCode: empCode);

  @override
  UserItem name(String name) => this(name: name);

  @override
  UserItem phone(String phone) => this(phone: phone);

  @override
  UserItem email(String? email) => this(email: email);

  @override
  UserItem role(Role role) => this(role: role);

  @override
  UserItem isActive(bool isActive) => this(isActive: isActive);

  @override
  UserItem hasPassword(bool hasPassword) => this(hasPassword: hasPassword);

  @override
  UserItem lockedUntil(DateTime? lockedUntil) => this(lockedUntil: lockedUntil);

  @override
  UserItem lastLoginAt(DateTime? lastLoginAt) => this(lastLoginAt: lastLoginAt);

  @override
  UserItem reportingTo(PersonRef? reportingTo) =>
      this(reportingTo: reportingTo);

  @override
  UserItem businessUnits(List<BusinessUnitMembership> businessUnits) =>
      this(businessUnits: businessUnits);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserItem(...).copyWith(id: 12, name: "My name")
  /// ````
  UserItem call({
    Object? id = const $CopyWithPlaceholder(),
    Object? employeeId = const $CopyWithPlaceholder(),
    Object? empCode = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? role = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? hasPassword = const $CopyWithPlaceholder(),
    Object? lockedUntil = const $CopyWithPlaceholder(),
    Object? lastLoginAt = const $CopyWithPlaceholder(),
    Object? reportingTo = const $CopyWithPlaceholder(),
    Object? businessUnits = const $CopyWithPlaceholder(),
  }) {
    return UserItem(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
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
      phone: phone == const $CopyWithPlaceholder()
          ? _value.phone
          // ignore: cast_nullable_to_non_nullable
          : phone as String,
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String?,
      role: role == const $CopyWithPlaceholder()
          ? _value.role
          // ignore: cast_nullable_to_non_nullable
          : role as Role,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool,
      hasPassword: hasPassword == const $CopyWithPlaceholder()
          ? _value.hasPassword
          // ignore: cast_nullable_to_non_nullable
          : hasPassword as bool,
      lockedUntil: lockedUntil == const $CopyWithPlaceholder()
          ? _value.lockedUntil
          // ignore: cast_nullable_to_non_nullable
          : lockedUntil as DateTime?,
      lastLoginAt: lastLoginAt == const $CopyWithPlaceholder()
          ? _value.lastLoginAt
          // ignore: cast_nullable_to_non_nullable
          : lastLoginAt as DateTime?,
      reportingTo: reportingTo == const $CopyWithPlaceholder()
          ? _value.reportingTo
          // ignore: cast_nullable_to_non_nullable
          : reportingTo as PersonRef?,
      businessUnits: businessUnits == const $CopyWithPlaceholder()
          ? _value.businessUnits
          // ignore: cast_nullable_to_non_nullable
          : businessUnits as List<BusinessUnitMembership>,
    );
  }
}

extension $UserItemCopyWith on UserItem {
  /// Returns a callable class that can be used as follows: `instanceOfUserItem.copyWith(...)` or like so:`instanceOfUserItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserItemCWProxy get copyWith => _$UserItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserItem _$UserItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UserItem', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'employeeId',
          'empCode',
          'name',
          'phone',
          'email',
          'role',
          'isActive',
          'hasPassword',
          'lockedUntil',
          'lastLoginAt',
          'reportingTo',
          'businessUnits',
        ],
      );
      final val = UserItem(
        id: $checkedConvert('id', (v) => v as String),
        employeeId: $checkedConvert('employeeId', (v) => v as String),
        empCode: $checkedConvert('empCode', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        phone: $checkedConvert('phone', (v) => v as String),
        email: $checkedConvert('email', (v) => v as String?),
        role: $checkedConvert('role', (v) => $enumDecode(_$RoleEnumMap, v)),
        isActive: $checkedConvert('isActive', (v) => v as bool),
        hasPassword: $checkedConvert('hasPassword', (v) => v as bool),
        lockedUntil: $checkedConvert(
          'lockedUntil',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        lastLoginAt: $checkedConvert(
          'lastLoginAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        reportingTo: $checkedConvert(
          'reportingTo',
          (v) =>
              v == null ? null : PersonRef.fromJson(v as Map<String, dynamic>),
        ),
        businessUnits: $checkedConvert(
          'businessUnits',
          (v) => (v as List<dynamic>)
              .map(
                (e) =>
                    BusinessUnitMembership.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$UserItemToJson(UserItem instance) => <String, dynamic>{
  'id': instance.id,
  'employeeId': instance.employeeId,
  'empCode': instance.empCode,
  'name': instance.name,
  'phone': instance.phone,
  'email': instance.email,
  'role': _$RoleEnumMap[instance.role]!,
  'isActive': instance.isActive,
  'hasPassword': instance.hasPassword,
  'lockedUntil': instance.lockedUntil?.toIso8601String(),
  'lastLoginAt': instance.lastLoginAt?.toIso8601String(),
  'reportingTo': instance.reportingTo?.toJson(),
  'businessUnits': instance.businessUnits.map((e) => e.toJson()).toList(),
};

const _$RoleEnumMap = {
  Role.DIRECTOR: 'DIRECTOR',
  Role.HR: 'HR',
  Role.OPERATIONAL_MANAGER: 'OPERATIONAL_MANAGER',
  Role.REGIONAL_MANAGER: 'REGIONAL_MANAGER',
};
