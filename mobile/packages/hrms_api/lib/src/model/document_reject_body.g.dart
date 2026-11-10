// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_reject_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DocumentRejectBodyCWProxy {
  DocumentRejectBody reason(String reason);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DocumentRejectBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DocumentRejectBody(...).copyWith(id: 12, name: "My name")
  /// ````
  DocumentRejectBody call({String reason});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDocumentRejectBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDocumentRejectBody.copyWith.fieldName(...)`
class _$DocumentRejectBodyCWProxyImpl implements _$DocumentRejectBodyCWProxy {
  const _$DocumentRejectBodyCWProxyImpl(this._value);

  final DocumentRejectBody _value;

  @override
  DocumentRejectBody reason(String reason) => this(reason: reason);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DocumentRejectBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DocumentRejectBody(...).copyWith(id: 12, name: "My name")
  /// ````
  DocumentRejectBody call({Object? reason = const $CopyWithPlaceholder()}) {
    return DocumentRejectBody(
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String,
    );
  }
}

extension $DocumentRejectBodyCopyWith on DocumentRejectBody {
  /// Returns a callable class that can be used as follows: `instanceOfDocumentRejectBody.copyWith(...)` or like so:`instanceOfDocumentRejectBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DocumentRejectBodyCWProxy get copyWith =>
      _$DocumentRejectBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentRejectBody _$DocumentRejectBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DocumentRejectBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['reason']);
      final val = DocumentRejectBody(
        reason: $checkedConvert('reason', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$DocumentRejectBodyToJson(DocumentRejectBody instance) =>
    <String, dynamic>{'reason': instance.reason};
