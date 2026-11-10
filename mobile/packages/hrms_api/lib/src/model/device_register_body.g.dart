// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_register_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DeviceRegisterBodyCWProxy {
  DeviceRegisterBody token(String token);

  DeviceRegisterBody platform(DeviceRegisterBodyPlatformEnum platform);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DeviceRegisterBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DeviceRegisterBody(...).copyWith(id: 12, name: "My name")
  /// ````
  DeviceRegisterBody call({
    String token,
    DeviceRegisterBodyPlatformEnum platform,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDeviceRegisterBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDeviceRegisterBody.copyWith.fieldName(...)`
class _$DeviceRegisterBodyCWProxyImpl implements _$DeviceRegisterBodyCWProxy {
  const _$DeviceRegisterBodyCWProxyImpl(this._value);

  final DeviceRegisterBody _value;

  @override
  DeviceRegisterBody token(String token) => this(token: token);

  @override
  DeviceRegisterBody platform(DeviceRegisterBodyPlatformEnum platform) =>
      this(platform: platform);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DeviceRegisterBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DeviceRegisterBody(...).copyWith(id: 12, name: "My name")
  /// ````
  DeviceRegisterBody call({
    Object? token = const $CopyWithPlaceholder(),
    Object? platform = const $CopyWithPlaceholder(),
  }) {
    return DeviceRegisterBody(
      token: token == const $CopyWithPlaceholder()
          ? _value.token
          // ignore: cast_nullable_to_non_nullable
          : token as String,
      platform: platform == const $CopyWithPlaceholder()
          ? _value.platform
          // ignore: cast_nullable_to_non_nullable
          : platform as DeviceRegisterBodyPlatformEnum,
    );
  }
}

extension $DeviceRegisterBodyCopyWith on DeviceRegisterBody {
  /// Returns a callable class that can be used as follows: `instanceOfDeviceRegisterBody.copyWith(...)` or like so:`instanceOfDeviceRegisterBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DeviceRegisterBodyCWProxy get copyWith =>
      _$DeviceRegisterBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceRegisterBody _$DeviceRegisterBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DeviceRegisterBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['token', 'platform']);
      final val = DeviceRegisterBody(
        token: $checkedConvert('token', (v) => v as String),
        platform: $checkedConvert(
          'platform',
          (v) => $enumDecode(_$DeviceRegisterBodyPlatformEnumEnumMap, v),
        ),
      );
      return val;
    });

Map<String, dynamic> _$DeviceRegisterBodyToJson(DeviceRegisterBody instance) =>
    <String, dynamic>{
      'token': instance.token,
      'platform': _$DeviceRegisterBodyPlatformEnumEnumMap[instance.platform]!,
    };

const _$DeviceRegisterBodyPlatformEnumEnumMap = {
  DeviceRegisterBodyPlatformEnum.android: 'android',
  DeviceRegisterBodyPlatformEnum.ios: 'ios',
  DeviceRegisterBodyPlatformEnum.web: 'web',
};
