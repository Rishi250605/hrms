// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_verify_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DocumentVerifyBodyCWProxy {
  DocumentVerifyBody expiryDate(String? expiryDate);

  DocumentVerifyBody note(String? note);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DocumentVerifyBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DocumentVerifyBody(...).copyWith(id: 12, name: "My name")
  /// ````
  DocumentVerifyBody call({String? expiryDate, String? note});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDocumentVerifyBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDocumentVerifyBody.copyWith.fieldName(...)`
class _$DocumentVerifyBodyCWProxyImpl implements _$DocumentVerifyBodyCWProxy {
  const _$DocumentVerifyBodyCWProxyImpl(this._value);

  final DocumentVerifyBody _value;

  @override
  DocumentVerifyBody expiryDate(String? expiryDate) =>
      this(expiryDate: expiryDate);

  @override
  DocumentVerifyBody note(String? note) => this(note: note);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DocumentVerifyBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DocumentVerifyBody(...).copyWith(id: 12, name: "My name")
  /// ````
  DocumentVerifyBody call({
    Object? expiryDate = const $CopyWithPlaceholder(),
    Object? note = const $CopyWithPlaceholder(),
  }) {
    return DocumentVerifyBody(
      expiryDate: expiryDate == const $CopyWithPlaceholder()
          ? _value.expiryDate
          // ignore: cast_nullable_to_non_nullable
          : expiryDate as String?,
      note: note == const $CopyWithPlaceholder()
          ? _value.note
          // ignore: cast_nullable_to_non_nullable
          : note as String?,
    );
  }
}

extension $DocumentVerifyBodyCopyWith on DocumentVerifyBody {
  /// Returns a callable class that can be used as follows: `instanceOfDocumentVerifyBody.copyWith(...)` or like so:`instanceOfDocumentVerifyBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DocumentVerifyBodyCWProxy get copyWith =>
      _$DocumentVerifyBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentVerifyBody _$DocumentVerifyBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DocumentVerifyBody', json, ($checkedConvert) {
      final val = DocumentVerifyBody(
        expiryDate: $checkedConvert('expiryDate', (v) => v as String?),
        note: $checkedConvert('note', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$DocumentVerifyBodyToJson(DocumentVerifyBody instance) =>
    <String, dynamic>{
      'expiryDate': ?instance.expiryDate,
      'note': ?instance.note,
    };
