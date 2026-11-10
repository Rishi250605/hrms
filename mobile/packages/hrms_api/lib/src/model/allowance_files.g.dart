// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allowance_files.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AllowanceFilesCWProxy {
  AllowanceFiles voiceNote(SignedUrlResponse? voiceNote);

  AllowanceFiles receipt(SignedUrlResponse? receipt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AllowanceFiles(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AllowanceFiles(...).copyWith(id: 12, name: "My name")
  /// ````
  AllowanceFiles call({
    SignedUrlResponse? voiceNote,
    SignedUrlResponse? receipt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAllowanceFiles.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAllowanceFiles.copyWith.fieldName(...)`
class _$AllowanceFilesCWProxyImpl implements _$AllowanceFilesCWProxy {
  const _$AllowanceFilesCWProxyImpl(this._value);

  final AllowanceFiles _value;

  @override
  AllowanceFiles voiceNote(SignedUrlResponse? voiceNote) =>
      this(voiceNote: voiceNote);

  @override
  AllowanceFiles receipt(SignedUrlResponse? receipt) => this(receipt: receipt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AllowanceFiles(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AllowanceFiles(...).copyWith(id: 12, name: "My name")
  /// ````
  AllowanceFiles call({
    Object? voiceNote = const $CopyWithPlaceholder(),
    Object? receipt = const $CopyWithPlaceholder(),
  }) {
    return AllowanceFiles(
      voiceNote: voiceNote == const $CopyWithPlaceholder()
          ? _value.voiceNote
          // ignore: cast_nullable_to_non_nullable
          : voiceNote as SignedUrlResponse?,
      receipt: receipt == const $CopyWithPlaceholder()
          ? _value.receipt
          // ignore: cast_nullable_to_non_nullable
          : receipt as SignedUrlResponse?,
    );
  }
}

extension $AllowanceFilesCopyWith on AllowanceFiles {
  /// Returns a callable class that can be used as follows: `instanceOfAllowanceFiles.copyWith(...)` or like so:`instanceOfAllowanceFiles.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AllowanceFilesCWProxy get copyWith => _$AllowanceFilesCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllowanceFiles _$AllowanceFilesFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AllowanceFiles', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['voiceNote', 'receipt']);
      final val = AllowanceFiles(
        voiceNote: $checkedConvert(
          'voiceNote',
          (v) => v == null
              ? null
              : SignedUrlResponse.fromJson(v as Map<String, dynamic>),
        ),
        receipt: $checkedConvert(
          'receipt',
          (v) => v == null
              ? null
              : SignedUrlResponse.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$AllowanceFilesToJson(AllowanceFiles instance) =>
    <String, dynamic>{
      'voiceNote': instance.voiceNote?.toJson(),
      'receipt': instance.receipt?.toJson(),
    };
