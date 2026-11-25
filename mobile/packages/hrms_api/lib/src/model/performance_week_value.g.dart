// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performance_week_value.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PerformanceWeekValueCWProxy {
  PerformanceWeekValue metricId(String metricId);

  PerformanceWeekValue code(String code);

  PerformanceWeekValue name(String name);

  PerformanceWeekValue unit(String? unit);

  PerformanceWeekValue value(num? value);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PerformanceWeekValue(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PerformanceWeekValue(...).copyWith(id: 12, name: "My name")
  /// ````
  PerformanceWeekValue call({
    String metricId,
    String code,
    String name,
    String? unit,
    num? value,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPerformanceWeekValue.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPerformanceWeekValue.copyWith.fieldName(...)`
class _$PerformanceWeekValueCWProxyImpl
    implements _$PerformanceWeekValueCWProxy {
  const _$PerformanceWeekValueCWProxyImpl(this._value);

  final PerformanceWeekValue _value;

  @override
  PerformanceWeekValue metricId(String metricId) => this(metricId: metricId);

  @override
  PerformanceWeekValue code(String code) => this(code: code);

  @override
  PerformanceWeekValue name(String name) => this(name: name);

  @override
  PerformanceWeekValue unit(String? unit) => this(unit: unit);

  @override
  PerformanceWeekValue value(num? value) => this(value: value);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PerformanceWeekValue(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PerformanceWeekValue(...).copyWith(id: 12, name: "My name")
  /// ````
  PerformanceWeekValue call({
    Object? metricId = const $CopyWithPlaceholder(),
    Object? code = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? unit = const $CopyWithPlaceholder(),
    Object? value = const $CopyWithPlaceholder(),
  }) {
    return PerformanceWeekValue(
      metricId: metricId == const $CopyWithPlaceholder()
          ? _value.metricId
          // ignore: cast_nullable_to_non_nullable
          : metricId as String,
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
      value: value == const $CopyWithPlaceholder()
          ? _value.value
          // ignore: cast_nullable_to_non_nullable
          : value as num?,
    );
  }
}

extension $PerformanceWeekValueCopyWith on PerformanceWeekValue {
  /// Returns a callable class that can be used as follows: `instanceOfPerformanceWeekValue.copyWith(...)` or like so:`instanceOfPerformanceWeekValue.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PerformanceWeekValueCWProxy get copyWith =>
      _$PerformanceWeekValueCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PerformanceWeekValue _$PerformanceWeekValueFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('PerformanceWeekValue', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['metricId', 'code', 'name', 'unit', 'value'],
  );
  final val = PerformanceWeekValue(
    metricId: $checkedConvert('metricId', (v) => v as String),
    code: $checkedConvert('code', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    unit: $checkedConvert('unit', (v) => v as String?),
    value: $checkedConvert('value', (v) => v as num?),
  );
  return val;
});

Map<String, dynamic> _$PerformanceWeekValueToJson(
  PerformanceWeekValue instance,
) => <String, dynamic>{
  'metricId': instance.metricId,
  'code': instance.code,
  'name': instance.name,
  'unit': instance.unit,
  'value': instance.value,
};
