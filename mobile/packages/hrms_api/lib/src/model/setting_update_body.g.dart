// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_update_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SettingUpdateBodyCWProxy {
  SettingUpdateBody value(Object? value);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SettingUpdateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SettingUpdateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  SettingUpdateBody call({Object? value});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSettingUpdateBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSettingUpdateBody.copyWith.fieldName(...)`
class _$SettingUpdateBodyCWProxyImpl implements _$SettingUpdateBodyCWProxy {
  const _$SettingUpdateBodyCWProxyImpl(this._value);

  final SettingUpdateBody _value;

  @override
  SettingUpdateBody value(Object? value) => this(value: value);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SettingUpdateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SettingUpdateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  SettingUpdateBody call({Object? value = const $CopyWithPlaceholder()}) {
    return SettingUpdateBody(
      value: value == const $CopyWithPlaceholder()
          ? _value.value
          // ignore: cast_nullable_to_non_nullable
          : value as Object?,
    );
  }
}

extension $SettingUpdateBodyCopyWith on SettingUpdateBody {
  /// Returns a callable class that can be used as follows: `instanceOfSettingUpdateBody.copyWith(...)` or like so:`instanceOfSettingUpdateBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SettingUpdateBodyCWProxy get copyWith =>
      _$SettingUpdateBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingUpdateBody _$SettingUpdateBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SettingUpdateBody', json, ($checkedConvert) {
      final val = SettingUpdateBody(value: $checkedConvert('value', (v) => v));
      return val;
    });

Map<String, dynamic> _$SettingUpdateBodyToJson(SettingUpdateBody instance) =>
    <String, dynamic>{'value': ?instance.value};
