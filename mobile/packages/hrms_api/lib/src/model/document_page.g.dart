// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_page.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DocumentPageCWProxy {
  DocumentPage items(List<DocumentWithEmployee> items);

  DocumentPage nextCursor(String? nextCursor);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DocumentPage(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DocumentPage(...).copyWith(id: 12, name: "My name")
  /// ````
  DocumentPage call({List<DocumentWithEmployee> items, String? nextCursor});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDocumentPage.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDocumentPage.copyWith.fieldName(...)`
class _$DocumentPageCWProxyImpl implements _$DocumentPageCWProxy {
  const _$DocumentPageCWProxyImpl(this._value);

  final DocumentPage _value;

  @override
  DocumentPage items(List<DocumentWithEmployee> items) => this(items: items);

  @override
  DocumentPage nextCursor(String? nextCursor) => this(nextCursor: nextCursor);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DocumentPage(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DocumentPage(...).copyWith(id: 12, name: "My name")
  /// ````
  DocumentPage call({
    Object? items = const $CopyWithPlaceholder(),
    Object? nextCursor = const $CopyWithPlaceholder(),
  }) {
    return DocumentPage(
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<DocumentWithEmployee>,
      nextCursor: nextCursor == const $CopyWithPlaceholder()
          ? _value.nextCursor
          // ignore: cast_nullable_to_non_nullable
          : nextCursor as String?,
    );
  }
}

extension $DocumentPageCopyWith on DocumentPage {
  /// Returns a callable class that can be used as follows: `instanceOfDocumentPage.copyWith(...)` or like so:`instanceOfDocumentPage.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DocumentPageCWProxy get copyWith => _$DocumentPageCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentPage _$DocumentPageFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DocumentPage', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['items', 'nextCursor']);
      final val = DocumentPage(
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map(
                (e) => DocumentWithEmployee.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
        ),
        nextCursor: $checkedConvert('nextCursor', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$DocumentPageToJson(DocumentPage instance) =>
    <String, dynamic>{
      'items': instance.items.map((e) => e.toJson()).toList(),
      'nextCursor': instance.nextCursor,
    };
