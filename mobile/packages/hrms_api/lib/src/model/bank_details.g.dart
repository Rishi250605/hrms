// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_details.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BankDetailsCWProxy {
  BankDetails accountMasked(String? accountMasked);

  BankDetails ifsc(String? ifsc);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BankDetails(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BankDetails(...).copyWith(id: 12, name: "My name")
  /// ````
  BankDetails call({String? accountMasked, String? ifsc});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBankDetails.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBankDetails.copyWith.fieldName(...)`
class _$BankDetailsCWProxyImpl implements _$BankDetailsCWProxy {
  const _$BankDetailsCWProxyImpl(this._value);

  final BankDetails _value;

  @override
  BankDetails accountMasked(String? accountMasked) =>
      this(accountMasked: accountMasked);

  @override
  BankDetails ifsc(String? ifsc) => this(ifsc: ifsc);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BankDetails(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BankDetails(...).copyWith(id: 12, name: "My name")
  /// ````
  BankDetails call({
    Object? accountMasked = const $CopyWithPlaceholder(),
    Object? ifsc = const $CopyWithPlaceholder(),
  }) {
    return BankDetails(
      accountMasked: accountMasked == const $CopyWithPlaceholder()
          ? _value.accountMasked
          // ignore: cast_nullable_to_non_nullable
          : accountMasked as String?,
      ifsc: ifsc == const $CopyWithPlaceholder()
          ? _value.ifsc
          // ignore: cast_nullable_to_non_nullable
          : ifsc as String?,
    );
  }
}

extension $BankDetailsCopyWith on BankDetails {
  /// Returns a callable class that can be used as follows: `instanceOfBankDetails.copyWith(...)` or like so:`instanceOfBankDetails.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BankDetailsCWProxy get copyWith => _$BankDetailsCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankDetails _$BankDetailsFromJson(Map<String, dynamic> json) =>
    $checkedCreate('BankDetails', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['accountMasked', 'ifsc']);
      final val = BankDetails(
        accountMasked: $checkedConvert('accountMasked', (v) => v as String?),
        ifsc: $checkedConvert('ifsc', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$BankDetailsToJson(BankDetails instance) =>
    <String, dynamic>{
      'accountMasked': instance.accountMasked,
      'ifsc': instance.ifsc,
    };
