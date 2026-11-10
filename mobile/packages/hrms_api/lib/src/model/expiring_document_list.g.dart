// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expiring_document_list.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ExpiringDocumentListCWProxy {
  ExpiringDocumentList items(List<DocumentWithEmployee> items);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExpiringDocumentList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExpiringDocumentList(...).copyWith(id: 12, name: "My name")
  /// ````
  ExpiringDocumentList call({List<DocumentWithEmployee> items});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfExpiringDocumentList.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfExpiringDocumentList.copyWith.fieldName(...)`
class _$ExpiringDocumentListCWProxyImpl
    implements _$ExpiringDocumentListCWProxy {
  const _$ExpiringDocumentListCWProxyImpl(this._value);

  final ExpiringDocumentList _value;

  @override
  ExpiringDocumentList items(List<DocumentWithEmployee> items) =>
      this(items: items);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExpiringDocumentList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExpiringDocumentList(...).copyWith(id: 12, name: "My name")
  /// ````
  ExpiringDocumentList call({Object? items = const $CopyWithPlaceholder()}) {
    return ExpiringDocumentList(
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<DocumentWithEmployee>,
    );
  }
}

extension $ExpiringDocumentListCopyWith on ExpiringDocumentList {
  /// Returns a callable class that can be used as follows: `instanceOfExpiringDocumentList.copyWith(...)` or like so:`instanceOfExpiringDocumentList.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ExpiringDocumentListCWProxy get copyWith =>
      _$ExpiringDocumentListCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpiringDocumentList _$ExpiringDocumentListFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ExpiringDocumentList', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['items']);
  final val = ExpiringDocumentList(
    items: $checkedConvert(
      'items',
      (v) => (v as List<dynamic>)
          .map((e) => DocumentWithEmployee.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$ExpiringDocumentListToJson(
  ExpiringDocumentList instance,
) => <String, dynamic>{'items': instance.items.map((e) => e.toJson()).toList()};
