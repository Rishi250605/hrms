// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performance_person_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PerformancePersonItemCWProxy {
  PerformancePersonItem person(PersonRef person);

  PerformancePersonItem businessUnit(BusinessUnitRef businessUnit);

  PerformancePersonItem latestRating(PerformanceRatingItem? latestRating);

  PerformancePersonItem lastWeekStart(String? lastWeekStart);

  PerformancePersonItem canRate(bool canRate);

  PerformancePersonItem canEnterMetrics(bool canEnterMetrics);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PerformancePersonItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PerformancePersonItem(...).copyWith(id: 12, name: "My name")
  /// ````
  PerformancePersonItem call({
    PersonRef person,
    BusinessUnitRef businessUnit,
    PerformanceRatingItem? latestRating,
    String? lastWeekStart,
    bool canRate,
    bool canEnterMetrics,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPerformancePersonItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPerformancePersonItem.copyWith.fieldName(...)`
class _$PerformancePersonItemCWProxyImpl
    implements _$PerformancePersonItemCWProxy {
  const _$PerformancePersonItemCWProxyImpl(this._value);

  final PerformancePersonItem _value;

  @override
  PerformancePersonItem person(PersonRef person) => this(person: person);

  @override
  PerformancePersonItem businessUnit(BusinessUnitRef businessUnit) =>
      this(businessUnit: businessUnit);

  @override
  PerformancePersonItem latestRating(PerformanceRatingItem? latestRating) =>
      this(latestRating: latestRating);

  @override
  PerformancePersonItem lastWeekStart(String? lastWeekStart) =>
      this(lastWeekStart: lastWeekStart);

  @override
  PerformancePersonItem canRate(bool canRate) => this(canRate: canRate);

  @override
  PerformancePersonItem canEnterMetrics(bool canEnterMetrics) =>
      this(canEnterMetrics: canEnterMetrics);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PerformancePersonItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PerformancePersonItem(...).copyWith(id: 12, name: "My name")
  /// ````
  PerformancePersonItem call({
    Object? person = const $CopyWithPlaceholder(),
    Object? businessUnit = const $CopyWithPlaceholder(),
    Object? latestRating = const $CopyWithPlaceholder(),
    Object? lastWeekStart = const $CopyWithPlaceholder(),
    Object? canRate = const $CopyWithPlaceholder(),
    Object? canEnterMetrics = const $CopyWithPlaceholder(),
  }) {
    return PerformancePersonItem(
      person: person == const $CopyWithPlaceholder()
          ? _value.person
          // ignore: cast_nullable_to_non_nullable
          : person as PersonRef,
      businessUnit: businessUnit == const $CopyWithPlaceholder()
          ? _value.businessUnit
          // ignore: cast_nullable_to_non_nullable
          : businessUnit as BusinessUnitRef,
      latestRating: latestRating == const $CopyWithPlaceholder()
          ? _value.latestRating
          // ignore: cast_nullable_to_non_nullable
          : latestRating as PerformanceRatingItem?,
      lastWeekStart: lastWeekStart == const $CopyWithPlaceholder()
          ? _value.lastWeekStart
          // ignore: cast_nullable_to_non_nullable
          : lastWeekStart as String?,
      canRate: canRate == const $CopyWithPlaceholder()
          ? _value.canRate
          // ignore: cast_nullable_to_non_nullable
          : canRate as bool,
      canEnterMetrics: canEnterMetrics == const $CopyWithPlaceholder()
          ? _value.canEnterMetrics
          // ignore: cast_nullable_to_non_nullable
          : canEnterMetrics as bool,
    );
  }
}

extension $PerformancePersonItemCopyWith on PerformancePersonItem {
  /// Returns a callable class that can be used as follows: `instanceOfPerformancePersonItem.copyWith(...)` or like so:`instanceOfPerformancePersonItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PerformancePersonItemCWProxy get copyWith =>
      _$PerformancePersonItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PerformancePersonItem _$PerformancePersonItemFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('PerformancePersonItem', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'person',
      'businessUnit',
      'latestRating',
      'lastWeekStart',
      'canRate',
      'canEnterMetrics',
    ],
  );
  final val = PerformancePersonItem(
    person: $checkedConvert(
      'person',
      (v) => PersonRef.fromJson(v as Map<String, dynamic>),
    ),
    businessUnit: $checkedConvert(
      'businessUnit',
      (v) => BusinessUnitRef.fromJson(v as Map<String, dynamic>),
    ),
    latestRating: $checkedConvert(
      'latestRating',
      (v) => v == null
          ? null
          : PerformanceRatingItem.fromJson(v as Map<String, dynamic>),
    ),
    lastWeekStart: $checkedConvert('lastWeekStart', (v) => v as String?),
    canRate: $checkedConvert('canRate', (v) => v as bool),
    canEnterMetrics: $checkedConvert('canEnterMetrics', (v) => v as bool),
  );
  return val;
});

Map<String, dynamic> _$PerformancePersonItemToJson(
  PerformancePersonItem instance,
) => <String, dynamic>{
  'person': instance.person.toJson(),
  'businessUnit': instance.businessUnit.toJson(),
  'latestRating': instance.latestRating?.toJson(),
  'lastWeekStart': instance.lastWeekStart,
  'canRate': instance.canRate,
  'canEnterMetrics': instance.canEnterMetrics,
};
