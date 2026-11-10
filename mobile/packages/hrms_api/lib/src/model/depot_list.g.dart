// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'depot_list.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DepotListCWProxy {
  DepotList items(List<DepotItem> items);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DepotList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DepotList(...).copyWith(id: 12, name: "My name")
  /// ````
  DepotList call({List<DepotItem> items});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDepotList.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDepotList.copyWith.fieldName(...)`
class _$DepotListCWProxyImpl implements _$DepotListCWProxy {
  const _$DepotListCWProxyImpl(this._value);

  final DepotList _value;

  @override
  DepotList items(List<DepotItem> items) => this(items: items);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DepotList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DepotList(...).copyWith(id: 12, name: "My name")
  /// ````
  DepotList call({Object? items = const $CopyWithPlaceholder()}) {
    return DepotList(
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<DepotItem>,
    );
  }
}

extension $DepotListCopyWith on DepotList {
  /// Returns a callable class that can be used as follows: `instanceOfDepotList.copyWith(...)` or like so:`instanceOfDepotList.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DepotListCWProxy get copyWith => _$DepotListCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepotList _$DepotListFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DepotList', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['items']);
      final val = DepotList(
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map((e) => DepotItem.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$DepotListToJson(DepotList instance) => <String, dynamic>{
  'items': instance.items.map((e) => e.toJson()).toList(),
};
