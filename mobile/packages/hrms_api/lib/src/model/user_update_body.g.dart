// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_update_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserUpdateBodyCWProxy {
  UserUpdateBody name(String? name);

  UserUpdateBody phone(String? phone);

  UserUpdateBody email(String? email);

  UserUpdateBody isActive(bool? isActive);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserUpdateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserUpdateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  UserUpdateBody call({
    String? name,
    String? phone,
    String? email,
    bool? isActive,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUserUpdateBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUserUpdateBody.copyWith.fieldName(...)`
class _$UserUpdateBodyCWProxyImpl implements _$UserUpdateBodyCWProxy {
  const _$UserUpdateBodyCWProxyImpl(this._value);

  final UserUpdateBody _value;

  @override
  UserUpdateBody name(String? name) => this(name: name);

  @override
  UserUpdateBody phone(String? phone) => this(phone: phone);

  @override
  UserUpdateBody email(String? email) => this(email: email);

  @override
  UserUpdateBody isActive(bool? isActive) => this(isActive: isActive);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserUpdateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserUpdateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  UserUpdateBody call({
    Object? name = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
  }) {
    return UserUpdateBody(
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      phone: phone == const $CopyWithPlaceholder()
          ? _value.phone
          // ignore: cast_nullable_to_non_nullable
          : phone as String?,
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String?,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool?,
    );
  }
}

extension $UserUpdateBodyCopyWith on UserUpdateBody {
  /// Returns a callable class that can be used as follows: `instanceOfUserUpdateBody.copyWith(...)` or like so:`instanceOfUserUpdateBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserUpdateBodyCWProxy get copyWith => _$UserUpdateBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserUpdateBody _$UserUpdateBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UserUpdateBody', json, ($checkedConvert) {
      final val = UserUpdateBody(
        name: $checkedConvert('name', (v) => v as String?),
        phone: $checkedConvert('phone', (v) => v as String?),
        email: $checkedConvert('email', (v) => v as String?),
        isActive: $checkedConvert('isActive', (v) => v as bool?),
      );
      return val;
    });

Map<String, dynamic> _$UserUpdateBodyToJson(UserUpdateBody instance) =>
    <String, dynamic>{
      'name': ?instance.name,
      'phone': ?instance.phone,
      'email': ?instance.email,
      'isActive': ?instance.isActive,
    };
