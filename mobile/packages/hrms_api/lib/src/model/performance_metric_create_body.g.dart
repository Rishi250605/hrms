// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performance_metric_create_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PerformanceMetricCreateBodyCWProxy {
  PerformanceMetricCreateBody code(String code);

  PerformanceMetricCreateBody name(String name);

  PerformanceMetricCreateBody unit(String? unit);

  PerformanceMetricCreateBody sortOrder(int? sortOrder);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PerformanceMetricCreateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PerformanceMetricCreateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  PerformanceMetricCreateBody call({
    String code,
    String name,
    String? unit,
    int? sortOrder,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPerformanceMetricCreateBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPerformanceMetricCreateBody.copyWith.fieldName(...)`
class _$PerformanceMetricCreateBodyCWProxyImpl
    implements _$PerformanceMetricCreateBodyCWProxy {
  const _$PerformanceMetricCreateBodyCWProxyImpl(this._value);

  final PerformanceMetricCreateBody _value;

  @override
  PerformanceMetricCreateBody code(String code) => this(code: code);

  @override
  PerformanceMetricCreateBody name(String name) => this(name: name);

  @override
  PerformanceMetricCreateBody unit(String? unit) => this(unit: unit);

  @override
  PerformanceMetricCreateBody sortOrder(int? sortOrder) =>
      this(sortOrder: sortOrder);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PerformanceMetricCreateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PerformanceMetricCreateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  PerformanceMetricCreateBody call({
    Object? code = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? unit = const $CopyWithPlaceholder(),
    Object? sortOrder = const $CopyWithPlaceholder(),
  }) {
    return PerformanceMetricCreateBody(
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
          : sortOrder as int?,
    );
  }
}

extension $PerformanceMetricCreateBodyCopyWith on PerformanceMetricCreateBody {
  /// Returns a callable class that can be used as follows: `instanceOfPerformanceMetricCreateBody.copyWith(...)` or like so:`instanceOfPerformanceMetricCreateBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PerformanceMetricCreateBodyCWProxy get copyWith =>
      _$PerformanceMetricCreateBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PerformanceMetricCreateBody _$PerformanceMetricCreateBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('PerformanceMetricCreateBody', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['code', 'name']);
  final val = PerformanceMetricCreateBody(
    code: $checkedConvert('code', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    unit: $checkedConvert('unit', (v) => v as String?),
    sortOrder: $checkedConvert('sortOrder', (v) => (v as num?)?.toInt()),
  );
  return val;
});

Map<String, dynamic> _$PerformanceMetricCreateBodyToJson(
  PerformanceMetricCreateBody instance,
) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'unit': ?instance.unit,
  'sortOrder': ?instance.sortOrder,
};
