// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payslip_upload_result_invalid_inner.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PayslipUploadResultInvalidInnerCWProxy {
  PayslipUploadResultInvalidInner fileName(String fileName);

  PayslipUploadResultInvalidInner reason(
    PayslipUploadResultInvalidInnerReasonEnum reason,
  );

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PayslipUploadResultInvalidInner(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PayslipUploadResultInvalidInner(...).copyWith(id: 12, name: "My name")
  /// ````
  PayslipUploadResultInvalidInner call({
    String fileName,
    PayslipUploadResultInvalidInnerReasonEnum reason,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPayslipUploadResultInvalidInner.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPayslipUploadResultInvalidInner.copyWith.fieldName(...)`
class _$PayslipUploadResultInvalidInnerCWProxyImpl
    implements _$PayslipUploadResultInvalidInnerCWProxy {
  const _$PayslipUploadResultInvalidInnerCWProxyImpl(this._value);

  final PayslipUploadResultInvalidInner _value;

  @override
  PayslipUploadResultInvalidInner fileName(String fileName) =>
      this(fileName: fileName);

  @override
  PayslipUploadResultInvalidInner reason(
    PayslipUploadResultInvalidInnerReasonEnum reason,
  ) => this(reason: reason);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PayslipUploadResultInvalidInner(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PayslipUploadResultInvalidInner(...).copyWith(id: 12, name: "My name")
  /// ````
  PayslipUploadResultInvalidInner call({
    Object? fileName = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
  }) {
    return PayslipUploadResultInvalidInner(
      fileName: fileName == const $CopyWithPlaceholder()
          ? _value.fileName
          // ignore: cast_nullable_to_non_nullable
          : fileName as String,
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as PayslipUploadResultInvalidInnerReasonEnum,
    );
  }
}

extension $PayslipUploadResultInvalidInnerCopyWith
    on PayslipUploadResultInvalidInner {
  /// Returns a callable class that can be used as follows: `instanceOfPayslipUploadResultInvalidInner.copyWith(...)` or like so:`instanceOfPayslipUploadResultInvalidInner.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PayslipUploadResultInvalidInnerCWProxy get copyWith =>
      _$PayslipUploadResultInvalidInnerCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayslipUploadResultInvalidInner _$PayslipUploadResultInvalidInnerFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('PayslipUploadResultInvalidInner', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['fileName', 'reason']);
  final val = PayslipUploadResultInvalidInner(
    fileName: $checkedConvert('fileName', (v) => v as String),
    reason: $checkedConvert(
      'reason',
      (v) => $enumDecode(_$PayslipUploadResultInvalidInnerReasonEnumEnumMap, v),
    ),
  );
  return val;
});

Map<String, dynamic> _$PayslipUploadResultInvalidInnerToJson(
  PayslipUploadResultInvalidInner instance,
) => <String, dynamic>{
  'fileName': instance.fileName,
  'reason':
      _$PayslipUploadResultInvalidInnerReasonEnumEnumMap[instance.reason]!,
};

const _$PayslipUploadResultInvalidInnerReasonEnumEnumMap = {
  PayslipUploadResultInvalidInnerReasonEnum.NAME_FORMAT: 'NAME_FORMAT',
  PayslipUploadResultInvalidInnerReasonEnum.NOT_PDF: 'NOT_PDF',
  PayslipUploadResultInvalidInnerReasonEnum.TOO_LARGE: 'TOO_LARGE',
  PayslipUploadResultInvalidInnerReasonEnum.EMPTY: 'EMPTY',
};
