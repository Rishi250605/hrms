// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payslip_version_list_items_inner.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PayslipVersionListItemsInnerCWProxy {
  PayslipVersionListItemsInner version(int version);

  PayslipVersionListItemsInner sizeBytes(int sizeBytes);

  PayslipVersionListItemsInner originalName(String originalName);

  PayslipVersionListItemsInner uploadedByName(String? uploadedByName);

  PayslipVersionListItemsInner uploadedAt(DateTime uploadedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PayslipVersionListItemsInner(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PayslipVersionListItemsInner(...).copyWith(id: 12, name: "My name")
  /// ````
  PayslipVersionListItemsInner call({
    int version,
    int sizeBytes,
    String originalName,
    String? uploadedByName,
    DateTime uploadedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPayslipVersionListItemsInner.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPayslipVersionListItemsInner.copyWith.fieldName(...)`
class _$PayslipVersionListItemsInnerCWProxyImpl
    implements _$PayslipVersionListItemsInnerCWProxy {
  const _$PayslipVersionListItemsInnerCWProxyImpl(this._value);

  final PayslipVersionListItemsInner _value;

  @override
  PayslipVersionListItemsInner version(int version) => this(version: version);

  @override
  PayslipVersionListItemsInner sizeBytes(int sizeBytes) =>
      this(sizeBytes: sizeBytes);

  @override
  PayslipVersionListItemsInner originalName(String originalName) =>
      this(originalName: originalName);

  @override
  PayslipVersionListItemsInner uploadedByName(String? uploadedByName) =>
      this(uploadedByName: uploadedByName);

  @override
  PayslipVersionListItemsInner uploadedAt(DateTime uploadedAt) =>
      this(uploadedAt: uploadedAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PayslipVersionListItemsInner(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PayslipVersionListItemsInner(...).copyWith(id: 12, name: "My name")
  /// ````
  PayslipVersionListItemsInner call({
    Object? version = const $CopyWithPlaceholder(),
    Object? sizeBytes = const $CopyWithPlaceholder(),
    Object? originalName = const $CopyWithPlaceholder(),
    Object? uploadedByName = const $CopyWithPlaceholder(),
    Object? uploadedAt = const $CopyWithPlaceholder(),
  }) {
    return PayslipVersionListItemsInner(
      version: version == const $CopyWithPlaceholder()
          ? _value.version
          // ignore: cast_nullable_to_non_nullable
          : version as int,
      sizeBytes: sizeBytes == const $CopyWithPlaceholder()
          ? _value.sizeBytes
          // ignore: cast_nullable_to_non_nullable
          : sizeBytes as int,
      originalName: originalName == const $CopyWithPlaceholder()
          ? _value.originalName
          // ignore: cast_nullable_to_non_nullable
          : originalName as String,
      uploadedByName: uploadedByName == const $CopyWithPlaceholder()
          ? _value.uploadedByName
          // ignore: cast_nullable_to_non_nullable
          : uploadedByName as String?,
      uploadedAt: uploadedAt == const $CopyWithPlaceholder()
          ? _value.uploadedAt
          // ignore: cast_nullable_to_non_nullable
          : uploadedAt as DateTime,
    );
  }
}

extension $PayslipVersionListItemsInnerCopyWith
    on PayslipVersionListItemsInner {
  /// Returns a callable class that can be used as follows: `instanceOfPayslipVersionListItemsInner.copyWith(...)` or like so:`instanceOfPayslipVersionListItemsInner.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PayslipVersionListItemsInnerCWProxy get copyWith =>
      _$PayslipVersionListItemsInnerCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayslipVersionListItemsInner _$PayslipVersionListItemsInnerFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('PayslipVersionListItemsInner', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'version',
      'sizeBytes',
      'originalName',
      'uploadedByName',
      'uploadedAt',
    ],
  );
  final val = PayslipVersionListItemsInner(
    version: $checkedConvert('version', (v) => (v as num).toInt()),
    sizeBytes: $checkedConvert('sizeBytes', (v) => (v as num).toInt()),
    originalName: $checkedConvert('originalName', (v) => v as String),
    uploadedByName: $checkedConvert('uploadedByName', (v) => v as String?),
    uploadedAt: $checkedConvert(
      'uploadedAt',
      (v) => DateTime.parse(v as String),
    ),
  );
  return val;
});

Map<String, dynamic> _$PayslipVersionListItemsInnerToJson(
  PayslipVersionListItemsInner instance,
) => <String, dynamic>{
  'version': instance.version,
  'sizeBytes': instance.sizeBytes,
  'originalName': instance.originalName,
  'uploadedByName': instance.uploadedByName,
  'uploadedAt': instance.uploadedAt.toIso8601String(),
};
