// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allowance_type_list.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AllowanceTypeListCWProxy {
  AllowanceTypeList items(List<AllowanceTypeItem> items);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AllowanceTypeList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AllowanceTypeList(...).copyWith(id: 12, name: "My name")
  /// ````
  AllowanceTypeList call({List<AllowanceTypeItem> items});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAllowanceTypeList.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAllowanceTypeList.copyWith.fieldName(...)`
class _$AllowanceTypeListCWProxyImpl implements _$AllowanceTypeListCWProxy {
  const _$AllowanceTypeListCWProxyImpl(this._value);

  final AllowanceTypeList _value;

  @override
  AllowanceTypeList items(List<AllowanceTypeItem> items) => this(items: items);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AllowanceTypeList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AllowanceTypeList(...).copyWith(id: 12, name: "My name")
  /// ````
  AllowanceTypeList call({Object? items = const $CopyWithPlaceholder()}) {
    return AllowanceTypeList(
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<AllowanceTypeItem>,
    );
  }
}

extension $AllowanceTypeListCopyWith on AllowanceTypeList {
  /// Returns a callable class that can be used as follows: `instanceOfAllowanceTypeList.copyWith(...)` or like so:`instanceOfAllowanceTypeList.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AllowanceTypeListCWProxy get copyWith =>
      _$AllowanceTypeListCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllowanceTypeList _$AllowanceTypeListFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AllowanceTypeList', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['items']);
      final val = AllowanceTypeList(
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map((e) => AllowanceTypeItem.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$AllowanceTypeListToJson(AllowanceTypeList instance) =>
    <String, dynamic>{'items': instance.items.map((e) => e.toJson()).toList()};
