// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_unit_list.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BusinessUnitListCWProxy {
  BusinessUnitList items(List<BusinessUnitItem> items);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BusinessUnitList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BusinessUnitList(...).copyWith(id: 12, name: "My name")
  /// ````
  BusinessUnitList call({List<BusinessUnitItem> items});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBusinessUnitList.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBusinessUnitList.copyWith.fieldName(...)`
class _$BusinessUnitListCWProxyImpl implements _$BusinessUnitListCWProxy {
  const _$BusinessUnitListCWProxyImpl(this._value);

  final BusinessUnitList _value;

  @override
  BusinessUnitList items(List<BusinessUnitItem> items) => this(items: items);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BusinessUnitList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BusinessUnitList(...).copyWith(id: 12, name: "My name")
  /// ````
  BusinessUnitList call({Object? items = const $CopyWithPlaceholder()}) {
    return BusinessUnitList(
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<BusinessUnitItem>,
    );
  }
}

extension $BusinessUnitListCopyWith on BusinessUnitList {
  /// Returns a callable class that can be used as follows: `instanceOfBusinessUnitList.copyWith(...)` or like so:`instanceOfBusinessUnitList.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BusinessUnitListCWProxy get copyWith => _$BusinessUnitListCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessUnitList _$BusinessUnitListFromJson(Map<String, dynamic> json) =>
    $checkedCreate('BusinessUnitList', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['items']);
      final val = BusinessUnitList(
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map((e) => BusinessUnitItem.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$BusinessUnitListToJson(BusinessUnitList instance) =>
    <String, dynamic>{'items': instance.items.map((e) => e.toJson()).toList()};
