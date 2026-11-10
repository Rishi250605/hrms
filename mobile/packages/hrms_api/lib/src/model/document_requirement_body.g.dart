// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_requirement_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DocumentRequirementBodyCWProxy {
  DocumentRequirementBody documentTypes(List<DocumentType> documentTypes);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DocumentRequirementBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DocumentRequirementBody(...).copyWith(id: 12, name: "My name")
  /// ````
  DocumentRequirementBody call({List<DocumentType> documentTypes});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDocumentRequirementBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDocumentRequirementBody.copyWith.fieldName(...)`
class _$DocumentRequirementBodyCWProxyImpl
    implements _$DocumentRequirementBodyCWProxy {
  const _$DocumentRequirementBodyCWProxyImpl(this._value);

  final DocumentRequirementBody _value;

  @override
  DocumentRequirementBody documentTypes(List<DocumentType> documentTypes) =>
      this(documentTypes: documentTypes);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DocumentRequirementBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DocumentRequirementBody(...).copyWith(id: 12, name: "My name")
  /// ````
  DocumentRequirementBody call({
    Object? documentTypes = const $CopyWithPlaceholder(),
  }) {
    return DocumentRequirementBody(
      documentTypes: documentTypes == const $CopyWithPlaceholder()
          ? _value.documentTypes
          // ignore: cast_nullable_to_non_nullable
          : documentTypes as List<DocumentType>,
    );
  }
}

extension $DocumentRequirementBodyCopyWith on DocumentRequirementBody {
  /// Returns a callable class that can be used as follows: `instanceOfDocumentRequirementBody.copyWith(...)` or like so:`instanceOfDocumentRequirementBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DocumentRequirementBodyCWProxy get copyWith =>
      _$DocumentRequirementBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentRequirementBody _$DocumentRequirementBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DocumentRequirementBody', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['documentTypes']);
  final val = DocumentRequirementBody(
    documentTypes: $checkedConvert(
      'documentTypes',
      (v) => (v as List<dynamic>)
          .map((e) => $enumDecode(_$DocumentTypeEnumMap, e))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$DocumentRequirementBodyToJson(
  DocumentRequirementBody instance,
) => <String, dynamic>{
  'documentTypes': instance.documentTypes
      .map((e) => _$DocumentTypeEnumMap[e]!)
      .toList(),
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
