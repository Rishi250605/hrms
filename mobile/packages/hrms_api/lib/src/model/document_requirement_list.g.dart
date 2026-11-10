// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_requirement_list.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DocumentRequirementListCWProxy {
  DocumentRequirementList items(List<DocumentRequirementItem> items);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DocumentRequirementList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DocumentRequirementList(...).copyWith(id: 12, name: "My name")
  /// ````
  DocumentRequirementList call({List<DocumentRequirementItem> items});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDocumentRequirementList.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDocumentRequirementList.copyWith.fieldName(...)`
class _$DocumentRequirementListCWProxyImpl
    implements _$DocumentRequirementListCWProxy {
  const _$DocumentRequirementListCWProxyImpl(this._value);

  final DocumentRequirementList _value;

  @override
  DocumentRequirementList items(List<DocumentRequirementItem> items) =>
      this(items: items);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DocumentRequirementList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DocumentRequirementList(...).copyWith(id: 12, name: "My name")
  /// ````
  DocumentRequirementList call({Object? items = const $CopyWithPlaceholder()}) {
    return DocumentRequirementList(
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<DocumentRequirementItem>,
    );
  }
}

extension $DocumentRequirementListCopyWith on DocumentRequirementList {
  /// Returns a callable class that can be used as follows: `instanceOfDocumentRequirementList.copyWith(...)` or like so:`instanceOfDocumentRequirementList.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DocumentRequirementListCWProxy get copyWith =>
      _$DocumentRequirementListCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentRequirementList _$DocumentRequirementListFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DocumentRequirementList', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['items']);
  final val = DocumentRequirementList(
    items: $checkedConvert(
      'items',
      (v) => (v as List<dynamic>)
          .map(
            (e) => DocumentRequirementItem.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$DocumentRequirementListToJson(
  DocumentRequirementList instance,
) => <String, dynamic>{'items': instance.items.map((e) => e.toJson()).toList()};
