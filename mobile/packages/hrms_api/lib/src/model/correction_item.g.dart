// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'correction_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CorrectionItemCWProxy {
  CorrectionItem id(String id);

  CorrectionItem employee(AttendanceEmployee employee);

  CorrectionItem businessUnit(BusinessUnitRef businessUnit);

  CorrectionItem date(String date);

  CorrectionItem fromStatus(AttendanceStatus? fromStatus);

  CorrectionItem toStatus(AttendanceStatus toStatus);

  CorrectionItem reason(String reason);

  CorrectionItem status(RequestStatus status);

  CorrectionItem raisedByName(String raisedByName);

  CorrectionItem approver(PersonRef? approver);

  CorrectionItem decidedAt(DateTime? decidedAt);

  CorrectionItem rejectionReason(String? rejectionReason);

  CorrectionItem canDecide(bool canDecide);

  CorrectionItem createdAt(DateTime createdAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CorrectionItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CorrectionItem(...).copyWith(id: 12, name: "My name")
  /// ````
  CorrectionItem call({
    String id,
    AttendanceEmployee employee,
    BusinessUnitRef businessUnit,
    String date,
    AttendanceStatus? fromStatus,
    AttendanceStatus toStatus,
    String reason,
    RequestStatus status,
    String raisedByName,
    PersonRef? approver,
    DateTime? decidedAt,
    String? rejectionReason,
    bool canDecide,
    DateTime createdAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCorrectionItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCorrectionItem.copyWith.fieldName(...)`
class _$CorrectionItemCWProxyImpl implements _$CorrectionItemCWProxy {
  const _$CorrectionItemCWProxyImpl(this._value);

  final CorrectionItem _value;

  @override
  CorrectionItem id(String id) => this(id: id);

  @override
  CorrectionItem employee(AttendanceEmployee employee) =>
      this(employee: employee);

  @override
  CorrectionItem businessUnit(BusinessUnitRef businessUnit) =>
      this(businessUnit: businessUnit);

  @override
  CorrectionItem date(String date) => this(date: date);

  @override
  CorrectionItem fromStatus(AttendanceStatus? fromStatus) =>
      this(fromStatus: fromStatus);

  @override
  CorrectionItem toStatus(AttendanceStatus toStatus) =>
      this(toStatus: toStatus);

  @override
  CorrectionItem reason(String reason) => this(reason: reason);

  @override
  CorrectionItem status(RequestStatus status) => this(status: status);

  @override
  CorrectionItem raisedByName(String raisedByName) =>
      this(raisedByName: raisedByName);

  @override
  CorrectionItem approver(PersonRef? approver) => this(approver: approver);

  @override
  CorrectionItem decidedAt(DateTime? decidedAt) => this(decidedAt: decidedAt);

  @override
  CorrectionItem rejectionReason(String? rejectionReason) =>
      this(rejectionReason: rejectionReason);

  @override
  CorrectionItem canDecide(bool canDecide) => this(canDecide: canDecide);

  @override
  CorrectionItem createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CorrectionItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CorrectionItem(...).copyWith(id: 12, name: "My name")
  /// ````
  CorrectionItem call({
    Object? id = const $CopyWithPlaceholder(),
    Object? employee = const $CopyWithPlaceholder(),
    Object? businessUnit = const $CopyWithPlaceholder(),
    Object? date = const $CopyWithPlaceholder(),
    Object? fromStatus = const $CopyWithPlaceholder(),
    Object? toStatus = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? raisedByName = const $CopyWithPlaceholder(),
    Object? approver = const $CopyWithPlaceholder(),
    Object? decidedAt = const $CopyWithPlaceholder(),
    Object? rejectionReason = const $CopyWithPlaceholder(),
    Object? canDecide = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
  }) {
    return CorrectionItem(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      employee: employee == const $CopyWithPlaceholder()
          ? _value.employee
          // ignore: cast_nullable_to_non_nullable
          : employee as AttendanceEmployee,
      businessUnit: businessUnit == const $CopyWithPlaceholder()
          ? _value.businessUnit
          // ignore: cast_nullable_to_non_nullable
          : businessUnit as BusinessUnitRef,
      date: date == const $CopyWithPlaceholder()
          ? _value.date
          // ignore: cast_nullable_to_non_nullable
          : date as String,
      fromStatus: fromStatus == const $CopyWithPlaceholder()
          ? _value.fromStatus
          // ignore: cast_nullable_to_non_nullable
          : fromStatus as AttendanceStatus?,
      toStatus: toStatus == const $CopyWithPlaceholder()
          ? _value.toStatus
          // ignore: cast_nullable_to_non_nullable
          : toStatus as AttendanceStatus,
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as RequestStatus,
      raisedByName: raisedByName == const $CopyWithPlaceholder()
          ? _value.raisedByName
          // ignore: cast_nullable_to_non_nullable
          : raisedByName as String,
      approver: approver == const $CopyWithPlaceholder()
          ? _value.approver
          // ignore: cast_nullable_to_non_nullable
          : approver as PersonRef?,
      decidedAt: decidedAt == const $CopyWithPlaceholder()
          ? _value.decidedAt
          // ignore: cast_nullable_to_non_nullable
          : decidedAt as DateTime?,
      rejectionReason: rejectionReason == const $CopyWithPlaceholder()
          ? _value.rejectionReason
          // ignore: cast_nullable_to_non_nullable
          : rejectionReason as String?,
      canDecide: canDecide == const $CopyWithPlaceholder()
          ? _value.canDecide
          // ignore: cast_nullable_to_non_nullable
          : canDecide as bool,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
    );
  }
}

extension $CorrectionItemCopyWith on CorrectionItem {
  /// Returns a callable class that can be used as follows: `instanceOfCorrectionItem.copyWith(...)` or like so:`instanceOfCorrectionItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CorrectionItemCWProxy get copyWith => _$CorrectionItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CorrectionItem _$CorrectionItemFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('CorrectionItem', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'employee',
      'businessUnit',
      'date',
      'fromStatus',
      'toStatus',
      'reason',
      'status',
      'raisedByName',
      'approver',
      'decidedAt',
      'rejectionReason',
      'canDecide',
      'createdAt',
    ],
  );
  final val = CorrectionItem(
    id: $checkedConvert('id', (v) => v as String),
    employee: $checkedConvert(
      'employee',
      (v) => AttendanceEmployee.fromJson(v as Map<String, dynamic>),
    ),
    businessUnit: $checkedConvert(
      'businessUnit',
      (v) => BusinessUnitRef.fromJson(v as Map<String, dynamic>),
    ),
    date: $checkedConvert('date', (v) => v as String),
    fromStatus: $checkedConvert(
      'fromStatus',
      (v) => $enumDecodeNullable(_$AttendanceStatusEnumMap, v),
    ),
    toStatus: $checkedConvert(
      'toStatus',
      (v) => $enumDecode(_$AttendanceStatusEnumMap, v),
    ),
    reason: $checkedConvert('reason', (v) => v as String),
    status: $checkedConvert(
      'status',
      (v) => $enumDecode(_$RequestStatusEnumMap, v),
    ),
    raisedByName: $checkedConvert('raisedByName', (v) => v as String),
    approver: $checkedConvert(
      'approver',
      (v) => v == null ? null : PersonRef.fromJson(v as Map<String, dynamic>),
    ),
    decidedAt: $checkedConvert(
      'decidedAt',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    rejectionReason: $checkedConvert('rejectionReason', (v) => v as String?),
    canDecide: $checkedConvert('canDecide', (v) => v as bool),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
  );
  return val;
});

Map<String, dynamic> _$CorrectionItemToJson(CorrectionItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employee': instance.employee.toJson(),
      'businessUnit': instance.businessUnit.toJson(),
      'date': instance.date,
      'fromStatus': _$AttendanceStatusEnumMap[instance.fromStatus],
      'toStatus': _$AttendanceStatusEnumMap[instance.toStatus]!,
      'reason': instance.reason,
      'status': _$RequestStatusEnumMap[instance.status]!,
      'raisedByName': instance.raisedByName,
      'approver': instance.approver?.toJson(),
      'decidedAt': instance.decidedAt?.toIso8601String(),
      'rejectionReason': instance.rejectionReason,
      'canDecide': instance.canDecide,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$AttendanceStatusEnumMap = {
  AttendanceStatus.PRESENT: 'PRESENT',
  AttendanceStatus.ABSENT: 'ABSENT',
  AttendanceStatus.HALF_DAY: 'HALF_DAY',
  AttendanceStatus.ON_LEAVE: 'ON_LEAVE',
  AttendanceStatus.ON_DUTY: 'ON_DUTY',
  AttendanceStatus.WEEKLY_OFF: 'WEEKLY_OFF',
  AttendanceStatus.HOLIDAY: 'HOLIDAY',
};

const _$RequestStatusEnumMap = {
  RequestStatus.PENDING: 'PENDING',
  RequestStatus.APPROVED: 'APPROVED',
  RequestStatus.REJECTED: 'REJECTED',
  RequestStatus.CANCELLED: 'CANCELLED',
};
