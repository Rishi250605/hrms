// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compliance_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ComplianceItemCWProxy {
  ComplianceItem type(DocumentType type);

  ComplianceItem state(ComplianceState state);

  ComplianceItem documentId(String? documentId);

  ComplianceItem expiryDate(String? expiryDate);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ComplianceItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ComplianceItem(...).copyWith(id: 12, name: "My name")
  /// ````
  ComplianceItem call({
    DocumentType type,
    ComplianceState state,
    String? documentId,
    String? expiryDate,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfComplianceItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfComplianceItem.copyWith.fieldName(...)`
class _$ComplianceItemCWProxyImpl implements _$ComplianceItemCWProxy {
  const _$ComplianceItemCWProxyImpl(this._value);

  final ComplianceItem _value;

  @override
  ComplianceItem type(DocumentType type) => this(type: type);

  @override
  ComplianceItem state(ComplianceState state) => this(state: state);

  @override
  ComplianceItem documentId(String? documentId) => this(documentId: documentId);

  @override
  ComplianceItem expiryDate(String? expiryDate) => this(expiryDate: expiryDate);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ComplianceItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ComplianceItem(...).copyWith(id: 12, name: "My name")
  /// ````
  ComplianceItem call({
    Object? type = const $CopyWithPlaceholder(),
    Object? state = const $CopyWithPlaceholder(),
    Object? documentId = const $CopyWithPlaceholder(),
    Object? expiryDate = const $CopyWithPlaceholder(),
  }) {
    return ComplianceItem(
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as DocumentType,
      state: state == const $CopyWithPlaceholder()
          ? _value.state
          // ignore: cast_nullable_to_non_nullable
          : state as ComplianceState,
      documentId: documentId == const $CopyWithPlaceholder()
          ? _value.documentId
          // ignore: cast_nullable_to_non_nullable
          : documentId as String?,
      expiryDate: expiryDate == const $CopyWithPlaceholder()
          ? _value.expiryDate
          // ignore: cast_nullable_to_non_nullable
          : expiryDate as String?,
    );
  }
}

extension $ComplianceItemCopyWith on ComplianceItem {
  /// Returns a callable class that can be used as follows: `instanceOfComplianceItem.copyWith(...)` or like so:`instanceOfComplianceItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ComplianceItemCWProxy get copyWith => _$ComplianceItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComplianceItem _$ComplianceItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ComplianceItem', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['type', 'state', 'documentId', 'expiryDate'],
      );
      final val = ComplianceItem(
        type: $checkedConvert(
          'type',
          (v) => $enumDecode(_$DocumentTypeEnumMap, v),
        ),
        state: $checkedConvert(
          'state',
          (v) => $enumDecode(_$ComplianceStateEnumMap, v),
        ),
        documentId: $checkedConvert('documentId', (v) => v as String?),
        expiryDate: $checkedConvert('expiryDate', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$ComplianceItemToJson(ComplianceItem instance) =>
    <String, dynamic>{
      'type': _$DocumentTypeEnumMap[instance.type]!,
      'state': _$ComplianceStateEnumMap[instance.state]!,
      'documentId': instance.documentId,
      'expiryDate': instance.expiryDate,
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

const _$ComplianceStateEnumMap = {
  ComplianceState.VALID: 'VALID',
  ComplianceState.EXPIRING: 'EXPIRING',
  ComplianceState.UNVERIFIED: 'UNVERIFIED',
  ComplianceState.EXPIRED: 'EXPIRED',
  ComplianceState.REJECTED: 'REJECTED',
  ComplianceState.MISSING: 'MISSING',
};
