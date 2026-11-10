// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allowance_list.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AllowanceListCWProxy {
  AllowanceList items(List<AllowanceItem> items);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AllowanceList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AllowanceList(...).copyWith(id: 12, name: "My name")
  /// ````
  AllowanceList call({List<AllowanceItem> items});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAllowanceList.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAllowanceList.copyWith.fieldName(...)`
class _$AllowanceListCWProxyImpl implements _$AllowanceListCWProxy {
  const _$AllowanceListCWProxyImpl(this._value);

  final AllowanceList _value;

  @override
  AllowanceList items(List<AllowanceItem> items) => this(items: items);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AllowanceList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AllowanceList(...).copyWith(id: 12, name: "My name")
  /// ````
  AllowanceList call({Object? items = const $CopyWithPlaceholder()}) {
    return AllowanceList(
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<AllowanceItem>,
    );
  }
}

extension $AllowanceListCopyWith on AllowanceList {
  /// Returns a callable class that can be used as follows: `instanceOfAllowanceList.copyWith(...)` or like so:`instanceOfAllowanceList.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AllowanceListCWProxy get copyWith => _$AllowanceListCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllowanceList _$AllowanceListFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AllowanceList', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['items']);
      final val = AllowanceList(
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map((e) => AllowanceItem.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$AllowanceListToJson(AllowanceList instance) =>
    <String, dynamic>{'items': instance.items.map((e) => e.toJson()).toList()};
