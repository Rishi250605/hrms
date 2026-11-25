// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performance_metric_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PerformanceMetricItemCWProxy {
  PerformanceMetricItem id(String id);

  PerformanceMetricItem code(String code);

  PerformanceMetricItem name(String name);

  PerformanceMetricItem unit(String? unit);

  PerformanceMetricItem sortOrder(int sortOrder);

  PerformanceMetricItem isActive(bool isActive);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PerformanceMetricItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PerformanceMetricItem(...).copyWith(id: 12, name: "My name")
  /// ````
  PerformanceMetricItem call({
    String id,
    String code,
    String name,
    String? unit,
    int sortOrder,
    bool isActive,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPerformanceMetricItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPerformanceMetricItem.copyWith.fieldName(...)`
class _$PerformanceMetricItemCWProxyImpl
    implements _$PerformanceMetricItemCWProxy {
  const _$PerformanceMetricItemCWProxyImpl(this._value);

  final PerformanceMetricItem _value;

  @override
  PerformanceMetricItem id(String id) => this(id: id);

  @override
  PerformanceMetricItem code(String code) => this(code: code);

  @override
  PerformanceMetricItem name(String name) => this(name: name);

  @override
  PerformanceMetricItem unit(String? unit) => this(unit: unit);

  @override
  PerformanceMetricItem sortOrder(int sortOrder) => this(sortOrder: sortOrder);

  @override
  PerformanceMetricItem isActive(bool isActive) => this(isActive: isActive);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PerformanceMetricItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PerformanceMetricItem(...).copyWith(id: 12, name: "My name")
  /// ````
  PerformanceMetricItem call({
    Object? id = const $CopyWithPlaceholder(),
    Object? code = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? unit = const $CopyWithPlaceholder(),
    Object? sortOrder = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
  }) {
    return PerformanceMetricItem(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      code: code == const $CopyWithPlaceholder()
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      unit: unit == const $CopyWithPlaceholder()
          ? _value.unit
          // ignore: cast_nullable_to_non_nullable
          : unit as String?,
      sortOrder: sortOrder == const $CopyWithPlaceholder()
          ? _value.sortOrder
          // ignore: cast_nullable_to_non_nullable
          : sortOrder as int,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool,
    );
  }
}

extension $PerformanceMetricItemCopyWith on PerformanceMetricItem {
  /// Returns a callable class that can be used as follows: `instanceOfPerformanceMetricItem.copyWith(...)` or like so:`instanceOfPerformanceMetricItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PerformanceMetricItemCWProxy get copyWith =>
      _$PerformanceMetricItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PerformanceMetricItem _$PerformanceMetricItemFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('PerformanceMetricItem', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'code', 'name', 'unit', 'sortOrder', 'isActive'],
  );
  final val = PerformanceMetricItem(
    id: $checkedConvert('id', (v) => v as String),
    code: $checkedConvert('code', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    unit: $checkedConvert('unit', (v) => v as String?),
    sortOrder: $checkedConvert('sortOrder', (v) => (v as num).toInt()),
    isActive: $checkedConvert('isActive', (v) => v as bool),
  );
  return val;
});

Map<String, dynamic> _$PerformanceMetricItemToJson(
  PerformanceMetricItem instance,
) => <String, dynamic>{
  'id': instance.id,
  'code': instance.code,
  'name': instance.name,
  'unit': instance.unit,
  'sortOrder': instance.sortOrder,
  'isActive': instance.isActive,
};
