// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performance_metric_update_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PerformanceMetricUpdateBodyCWProxy {
  PerformanceMetricUpdateBody name(String? name);

  PerformanceMetricUpdateBody unit(String? unit);

  PerformanceMetricUpdateBody sortOrder(int? sortOrder);

  PerformanceMetricUpdateBody isActive(bool? isActive);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PerformanceMetricUpdateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PerformanceMetricUpdateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  PerformanceMetricUpdateBody call({
    String? name,
    String? unit,
    int? sortOrder,
    bool? isActive,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPerformanceMetricUpdateBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPerformanceMetricUpdateBody.copyWith.fieldName(...)`
class _$PerformanceMetricUpdateBodyCWProxyImpl
    implements _$PerformanceMetricUpdateBodyCWProxy {
  const _$PerformanceMetricUpdateBodyCWProxyImpl(this._value);

  final PerformanceMetricUpdateBody _value;

  @override
  PerformanceMetricUpdateBody name(String? name) => this(name: name);

  @override
  PerformanceMetricUpdateBody unit(String? unit) => this(unit: unit);

  @override
  PerformanceMetricUpdateBody sortOrder(int? sortOrder) =>
      this(sortOrder: sortOrder);

  @override
  PerformanceMetricUpdateBody isActive(bool? isActive) =>
      this(isActive: isActive);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PerformanceMetricUpdateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PerformanceMetricUpdateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  PerformanceMetricUpdateBody call({
    Object? name = const $CopyWithPlaceholder(),
    Object? unit = const $CopyWithPlaceholder(),
    Object? sortOrder = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
  }) {
    return PerformanceMetricUpdateBody(
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      unit: unit == const $CopyWithPlaceholder()
          ? _value.unit
          // ignore: cast_nullable_to_non_nullable
          : unit as String?,
      sortOrder: sortOrder == const $CopyWithPlaceholder()
          ? _value.sortOrder
          // ignore: cast_nullable_to_non_nullable
          : sortOrder as int?,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool?,
    );
  }
}

extension $PerformanceMetricUpdateBodyCopyWith on PerformanceMetricUpdateBody {
  /// Returns a callable class that can be used as follows: `instanceOfPerformanceMetricUpdateBody.copyWith(...)` or like so:`instanceOfPerformanceMetricUpdateBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PerformanceMetricUpdateBodyCWProxy get copyWith =>
      _$PerformanceMetricUpdateBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PerformanceMetricUpdateBody _$PerformanceMetricUpdateBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('PerformanceMetricUpdateBody', json, ($checkedConvert) {
  final val = PerformanceMetricUpdateBody(
    name: $checkedConvert('name', (v) => v as String?),
    unit: $checkedConvert('unit', (v) => v as String?),
    sortOrder: $checkedConvert('sortOrder', (v) => (v as num?)?.toInt()),
    isActive: $checkedConvert('isActive', (v) => v as bool?),
  );
  return val;
});

Map<String, dynamic> _$PerformanceMetricUpdateBodyToJson(
  PerformanceMetricUpdateBody instance,
) => <String, dynamic>{
  'name': ?instance.name,
  'unit': ?instance.unit,
  'sortOrder': ?instance.sortOrder,
  'isActive': ?instance.isActive,
};
