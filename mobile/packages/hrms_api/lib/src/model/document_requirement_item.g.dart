// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_requirement_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DocumentRequirementItemCWProxy {
  DocumentRequirementItem category(EmployeeCategory category);

  DocumentRequirementItem documentTypes(List<DocumentType> documentTypes);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DocumentRequirementItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DocumentRequirementItem(...).copyWith(id: 12, name: "My name")
  /// ````
  DocumentRequirementItem call({
    EmployeeCategory category,
    List<DocumentType> documentTypes,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDocumentRequirementItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDocumentRequirementItem.copyWith.fieldName(...)`
class _$DocumentRequirementItemCWProxyImpl
    implements _$DocumentRequirementItemCWProxy {
  const _$DocumentRequirementItemCWProxyImpl(this._value);

  final DocumentRequirementItem _value;

  @override
  DocumentRequirementItem category(EmployeeCategory category) =>
      this(category: category);

  @override
  DocumentRequirementItem documentTypes(List<DocumentType> documentTypes) =>
      this(documentTypes: documentTypes);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DocumentRequirementItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DocumentRequirementItem(...).copyWith(id: 12, name: "My name")
  /// ````
  DocumentRequirementItem call({
    Object? category = const $CopyWithPlaceholder(),
    Object? documentTypes = const $CopyWithPlaceholder(),
  }) {
    return DocumentRequirementItem(
      category: category == const $CopyWithPlaceholder()
          ? _value.category
          // ignore: cast_nullable_to_non_nullable
          : category as EmployeeCategory,
      documentTypes: documentTypes == const $CopyWithPlaceholder()
          ? _value.documentTypes
          // ignore: cast_nullable_to_non_nullable
          : documentTypes as List<DocumentType>,
    );
  }
}

extension $DocumentRequirementItemCopyWith on DocumentRequirementItem {
  /// Returns a callable class that can be used as follows: `instanceOfDocumentRequirementItem.copyWith(...)` or like so:`instanceOfDocumentRequirementItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DocumentRequirementItemCWProxy get copyWith =>
      _$DocumentRequirementItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentRequirementItem _$DocumentRequirementItemFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DocumentRequirementItem', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['category', 'documentTypes']);
  final val = DocumentRequirementItem(
    category: $checkedConvert(
      'category',
      (v) => $enumDecode(_$EmployeeCategoryEnumMap, v),
    ),
    documentTypes: $checkedConvert(
      'documentTypes',
      (v) => (v as List<dynamic>)
          .map((e) => $enumDecode(_$DocumentTypeEnumMap, e))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$DocumentRequirementItemToJson(
  DocumentRequirementItem instance,
) => <String, dynamic>{
  'category': _$EmployeeCategoryEnumMap[instance.category]!,
  'documentTypes': instance.documentTypes
      .map((e) => _$DocumentTypeEnumMap[e]!)
      .toList(),
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
