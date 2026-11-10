// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_invalid_details.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DocumentInvalidDetailsCWProxy {
  DocumentInvalidDetails failing(List<ComplianceItem> failing);

  DocumentInvalidDetails spares(List<SpareItem> spares);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DocumentInvalidDetails(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DocumentInvalidDetails(...).copyWith(id: 12, name: "My name")
  /// ````
  DocumentInvalidDetails call({
    List<ComplianceItem> failing,
    List<SpareItem> spares,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDocumentInvalidDetails.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDocumentInvalidDetails.copyWith.fieldName(...)`
class _$DocumentInvalidDetailsCWProxyImpl
    implements _$DocumentInvalidDetailsCWProxy {
  const _$DocumentInvalidDetailsCWProxyImpl(this._value);

  final DocumentInvalidDetails _value;

  @override
  DocumentInvalidDetails failing(List<ComplianceItem> failing) =>
      this(failing: failing);

  @override
  DocumentInvalidDetails spares(List<SpareItem> spares) => this(spares: spares);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DocumentInvalidDetails(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DocumentInvalidDetails(...).copyWith(id: 12, name: "My name")
  /// ````
  DocumentInvalidDetails call({
    Object? failing = const $CopyWithPlaceholder(),
    Object? spares = const $CopyWithPlaceholder(),
  }) {
    return DocumentInvalidDetails(
      failing: failing == const $CopyWithPlaceholder()
          ? _value.failing
          // ignore: cast_nullable_to_non_nullable
          : failing as List<ComplianceItem>,
      spares: spares == const $CopyWithPlaceholder()
          ? _value.spares
          // ignore: cast_nullable_to_non_nullable
          : spares as List<SpareItem>,
    );
  }
}

extension $DocumentInvalidDetailsCopyWith on DocumentInvalidDetails {
  /// Returns a callable class that can be used as follows: `instanceOfDocumentInvalidDetails.copyWith(...)` or like so:`instanceOfDocumentInvalidDetails.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DocumentInvalidDetailsCWProxy get copyWith =>
      _$DocumentInvalidDetailsCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentInvalidDetails _$DocumentInvalidDetailsFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DocumentInvalidDetails', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['failing', 'spares']);
  final val = DocumentInvalidDetails(
    failing: $checkedConvert(
      'failing',
      (v) => (v as List<dynamic>)
          .map((e) => ComplianceItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    spares: $checkedConvert(
      'spares',
      (v) => (v as List<dynamic>)
          .map((e) => SpareItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$DocumentInvalidDetailsToJson(
  DocumentInvalidDetails instance,
) => <String, dynamic>{
  'failing': instance.failing.map((e) => e.toJson()).toList(),
  'spares': instance.spares.map((e) => e.toJson()).toList(),
};
