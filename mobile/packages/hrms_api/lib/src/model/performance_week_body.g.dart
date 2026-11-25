// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performance_week_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PerformanceWeekBodyCWProxy {
  PerformanceWeekBody values(List<PerformanceWeekBodyValuesInner> values);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PerformanceWeekBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PerformanceWeekBody(...).copyWith(id: 12, name: "My name")
  /// ````
  PerformanceWeekBody call({List<PerformanceWeekBodyValuesInner> values});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPerformanceWeekBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPerformanceWeekBody.copyWith.fieldName(...)`
class _$PerformanceWeekBodyCWProxyImpl implements _$PerformanceWeekBodyCWProxy {
  const _$PerformanceWeekBodyCWProxyImpl(this._value);

  final PerformanceWeekBody _value;

  @override
  PerformanceWeekBody values(List<PerformanceWeekBodyValuesInner> values) =>
      this(values: values);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PerformanceWeekBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PerformanceWeekBody(...).copyWith(id: 12, name: "My name")
  /// ````
  PerformanceWeekBody call({Object? values = const $CopyWithPlaceholder()}) {
    return PerformanceWeekBody(
      values: values == const $CopyWithPlaceholder()
          ? _value.values
          // ignore: cast_nullable_to_non_nullable
          : values as List<PerformanceWeekBodyValuesInner>,
    );
  }
}

extension $PerformanceWeekBodyCopyWith on PerformanceWeekBody {
  /// Returns a callable class that can be used as follows: `instanceOfPerformanceWeekBody.copyWith(...)` or like so:`instanceOfPerformanceWeekBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PerformanceWeekBodyCWProxy get copyWith =>
      _$PerformanceWeekBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PerformanceWeekBody _$PerformanceWeekBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PerformanceWeekBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['values']);
      final val = PerformanceWeekBody(
        values: $checkedConvert(
          'values',
          (v) => (v as List<dynamic>)
              .map(
                (e) => PerformanceWeekBodyValuesInner.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$PerformanceWeekBodyToJson(
  PerformanceWeekBody instance,
) => <String, dynamic>{
  'values': instance.values.map((e) => e.toJson()).toList(),
};
