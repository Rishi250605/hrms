// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_list.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SettingListCWProxy {
  SettingList items(List<SettingItem> items);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SettingList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SettingList(...).copyWith(id: 12, name: "My name")
  /// ````
  SettingList call({List<SettingItem> items});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSettingList.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSettingList.copyWith.fieldName(...)`
class _$SettingListCWProxyImpl implements _$SettingListCWProxy {
  const _$SettingListCWProxyImpl(this._value);

  final SettingList _value;

  @override
  SettingList items(List<SettingItem> items) => this(items: items);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SettingList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SettingList(...).copyWith(id: 12, name: "My name")
  /// ````
  SettingList call({Object? items = const $CopyWithPlaceholder()}) {
    return SettingList(
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<SettingItem>,
    );
  }
}

extension $SettingListCopyWith on SettingList {
  /// Returns a callable class that can be used as follows: `instanceOfSettingList.copyWith(...)` or like so:`instanceOfSettingList.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SettingListCWProxy get copyWith => _$SettingListCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingList _$SettingListFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SettingList', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['items']);
      final val = SettingList(
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map((e) => SettingItem.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$SettingListToJson(SettingList instance) =>
    <String, dynamic>{'items': instance.items.map((e) => e.toJson()).toList()};
