// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_request_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LeaveRequestItemCWProxy {
  LeaveRequestItem id(String id);

  LeaveRequestItem kind(LeaveKind kind);

  LeaveRequestItem employee(PersonRef employee);

  LeaveRequestItem businessUnit(BusinessUnitRef businessUnit);

  LeaveRequestItem leaveType(LeaveRequestItemLeaveType? leaveType);

  LeaveRequestItem fromDate(String fromDate);

  LeaveRequestItem toDate(String toDate);

  LeaveRequestItem fromHalf(bool fromHalf);

  LeaveRequestItem toHalf(bool toHalf);

  LeaveRequestItem days(num days);

  LeaveRequestItem reason(String reason);

  LeaveRequestItem odLocation(String? odLocation);

  LeaveRequestItem odPurpose(String? odPurpose);

  LeaveRequestItem odFromTime(String? odFromTime);

  LeaveRequestItem odToTime(String? odToTime);

  LeaveRequestItem status(RequestStatus status);

  LeaveRequestItem raisedByName(String raisedByName);

  LeaveRequestItem approver(PersonRef? approver);

  LeaveRequestItem decidedAt(DateTime? decidedAt);

  LeaveRequestItem decidedByName(String? decidedByName);

  LeaveRequestItem rejectionReason(String? rejectionReason);

  LeaveRequestItem canDecide(bool canDecide);

  LeaveRequestItem canCancel(bool canCancel);

  LeaveRequestItem warnings(List<String> warnings);

  LeaveRequestItem createdAt(DateTime createdAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LeaveRequestItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LeaveRequestItem(...).copyWith(id: 12, name: "My name")
  /// ````
  LeaveRequestItem call({
    String id,
    LeaveKind kind,
    PersonRef employee,
    BusinessUnitRef businessUnit,
    LeaveRequestItemLeaveType? leaveType,
    String fromDate,
    String toDate,
    bool fromHalf,
    bool toHalf,
    num days,
    String reason,
    String? odLocation,
    String? odPurpose,
    String? odFromTime,
    String? odToTime,
    RequestStatus status,
    String raisedByName,
    PersonRef? approver,
    DateTime? decidedAt,
    String? decidedByName,
    String? rejectionReason,
    bool canDecide,
    bool canCancel,
    List<String> warnings,
    DateTime createdAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfLeaveRequestItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfLeaveRequestItem.copyWith.fieldName(...)`
class _$LeaveRequestItemCWProxyImpl implements _$LeaveRequestItemCWProxy {
  const _$LeaveRequestItemCWProxyImpl(this._value);

  final LeaveRequestItem _value;

  @override
  LeaveRequestItem id(String id) => this(id: id);

  @override
  LeaveRequestItem kind(LeaveKind kind) => this(kind: kind);

  @override
  LeaveRequestItem employee(PersonRef employee) => this(employee: employee);

  @override
  LeaveRequestItem businessUnit(BusinessUnitRef businessUnit) =>
      this(businessUnit: businessUnit);

  @override
  LeaveRequestItem leaveType(LeaveRequestItemLeaveType? leaveType) =>
      this(leaveType: leaveType);

  @override
  LeaveRequestItem fromDate(String fromDate) => this(fromDate: fromDate);

  @override
  LeaveRequestItem toDate(String toDate) => this(toDate: toDate);

  @override
  LeaveRequestItem fromHalf(bool fromHalf) => this(fromHalf: fromHalf);

  @override
  LeaveRequestItem toHalf(bool toHalf) => this(toHalf: toHalf);

  @override
  LeaveRequestItem days(num days) => this(days: days);

  @override
  LeaveRequestItem reason(String reason) => this(reason: reason);

  @override
  LeaveRequestItem odLocation(String? odLocation) =>
      this(odLocation: odLocation);

  @override
  LeaveRequestItem odPurpose(String? odPurpose) => this(odPurpose: odPurpose);

  @override
  LeaveRequestItem odFromTime(String? odFromTime) =>
      this(odFromTime: odFromTime);

  @override
  LeaveRequestItem odToTime(String? odToTime) => this(odToTime: odToTime);

  @override
  LeaveRequestItem status(RequestStatus status) => this(status: status);

  @override
  LeaveRequestItem raisedByName(String raisedByName) =>
      this(raisedByName: raisedByName);

  @override
  LeaveRequestItem approver(PersonRef? approver) => this(approver: approver);

  @override
  LeaveRequestItem decidedAt(DateTime? decidedAt) => this(decidedAt: decidedAt);

  @override
  LeaveRequestItem decidedByName(String? decidedByName) =>
      this(decidedByName: decidedByName);

  @override
  LeaveRequestItem rejectionReason(String? rejectionReason) =>
      this(rejectionReason: rejectionReason);

  @override
  LeaveRequestItem canDecide(bool canDecide) => this(canDecide: canDecide);

  @override
  LeaveRequestItem canCancel(bool canCancel) => this(canCancel: canCancel);

  @override
  LeaveRequestItem warnings(List<String> warnings) => this(warnings: warnings);

  @override
  LeaveRequestItem createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LeaveRequestItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LeaveRequestItem(...).copyWith(id: 12, name: "My name")
  /// ````
  LeaveRequestItem call({
    Object? id = const $CopyWithPlaceholder(),
    Object? kind = const $CopyWithPlaceholder(),
    Object? employee = const $CopyWithPlaceholder(),
    Object? businessUnit = const $CopyWithPlaceholder(),
    Object? leaveType = const $CopyWithPlaceholder(),
    Object? fromDate = const $CopyWithPlaceholder(),
    Object? toDate = const $CopyWithPlaceholder(),
    Object? fromHalf = const $CopyWithPlaceholder(),
    Object? toHalf = const $CopyWithPlaceholder(),
    Object? days = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
    Object? odLocation = const $CopyWithPlaceholder(),
    Object? odPurpose = const $CopyWithPlaceholder(),
    Object? odFromTime = const $CopyWithPlaceholder(),
    Object? odToTime = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? raisedByName = const $CopyWithPlaceholder(),
    Object? approver = const $CopyWithPlaceholder(),
    Object? decidedAt = const $CopyWithPlaceholder(),
    Object? decidedByName = const $CopyWithPlaceholder(),
    Object? rejectionReason = const $CopyWithPlaceholder(),
    Object? canDecide = const $CopyWithPlaceholder(),
    Object? canCancel = const $CopyWithPlaceholder(),
    Object? warnings = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
  }) {
    return LeaveRequestItem(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      kind: kind == const $CopyWithPlaceholder()
          ? _value.kind
          // ignore: cast_nullable_to_non_nullable
          : kind as LeaveKind,
      employee: employee == const $CopyWithPlaceholder()
          ? _value.employee
          // ignore: cast_nullable_to_non_nullable
          : employee as PersonRef,
      businessUnit: businessUnit == const $CopyWithPlaceholder()
          ? _value.businessUnit
          // ignore: cast_nullable_to_non_nullable
          : businessUnit as BusinessUnitRef,
      leaveType: leaveType == const $CopyWithPlaceholder()
          ? _value.leaveType
          // ignore: cast_nullable_to_non_nullable
          : leaveType as LeaveRequestItemLeaveType?,
      fromDate: fromDate == const $CopyWithPlaceholder()
          ? _value.fromDate
          // ignore: cast_nullable_to_non_nullable
          : fromDate as String,
      toDate: toDate == const $CopyWithPlaceholder()
          ? _value.toDate
          // ignore: cast_nullable_to_non_nullable
          : toDate as String,
      fromHalf: fromHalf == const $CopyWithPlaceholder()
          ? _value.fromHalf
          // ignore: cast_nullable_to_non_nullable
          : fromHalf as bool,
      toHalf: toHalf == const $CopyWithPlaceholder()
          ? _value.toHalf
          // ignore: cast_nullable_to_non_nullable
          : toHalf as bool,
      days: days == const $CopyWithPlaceholder()
          ? _value.days
          // ignore: cast_nullable_to_non_nullable
          : days as num,
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String,
      odLocation: odLocation == const $CopyWithPlaceholder()
          ? _value.odLocation
          // ignore: cast_nullable_to_non_nullable
          : odLocation as String?,
      odPurpose: odPurpose == const $CopyWithPlaceholder()
          ? _value.odPurpose
          // ignore: cast_nullable_to_non_nullable
          : odPurpose as String?,
      odFromTime: odFromTime == const $CopyWithPlaceholder()
          ? _value.odFromTime
          // ignore: cast_nullable_to_non_nullable
          : odFromTime as String?,
      odToTime: odToTime == const $CopyWithPlaceholder()
          ? _value.odToTime
          // ignore: cast_nullable_to_non_nullable
          : odToTime as String?,
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
      decidedByName: decidedByName == const $CopyWithPlaceholder()
          ? _value.decidedByName
          // ignore: cast_nullable_to_non_nullable
          : decidedByName as String?,
      rejectionReason: rejectionReason == const $CopyWithPlaceholder()
          ? _value.rejectionReason
          // ignore: cast_nullable_to_non_nullable
          : rejectionReason as String?,
      canDecide: canDecide == const $CopyWithPlaceholder()
          ? _value.canDecide
          // ignore: cast_nullable_to_non_nullable
          : canDecide as bool,
      canCancel: canCancel == const $CopyWithPlaceholder()
          ? _value.canCancel
          // ignore: cast_nullable_to_non_nullable
          : canCancel as bool,
      warnings: warnings == const $CopyWithPlaceholder()
          ? _value.warnings
          // ignore: cast_nullable_to_non_nullable
          : warnings as List<String>,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
    );
  }
}

extension $LeaveRequestItemCopyWith on LeaveRequestItem {
  /// Returns a callable class that can be used as follows: `instanceOfLeaveRequestItem.copyWith(...)` or like so:`instanceOfLeaveRequestItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LeaveRequestItemCWProxy get copyWith => _$LeaveRequestItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveRequestItem _$LeaveRequestItemFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('LeaveRequestItem', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'kind',
      'employee',
      'businessUnit',
      'leaveType',
      'fromDate',
      'toDate',
      'fromHalf',
      'toHalf',
      'days',
      'reason',
      'odLocation',
      'odPurpose',
      'odFromTime',
      'odToTime',
      'status',
      'raisedByName',
      'approver',
      'decidedAt',
      'decidedByName',
      'rejectionReason',
      'canDecide',
      'canCancel',
      'warnings',
      'createdAt',
    ],
  );
  final val = LeaveRequestItem(
    id: $checkedConvert('id', (v) => v as String),
    kind: $checkedConvert('kind', (v) => $enumDecode(_$LeaveKindEnumMap, v)),
    employee: $checkedConvert(
      'employee',
      (v) => PersonRef.fromJson(v as Map<String, dynamic>),
    ),
    businessUnit: $checkedConvert(
      'businessUnit',
      (v) => BusinessUnitRef.fromJson(v as Map<String, dynamic>),
    ),
    leaveType: $checkedConvert(
      'leaveType',
      (v) => v == null
          ? null
          : LeaveRequestItemLeaveType.fromJson(v as Map<String, dynamic>),
    ),
    fromDate: $checkedConvert('fromDate', (v) => v as String),
    toDate: $checkedConvert('toDate', (v) => v as String),
    fromHalf: $checkedConvert('fromHalf', (v) => v as bool),
    toHalf: $checkedConvert('toHalf', (v) => v as bool),
    days: $checkedConvert('days', (v) => v as num),
    reason: $checkedConvert('reason', (v) => v as String),
    odLocation: $checkedConvert('odLocation', (v) => v as String?),
    odPurpose: $checkedConvert('odPurpose', (v) => v as String?),
    odFromTime: $checkedConvert('odFromTime', (v) => v as String?),
    odToTime: $checkedConvert('odToTime', (v) => v as String?),
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
    decidedByName: $checkedConvert('decidedByName', (v) => v as String?),
    rejectionReason: $checkedConvert('rejectionReason', (v) => v as String?),
    canDecide: $checkedConvert('canDecide', (v) => v as bool),
    canCancel: $checkedConvert('canCancel', (v) => v as bool),
    warnings: $checkedConvert(
      'warnings',
      (v) => (v as List<dynamic>).map((e) => e as String).toList(),
    ),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
  );
  return val;
});

