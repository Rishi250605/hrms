// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DocumentItemCWProxy {
  DocumentItem id(String id);

  DocumentItem employeeId(String employeeId);

  DocumentItem type(DocumentType type);

  DocumentItem number(String number);

  DocumentItem licenceClass(String? licenceClass);

  DocumentItem issueDate(String? issueDate);

  DocumentItem expiryDate(String? expiryDate);

  DocumentItem status(DocumentStatus status);

  DocumentItem hasFile(bool hasFile);

  DocumentItem verifiedAt(DateTime? verifiedAt);

  DocumentItem verifiedByName(String? verifiedByName);

  DocumentItem rejectionReason(String? rejectionReason);

  DocumentItem createdAt(DateTime createdAt);

  DocumentItem daysToExpiry(int? daysToExpiry);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DocumentItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DocumentItem(...).copyWith(id: 12, name: "My name")
  /// ````
  DocumentItem call({
    String id,
    String employeeId,
    DocumentType type,
    String number,
    String? licenceClass,
    String? issueDate,
    String? expiryDate,
    DocumentStatus status,
    bool hasFile,
    DateTime? verifiedAt,
    String? verifiedByName,
    String? rejectionReason,
    DateTime createdAt,
    int? daysToExpiry,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDocumentItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDocumentItem.copyWith.fieldName(...)`
class _$DocumentItemCWProxyImpl implements _$DocumentItemCWProxy {
  const _$DocumentItemCWProxyImpl(this._value);

  final DocumentItem _value;

  @override
  DocumentItem id(String id) => this(id: id);

  @override
  DocumentItem employeeId(String employeeId) => this(employeeId: employeeId);

  @override
  DocumentItem type(DocumentType type) => this(type: type);

  @override
  DocumentItem number(String number) => this(number: number);

  @override
  DocumentItem licenceClass(String? licenceClass) =>
      this(licenceClass: licenceClass);

  @override
  DocumentItem issueDate(String? issueDate) => this(issueDate: issueDate);

  @override
  DocumentItem expiryDate(String? expiryDate) => this(expiryDate: expiryDate);

  @override
  DocumentItem status(DocumentStatus status) => this(status: status);

  @override
  DocumentItem hasFile(bool hasFile) => this(hasFile: hasFile);

  @override
  DocumentItem verifiedAt(DateTime? verifiedAt) => this(verifiedAt: verifiedAt);

  @override
  DocumentItem verifiedByName(String? verifiedByName) =>
      this(verifiedByName: verifiedByName);

  @override
  DocumentItem rejectionReason(String? rejectionReason) =>
      this(rejectionReason: rejectionReason);

  @override
  DocumentItem createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  DocumentItem daysToExpiry(int? daysToExpiry) =>
      this(daysToExpiry: daysToExpiry);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DocumentItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DocumentItem(...).copyWith(id: 12, name: "My name")
  /// ````
  DocumentItem call({
    Object? id = const $CopyWithPlaceholder(),
    Object? employeeId = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? number = const $CopyWithPlaceholder(),
    Object? licenceClass = const $CopyWithPlaceholder(),
    Object? issueDate = const $CopyWithPlaceholder(),
    Object? expiryDate = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? hasFile = const $CopyWithPlaceholder(),
    Object? verifiedAt = const $CopyWithPlaceholder(),
    Object? verifiedByName = const $CopyWithPlaceholder(),
    Object? rejectionReason = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? daysToExpiry = const $CopyWithPlaceholder(),
  }) {
    return DocumentItem(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      employeeId: employeeId == const $CopyWithPlaceholder()
          ? _value.employeeId
          // ignore: cast_nullable_to_non_nullable
          : employeeId as String,
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as DocumentType,
      number: number == const $CopyWithPlaceholder()
          ? _value.number
          // ignore: cast_nullable_to_non_nullable
          : number as String,
      licenceClass: licenceClass == const $CopyWithPlaceholder()
          ? _value.licenceClass
          // ignore: cast_nullable_to_non_nullable
          : licenceClass as String?,
      issueDate: issueDate == const $CopyWithPlaceholder()
          ? _value.issueDate
          // ignore: cast_nullable_to_non_nullable
          : issueDate as String?,
      expiryDate: expiryDate == const $CopyWithPlaceholder()
          ? _value.expiryDate
          // ignore: cast_nullable_to_non_nullable
          : expiryDate as String?,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as DocumentStatus,
      hasFile: hasFile == const $CopyWithPlaceholder()
          ? _value.hasFile
          // ignore: cast_nullable_to_non_nullable
          : hasFile as bool,
      verifiedAt: verifiedAt == const $CopyWithPlaceholder()
          ? _value.verifiedAt
          // ignore: cast_nullable_to_non_nullable
          : verifiedAt as DateTime?,
      verifiedByName: verifiedByName == const $CopyWithPlaceholder()
          ? _value.verifiedByName
          // ignore: cast_nullable_to_non_nullable
          : verifiedByName as String?,
      rejectionReason: rejectionReason == const $CopyWithPlaceholder()
          ? _value.rejectionReason
          // ignore: cast_nullable_to_non_nullable
          : rejectionReason as String?,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      daysToExpiry: daysToExpiry == const $CopyWithPlaceholder()
          ? _value.daysToExpiry
          // ignore: cast_nullable_to_non_nullable
          : daysToExpiry as int?,
    );
  }
}

extension $DocumentItemCopyWith on DocumentItem {
  /// Returns a callable class that can be used as follows: `instanceOfDocumentItem.copyWith(...)` or like so:`instanceOfDocumentItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DocumentItemCWProxy get copyWith => _$DocumentItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentItem _$DocumentItemFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DocumentItem', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'employeeId',
      'type',
      'number',
      'licenceClass',
      'issueDate',
      'expiryDate',
      'status',
      'hasFile',
      'verifiedAt',
      'verifiedByName',
      'rejectionReason',
      'createdAt',
      'daysToExpiry',
    ],
  );
  final val = DocumentItem(
    id: $checkedConvert('id', (v) => v as String),
    employeeId: $checkedConvert('employeeId', (v) => v as String),
    type: $checkedConvert('type', (v) => $enumDecode(_$DocumentTypeEnumMap, v)),
    number: $checkedConvert('number', (v) => v as String),
    licenceClass: $checkedConvert('licenceClass', (v) => v as String?),
    issueDate: $checkedConvert('issueDate', (v) => v as String?),
    expiryDate: $checkedConvert('expiryDate', (v) => v as String?),
    status: $checkedConvert(
      'status',
      (v) => $enumDecode(_$DocumentStatusEnumMap, v),
    ),
    hasFile: $checkedConvert('hasFile', (v) => v as bool),
    verifiedAt: $checkedConvert(
      'verifiedAt',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    verifiedByName: $checkedConvert('verifiedByName', (v) => v as String?),
    rejectionReason: $checkedConvert('rejectionReason', (v) => v as String?),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
    daysToExpiry: $checkedConvert('daysToExpiry', (v) => (v as num?)?.toInt()),
  );
  return val;
});

