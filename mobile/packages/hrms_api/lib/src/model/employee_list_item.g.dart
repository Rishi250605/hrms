// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_list_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$EmployeeListItemCWProxy {
  EmployeeListItem id(String id);

  EmployeeListItem empCode(String empCode);

  EmployeeListItem fullName(String fullName);

  EmployeeListItem phone(String phone);

  EmployeeListItem category(EmployeeCategory category);

  EmployeeListItem role(Role? role);

  EmployeeListItem employmentType(EmploymentType employmentType);

  EmployeeListItem status(EmployeeStatus status);

  EmployeeListItem designation(String? designation);

  EmployeeListItem depot(DepotSummary? depot);

  EmployeeListItem businessUnit(BusinessUnitRef? businessUnit);

  EmployeeListItem reportingTo(PersonRef? reportingTo);

  EmployeeListItem compliance(ComplianceOverall compliance);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `EmployeeListItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// EmployeeListItem(...).copyWith(id: 12, name: "My name")
  /// ````
  EmployeeListItem call({
    String id,
    String empCode,
    String fullName,
    String phone,
    EmployeeCategory category,
    Role? role,
    EmploymentType employmentType,
    EmployeeStatus status,
    String? designation,
    DepotSummary? depot,
    BusinessUnitRef? businessUnit,
    PersonRef? reportingTo,
    ComplianceOverall compliance,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfEmployeeListItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfEmployeeListItem.copyWith.fieldName(...)`
class _$EmployeeListItemCWProxyImpl implements _$EmployeeListItemCWProxy {
  const _$EmployeeListItemCWProxyImpl(this._value);

  final EmployeeListItem _value;

  @override
  EmployeeListItem id(String id) => this(id: id);

  @override
  EmployeeListItem empCode(String empCode) => this(empCode: empCode);

  @override
  EmployeeListItem fullName(String fullName) => this(fullName: fullName);

  @override
  EmployeeListItem phone(String phone) => this(phone: phone);

  @override
  EmployeeListItem category(EmployeeCategory category) =>
      this(category: category);

  @override
  EmployeeListItem role(Role? role) => this(role: role);

  @override
  EmployeeListItem employmentType(EmploymentType employmentType) =>
      this(employmentType: employmentType);

  @override
  EmployeeListItem status(EmployeeStatus status) => this(status: status);

  @override
  EmployeeListItem designation(String? designation) =>
      this(designation: designation);

  @override
  EmployeeListItem depot(DepotSummary? depot) => this(depot: depot);

  @override
  EmployeeListItem businessUnit(BusinessUnitRef? businessUnit) =>
      this(businessUnit: businessUnit);

  @override
  EmployeeListItem reportingTo(PersonRef? reportingTo) =>
      this(reportingTo: reportingTo);

