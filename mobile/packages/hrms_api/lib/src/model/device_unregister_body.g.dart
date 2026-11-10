// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_unregister_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DeviceUnregisterBodyCWProxy {
  DeviceUnregisterBody token(String token);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DeviceUnregisterBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DeviceUnregisterBody(...).copyWith(id: 12, name: "My name")
  /// ````
  DeviceUnregisterBody call({String token});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDeviceUnregisterBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDeviceUnregisterBody.copyWith.fieldName(...)`
class _$DeviceUnregisterBodyCWProxyImpl
    implements _$DeviceUnregisterBodyCWProxy {
  const _$DeviceUnregisterBodyCWProxyImpl(this._value);

  final DeviceUnregisterBody _value;

  @override
  DeviceUnregisterBody token(String token) => this(token: token);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DeviceUnregisterBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DeviceUnregisterBody(...).copyWith(id: 12, name: "My name")
  /// ````
  DeviceUnregisterBody call({Object? token = const $CopyWithPlaceholder()}) {
    return DeviceUnregisterBody(
      token: token == const $CopyWithPlaceholder()
          ? _value.token
          // ignore: cast_nullable_to_non_nullable
          : token as String,
    );
  }
}

extension $DeviceUnregisterBodyCopyWith on DeviceUnregisterBody {
  /// Returns a callable class that can be used as follows: `instanceOfDeviceUnregisterBody.copyWith(...)` or like so:`instanceOfDeviceUnregisterBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DeviceUnregisterBodyCWProxy get copyWith =>
      _$DeviceUnregisterBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceUnregisterBody _$DeviceUnregisterBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DeviceUnregisterBody', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['token']);
  final val = DeviceUnregisterBody(
    token: $checkedConvert('token', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$DeviceUnregisterBodyToJson(
  DeviceUnregisterBody instance,
) => <String, dynamic>{'token': instance.token};
