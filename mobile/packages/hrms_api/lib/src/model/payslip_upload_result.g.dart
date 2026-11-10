// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payslip_upload_result.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PayslipUploadResultCWProxy {
  PayslipUploadResult period(String period);

  PayslipUploadResult matched(List<PayslipUploadMatch> matched);

  PayslipUploadResult replaced(List<PayslipUploadMatch> replaced);

  PayslipUploadResult unmatched(List<String> unmatched);

  PayslipUploadResult invalid(List<PayslipUploadResultInvalidInner> invalid);

  PayslipUploadResult duplicates(List<String> duplicates);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PayslipUploadResult(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PayslipUploadResult(...).copyWith(id: 12, name: "My name")
  /// ````
  PayslipUploadResult call({
    String period,
    List<PayslipUploadMatch> matched,
    List<PayslipUploadMatch> replaced,
    List<String> unmatched,
    List<PayslipUploadResultInvalidInner> invalid,
    List<String> duplicates,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPayslipUploadResult.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPayslipUploadResult.copyWith.fieldName(...)`
class _$PayslipUploadResultCWProxyImpl implements _$PayslipUploadResultCWProxy {
  const _$PayslipUploadResultCWProxyImpl(this._value);

  final PayslipUploadResult _value;

  @override
  PayslipUploadResult period(String period) => this(period: period);

  @override
  PayslipUploadResult matched(List<PayslipUploadMatch> matched) =>
      this(matched: matched);

  @override
  PayslipUploadResult replaced(List<PayslipUploadMatch> replaced) =>
      this(replaced: replaced);

  @override
  PayslipUploadResult unmatched(List<String> unmatched) =>
      this(unmatched: unmatched);

  @override
  PayslipUploadResult invalid(List<PayslipUploadResultInvalidInner> invalid) =>
      this(invalid: invalid);

  @override
  PayslipUploadResult duplicates(List<String> duplicates) =>
      this(duplicates: duplicates);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PayslipUploadResult(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PayslipUploadResult(...).copyWith(id: 12, name: "My name")
  /// ````
  PayslipUploadResult call({
    Object? period = const $CopyWithPlaceholder(),
    Object? matched = const $CopyWithPlaceholder(),
    Object? replaced = const $CopyWithPlaceholder(),
    Object? unmatched = const $CopyWithPlaceholder(),
    Object? invalid = const $CopyWithPlaceholder(),
    Object? duplicates = const $CopyWithPlaceholder(),
  }) {
    return PayslipUploadResult(
      period: period == const $CopyWithPlaceholder()
          ? _value.period
          // ignore: cast_nullable_to_non_nullable
          : period as String,
      matched: matched == const $CopyWithPlaceholder()
          ? _value.matched
          // ignore: cast_nullable_to_non_nullable
          : matched as List<PayslipUploadMatch>,
      replaced: replaced == const $CopyWithPlaceholder()
          ? _value.replaced
          // ignore: cast_nullable_to_non_nullable
          : replaced as List<PayslipUploadMatch>,
      unmatched: unmatched == const $CopyWithPlaceholder()
          ? _value.unmatched
          // ignore: cast_nullable_to_non_nullable
          : unmatched as List<String>,
      invalid: invalid == const $CopyWithPlaceholder()
          ? _value.invalid
          // ignore: cast_nullable_to_non_nullable
          : invalid as List<PayslipUploadResultInvalidInner>,
      duplicates: duplicates == const $CopyWithPlaceholder()
          ? _value.duplicates
          // ignore: cast_nullable_to_non_nullable
          : duplicates as List<String>,
    );
  }
}

extension $PayslipUploadResultCopyWith on PayslipUploadResult {
  /// Returns a callable class that can be used as follows: `instanceOfPayslipUploadResult.copyWith(...)` or like so:`instanceOfPayslipUploadResult.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PayslipUploadResultCWProxy get copyWith =>
      _$PayslipUploadResultCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayslipUploadResult _$PayslipUploadResultFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('PayslipUploadResult', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'period',
      'matched',
      'replaced',
      'unmatched',
      'invalid',
      'duplicates',
    ],
  );
  final val = PayslipUploadResult(
    period: $checkedConvert('period', (v) => v as String),
    matched: $checkedConvert(
      'matched',
      (v) => (v as List<dynamic>)
          .map((e) => PayslipUploadMatch.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    replaced: $checkedConvert(
      'replaced',
      (v) => (v as List<dynamic>)
          .map((e) => PayslipUploadMatch.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    unmatched: $checkedConvert(
      'unmatched',
      (v) => (v as List<dynamic>).map((e) => e as String).toList(),
    ),
    invalid: $checkedConvert(
      'invalid',
      (v) => (v as List<dynamic>)
          .map(
            (e) => PayslipUploadResultInvalidInner.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
    ),
    duplicates: $checkedConvert(
      'duplicates',
      (v) => (v as List<dynamic>).map((e) => e as String).toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$PayslipUploadResultToJson(
  PayslipUploadResult instance,
) => <String, dynamic>{
  'period': instance.period,
  'matched': instance.matched.map((e) => e.toJson()).toList(),
  'replaced': instance.replaced.map((e) => e.toJson()).toList(),
  'unmatched': instance.unmatched,
  'invalid': instance.invalid.map((e) => e.toJson()).toList(),
  'duplicates': instance.duplicates,
};
