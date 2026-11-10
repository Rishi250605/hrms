// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'me_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MeResponseCWProxy {
  MeResponse id(String id);

  MeResponse employeeId(String employeeId);

  MeResponse empCode(String empCode);

  MeResponse name(String name);

  MeResponse phone(String phone);

  MeResponse email(String? email);

  MeResponse role(Role role);

  MeResponse lastLoginAt(DateTime? lastLoginAt);

  MeResponse passwordChangedAt(DateTime? passwordChangedAt);

  MeResponse reportingTo(PersonRef? reportingTo);

  MeResponse businessUnits(List<BusinessUnitMembership> businessUnits);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MeResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MeResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  MeResponse call({
    String id,
    String employeeId,
    String empCode,
    String name,
    String phone,
    String? email,
    Role role,
    DateTime? lastLoginAt,
    DateTime? passwordChangedAt,
    PersonRef? reportingTo,
    List<BusinessUnitMembership> businessUnits,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMeResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMeResponse.copyWith.fieldName(...)`
class _$MeResponseCWProxyImpl implements _$MeResponseCWProxy {
  const _$MeResponseCWProxyImpl(this._value);

  final MeResponse _value;

  @override
  MeResponse id(String id) => this(id: id);

  @override
  MeResponse employeeId(String employeeId) => this(employeeId: employeeId);

  @override
  MeResponse empCode(String empCode) => this(empCode: empCode);

  @override
  MeResponse name(String name) => this(name: name);

  @override
  MeResponse phone(String phone) => this(phone: phone);

  @override
  MeResponse email(String? email) => this(email: email);

  @override
  MeResponse role(Role role) => this(role: role);

  @override
  MeResponse lastLoginAt(DateTime? lastLoginAt) =>
      this(lastLoginAt: lastLoginAt);

  @override
  MeResponse passwordChangedAt(DateTime? passwordChangedAt) =>
      this(passwordChangedAt: passwordChangedAt);

  @override
  MeResponse reportingTo(PersonRef? reportingTo) =>
      this(reportingTo: reportingTo);

  @override
  MeResponse businessUnits(List<BusinessUnitMembership> businessUnits) =>
      this(businessUnits: businessUnits);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MeResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MeResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  MeResponse call({
    Object? id = const $CopyWithPlaceholder(),
    Object? employeeId = const $CopyWithPlaceholder(),
    Object? empCode = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? role = const $CopyWithPlaceholder(),
    Object? lastLoginAt = const $CopyWithPlaceholder(),
    Object? passwordChangedAt = const $CopyWithPlaceholder(),
    Object? reportingTo = const $CopyWithPlaceholder(),
    Object? businessUnits = const $CopyWithPlaceholder(),
  }) {
    return MeResponse(
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
      lastLoginAt: lastLoginAt == const $CopyWithPlaceholder()
          ? _value.lastLoginAt
          // ignore: cast_nullable_to_non_nullable
          : lastLoginAt as DateTime?,
      passwordChangedAt: passwordChangedAt == const $CopyWithPlaceholder()
          ? _value.passwordChangedAt
          // ignore: cast_nullable_to_non_nullable
          : passwordChangedAt as DateTime?,
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

extension $MeResponseCopyWith on MeResponse {
  /// Returns a callable class that can be used as follows: `instanceOfMeResponse.copyWith(...)` or like so:`instanceOfMeResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MeResponseCWProxy get copyWith => _$MeResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeResponse _$MeResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('MeResponse', json, ($checkedConvert) {
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
          'lastLoginAt',
          'passwordChangedAt',
          'reportingTo',
          'businessUnits',
        ],
      );
      final val = MeResponse(
        id: $checkedConvert('id', (v) => v as String),
        employeeId: $checkedConvert('employeeId', (v) => v as String),
        empCode: $checkedConvert('empCode', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        phone: $checkedConvert('phone', (v) => v as String),
        email: $checkedConvert('email', (v) => v as String?),
        role: $checkedConvert('role', (v) => $enumDecode(_$RoleEnumMap, v)),
        lastLoginAt: $checkedConvert(
          'lastLoginAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        passwordChangedAt: $checkedConvert(
          'passwordChangedAt',
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

Map<String, dynamic> _$MeResponseToJson(MeResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employeeId': instance.employeeId,
      'empCode': instance.empCode,
      'name': instance.name,
      'phone': instance.phone,
      'email': instance.email,
      'role': _$RoleEnumMap[instance.role]!,
      'lastLoginAt': instance.lastLoginAt?.toIso8601String(),
      'passwordChangedAt': instance.passwordChangedAt?.toIso8601String(),
      'reportingTo': instance.reportingTo?.toJson(),
      'businessUnits': instance.businessUnits.map((e) => e.toJson()).toList(),
    };

const _$RoleEnumMap = {
  Role.DIRECTOR: 'DIRECTOR',
  Role.HR: 'HR',
  Role.OPERATIONAL_MANAGER: 'OPERATIONAL_MANAGER',
  Role.REGIONAL_MANAGER: 'REGIONAL_MANAGER',
};
