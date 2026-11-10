// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_create_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DocumentCreateBodyCWProxy {
  DocumentCreateBody type(DocumentType type);

  DocumentCreateBody number(String number);

  DocumentCreateBody licenceClass(String? licenceClass);

  DocumentCreateBody issueDate(String? issueDate);

  DocumentCreateBody expiryDate(String? expiryDate);

  DocumentCreateBody fileKey(String fileKey);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DocumentCreateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DocumentCreateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  DocumentCreateBody call({
    DocumentType type,
    String number,
    String? licenceClass,
    String? issueDate,
    String? expiryDate,
    String fileKey,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDocumentCreateBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDocumentCreateBody.copyWith.fieldName(...)`
class _$DocumentCreateBodyCWProxyImpl implements _$DocumentCreateBodyCWProxy {
  const _$DocumentCreateBodyCWProxyImpl(this._value);

  final DocumentCreateBody _value;

  @override
  DocumentCreateBody type(DocumentType type) => this(type: type);

  @override
  DocumentCreateBody number(String number) => this(number: number);

  @override
  DocumentCreateBody licenceClass(String? licenceClass) =>
      this(licenceClass: licenceClass);

  @override
  DocumentCreateBody issueDate(String? issueDate) => this(issueDate: issueDate);

  @override
  DocumentCreateBody expiryDate(String? expiryDate) =>
      this(expiryDate: expiryDate);

  @override
  DocumentCreateBody fileKey(String fileKey) => this(fileKey: fileKey);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DocumentCreateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DocumentCreateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  DocumentCreateBody call({
    Object? type = const $CopyWithPlaceholder(),
    Object? number = const $CopyWithPlaceholder(),
    Object? licenceClass = const $CopyWithPlaceholder(),
    Object? issueDate = const $CopyWithPlaceholder(),
    Object? expiryDate = const $CopyWithPlaceholder(),
    Object? fileKey = const $CopyWithPlaceholder(),
  }) {
    return DocumentCreateBody(
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
      fileKey: fileKey == const $CopyWithPlaceholder()
          ? _value.fileKey
          // ignore: cast_nullable_to_non_nullable
          : fileKey as String,
    );
  }
}

extension $DocumentCreateBodyCopyWith on DocumentCreateBody {
  /// Returns a callable class that can be used as follows: `instanceOfDocumentCreateBody.copyWith(...)` or like so:`instanceOfDocumentCreateBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DocumentCreateBodyCWProxy get copyWith =>
      _$DocumentCreateBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentCreateBody _$DocumentCreateBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DocumentCreateBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['type', 'number', 'fileKey']);
      final val = DocumentCreateBody(
        type: $checkedConvert(
          'type',
          (v) => $enumDecode(_$DocumentTypeEnumMap, v),
        ),
        number: $checkedConvert('number', (v) => v as String),
        licenceClass: $checkedConvert('licenceClass', (v) => v as String?),
        issueDate: $checkedConvert('issueDate', (v) => v as String?),
        expiryDate: $checkedConvert('expiryDate', (v) => v as String?),
        fileKey: $checkedConvert('fileKey', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$DocumentCreateBodyToJson(DocumentCreateBody instance) =>
    <String, dynamic>{
      'type': _$DocumentTypeEnumMap[instance.type]!,
      'number': instance.number,
      'licenceClass': ?instance.licenceClass,
      'issueDate': ?instance.issueDate,
      'expiryDate': ?instance.expiryDate,
      'fileKey': instance.fileKey,
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
