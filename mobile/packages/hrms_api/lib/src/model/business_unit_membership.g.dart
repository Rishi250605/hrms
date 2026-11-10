// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_unit_membership.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BusinessUnitMembershipCWProxy {
  BusinessUnitMembership id(String id);

  BusinessUnitMembership code(String code);

  BusinessUnitMembership name(String name);

  BusinessUnitMembership isPrimary(bool isPrimary);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BusinessUnitMembership(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BusinessUnitMembership(...).copyWith(id: 12, name: "My name")
  /// ````
  BusinessUnitMembership call({
    String id,
    String code,
    String name,
    bool isPrimary,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBusinessUnitMembership.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBusinessUnitMembership.copyWith.fieldName(...)`
class _$BusinessUnitMembershipCWProxyImpl
    implements _$BusinessUnitMembershipCWProxy {
  const _$BusinessUnitMembershipCWProxyImpl(this._value);

  final BusinessUnitMembership _value;

  @override
  BusinessUnitMembership id(String id) => this(id: id);

  @override
  BusinessUnitMembership code(String code) => this(code: code);

  @override
  BusinessUnitMembership name(String name) => this(name: name);

  @override
  BusinessUnitMembership isPrimary(bool isPrimary) =>
      this(isPrimary: isPrimary);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BusinessUnitMembership(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BusinessUnitMembership(...).copyWith(id: 12, name: "My name")
  /// ````
  BusinessUnitMembership call({
    Object? id = const $CopyWithPlaceholder(),
    Object? code = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? isPrimary = const $CopyWithPlaceholder(),
  }) {
    return BusinessUnitMembership(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      code: code == const $CopyWithPlaceholder()
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      isPrimary: isPrimary == const $CopyWithPlaceholder()
          ? _value.isPrimary
          // ignore: cast_nullable_to_non_nullable
          : isPrimary as bool,
    );
  }
}

extension $BusinessUnitMembershipCopyWith on BusinessUnitMembership {
  /// Returns a callable class that can be used as follows: `instanceOfBusinessUnitMembership.copyWith(...)` or like so:`instanceOfBusinessUnitMembership.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BusinessUnitMembershipCWProxy get copyWith =>
      _$BusinessUnitMembershipCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessUnitMembership _$BusinessUnitMembershipFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BusinessUnitMembership', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['id', 'code', 'name', 'isPrimary']);
  final val = BusinessUnitMembership(
    id: $checkedConvert('id', (v) => v as String),
    code: $checkedConvert('code', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    isPrimary: $checkedConvert('isPrimary', (v) => v as bool),
  );
  return val;
});

Map<String, dynamic> _$BusinessUnitMembershipToJson(
  BusinessUnitMembership instance,
) => <String, dynamic>{
  'id': instance.id,
  'code': instance.code,
  'name': instance.name,
  'isPrimary': instance.isPrimary,
};
