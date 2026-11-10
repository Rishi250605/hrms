// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'presign_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PresignBodyCWProxy {
  PresignBody employeeId(String? employeeId);

  PresignBody purpose(PresignBodyPurposeEnum purpose);

  PresignBody contentType(PresignBodyContentTypeEnum contentType);

  PresignBody sizeBytes(int sizeBytes);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PresignBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PresignBody(...).copyWith(id: 12, name: "My name")
  /// ````
  PresignBody call({
    String? employeeId,
    PresignBodyPurposeEnum purpose,
    PresignBodyContentTypeEnum contentType,
    int sizeBytes,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPresignBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPresignBody.copyWith.fieldName(...)`
class _$PresignBodyCWProxyImpl implements _$PresignBodyCWProxy {
  const _$PresignBodyCWProxyImpl(this._value);

  final PresignBody _value;

  @override
  PresignBody employeeId(String? employeeId) => this(employeeId: employeeId);

  @override
  PresignBody purpose(PresignBodyPurposeEnum purpose) => this(purpose: purpose);

  @override
  PresignBody contentType(PresignBodyContentTypeEnum contentType) =>
      this(contentType: contentType);

  @override
  PresignBody sizeBytes(int sizeBytes) => this(sizeBytes: sizeBytes);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PresignBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PresignBody(...).copyWith(id: 12, name: "My name")
  /// ````
  PresignBody call({
    Object? employeeId = const $CopyWithPlaceholder(),
    Object? purpose = const $CopyWithPlaceholder(),
    Object? contentType = const $CopyWithPlaceholder(),
    Object? sizeBytes = const $CopyWithPlaceholder(),
  }) {
    return PresignBody(
      employeeId: employeeId == const $CopyWithPlaceholder()
          ? _value.employeeId
          // ignore: cast_nullable_to_non_nullable
          : employeeId as String?,
      purpose: purpose == const $CopyWithPlaceholder()
          ? _value.purpose
          // ignore: cast_nullable_to_non_nullable
          : purpose as PresignBodyPurposeEnum,
      contentType: contentType == const $CopyWithPlaceholder()
          ? _value.contentType
          // ignore: cast_nullable_to_non_nullable
          : contentType as PresignBodyContentTypeEnum,
      sizeBytes: sizeBytes == const $CopyWithPlaceholder()
          ? _value.sizeBytes
          // ignore: cast_nullable_to_non_nullable
          : sizeBytes as int,
    );
  }
}

extension $PresignBodyCopyWith on PresignBody {
  /// Returns a callable class that can be used as follows: `instanceOfPresignBody.copyWith(...)` or like so:`instanceOfPresignBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PresignBodyCWProxy get copyWith => _$PresignBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PresignBody _$PresignBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PresignBody', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['purpose', 'contentType', 'sizeBytes'],
      );
      final val = PresignBody(
        employeeId: $checkedConvert('employeeId', (v) => v as String?),
        purpose: $checkedConvert(
          'purpose',
          (v) => $enumDecode(_$PresignBodyPurposeEnumEnumMap, v),
        ),
        contentType: $checkedConvert(
          'contentType',
          (v) => $enumDecode(_$PresignBodyContentTypeEnumEnumMap, v),
        ),
        sizeBytes: $checkedConvert('sizeBytes', (v) => (v as num).toInt()),
      );
      return val;
    });

Map<String, dynamic> _$PresignBodyToJson(PresignBody instance) =>
    <String, dynamic>{
      'employeeId': ?instance.employeeId,
      'purpose': _$PresignBodyPurposeEnumEnumMap[instance.purpose]!,
      'contentType': _$PresignBodyContentTypeEnumEnumMap[instance.contentType]!,
      'sizeBytes': instance.sizeBytes,
    };

const _$PresignBodyPurposeEnumEnumMap = {
  PresignBodyPurposeEnum.DOCUMENT: 'DOCUMENT',
  PresignBodyPurposeEnum.PHOTO: 'PHOTO',
  PresignBodyPurposeEnum.VOICE_NOTE: 'VOICE_NOTE',
  PresignBodyPurposeEnum.RECEIPT: 'RECEIPT',
};

const _$PresignBodyContentTypeEnumEnumMap = {
  PresignBodyContentTypeEnum.imageSlashJpeg: 'image/jpeg',
  PresignBodyContentTypeEnum.imageSlashPng: 'image/png',
  PresignBodyContentTypeEnum.imageSlashWebp: 'image/webp',
  PresignBodyContentTypeEnum.applicationSlashPdf: 'application/pdf',
  PresignBodyContentTypeEnum.audioSlashMp4: 'audio/mp4',
  PresignBodyContentTypeEnum.audioSlashAac: 'audio/aac',
  PresignBodyContentTypeEnum.audioSlashM4a: 'audio/m4a',
  PresignBodyContentTypeEnum.audioSlashXM4a: 'audio/x-m4a',
};