Map<String, dynamic> _$LeaveRequestItemToJson(LeaveRequestItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'kind': _$LeaveKindEnumMap[instance.kind]!,
      'employee': instance.employee.toJson(),
      'businessUnit': instance.businessUnit.toJson(),
      'leaveType': instance.leaveType?.toJson(),
      'fromDate': instance.fromDate,
      'toDate': instance.toDate,
      'fromHalf': instance.fromHalf,
      'toHalf': instance.toHalf,
      'days': instance.days,
      'reason': instance.reason,
      'odLocation': instance.odLocation,
      'odPurpose': instance.odPurpose,
      'odFromTime': instance.odFromTime,
      'odToTime': instance.odToTime,
      'status': _$RequestStatusEnumMap[instance.status]!,
      'raisedByName': instance.raisedByName,
      'approver': instance.approver?.toJson(),
      'decidedAt': instance.decidedAt?.toIso8601String(),
      'decidedByName': instance.decidedByName,
      'rejectionReason': instance.rejectionReason,
      'canDecide': instance.canDecide,
      'canCancel': instance.canCancel,
      'warnings': instance.warnings,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$LeaveKindEnumMap = {LeaveKind.LEAVE: 'LEAVE', LeaveKind.OD: 'OD'};

const _$RequestStatusEnumMap = {
  RequestStatus.PENDING: 'PENDING',
  RequestStatus.APPROVED: 'APPROVED',
  RequestStatus.REJECTED: 'REJECTED',
  RequestStatus.CANCELLED: 'CANCELLED',
};
