// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_type_list.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LeaveTypeListCWProxy {
  LeaveTypeList items(List<LeaveTypeItem> items);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LeaveTypeList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LeaveTypeList(...).copyWith(id: 12, name: "My name")
  /// ````
  LeaveTypeList call({List<LeaveTypeItem> items});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfLeaveTypeList.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfLeaveTypeList.copyWith.fieldName(...)`
class _$LeaveTypeListCWProxyImpl implements _$LeaveTypeListCWProxy {
  const _$LeaveTypeListCWProxyImpl(this._value);

  final LeaveTypeList _value;

  @override
  LeaveTypeList items(List<LeaveTypeItem> items) => this(items: items);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LeaveTypeList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LeaveTypeList(...).copyWith(id: 12, name: "My name")
  /// ````
  LeaveTypeList call({Object? items = const $CopyWithPlaceholder()}) {
    return LeaveTypeList(
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<LeaveTypeItem>,
    );
  }
}

extension $LeaveTypeListCopyWith on LeaveTypeList {
  /// Returns a callable class that can be used as follows: `instanceOfLeaveTypeList.copyWith(...)` or like so:`instanceOfLeaveTypeList.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LeaveTypeListCWProxy get copyWith => _$LeaveTypeListCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveTypeList _$LeaveTypeListFromJson(Map<String, dynamic> json) =>
    $checkedCreate('LeaveTypeList', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['items']);
      final val = LeaveTypeList(
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map((e) => LeaveTypeItem.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$LeaveTypeListToJson(LeaveTypeList instance) =>
    <String, dynamic>{'items': instance.items.map((e) => e.toJson()).toList()};
