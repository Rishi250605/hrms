// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'next_code_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NextCodeResponseCWProxy {
  NextCodeResponse empCode(String empCode);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NextCodeResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NextCodeResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  NextCodeResponse call({String empCode});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfNextCodeResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfNextCodeResponse.copyWith.fieldName(...)`
class _$NextCodeResponseCWProxyImpl implements _$NextCodeResponseCWProxy {
  const _$NextCodeResponseCWProxyImpl(this._value);

  final NextCodeResponse _value;

  @override
  NextCodeResponse empCode(String empCode) => this(empCode: empCode);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NextCodeResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NextCodeResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  NextCodeResponse call({Object? empCode = const $CopyWithPlaceholder()}) {
    return NextCodeResponse(
      empCode: empCode == const $CopyWithPlaceholder()
          ? _value.empCode
          // ignore: cast_nullable_to_non_nullable
          : empCode as String,
    );
  }
}

extension $NextCodeResponseCopyWith on NextCodeResponse {
  /// Returns a callable class that can be used as follows: `instanceOfNextCodeResponse.copyWith(...)` or like so:`instanceOfNextCodeResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$NextCodeResponseCWProxy get copyWith => _$NextCodeResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NextCodeResponse _$NextCodeResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('NextCodeResponse', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['empCode']);
      final val = NextCodeResponse(
        empCode: $checkedConvert('empCode', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$NextCodeResponseToJson(NextCodeResponse instance) =>
    <String, dynamic>{'empCode': instance.empCode};
