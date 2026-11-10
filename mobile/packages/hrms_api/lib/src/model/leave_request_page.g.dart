// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_request_page.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LeaveRequestPageCWProxy {
  LeaveRequestPage items(List<LeaveRequestItem> items);

  LeaveRequestPage nextCursor(String? nextCursor);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LeaveRequestPage(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LeaveRequestPage(...).copyWith(id: 12, name: "My name")
  /// ````
  LeaveRequestPage call({List<LeaveRequestItem> items, String? nextCursor});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfLeaveRequestPage.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfLeaveRequestPage.copyWith.fieldName(...)`
class _$LeaveRequestPageCWProxyImpl implements _$LeaveRequestPageCWProxy {
  const _$LeaveRequestPageCWProxyImpl(this._value);

  final LeaveRequestPage _value;

  @override
  LeaveRequestPage items(List<LeaveRequestItem> items) => this(items: items);

  @override
  LeaveRequestPage nextCursor(String? nextCursor) =>
      this(nextCursor: nextCursor);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LeaveRequestPage(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LeaveRequestPage(...).copyWith(id: 12, name: "My name")
  /// ````
  LeaveRequestPage call({
    Object? items = const $CopyWithPlaceholder(),
    Object? nextCursor = const $CopyWithPlaceholder(),
  }) {
    return LeaveRequestPage(
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<LeaveRequestItem>,
      nextCursor: nextCursor == const $CopyWithPlaceholder()
          ? _value.nextCursor
          // ignore: cast_nullable_to_non_nullable
          : nextCursor as String?,
    );
  }
}

extension $LeaveRequestPageCopyWith on LeaveRequestPage {
  /// Returns a callable class that can be used as follows: `instanceOfLeaveRequestPage.copyWith(...)` or like so:`instanceOfLeaveRequestPage.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LeaveRequestPageCWProxy get copyWith => _$LeaveRequestPageCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveRequestPage _$LeaveRequestPageFromJson(Map<String, dynamic> json) =>
    $checkedCreate('LeaveRequestPage', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['items', 'nextCursor']);
      final val = LeaveRequestPage(
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map((e) => LeaveRequestItem.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        nextCursor: $checkedConvert('nextCursor', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$LeaveRequestPageToJson(LeaveRequestPage instance) =>
    <String, dynamic>{
      'items': instance.items.map((e) => e.toJson()).toList(),
      'nextCursor': instance.nextCursor,
    };
