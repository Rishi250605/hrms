// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NotificationItemCWProxy {
  NotificationItem id(String id);

  NotificationItem type(String type);

  NotificationItem title(String title);

  NotificationItem body(String body);

  NotificationItem entityType(String? entityType);

  NotificationItem entityId(String? entityId);

  NotificationItem businessUnitId(String businessUnitId);

  NotificationItem createdAt(DateTime createdAt);

  NotificationItem readAt(DateTime? readAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NotificationItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NotificationItem(...).copyWith(id: 12, name: "My name")
  /// ````
  NotificationItem call({
    String id,
    String type,
    String title,
    String body,
    String? entityType,
    String? entityId,
    String businessUnitId,
    DateTime createdAt,
    DateTime? readAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfNotificationItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfNotificationItem.copyWith.fieldName(...)`
class _$NotificationItemCWProxyImpl implements _$NotificationItemCWProxy {
  const _$NotificationItemCWProxyImpl(this._value);

  final NotificationItem _value;

  @override
  NotificationItem id(String id) => this(id: id);

  @override
  NotificationItem type(String type) => this(type: type);

  @override
  NotificationItem title(String title) => this(title: title);

  @override
  NotificationItem body(String body) => this(body: body);

  @override
  NotificationItem entityType(String? entityType) =>
      this(entityType: entityType);

  @override
  NotificationItem entityId(String? entityId) => this(entityId: entityId);

  @override
  NotificationItem businessUnitId(String businessUnitId) =>
      this(businessUnitId: businessUnitId);

  @override
  NotificationItem createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  NotificationItem readAt(DateTime? readAt) => this(readAt: readAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NotificationItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NotificationItem(...).copyWith(id: 12, name: "My name")
  /// ````
  NotificationItem call({
    Object? id = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? title = const $CopyWithPlaceholder(),
    Object? body = const $CopyWithPlaceholder(),
    Object? entityType = const $CopyWithPlaceholder(),
    Object? entityId = const $CopyWithPlaceholder(),
    Object? businessUnitId = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? readAt = const $CopyWithPlaceholder(),
  }) {
    return NotificationItem(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as String,
      title: title == const $CopyWithPlaceholder()
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String,
      body: body == const $CopyWithPlaceholder()
          ? _value.body
          // ignore: cast_nullable_to_non_nullable
          : body as String,
      entityType: entityType == const $CopyWithPlaceholder()
          ? _value.entityType
          // ignore: cast_nullable_to_non_nullable
          : entityType as String?,
      entityId: entityId == const $CopyWithPlaceholder()
          ? _value.entityId
          // ignore: cast_nullable_to_non_nullable
          : entityId as String?,
      businessUnitId: businessUnitId == const $CopyWithPlaceholder()
          ? _value.businessUnitId
          // ignore: cast_nullable_to_non_nullable
          : businessUnitId as String,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      readAt: readAt == const $CopyWithPlaceholder()
          ? _value.readAt
          // ignore: cast_nullable_to_non_nullable
          : readAt as DateTime?,
    );
  }
}

extension $NotificationItemCopyWith on NotificationItem {
  /// Returns a callable class that can be used as follows: `instanceOfNotificationItem.copyWith(...)` or like so:`instanceOfNotificationItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$NotificationItemCWProxy get copyWith => _$NotificationItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationItem _$NotificationItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate('NotificationItem', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'type',
          'title',
          'body',
          'entityType',
          'entityId',
          'businessUnitId',
          'createdAt',
          'readAt',
        ],
      );
      final val = NotificationItem(
        id: $checkedConvert('id', (v) => v as String),
        type: $checkedConvert('type', (v) => v as String),
        title: $checkedConvert('title', (v) => v as String),
        body: $checkedConvert('body', (v) => v as String),
        entityType: $checkedConvert('entityType', (v) => v as String?),
        entityId: $checkedConvert('entityId', (v) => v as String?),
        businessUnitId: $checkedConvert('businessUnitId', (v) => v as String),
        createdAt: $checkedConvert(
          'createdAt',
          (v) => DateTime.parse(v as String),
        ),
        readAt: $checkedConvert(
          'readAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$NotificationItemToJson(NotificationItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'title': instance.title,
      'body': instance.body,
      'entityType': instance.entityType,
      'entityId': instance.entityId,
      'businessUnitId': instance.businessUnitId,
      'createdAt': instance.createdAt.toIso8601String(),
      'readAt': instance.readAt?.toIso8601String(),
    };
