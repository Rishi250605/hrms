// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allowance_type_update_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AllowanceTypeUpdateBodyCWProxy {
  AllowanceTypeUpdateBody name(String? name);

  AllowanceTypeUpdateBody maxAmountPaise(int? maxAmountPaise);

  AllowanceTypeUpdateBody isActive(bool? isActive);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AllowanceTypeUpdateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AllowanceTypeUpdateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  AllowanceTypeUpdateBody call({
    String? name,
    int? maxAmountPaise,
    bool? isActive,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAllowanceTypeUpdateBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAllowanceTypeUpdateBody.copyWith.fieldName(...)`
class _$AllowanceTypeUpdateBodyCWProxyImpl
    implements _$AllowanceTypeUpdateBodyCWProxy {
  const _$AllowanceTypeUpdateBodyCWProxyImpl(this._value);

  final AllowanceTypeUpdateBody _value;

  @override
  AllowanceTypeUpdateBody name(String? name) => this(name: name);

  @override
  AllowanceTypeUpdateBody maxAmountPaise(int? maxAmountPaise) =>
      this(maxAmountPaise: maxAmountPaise);

  @override
  AllowanceTypeUpdateBody isActive(bool? isActive) => this(isActive: isActive);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AllowanceTypeUpdateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AllowanceTypeUpdateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  AllowanceTypeUpdateBody call({
    Object? name = const $CopyWithPlaceholder(),
    Object? maxAmountPaise = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
  }) {
    return AllowanceTypeUpdateBody(
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      maxAmountPaise: maxAmountPaise == const $CopyWithPlaceholder()
          ? _value.maxAmountPaise
          // ignore: cast_nullable_to_non_nullable
          : maxAmountPaise as int?,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool?,
    );
  }
}

extension $AllowanceTypeUpdateBodyCopyWith on AllowanceTypeUpdateBody {
  /// Returns a callable class that can be used as follows: `instanceOfAllowanceTypeUpdateBody.copyWith(...)` or like so:`instanceOfAllowanceTypeUpdateBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AllowanceTypeUpdateBodyCWProxy get copyWith =>
      _$AllowanceTypeUpdateBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllowanceTypeUpdateBody _$AllowanceTypeUpdateBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AllowanceTypeUpdateBody', json, ($checkedConvert) {
  final val = AllowanceTypeUpdateBody(
    name: $checkedConvert('name', (v) => v as String?),
    maxAmountPaise: $checkedConvert(
      'maxAmountPaise',
      (v) => (v as num?)?.toInt(),
    ),
    isActive: $checkedConvert('isActive', (v) => v as bool?),
  );
  return val;
});

Map<String, dynamic> _$AllowanceTypeUpdateBodyToJson(
  AllowanceTypeUpdateBody instance,
) => <String, dynamic>{
  'name': ?instance.name,
  'maxAmountPaise': ?instance.maxAmountPaise,
  'isActive': ?instance.isActive,
};
