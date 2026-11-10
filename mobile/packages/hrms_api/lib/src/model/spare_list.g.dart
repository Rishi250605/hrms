// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spare_list.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SpareListCWProxy {
  SpareList items(List<SpareItem> items);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SpareList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SpareList(...).copyWith(id: 12, name: "My name")
  /// ````
  SpareList call({List<SpareItem> items});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSpareList.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSpareList.copyWith.fieldName(...)`
class _$SpareListCWProxyImpl implements _$SpareListCWProxy {
  const _$SpareListCWProxyImpl(this._value);

  final SpareList _value;

  @override
  SpareList items(List<SpareItem> items) => this(items: items);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SpareList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SpareList(...).copyWith(id: 12, name: "My name")
  /// ````
  SpareList call({Object? items = const $CopyWithPlaceholder()}) {
    return SpareList(
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<SpareItem>,
    );
  }
}

extension $SpareListCopyWith on SpareList {
  /// Returns a callable class that can be used as follows: `instanceOfSpareList.copyWith(...)` or like so:`instanceOfSpareList.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SpareListCWProxy get copyWith => _$SpareListCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpareList _$SpareListFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SpareList', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['items']);
      final val = SpareList(
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map((e) => SpareItem.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$SpareListToJson(SpareList instance) => <String, dynamic>{
  'items': instance.items.map((e) => e.toJson()).toList(),
};
