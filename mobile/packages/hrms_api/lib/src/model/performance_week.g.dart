// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performance_week.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PerformanceWeekCWProxy {
  PerformanceWeek weekStart(String weekStart);

  PerformanceWeek values(List<PerformanceWeekValue> values);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PerformanceWeek(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PerformanceWeek(...).copyWith(id: 12, name: "My name")
  /// ````
  PerformanceWeek call({String weekStart, List<PerformanceWeekValue> values});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPerformanceWeek.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPerformanceWeek.copyWith.fieldName(...)`
class _$PerformanceWeekCWProxyImpl implements _$PerformanceWeekCWProxy {
  const _$PerformanceWeekCWProxyImpl(this._value);

  final PerformanceWeek _value;

  @override
  PerformanceWeek weekStart(String weekStart) => this(weekStart: weekStart);

  @override
  PerformanceWeek values(List<PerformanceWeekValue> values) =>
      this(values: values);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PerformanceWeek(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PerformanceWeek(...).copyWith(id: 12, name: "My name")
  /// ````
  PerformanceWeek call({
    Object? weekStart = const $CopyWithPlaceholder(),
    Object? values = const $CopyWithPlaceholder(),
  }) {
    return PerformanceWeek(
      weekStart: weekStart == const $CopyWithPlaceholder()
          ? _value.weekStart
          // ignore: cast_nullable_to_non_nullable
          : weekStart as String,
      values: values == const $CopyWithPlaceholder()
          ? _value.values
          // ignore: cast_nullable_to_non_nullable
          : values as List<PerformanceWeekValue>,
    );
  }
}

extension $PerformanceWeekCopyWith on PerformanceWeek {
  /// Returns a callable class that can be used as follows: `instanceOfPerformanceWeek.copyWith(...)` or like so:`instanceOfPerformanceWeek.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PerformanceWeekCWProxy get copyWith => _$PerformanceWeekCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PerformanceWeek _$PerformanceWeekFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PerformanceWeek', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['weekStart', 'values']);
      final val = PerformanceWeek(
        weekStart: $checkedConvert('weekStart', (v) => v as String),
        values: $checkedConvert(
          'values',
          (v) => (v as List<dynamic>)
              .map(
                (e) => PerformanceWeekValue.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$PerformanceWeekToJson(PerformanceWeek instance) =>
    <String, dynamic>{
      'weekStart': instance.weekStart,
      'values': instance.values.map((e) => e.toJson()).toList(),
    };
