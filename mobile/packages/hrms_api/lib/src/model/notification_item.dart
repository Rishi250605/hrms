//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_item.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class NotificationItem {
  /// Returns a new [NotificationItem] instance.
  NotificationItem({
    required this.id,

    required this.type,

    required this.title,

    required this.body,

    required this.entityType,

    required this.entityId,

    required this.businessUnitId,

    required this.createdAt,

    required this.readAt,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'type', required: true, includeIfNull: false)
  final String type;

  @JsonKey(name: r'title', required: true, includeIfNull: false)
  final String title;

  @JsonKey(name: r'body', required: true, includeIfNull: false)
  final String body;

  /// ATTENDANCE, CORRECTION, LEAVE, ALLOWANCE, PAYSLIP, TASK, DOCUMENT, USER
  @JsonKey(name: r'entityType', required: true, includeIfNull: true)
  final String? entityType;

  @JsonKey(name: r'entityId', required: true, includeIfNull: true)
  final String? entityId;

  @JsonKey(name: r'businessUnitId', required: true, includeIfNull: false)
  final String businessUnitId;

  @JsonKey(name: r'createdAt', required: true, includeIfNull: false)
  final DateTime createdAt;

  @JsonKey(name: r'readAt', required: true, includeIfNull: true)
  final DateTime? readAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationItem &&
          other.id == id &&
          other.type == type &&
          other.title == title &&
          other.body == body &&
          other.entityType == entityType &&
          other.entityId == entityId &&
          other.businessUnitId == businessUnitId &&
          other.createdAt == createdAt &&
          other.readAt == readAt;

  @override
  int get hashCode =>
      id.hashCode +
      type.hashCode +
      title.hashCode +
      body.hashCode +
      (entityType == null ? 0 : entityType.hashCode) +
      (entityId == null ? 0 : entityId.hashCode) +
      businessUnitId.hashCode +
      createdAt.hashCode +
      (readAt == null ? 0 : readAt.hashCode);

  factory NotificationItem.fromJson(Map<String, dynamic> json) =>
      _$NotificationItemFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
