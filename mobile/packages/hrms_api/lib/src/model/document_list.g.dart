// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_list.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DocumentListCWProxy {
  DocumentList items(List<DocumentItem> items);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DocumentList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DocumentList(...).copyWith(id: 12, name: "My name")
  /// ````
  DocumentList call({List<DocumentItem> items});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDocumentList.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDocumentList.copyWith.fieldName(...)`
class _$DocumentListCWProxyImpl implements _$DocumentListCWProxy {
  const _$DocumentListCWProxyImpl(this._value);

  final DocumentList _value;

  @override
  DocumentList items(List<DocumentItem> items) => this(items: items);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DocumentList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DocumentList(...).copyWith(id: 12, name: "My name")
  /// ````
  DocumentList call({Object? items = const $CopyWithPlaceholder()}) {
    return DocumentList(
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<DocumentItem>,
    );
  }
}

extension $DocumentListCopyWith on DocumentList {
  /// Returns a callable class that can be used as follows: `instanceOfDocumentList.copyWith(...)` or like so:`instanceOfDocumentList.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DocumentListCWProxy get copyWith => _$DocumentListCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentList _$DocumentListFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DocumentList', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['items']);
      final val = DocumentList(
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map((e) => DocumentItem.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$DocumentListToJson(DocumentList instance) =>
    <String, dynamic>{'items': instance.items.map((e) => e.toJson()).toList()};
