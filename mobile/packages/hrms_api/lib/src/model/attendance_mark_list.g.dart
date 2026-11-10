// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_mark_list.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AttendanceMarkListCWProxy {
  AttendanceMarkList items(List<AttendanceMarkItem> items);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AttendanceMarkList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AttendanceMarkList(...).copyWith(id: 12, name: "My name")
  /// ````
  AttendanceMarkList call({List<AttendanceMarkItem> items});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAttendanceMarkList.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAttendanceMarkList.copyWith.fieldName(...)`
class _$AttendanceMarkListCWProxyImpl implements _$AttendanceMarkListCWProxy {
  const _$AttendanceMarkListCWProxyImpl(this._value);

  final AttendanceMarkList _value;

  @override
  AttendanceMarkList items(List<AttendanceMarkItem> items) =>
      this(items: items);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AttendanceMarkList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AttendanceMarkList(...).copyWith(id: 12, name: "My name")
  /// ````
  AttendanceMarkList call({Object? items = const $CopyWithPlaceholder()}) {
    return AttendanceMarkList(
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<AttendanceMarkItem>,
    );
  }
}

extension $AttendanceMarkListCopyWith on AttendanceMarkList {
  /// Returns a callable class that can be used as follows: `instanceOfAttendanceMarkList.copyWith(...)` or like so:`instanceOfAttendanceMarkList.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AttendanceMarkListCWProxy get copyWith =>
      _$AttendanceMarkListCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceMarkList _$AttendanceMarkListFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AttendanceMarkList', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['items']);
      final val = AttendanceMarkList(
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map(
                (e) => AttendanceMarkItem.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$AttendanceMarkListToJson(AttendanceMarkList instance) =>
    <String, dynamic>{'items': instance.items.map((e) => e.toJson()).toList()};
