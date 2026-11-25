// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performance_metric_list.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PerformanceMetricListCWProxy {
  PerformanceMetricList items(List<PerformanceMetricItem> items);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PerformanceMetricList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PerformanceMetricList(...).copyWith(id: 12, name: "My name")
  /// ````
  PerformanceMetricList call({List<PerformanceMetricItem> items});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPerformanceMetricList.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPerformanceMetricList.copyWith.fieldName(...)`
class _$PerformanceMetricListCWProxyImpl
    implements _$PerformanceMetricListCWProxy {
  const _$PerformanceMetricListCWProxyImpl(this._value);

  final PerformanceMetricList _value;

  @override
  PerformanceMetricList items(List<PerformanceMetricItem> items) =>
      this(items: items);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PerformanceMetricList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PerformanceMetricList(...).copyWith(id: 12, name: "My name")
  /// ````
  PerformanceMetricList call({Object? items = const $CopyWithPlaceholder()}) {
    return PerformanceMetricList(
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<PerformanceMetricItem>,
    );
  }
}

extension $PerformanceMetricListCopyWith on PerformanceMetricList {
  /// Returns a callable class that can be used as follows: `instanceOfPerformanceMetricList.copyWith(...)` or like so:`instanceOfPerformanceMetricList.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PerformanceMetricListCWProxy get copyWith =>
      _$PerformanceMetricListCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PerformanceMetricList _$PerformanceMetricListFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('PerformanceMetricList', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['items']);
  final val = PerformanceMetricList(
    items: $checkedConvert(
      'items',
      (v) => (v as List<dynamic>)
          .map((e) => PerformanceMetricItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$PerformanceMetricListToJson(
  PerformanceMetricList instance,
) => <String, dynamic>{'items': instance.items.map((e) => e.toJson()).toList()};
