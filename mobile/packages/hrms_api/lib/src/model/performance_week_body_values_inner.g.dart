// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performance_week_body_values_inner.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PerformanceWeekBodyValuesInnerCWProxy {
  PerformanceWeekBodyValuesInner metricId(String metricId);

  PerformanceWeekBodyValuesInner value(num? value);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PerformanceWeekBodyValuesInner(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PerformanceWeekBodyValuesInner(...).copyWith(id: 12, name: "My name")
  /// ````
  PerformanceWeekBodyValuesInner call({String metricId, num? value});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPerformanceWeekBodyValuesInner.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPerformanceWeekBodyValuesInner.copyWith.fieldName(...)`
class _$PerformanceWeekBodyValuesInnerCWProxyImpl
    implements _$PerformanceWeekBodyValuesInnerCWProxy {
  const _$PerformanceWeekBodyValuesInnerCWProxyImpl(this._value);

  final PerformanceWeekBodyValuesInner _value;

  @override
  PerformanceWeekBodyValuesInner metricId(String metricId) =>
      this(metricId: metricId);

  @override
  PerformanceWeekBodyValuesInner value(num? value) => this(value: value);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PerformanceWeekBodyValuesInner(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PerformanceWeekBodyValuesInner(...).copyWith(id: 12, name: "My name")
  /// ````
  PerformanceWeekBodyValuesInner call({
    Object? metricId = const $CopyWithPlaceholder(),
    Object? value = const $CopyWithPlaceholder(),
  }) {
    return PerformanceWeekBodyValuesInner(
      metricId: metricId == const $CopyWithPlaceholder()
          ? _value.metricId
          // ignore: cast_nullable_to_non_nullable
          : metricId as String,
      value: value == const $CopyWithPlaceholder()
          ? _value.value
          // ignore: cast_nullable_to_non_nullable
          : value as num?,
    );
  }
}

extension $PerformanceWeekBodyValuesInnerCopyWith
    on PerformanceWeekBodyValuesInner {
  /// Returns a callable class that can be used as follows: `instanceOfPerformanceWeekBodyValuesInner.copyWith(...)` or like so:`instanceOfPerformanceWeekBodyValuesInner.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PerformanceWeekBodyValuesInnerCWProxy get copyWith =>
      _$PerformanceWeekBodyValuesInnerCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PerformanceWeekBodyValuesInner _$PerformanceWeekBodyValuesInnerFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('PerformanceWeekBodyValuesInner', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['metricId', 'value']);
  final val = PerformanceWeekBodyValuesInner(
    metricId: $checkedConvert('metricId', (v) => v as String),
    value: $checkedConvert('value', (v) => v as num?),
  );
  return val;
});

Map<String, dynamic> _$PerformanceWeekBodyValuesInnerToJson(
  PerformanceWeekBodyValuesInner instance,
) => <String, dynamic>{'metricId': instance.metricId, 'value': instance.value};
