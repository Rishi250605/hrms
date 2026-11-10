// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_unit_update_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BusinessUnitUpdateBodyCWProxy {
  BusinessUnitUpdateBody name(String? name);

  BusinessUnitUpdateBody code(String? code);

  BusinessUnitUpdateBody isActive(bool? isActive);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BusinessUnitUpdateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BusinessUnitUpdateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  BusinessUnitUpdateBody call({String? name, String? code, bool? isActive});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBusinessUnitUpdateBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBusinessUnitUpdateBody.copyWith.fieldName(...)`
class _$BusinessUnitUpdateBodyCWProxyImpl
    implements _$BusinessUnitUpdateBodyCWProxy {
  const _$BusinessUnitUpdateBodyCWProxyImpl(this._value);

  final BusinessUnitUpdateBody _value;

  @override
  BusinessUnitUpdateBody name(String? name) => this(name: name);

  @override
  BusinessUnitUpdateBody code(String? code) => this(code: code);

  @override
  BusinessUnitUpdateBody isActive(bool? isActive) => this(isActive: isActive);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BusinessUnitUpdateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BusinessUnitUpdateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  BusinessUnitUpdateBody call({
    Object? name = const $CopyWithPlaceholder(),
    Object? code = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
  }) {
    return BusinessUnitUpdateBody(
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      code: code == const $CopyWithPlaceholder()
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String?,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool?,
    );
  }
}

extension $BusinessUnitUpdateBodyCopyWith on BusinessUnitUpdateBody {
  /// Returns a callable class that can be used as follows: `instanceOfBusinessUnitUpdateBody.copyWith(...)` or like so:`instanceOfBusinessUnitUpdateBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BusinessUnitUpdateBodyCWProxy get copyWith =>
      _$BusinessUnitUpdateBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessUnitUpdateBody _$BusinessUnitUpdateBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BusinessUnitUpdateBody', json, ($checkedConvert) {
  final val = BusinessUnitUpdateBody(
    name: $checkedConvert('name', (v) => v as String?),
    code: $checkedConvert('code', (v) => v as String?),
    isActive: $checkedConvert('isActive', (v) => v as bool?),
  );
  return val;
});

Map<String, dynamic> _$BusinessUnitUpdateBodyToJson(
  BusinessUnitUpdateBody instance,
) => <String, dynamic>{
  'name': ?instance.name,
  'code': ?instance.code,
  'isActive': ?instance.isActive,
};
