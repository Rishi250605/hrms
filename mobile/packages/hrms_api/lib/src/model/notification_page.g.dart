// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_page.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NotificationPageCWProxy {
  NotificationPage items(List<NotificationItem> items);

  NotificationPage nextCursor(String? nextCursor);

  NotificationPage unreadCount(int unreadCount);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NotificationPage(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NotificationPage(...).copyWith(id: 12, name: "My name")
  /// ````
  NotificationPage call({
    List<NotificationItem> items,
    String? nextCursor,
    int unreadCount,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfNotificationPage.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfNotificationPage.copyWith.fieldName(...)`
class _$NotificationPageCWProxyImpl implements _$NotificationPageCWProxy {
  const _$NotificationPageCWProxyImpl(this._value);

  final NotificationPage _value;

  @override
  NotificationPage items(List<NotificationItem> items) => this(items: items);

  @override
  NotificationPage nextCursor(String? nextCursor) =>
      this(nextCursor: nextCursor);

  @override
  NotificationPage unreadCount(int unreadCount) =>
      this(unreadCount: unreadCount);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NotificationPage(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NotificationPage(...).copyWith(id: 12, name: "My name")
  /// ````
  NotificationPage call({
    Object? items = const $CopyWithPlaceholder(),
    Object? nextCursor = const $CopyWithPlaceholder(),
    Object? unreadCount = const $CopyWithPlaceholder(),
  }) {
    return NotificationPage(
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<NotificationItem>,
      nextCursor: nextCursor == const $CopyWithPlaceholder()
          ? _value.nextCursor
          // ignore: cast_nullable_to_non_nullable
          : nextCursor as String?,
      unreadCount: unreadCount == const $CopyWithPlaceholder()
          ? _value.unreadCount
          // ignore: cast_nullable_to_non_nullable
          : unreadCount as int,
    );
  }
}

extension $NotificationPageCopyWith on NotificationPage {
  /// Returns a callable class that can be used as follows: `instanceOfNotificationPage.copyWith(...)` or like so:`instanceOfNotificationPage.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$NotificationPageCWProxy get copyWith => _$NotificationPageCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationPage _$NotificationPageFromJson(Map<String, dynamic> json) =>
    $checkedCreate('NotificationPage', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['items', 'nextCursor', 'unreadCount'],
      );
      final val = NotificationPage(
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map((e) => NotificationItem.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        nextCursor: $checkedConvert('nextCursor', (v) => v as String?),
        unreadCount: $checkedConvert('unreadCount', (v) => (v as num).toInt()),
      );
      return val;
    });

Map<String, dynamic> _$NotificationPageToJson(NotificationPage instance) =>
    <String, dynamic>{
      'items': instance.items.map((e) => e.toJson()).toList(),
      'nextCursor': instance.nextCursor,
      'unreadCount': instance.unreadCount,
    };
