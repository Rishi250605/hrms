// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allowance_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AllowanceItemCWProxy {
  AllowanceItem id(String id);

  AllowanceItem batchId(String batchId);

  AllowanceItem beneficiary(PersonRef beneficiary);

  AllowanceItem raisedBy(PersonRef raisedBy);

  AllowanceItem businessUnit(BusinessUnitRef businessUnit);

  AllowanceItem allowanceType(AllowanceItemAllowanceType allowanceType);

  AllowanceItem requestedAmountPaise(int requestedAmountPaise);

  AllowanceItem approvedAmountPaise(int? approvedAmountPaise);

  AllowanceItem fromDate(String fromDate);

  AllowanceItem toDate(String toDate);

  AllowanceItem comment(String? comment);

  AllowanceItem hasVoiceNote(bool hasVoiceNote);

  AllowanceItem hasReceipt(bool hasReceipt);

  AllowanceItem status(RequestStatus status);

  AllowanceItem approver(PersonRef? approver);

  AllowanceItem decidedAt(DateTime? decidedAt);

  AllowanceItem decidedByName(String? decidedByName);

  AllowanceItem decisionComment(String? decisionComment);

  AllowanceItem rejectionReason(String? rejectionReason);

  AllowanceItem canDecide(bool canDecide);

  AllowanceItem createdAt(DateTime createdAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AllowanceItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AllowanceItem(...).copyWith(id: 12, name: "My name")
  /// ````
  AllowanceItem call({
    String id,
    String batchId,
    PersonRef beneficiary,
    PersonRef raisedBy,
    BusinessUnitRef businessUnit,
    AllowanceItemAllowanceType allowanceType,
    int requestedAmountPaise,
    int? approvedAmountPaise,
    String fromDate,
    String toDate,
    String? comment,
    bool hasVoiceNote,
    bool hasReceipt,
    RequestStatus status,
    PersonRef? approver,
    DateTime? decidedAt,
    String? decidedByName,
    String? decisionComment,
    String? rejectionReason,
    bool canDecide,
    DateTime createdAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAllowanceItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAllowanceItem.copyWith.fieldName(...)`
class _$AllowanceItemCWProxyImpl implements _$AllowanceItemCWProxy {
  const _$AllowanceItemCWProxyImpl(this._value);

  final AllowanceItem _value;

  @override
  AllowanceItem id(String id) => this(id: id);

  @override
  AllowanceItem batchId(String batchId) => this(batchId: batchId);

  @override
  AllowanceItem beneficiary(PersonRef beneficiary) =>
      this(beneficiary: beneficiary);

  @override
  AllowanceItem raisedBy(PersonRef raisedBy) => this(raisedBy: raisedBy);

  @override
  AllowanceItem businessUnit(BusinessUnitRef businessUnit) =>
      this(businessUnit: businessUnit);

  @override
  AllowanceItem allowanceType(AllowanceItemAllowanceType allowanceType) =>
      this(allowanceType: allowanceType);

  @override
  AllowanceItem requestedAmountPaise(int requestedAmountPaise) =>
      this(requestedAmountPaise: requestedAmountPaise);

  @override
  AllowanceItem approvedAmountPaise(int? approvedAmountPaise) =>
      this(approvedAmountPaise: approvedAmountPaise);

  @override
  AllowanceItem fromDate(String fromDate) => this(fromDate: fromDate);

  @override
  AllowanceItem toDate(String toDate) => this(toDate: toDate);

  @override
  AllowanceItem comment(String? comment) => this(comment: comment);

  @override
  AllowanceItem hasVoiceNote(bool hasVoiceNote) =>
      this(hasVoiceNote: hasVoiceNote);

  @override
  AllowanceItem hasReceipt(bool hasReceipt) => this(hasReceipt: hasReceipt);

  @override
  AllowanceItem status(RequestStatus status) => this(status: status);

  @override
  AllowanceItem approver(PersonRef? approver) => this(approver: approver);

  @override
  AllowanceItem decidedAt(DateTime? decidedAt) => this(decidedAt: decidedAt);

  @override
  AllowanceItem decidedByName(String? decidedByName) =>
      this(decidedByName: decidedByName);

  @override
  AllowanceItem decisionComment(String? decisionComment) =>
      this(decisionComment: decisionComment);

  @override
  AllowanceItem rejectionReason(String? rejectionReason) =>
      this(rejectionReason: rejectionReason);

  @override
  AllowanceItem canDecide(bool canDecide) => this(canDecide: canDecide);

  @override
  AllowanceItem createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AllowanceItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AllowanceItem(...).copyWith(id: 12, name: "My name")
  /// ````
  AllowanceItem call({
    Object? id = const $CopyWithPlaceholder(),
    Object? batchId = const $CopyWithPlaceholder(),
    Object? beneficiary = const $CopyWithPlaceholder(),
    Object? raisedBy = const $CopyWithPlaceholder(),
    Object? businessUnit = const $CopyWithPlaceholder(),
    Object? allowanceType = const $CopyWithPlaceholder(),
    Object? requestedAmountPaise = const $CopyWithPlaceholder(),
    Object? approvedAmountPaise = const $CopyWithPlaceholder(),
    Object? fromDate = const $CopyWithPlaceholder(),
    Object? toDate = const $CopyWithPlaceholder(),
    Object? comment = const $CopyWithPlaceholder(),
    Object? hasVoiceNote = const $CopyWithPlaceholder(),
    Object? hasReceipt = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? approver = const $CopyWithPlaceholder(),
    Object? decidedAt = const $CopyWithPlaceholder(),
    Object? decidedByName = const $CopyWithPlaceholder(),
    Object? decisionComment = const $CopyWithPlaceholder(),
    Object? rejectionReason = const $CopyWithPlaceholder(),
    Object? canDecide = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
  }) {
    return AllowanceItem(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      batchId: batchId == const $CopyWithPlaceholder()
          ? _value.batchId
          // ignore: cast_nullable_to_non_nullable
          : batchId as String,
      beneficiary: beneficiary == const $CopyWithPlaceholder()
          ? _value.beneficiary
          // ignore: cast_nullable_to_non_nullable
          : beneficiary as PersonRef,
      raisedBy: raisedBy == const $CopyWithPlaceholder()
          ? _value.raisedBy
          // ignore: cast_nullable_to_non_nullable
          : raisedBy as PersonRef,
      businessUnit: businessUnit == const $CopyWithPlaceholder()
          ? _value.businessUnit
          // ignore: cast_nullable_to_non_nullable
          : businessUnit as BusinessUnitRef,
      allowanceType: allowanceType == const $CopyWithPlaceholder()
          ? _value.allowanceType
          // ignore: cast_nullable_to_non_nullable
          : allowanceType as AllowanceItemAllowanceType,
      requestedAmountPaise: requestedAmountPaise == const $CopyWithPlaceholder()
          ? _value.requestedAmountPaise
          // ignore: cast_nullable_to_non_nullable
          : requestedAmountPaise as int,
      approvedAmountPaise: approvedAmountPaise == const $CopyWithPlaceholder()
          ? _value.approvedAmountPaise
          // ignore: cast_nullable_to_non_nullable
          : approvedAmountPaise as int?,
      fromDate: fromDate == const $CopyWithPlaceholder()
          ? _value.fromDate
          // ignore: cast_nullable_to_non_nullable
          : fromDate as String,
      toDate: toDate == const $CopyWithPlaceholder()
          ? _value.toDate
          // ignore: cast_nullable_to_non_nullable
          : toDate as String,
      comment: comment == const $CopyWithPlaceholder()
          ? _value.comment
          // ignore: cast_nullable_to_non_nullable
          : comment as String?,
      hasVoiceNote: hasVoiceNote == const $CopyWithPlaceholder()
          ? _value.hasVoiceNote
          // ignore: cast_nullable_to_non_nullable
          : hasVoiceNote as bool,
      hasReceipt: hasReceipt == const $CopyWithPlaceholder()
          ? _value.hasReceipt
          // ignore: cast_nullable_to_non_nullable
          : hasReceipt as bool,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as RequestStatus,
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
      decisionComment: decisionComment == const $CopyWithPlaceholder()
          ? _value.decisionComment
          // ignore: cast_nullable_to_non_nullable
          : decisionComment as String?,
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

extension $AllowanceItemCopyWith on AllowanceItem {
  /// Returns a callable class that can be used as follows: `instanceOfAllowanceItem.copyWith(...)` or like so:`instanceOfAllowanceItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AllowanceItemCWProxy get copyWith => _$AllowanceItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllowanceItem _$AllowanceItemFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AllowanceItem', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'batchId',
      'beneficiary',
      'raisedBy',
      'businessUnit',
      'allowanceType',
      'requestedAmountPaise',
      'approvedAmountPaise',
      'fromDate',
      'toDate',
      'comment',
      'hasVoiceNote',
      'hasReceipt',
      'status',
      'approver',
      'decidedAt',
      'decidedByName',
      'decisionComment',
      'rejectionReason',
      'canDecide',
      'createdAt',
    ],
  );
  final val = AllowanceItem(
    id: $checkedConvert('id', (v) => v as String),
    batchId: $checkedConvert('batchId', (v) => v as String),
    beneficiary: $checkedConvert(
      'beneficiary',
      (v) => PersonRef.fromJson(v as Map<String, dynamic>),
    ),
    raisedBy: $checkedConvert(
      'raisedBy',
      (v) => PersonRef.fromJson(v as Map<String, dynamic>),
    ),
    businessUnit: $checkedConvert(
      'businessUnit',
      (v) => BusinessUnitRef.fromJson(v as Map<String, dynamic>),
    ),
    allowanceType: $checkedConvert(
      'allowanceType',
      (v) => AllowanceItemAllowanceType.fromJson(v as Map<String, dynamic>),
    ),
    requestedAmountPaise: $checkedConvert(
      'requestedAmountPaise',
      (v) => (v as num).toInt(),
    ),
    approvedAmountPaise: $checkedConvert(
      'approvedAmountPaise',
      (v) => (v as num?)?.toInt(),
    ),
    fromDate: $checkedConvert('fromDate', (v) => v as String),
    toDate: $checkedConvert('toDate', (v) => v as String),
    comment: $checkedConvert('comment', (v) => v as String?),
    hasVoiceNote: $checkedConvert('hasVoiceNote', (v) => v as bool),
    hasReceipt: $checkedConvert('hasReceipt', (v) => v as bool),
    status: $checkedConvert(
      'status',
      (v) => $enumDecode(_$RequestStatusEnumMap, v),
    ),
    approver: $checkedConvert(
      'approver',
      (v) => v == null ? null : PersonRef.fromJson(v as Map<String, dynamic>),
    ),
    decidedAt: $checkedConvert(
      'decidedAt',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    decidedByName: $checkedConvert('decidedByName', (v) => v as String?),
    decisionComment: $checkedConvert('decisionComment', (v) => v as String?),
    rejectionReason: $checkedConvert('rejectionReason', (v) => v as String?),
    canDecide: $checkedConvert('canDecide', (v) => v as bool),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
  );
  return val;
});

