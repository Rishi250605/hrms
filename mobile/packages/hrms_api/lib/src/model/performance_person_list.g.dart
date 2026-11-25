// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performance_person_list.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PerformancePersonListCWProxy {
  PerformancePersonList items(List<PerformancePersonItem> items);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PerformancePersonList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PerformancePersonList(...).copyWith(id: 12, name: "My name")
  /// ````
  PerformancePersonList call({List<PerformancePersonItem> items});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPerformancePersonList.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPerformancePersonList.copyWith.fieldName(...)`
class _$PerformancePersonListCWProxyImpl
    implements _$PerformancePersonListCWProxy {
  const _$PerformancePersonListCWProxyImpl(this._value);

  final PerformancePersonList _value;

  @override
  PerformancePersonList items(List<PerformancePersonItem> items) =>
      this(items: items);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PerformancePersonList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PerformancePersonList(...).copyWith(id: 12, name: "My name")
  /// ````
  PerformancePersonList call({Object? items = const $CopyWithPlaceholder()}) {
    return PerformancePersonList(
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<PerformancePersonItem>,
    );
  }
}

extension $PerformancePersonListCopyWith on PerformancePersonList {
  /// Returns a callable class that can be used as follows: `instanceOfPerformancePersonList.copyWith(...)` or like so:`instanceOfPerformancePersonList.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PerformancePersonListCWProxy get copyWith =>
      _$PerformancePersonListCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PerformancePersonList _$PerformancePersonListFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('PerformancePersonList', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['items']);
  final val = PerformancePersonList(
    items: $checkedConvert(
      'items',
      (v) => (v as List<dynamic>)
          .map((e) => PerformancePersonItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$PerformancePersonListToJson(
  PerformancePersonList instance,
) => <String, dynamic>{'items': instance.items.map((e) => e.toJson()).toList()};