Map<String, dynamic> _$DocumentItemToJson(DocumentItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employeeId': instance.employeeId,
      'type': _$DocumentTypeEnumMap[instance.type]!,
      'number': instance.number,
      'licenceClass': instance.licenceClass,
      'issueDate': instance.issueDate,
      'expiryDate': instance.expiryDate,
      'status': _$DocumentStatusEnumMap[instance.status]!,
      'hasFile': instance.hasFile,
      'verifiedAt': instance.verifiedAt?.toIso8601String(),
      'verifiedByName': instance.verifiedByName,
      'rejectionReason': instance.rejectionReason,
      'createdAt': instance.createdAt.toIso8601String(),
      'daysToExpiry': instance.daysToExpiry,
    };

const _$DocumentTypeEnumMap = {
  DocumentType.DRIVING_LICENCE: 'DRIVING_LICENCE',
  DocumentType.PSV_BADGE: 'PSV_BADGE',
  DocumentType.MEDICAL_FITNESS: 'MEDICAL_FITNESS',
  DocumentType.POLICE_VERIFICATION: 'POLICE_VERIFICATION',
  DocumentType.AADHAAR: 'AADHAAR',
  DocumentType.PAN: 'PAN',
  DocumentType.TRAINING_CERT: 'TRAINING_CERT',
  DocumentType.OTHER: 'OTHER',
};

const _$DocumentStatusEnumMap = {
  DocumentStatus.PENDING_VERIFICATION: 'PENDING_VERIFICATION',
  DocumentStatus.VERIFIED: 'VERIFIED',
  DocumentStatus.REJECTED: 'REJECTED',
  DocumentStatus.EXPIRED: 'EXPIRED',
};
