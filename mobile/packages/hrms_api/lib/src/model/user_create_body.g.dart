// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_create_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserCreateBodyCWProxy {
  UserCreateBody existingEmployeeId(String? existingEmployeeId);

  UserCreateBody empCode(String? empCode);

  UserCreateBody fullName(String? fullName);

  UserCreateBody phone(String phone);

  UserCreateBody email(String? email);

  UserCreateBody role(Role role);

  UserCreateBody businessUnitIds(List<String>? businessUnitIds);

  UserCreateBody primaryBusinessUnitId(String? primaryBusinessUnitId);

  UserCreateBody reportingToEmployeeId(String? reportingToEmployeeId);

  UserCreateBody depotId(String? depotId);

  UserCreateBody designation(String? designation);

  UserCreateBody joiningDate(String? joiningDate);

  UserCreateBody password(String password);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserCreateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserCreateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  UserCreateBody call({
    String? existingEmployeeId,
    String? empCode,
    String? fullName,
    String phone,
    String? email,
    Role role,
    List<String>? businessUnitIds,
    String? primaryBusinessUnitId,
    String? reportingToEmployeeId,
    String? depotId,
    String? designation,
    String? joiningDate,
    String password,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUserCreateBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUserCreateBody.copyWith.fieldName(...)`
class _$UserCreateBodyCWProxyImpl implements _$UserCreateBodyCWProxy {
  const _$UserCreateBodyCWProxyImpl(this._value);

  final UserCreateBody _value;

  @override
  UserCreateBody existingEmployeeId(String? existingEmployeeId) =>
      this(existingEmployeeId: existingEmployeeId);

  @override
  UserCreateBody empCode(String? empCode) => this(empCode: empCode);

  @override
  UserCreateBody fullName(String? fullName) => this(fullName: fullName);

  @override
  UserCreateBody phone(String phone) => this(phone: phone);

  @override
  UserCreateBody email(String? email) => this(email: email);

  @override
  UserCreateBody role(Role role) => this(role: role);

  @override
  UserCreateBody businessUnitIds(List<String>? businessUnitIds) =>
      this(businessUnitIds: businessUnitIds);

  @override
  UserCreateBody primaryBusinessUnitId(String? primaryBusinessUnitId) =>
      this(primaryBusinessUnitId: primaryBusinessUnitId);

  @override
  UserCreateBody reportingToEmployeeId(String? reportingToEmployeeId) =>
      this(reportingToEmployeeId: reportingToEmployeeId);

  @override
  UserCreateBody depotId(String? depotId) => this(depotId: depotId);

  @override
  UserCreateBody designation(String? designation) =>
      this(designation: designation);

  @override
  UserCreateBody joiningDate(String? joiningDate) =>
      this(joiningDate: joiningDate);

  @override
  UserCreateBody password(String password) => this(password: password);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserCreateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserCreateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  UserCreateBody call({
    Object? existingEmployeeId = const $CopyWithPlaceholder(),
    Object? empCode = const $CopyWithPlaceholder(),
    Object? fullName = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? role = const $CopyWithPlaceholder(),
    Object? businessUnitIds = const $CopyWithPlaceholder(),
    Object? primaryBusinessUnitId = const $CopyWithPlaceholder(),
    Object? reportingToEmployeeId = const $CopyWithPlaceholder(),
    Object? depotId = const $CopyWithPlaceholder(),
    Object? designation = const $CopyWithPlaceholder(),
    Object? joiningDate = const $CopyWithPlaceholder(),
    Object? password = const $CopyWithPlaceholder(),
  }) {
    return UserCreateBody(
      existingEmployeeId: existingEmployeeId == const $CopyWithPlaceholder()
          ? _value.existingEmployeeId
          // ignore: cast_nullable_to_non_nullable
          : existingEmployeeId as String?,
      empCode: empCode == const $CopyWithPlaceholder()
          ? _value.empCode
          // ignore: cast_nullable_to_non_nullable
          : empCode as String?,
      fullName: fullName == const $CopyWithPlaceholder()
          ? _value.fullName
          // ignore: cast_nullable_to_non_nullable
          : fullName as String?,
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
      businessUnitIds: businessUnitIds == const $CopyWithPlaceholder()
          ? _value.businessUnitIds
          // ignore: cast_nullable_to_non_nullable
          : businessUnitIds as List<String>?,
      primaryBusinessUnitId:
          primaryBusinessUnitId == const $CopyWithPlaceholder()
          ? _value.primaryBusinessUnitId
          // ignore: cast_nullable_to_non_nullable
          : primaryBusinessUnitId as String?,
      reportingToEmployeeId:
          reportingToEmployeeId == const $CopyWithPlaceholder()
          ? _value.reportingToEmployeeId
          // ignore: cast_nullable_to_non_nullable
          : reportingToEmployeeId as String?,
      depotId: depotId == const $CopyWithPlaceholder()
          ? _value.depotId
          // ignore: cast_nullable_to_non_nullable
          : depotId as String?,
      designation: designation == const $CopyWithPlaceholder()
          ? _value.designation
          // ignore: cast_nullable_to_non_nullable
          : designation as String?,
      joiningDate: joiningDate == const $CopyWithPlaceholder()
          ? _value.joiningDate
          // ignore: cast_nullable_to_non_nullable
          : joiningDate as String?,
      password: password == const $CopyWithPlaceholder()
          ? _value.password
          // ignore: cast_nullable_to_non_nullable
          : password as String,
    );
  }
}

extension $UserCreateBodyCopyWith on UserCreateBody {
  /// Returns a callable class that can be used as follows: `instanceOfUserCreateBody.copyWith(...)` or like so:`instanceOfUserCreateBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserCreateBodyCWProxy get copyWith => _$UserCreateBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCreateBody _$UserCreateBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UserCreateBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['phone', 'role', 'password']);
      final val = UserCreateBody(
        existingEmployeeId: $checkedConvert(
          'existingEmployeeId',
          (v) => v as String?,
        ),
        empCode: $checkedConvert('empCode', (v) => v as String?),
        fullName: $checkedConvert('fullName', (v) => v as String?),
        phone: $checkedConvert('phone', (v) => v as String),
        email: $checkedConvert('email', (v) => v as String?),
        role: $checkedConvert('role', (v) => $enumDecode(_$RoleEnumMap, v)),
        businessUnitIds: $checkedConvert(
          'businessUnitIds',
          (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
        ),
        primaryBusinessUnitId: $checkedConvert(
          'primaryBusinessUnitId',
          (v) => v as String?,
        ),
        reportingToEmployeeId: $checkedConvert(
          'reportingToEmployeeId',
          (v) => v as String?,
        ),
        depotId: $checkedConvert('depotId', (v) => v as String?),
        designation: $checkedConvert('designation', (v) => v as String?),
        joiningDate: $checkedConvert('joiningDate', (v) => v as String?),
        password: $checkedConvert('password', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$UserCreateBodyToJson(UserCreateBody instance) =>
    <String, dynamic>{
      'existingEmployeeId': ?instance.existingEmployeeId,
      'empCode': ?instance.empCode,
      'fullName': ?instance.fullName,
      'phone': instance.phone,
      'email': ?instance.email,
      'role': _$RoleEnumMap[instance.role]!,
      'businessUnitIds': ?instance.businessUnitIds,
      'primaryBusinessUnitId': ?instance.primaryBusinessUnitId,
      'reportingToEmployeeId': ?instance.reportingToEmployeeId,
      'depotId': ?instance.depotId,
      'designation': ?instance.designation,
      'joiningDate': ?instance.joiningDate,
      'password': instance.password,
    };

const _$RoleEnumMap = {
  Role.DIRECTOR: 'DIRECTOR',
  Role.HR: 'HR',
  Role.OPERATIONAL_MANAGER: 'OPERATIONAL_MANAGER',
  Role.REGIONAL_MANAGER: 'REGIONAL_MANAGER',
};
