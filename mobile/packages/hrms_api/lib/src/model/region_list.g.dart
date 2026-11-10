// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'region_list.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RegionListCWProxy {
  RegionList items(List<RegionItem> items);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RegionList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RegionList(...).copyWith(id: 12, name: "My name")
  /// ````
  RegionList call({List<RegionItem> items});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRegionList.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRegionList.copyWith.fieldName(...)`
class _$RegionListCWProxyImpl implements _$RegionListCWProxy {
  const _$RegionListCWProxyImpl(this._value);

  final RegionList _value;

  @override
  RegionList items(List<RegionItem> items) => this(items: items);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RegionList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RegionList(...).copyWith(id: 12, name: "My name")
  /// ````
  RegionList call({Object? items = const $CopyWithPlaceholder()}) {
    return RegionList(
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<RegionItem>,
    );
  }
}

extension $RegionListCopyWith on RegionList {
  /// Returns a callable class that can be used as follows: `instanceOfRegionList.copyWith(...)` or like so:`instanceOfRegionList.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RegionListCWProxy get copyWith => _$RegionListCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegionList _$RegionListFromJson(Map<String, dynamic> json) =>
    $checkedCreate('RegionList', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['items']);
      final val = RegionList(
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map((e) => RegionItem.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$RegionListToJson(RegionList instance) =>
    <String, dynamic>{'items': instance.items.map((e) => e.toJson()).toList()};
