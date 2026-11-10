// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allowance_type_create_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AllowanceTypeCreateBodyCWProxy {
  AllowanceTypeCreateBody code(String code);

  AllowanceTypeCreateBody name(String name);

  AllowanceTypeCreateBody maxAmountPaise(int? maxAmountPaise);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AllowanceTypeCreateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AllowanceTypeCreateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  AllowanceTypeCreateBody call({String code, String name, int? maxAmountPaise});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAllowanceTypeCreateBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAllowanceTypeCreateBody.copyWith.fieldName(...)`
class _$AllowanceTypeCreateBodyCWProxyImpl
    implements _$AllowanceTypeCreateBodyCWProxy {
  const _$AllowanceTypeCreateBodyCWProxyImpl(this._value);

  final AllowanceTypeCreateBody _value;

  @override
  AllowanceTypeCreateBody code(String code) => this(code: code);

  @override
  AllowanceTypeCreateBody name(String name) => this(name: name);

  @override
  AllowanceTypeCreateBody maxAmountPaise(int? maxAmountPaise) =>
      this(maxAmountPaise: maxAmountPaise);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AllowanceTypeCreateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AllowanceTypeCreateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  AllowanceTypeCreateBody call({
    Object? code = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? maxAmountPaise = const $CopyWithPlaceholder(),
  }) {
    return AllowanceTypeCreateBody(
      code: code == const $CopyWithPlaceholder()
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      maxAmountPaise: maxAmountPaise == const $CopyWithPlaceholder()
          ? _value.maxAmountPaise
          // ignore: cast_nullable_to_non_nullable
          : maxAmountPaise as int?,
    );
  }
}

extension $AllowanceTypeCreateBodyCopyWith on AllowanceTypeCreateBody {
  /// Returns a callable class that can be used as follows: `instanceOfAllowanceTypeCreateBody.copyWith(...)` or like so:`instanceOfAllowanceTypeCreateBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AllowanceTypeCreateBodyCWProxy get copyWith =>
      _$AllowanceTypeCreateBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllowanceTypeCreateBody _$AllowanceTypeCreateBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AllowanceTypeCreateBody', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['code', 'name']);
  final val = AllowanceTypeCreateBody(
    code: $checkedConvert('code', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    maxAmountPaise: $checkedConvert(
      'maxAmountPaise',
      (v) => (v as num?)?.toInt(),
    ),
  );
  return val;
});

Map<String, dynamic> _$AllowanceTypeCreateBodyToJson(
  AllowanceTypeCreateBody instance,
) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'maxAmountPaise': ?instance.maxAmountPaise,
};
