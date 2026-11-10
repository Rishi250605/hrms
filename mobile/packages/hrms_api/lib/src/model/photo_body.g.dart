// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PhotoBodyCWProxy {
  PhotoBody fileKey(String fileKey);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PhotoBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PhotoBody(...).copyWith(id: 12, name: "My name")
  /// ````
  PhotoBody call({String fileKey});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPhotoBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPhotoBody.copyWith.fieldName(...)`
class _$PhotoBodyCWProxyImpl implements _$PhotoBodyCWProxy {
  const _$PhotoBodyCWProxyImpl(this._value);

  final PhotoBody _value;

  @override
  PhotoBody fileKey(String fileKey) => this(fileKey: fileKey);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PhotoBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PhotoBody(...).copyWith(id: 12, name: "My name")
  /// ````
  PhotoBody call({Object? fileKey = const $CopyWithPlaceholder()}) {
    return PhotoBody(
      fileKey: fileKey == const $CopyWithPlaceholder()
          ? _value.fileKey
          // ignore: cast_nullable_to_non_nullable
          : fileKey as String,
    );
  }
}

extension $PhotoBodyCopyWith on PhotoBody {
  /// Returns a callable class that can be used as follows: `instanceOfPhotoBody.copyWith(...)` or like so:`instanceOfPhotoBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PhotoBodyCWProxy get copyWith => _$PhotoBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhotoBody _$PhotoBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PhotoBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['fileKey']);
      final val = PhotoBody(
        fileKey: $checkedConvert('fileKey', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$PhotoBodyToJson(PhotoBody instance) => <String, dynamic>{
  'fileKey': instance.fileKey,
};
