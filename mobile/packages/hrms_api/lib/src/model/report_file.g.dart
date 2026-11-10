// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_file.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReportFileCWProxy {
  ReportFile url(String url);

  ReportFile method(ReportFileMethodEnum method);

  ReportFile headers(Map<String, String> headers);

  ReportFile expiresAt(DateTime expiresAt);

  ReportFile fileName(String fileName);

  ReportFile contentType(String contentType);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReportFile(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReportFile(...).copyWith(id: 12, name: "My name")
  /// ````
  ReportFile call({
    String url,
    ReportFileMethodEnum method,
    Map<String, String> headers,
    DateTime expiresAt,
    String fileName,
    String contentType,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfReportFile.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfReportFile.copyWith.fieldName(...)`
class _$ReportFileCWProxyImpl implements _$ReportFileCWProxy {
  const _$ReportFileCWProxyImpl(this._value);

  final ReportFile _value;

  @override
  ReportFile url(String url) => this(url: url);

  @override
  ReportFile method(ReportFileMethodEnum method) => this(method: method);

  @override
  ReportFile headers(Map<String, String> headers) => this(headers: headers);

  @override
  ReportFile expiresAt(DateTime expiresAt) => this(expiresAt: expiresAt);

  @override
  ReportFile fileName(String fileName) => this(fileName: fileName);

  @override
  ReportFile contentType(String contentType) => this(contentType: contentType);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReportFile(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReportFile(...).copyWith(id: 12, name: "My name")
  /// ````
  ReportFile call({
    Object? url = const $CopyWithPlaceholder(),
    Object? method = const $CopyWithPlaceholder(),
    Object? headers = const $CopyWithPlaceholder(),
    Object? expiresAt = const $CopyWithPlaceholder(),
    Object? fileName = const $CopyWithPlaceholder(),
    Object? contentType = const $CopyWithPlaceholder(),
  }) {
    return ReportFile(
      url: url == const $CopyWithPlaceholder()
          ? _value.url
          // ignore: cast_nullable_to_non_nullable
          : url as String,
      method: method == const $CopyWithPlaceholder()
          ? _value.method
          // ignore: cast_nullable_to_non_nullable
          : method as ReportFileMethodEnum,
      headers: headers == const $CopyWithPlaceholder()
          ? _value.headers
          // ignore: cast_nullable_to_non_nullable
          : headers as Map<String, String>,
      expiresAt: expiresAt == const $CopyWithPlaceholder()
          ? _value.expiresAt
          // ignore: cast_nullable_to_non_nullable
          : expiresAt as DateTime,
      fileName: fileName == const $CopyWithPlaceholder()
          ? _value.fileName
          // ignore: cast_nullable_to_non_nullable
          : fileName as String,
      contentType: contentType == const $CopyWithPlaceholder()
          ? _value.contentType
          // ignore: cast_nullable_to_non_nullable
          : contentType as String,
    );
  }
}

extension $ReportFileCopyWith on ReportFile {
  /// Returns a callable class that can be used as follows: `instanceOfReportFile.copyWith(...)` or like so:`instanceOfReportFile.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReportFileCWProxy get copyWith => _$ReportFileCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportFile _$ReportFileFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ReportFile', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'url',
          'method',
          'headers',
          'expiresAt',
          'fileName',
          'contentType',
        ],
      );
      final val = ReportFile(
        url: $checkedConvert('url', (v) => v as String),
        method: $checkedConvert(
          'method',
          (v) => $enumDecode(_$ReportFileMethodEnumEnumMap, v),
        ),
        headers: $checkedConvert(
          'headers',
          (v) => Map<String, String>.from(v as Map),
        ),
        expiresAt: $checkedConvert(
          'expiresAt',
          (v) => DateTime.parse(v as String),
        ),
        fileName: $checkedConvert('fileName', (v) => v as String),
        contentType: $checkedConvert('contentType', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$ReportFileToJson(ReportFile instance) =>
    <String, dynamic>{
      'url': instance.url,
      'method': _$ReportFileMethodEnumEnumMap[instance.method]!,
      'headers': instance.headers,
      'expiresAt': instance.expiresAt.toIso8601String(),
      'fileName': instance.fileName,
      'contentType': instance.contentType,
    };

const _$ReportFileMethodEnumEnumMap = {
  ReportFileMethodEnum.GET: 'GET',
  ReportFileMethodEnum.PUT: 'PUT',
};