  @override
  EmployeeListItem compliance(ComplianceOverall compliance) =>
      this(compliance: compliance);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `EmployeeListItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// EmployeeListItem(...).copyWith(id: 12, name: "My name")
  /// ````
  EmployeeListItem call({
    Object? id = const $CopyWithPlaceholder(),
    Object? empCode = const $CopyWithPlaceholder(),
    Object? fullName = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
    Object? category = const $CopyWithPlaceholder(),
    Object? role = const $CopyWithPlaceholder(),
    Object? employmentType = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? designation = const $CopyWithPlaceholder(),
    Object? depot = const $CopyWithPlaceholder(),
    Object? businessUnit = const $CopyWithPlaceholder(),
    Object? reportingTo = const $CopyWithPlaceholder(),
    Object? compliance = const $CopyWithPlaceholder(),
  }) {
    return EmployeeListItem(
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
      phone: phone == const $CopyWithPlaceholder()
          ? _value.phone
          // ignore: cast_nullable_to_non_nullable
          : phone as String,
      category: category == const $CopyWithPlaceholder()
          ? _value.category
          // ignore: cast_nullable_to_non_nullable
          : category as EmployeeCategory,
      role: role == const $CopyWithPlaceholder()
          ? _value.role
          // ignore: cast_nullable_to_non_nullable
          : role as Role?,
      employmentType: employmentType == const $CopyWithPlaceholder()
          ? _value.employmentType
          // ignore: cast_nullable_to_non_nullable
          : employmentType as EmploymentType,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as EmployeeStatus,
      designation: designation == const $CopyWithPlaceholder()
          ? _value.designation
          // ignore: cast_nullable_to_non_nullable
          : designation as String?,
      depot: depot == const $CopyWithPlaceholder()
          ? _value.depot
          // ignore: cast_nullable_to_non_nullable
          : depot as DepotSummary?,
      businessUnit: businessUnit == const $CopyWithPlaceholder()
          ? _value.businessUnit
          // ignore: cast_nullable_to_non_nullable
          : businessUnit as BusinessUnitRef?,
      reportingTo: reportingTo == const $CopyWithPlaceholder()
          ? _value.reportingTo
          // ignore: cast_nullable_to_non_nullable
          : reportingTo as PersonRef?,
      compliance: compliance == const $CopyWithPlaceholder()
          ? _value.compliance
          // ignore: cast_nullable_to_non_nullable
          : compliance as ComplianceOverall,
    );
  }
}

extension $EmployeeListItemCopyWith on EmployeeListItem {
  /// Returns a callable class that can be used as follows: `instanceOfEmployeeListItem.copyWith(...)` or like so:`instanceOfEmployeeListItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$EmployeeListItemCWProxy get copyWith => _$EmployeeListItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeListItem _$EmployeeListItemFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('EmployeeListItem', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'empCode',
      'fullName',
      'phone',
      'category',
      'role',
      'employmentType',
      'status',
      'designation',
      'depot',
      'businessUnit',
      'reportingTo',
      'compliance',
    ],
  );
  final val = EmployeeListItem(
    id: $checkedConvert('id', (v) => v as String),
    empCode: $checkedConvert('empCode', (v) => v as String),
    fullName: $checkedConvert('fullName', (v) => v as String),
    phone: $checkedConvert('phone', (v) => v as String),
    category: $checkedConvert(
      'category',
      (v) => $enumDecode(_$EmployeeCategoryEnumMap, v),
    ),
    role: $checkedConvert('role', (v) => $enumDecodeNullable(_$RoleEnumMap, v)),
    employmentType: $checkedConvert(
      'employmentType',
      (v) => $enumDecode(_$EmploymentTypeEnumMap, v),
    ),
    status: $checkedConvert(
      'status',
      (v) => $enumDecode(_$EmployeeStatusEnumMap, v),
    ),
    designation: $checkedConvert('designation', (v) => v as String?),
    depot: $checkedConvert(
      'depot',
      (v) =>
          v == null ? null : DepotSummary.fromJson(v as Map<String, dynamic>),
    ),
    businessUnit: $checkedConvert(
      'businessUnit',
      (v) => v == null
          ? null
          : BusinessUnitRef.fromJson(v as Map<String, dynamic>),
    ),
    reportingTo: $checkedConvert(
      'reportingTo',
      (v) => v == null ? null : PersonRef.fromJson(v as Map<String, dynamic>),
    ),
    compliance: $checkedConvert(
      'compliance',
      (v) => $enumDecode(_$ComplianceOverallEnumMap, v),
    ),
  );
  return val;
});

Map<String, dynamic> _$EmployeeListItemToJson(EmployeeListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'empCode': instance.empCode,
      'fullName': instance.fullName,
      'phone': instance.phone,
      'category': _$EmployeeCategoryEnumMap[instance.category]!,
      'role': _$RoleEnumMap[instance.role],
      'employmentType': _$EmploymentTypeEnumMap[instance.employmentType]!,
      'status': _$EmployeeStatusEnumMap[instance.status]!,
      'designation': instance.designation,
      'depot': instance.depot?.toJson(),
      'businessUnit': instance.businessUnit?.toJson(),
      'reportingTo': instance.reportingTo?.toJson(),
      'compliance': _$ComplianceOverallEnumMap[instance.compliance]!,
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

const _$EmploymentTypeEnumMap = {
  EmploymentType.PERMANENT: 'PERMANENT',
  EmploymentType.FIXED_TERM: 'FIXED_TERM',
  EmploymentType.CONTRACT: 'CONTRACT',
};

const _$EmployeeStatusEnumMap = {
  EmployeeStatus.ACTIVE: 'ACTIVE',
  EmployeeStatus.ON_NOTICE: 'ON_NOTICE',
  EmployeeStatus.EXITED: 'EXITED',
  EmployeeStatus.SUSPENDED: 'SUSPENDED',
};

const _$ComplianceOverallEnumMap = {
  ComplianceOverall.OK: 'OK',
  ComplianceOverall.EXPIRING: 'EXPIRING',
  ComplianceOverall.PENDING_VERIFICATION: 'PENDING_VERIFICATION',
  ComplianceOverall.EXPIRED: 'EXPIRED',
  ComplianceOverall.MISSING: 'MISSING',
};
