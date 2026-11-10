// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_list.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserListCWProxy {
  UserList items(List<UserItem> items);

  UserList nextCursor(String? nextCursor);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserList(...).copyWith(id: 12, name: "My name")
  /// ````
  UserList call({List<UserItem> items, String? nextCursor});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUserList.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUserList.copyWith.fieldName(...)`
class _$UserListCWProxyImpl implements _$UserListCWProxy {
  const _$UserListCWProxyImpl(this._value);

  final UserList _value;

  @override
  UserList items(List<UserItem> items) => this(items: items);

  @override
  UserList nextCursor(String? nextCursor) => this(nextCursor: nextCursor);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserList(...).copyWith(id: 12, name: "My name")
  /// ````
  UserList call({
    Object? items = const $CopyWithPlaceholder(),
    Object? nextCursor = const $CopyWithPlaceholder(),
  }) {
    return UserList(
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<UserItem>,
      nextCursor: nextCursor == const $CopyWithPlaceholder()
          ? _value.nextCursor
          // ignore: cast_nullable_to_non_nullable
          : nextCursor as String?,
    );
  }
}

extension $UserListCopyWith on UserList {
  /// Returns a callable class that can be used as follows: `instanceOfUserList.copyWith(...)` or like so:`instanceOfUserList.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserListCWProxy get copyWith => _$UserListCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserList _$UserListFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UserList', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['items', 'nextCursor']);
      final val = UserList(
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map((e) => UserItem.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        nextCursor: $checkedConvert('nextCursor', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$UserListToJson(UserList instance) => <String, dynamic>{
  'items': instance.items.map((e) => e.toJson()).toList(),
  'nextCursor': instance.nextCursor,
};
