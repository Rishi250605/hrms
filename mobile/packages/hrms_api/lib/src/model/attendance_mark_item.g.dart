// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_mark_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AttendanceMarkItemCWProxy {
  AttendanceMarkItem id(String id);

  AttendanceMarkItem employee(AttendanceEmployee employee);

  AttendanceMarkItem businessUnit(BusinessUnitRef businessUnit);

  AttendanceMarkItem date(String date);

  AttendanceMarkItem status(AttendanceStatus status);

  AttendanceMarkItem approvalState(ApprovalState approvalState);

  AttendanceMarkItem source_(AttendanceSource source_);

  AttendanceMarkItem note(String? note);

  AttendanceMarkItem markedAt(DateTime markedAt);

  AttendanceMarkItem markedByName(String markedByName);

  AttendanceMarkItem approver(PersonRef? approver);

  AttendanceMarkItem decidedAt(DateTime? decidedAt);

  AttendanceMarkItem decidedByName(String? decidedByName);

  AttendanceMarkItem rejectionReason(String? rejectionReason);

  AttendanceMarkItem canDecide(bool canDecide);

  AttendanceMarkItem clientMutationId(String? clientMutationId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AttendanceMarkItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AttendanceMarkItem(...).copyWith(id: 12, name: "My name")
  /// ````
  AttendanceMarkItem call({
    String id,
    AttendanceEmployee employee,
    BusinessUnitRef businessUnit,
    String date,
    AttendanceStatus status,
    ApprovalState approvalState,
    AttendanceSource source_,
    String? note,
    DateTime markedAt,
    String markedByName,
    PersonRef? approver,
    DateTime? decidedAt,
    String? decidedByName,
    String? rejectionReason,
    bool canDecide,
    String? clientMutationId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAttendanceMarkItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAttendanceMarkItem.copyWith.fieldName(...)`
class _$AttendanceMarkItemCWProxyImpl implements _$AttendanceMarkItemCWProxy {
  const _$AttendanceMarkItemCWProxyImpl(this._value);

  final AttendanceMarkItem _value;

  @override
  AttendanceMarkItem id(String id) => this(id: id);

  @override
  AttendanceMarkItem employee(AttendanceEmployee employee) =>
      this(employee: employee);

  @override
  AttendanceMarkItem businessUnit(BusinessUnitRef businessUnit) =>
      this(businessUnit: businessUnit);

  @override
  AttendanceMarkItem date(String date) => this(date: date);

  @override
  AttendanceMarkItem status(AttendanceStatus status) => this(status: status);

  @override
  AttendanceMarkItem approvalState(ApprovalState approvalState) =>
      this(approvalState: approvalState);

  @override
  AttendanceMarkItem source_(AttendanceSource source_) =>
      this(source_: source_);

  @override
  AttendanceMarkItem note(String? note) => this(note: note);

  @override
  AttendanceMarkItem markedAt(DateTime markedAt) => this(markedAt: markedAt);

  @override
  AttendanceMarkItem markedByName(String markedByName) =>
      this(markedByName: markedByName);

  @override
  AttendanceMarkItem approver(PersonRef? approver) => this(approver: approver);

  @override
  AttendanceMarkItem decidedAt(DateTime? decidedAt) =>
      this(decidedAt: decidedAt);

  @override
  AttendanceMarkItem decidedByName(String? decidedByName) =>
      this(decidedByName: decidedByName);

  @override
  AttendanceMarkItem rejectionReason(String? rejectionReason) =>
      this(rejectionReason: rejectionReason);

  @override
  AttendanceMarkItem canDecide(bool canDecide) => this(canDecide: canDecide);

  @override
  AttendanceMarkItem clientMutationId(String? clientMutationId) =>
      this(clientMutationId: clientMutationId);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AttendanceMarkItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AttendanceMarkItem(...).copyWith(id: 12, name: "My name")
  /// ````
  AttendanceMarkItem call({
    Object? id = const $CopyWithPlaceholder(),
    Object? employee = const $CopyWithPlaceholder(),
    Object? businessUnit = const $CopyWithPlaceholder(),
    Object? date = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? approvalState = const $CopyWithPlaceholder(),
    Object? source_ = const $CopyWithPlaceholder(),
    Object? note = const $CopyWithPlaceholder(),
    Object? markedAt = const $CopyWithPlaceholder(),
    Object? markedByName = const $CopyWithPlaceholder(),
    Object? approver = const $CopyWithPlaceholder(),
    Object? decidedAt = const $CopyWithPlaceholder(),
    Object? decidedByName = const $CopyWithPlaceholder(),
    Object? rejectionReason = const $CopyWithPlaceholder(),
    Object? canDecide = const $CopyWithPlaceholder(),
    Object? clientMutationId = const $CopyWithPlaceholder(),
  }) {
    return AttendanceMarkItem(
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
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as AttendanceStatus,
      approvalState: approvalState == const $CopyWithPlaceholder()
          ? _value.approvalState
          // ignore: cast_nullable_to_non_nullable
          : approvalState as ApprovalState,
      source_: source_ == const $CopyWithPlaceholder()
          ? _value.source_
          // ignore: cast_nullable_to_non_nullable
          : source_ as AttendanceSource,
      note: note == const $CopyWithPlaceholder()
          ? _value.note
          // ignore: cast_nullable_to_non_nullable
          : note as String?,
      markedAt: markedAt == const $CopyWithPlaceholder()
          ? _value.markedAt
          // ignore: cast_nullable_to_non_nullable
          : markedAt as DateTime,
      markedByName: markedByName == const $CopyWithPlaceholder()
          ? _value.markedByName
          // ignore: cast_nullable_to_non_nullable
          : markedByName as String,
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
      clientMutationId: clientMutationId == const $CopyWithPlaceholder()
          ? _value.clientMutationId
          // ignore: cast_nullable_to_non_nullable
          : clientMutationId as String?,
    );
  }
}

extension $AttendanceMarkItemCopyWith on AttendanceMarkItem {
  /// Returns a callable class that can be used as follows: `instanceOfAttendanceMarkItem.copyWith(...)` or like so:`instanceOfAttendanceMarkItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AttendanceMarkItemCWProxy get copyWith =>
      _$AttendanceMarkItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceMarkItem _$AttendanceMarkItemFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AttendanceMarkItem', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'employee',
      'businessUnit',
      'date',
      'status',
      'approvalState',
      'source',
      'note',
      'markedAt',
      'markedByName',
      'approver',
      'decidedAt',
      'decidedByName',
      'rejectionReason',
      'canDecide',
      'clientMutationId',
    ],
  );
  final val = AttendanceMarkItem(
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
    status: $checkedConvert(
      'status',
      (v) => $enumDecode(_$AttendanceStatusEnumMap, v),
    ),
    approvalState: $checkedConvert(
      'approvalState',
      (v) => $enumDecode(_$ApprovalStateEnumMap, v),
    ),
    source_: $checkedConvert(
      'source',
      (v) => $enumDecode(_$AttendanceSourceEnumMap, v),
    ),
    note: $checkedConvert('note', (v) => v as String?),
    markedAt: $checkedConvert('markedAt', (v) => DateTime.parse(v as String)),
    markedByName: $checkedConvert('markedByName', (v) => v as String),
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
    clientMutationId: $checkedConvert('clientMutationId', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {'source_': 'source'});

Map<String, dynamic> _$AttendanceMarkItemToJson(AttendanceMarkItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employee': instance.employee.toJson(),
      'businessUnit': instance.businessUnit.toJson(),
      'date': instance.date,
      'status': _$AttendanceStatusEnumMap[instance.status]!,
      'approvalState': _$ApprovalStateEnumMap[instance.approvalState]!,
      'source': _$AttendanceSourceEnumMap[instance.source_]!,
      'note': instance.note,
      'markedAt': instance.markedAt.toIso8601String(),
      'markedByName': instance.markedByName,
      'approver': instance.approver?.toJson(),
      'decidedAt': instance.decidedAt?.toIso8601String(),
      'decidedByName': instance.decidedByName,
      'rejectionReason': instance.rejectionReason,
      'canDecide': instance.canDecide,
      'clientMutationId': instance.clientMutationId,
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

const _$ApprovalStateEnumMap = {
  ApprovalState.PENDING_APPROVAL: 'PENDING_APPROVAL',
  ApprovalState.APPROVED: 'APPROVED',
  ApprovalState.REJECTED: 'REJECTED',
};

const _$AttendanceSourceEnumMap = {
  AttendanceSource.MANAGER: 'MANAGER',
  AttendanceSource.SELF: 'SELF',
  AttendanceSource.SYSTEM: 'SYSTEM',
  AttendanceSource.BIOMETRIC: 'BIOMETRIC',
  AttendanceSource.TELEMATICS: 'TELEMATICS',
  AttendanceSource.IMPORT: 'IMPORT',
};
