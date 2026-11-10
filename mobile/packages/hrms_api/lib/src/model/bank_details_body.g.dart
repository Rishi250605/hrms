// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_details_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BankDetailsBodyCWProxy {
  BankDetailsBody bankAccount(String bankAccount);

  BankDetailsBody ifsc(String ifsc);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BankDetailsBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BankDetailsBody(...).copyWith(id: 12, name: "My name")
  /// ````
  BankDetailsBody call({String bankAccount, String ifsc});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBankDetailsBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBankDetailsBody.copyWith.fieldName(...)`
class _$BankDetailsBodyCWProxyImpl implements _$BankDetailsBodyCWProxy {
  const _$BankDetailsBodyCWProxyImpl(this._value);

  final BankDetailsBody _value;

  @override
  BankDetailsBody bankAccount(String bankAccount) =>
      this(bankAccount: bankAccount);

  @override
  BankDetailsBody ifsc(String ifsc) => this(ifsc: ifsc);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BankDetailsBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BankDetailsBody(...).copyWith(id: 12, name: "My name")
  /// ````
  BankDetailsBody call({
    Object? bankAccount = const $CopyWithPlaceholder(),
    Object? ifsc = const $CopyWithPlaceholder(),
  }) {
    return BankDetailsBody(
      bankAccount: bankAccount == const $CopyWithPlaceholder()
          ? _value.bankAccount
          // ignore: cast_nullable_to_non_nullable
          : bankAccount as String,
      ifsc: ifsc == const $CopyWithPlaceholder()
          ? _value.ifsc
          // ignore: cast_nullable_to_non_nullable
          : ifsc as String,
    );
  }
}

extension $BankDetailsBodyCopyWith on BankDetailsBody {
  /// Returns a callable class that can be used as follows: `instanceOfBankDetailsBody.copyWith(...)` or like so:`instanceOfBankDetailsBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BankDetailsBodyCWProxy get copyWith => _$BankDetailsBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankDetailsBody _$BankDetailsBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('BankDetailsBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['bankAccount', 'ifsc']);
      final val = BankDetailsBody(
        bankAccount: $checkedConvert('bankAccount', (v) => v as String),
        ifsc: $checkedConvert('ifsc', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$BankDetailsBodyToJson(BankDetailsBody instance) =>
    <String, dynamic>{
      'bankAccount': instance.bankAccount,
      'ifsc': instance.ifsc,
    };