Map<String, dynamic> _$AllowanceItemToJson(AllowanceItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'batchId': instance.batchId,
      'beneficiary': instance.beneficiary.toJson(),
      'raisedBy': instance.raisedBy.toJson(),
      'businessUnit': instance.businessUnit.toJson(),
      'allowanceType': instance.allowanceType.toJson(),
      'requestedAmountPaise': instance.requestedAmountPaise,
      'approvedAmountPaise': instance.approvedAmountPaise,
      'fromDate': instance.fromDate,
      'toDate': instance.toDate,
      'comment': instance.comment,
      'hasVoiceNote': instance.hasVoiceNote,
      'hasReceipt': instance.hasReceipt,
      'status': _$RequestStatusEnumMap[instance.status]!,
      'approver': instance.approver?.toJson(),
      'decidedAt': instance.decidedAt?.toIso8601String(),
      'decidedByName': instance.decidedByName,
      'decisionComment': instance.decisionComment,
      'rejectionReason': instance.rejectionReason,
      'canDecide': instance.canDecide,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$RequestStatusEnumMap = {
  RequestStatus.PENDING: 'PENDING',
  RequestStatus.APPROVED: 'APPROVED',
  RequestStatus.REJECTED: 'REJECTED',
  RequestStatus.CANCELLED: 'CANCELLED',
};
