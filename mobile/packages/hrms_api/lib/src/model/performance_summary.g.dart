// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performance_summary.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PerformanceSummaryCWProxy {
  PerformanceSummary person(PersonRef person);

  PerformanceSummary businessUnit(BusinessUnitRef businessUnit);

  PerformanceSummary latestRating(PerformanceRatingItem? latestRating);

  PerformanceSummary ratings(List<PerformanceRatingItem> ratings);

  PerformanceSummary weeks(List<PerformanceWeek> weeks);

  PerformanceSummary canRate(bool canRate);

  PerformanceSummary canEnterMetrics(bool canEnterMetrics);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PerformanceSummary(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PerformanceSummary(...).copyWith(id: 12, name: "My name")
  /// ````
  PerformanceSummary call({
    PersonRef person,
    BusinessUnitRef businessUnit,
    PerformanceRatingItem? latestRating,
    List<PerformanceRatingItem> ratings,
    List<PerformanceWeek> weeks,
    bool canRate,
    bool canEnterMetrics,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPerformanceSummary.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPerformanceSummary.copyWith.fieldName(...)`
class _$PerformanceSummaryCWProxyImpl implements _$PerformanceSummaryCWProxy {
  const _$PerformanceSummaryCWProxyImpl(this._value);

  final PerformanceSummary _value;

  @override
  PerformanceSummary person(PersonRef person) => this(person: person);

  @override
  PerformanceSummary businessUnit(BusinessUnitRef businessUnit) =>
      this(businessUnit: businessUnit);

  @override
  PerformanceSummary latestRating(PerformanceRatingItem? latestRating) =>
      this(latestRating: latestRating);

  @override
  PerformanceSummary ratings(List<PerformanceRatingItem> ratings) =>
      this(ratings: ratings);

  @override
  PerformanceSummary weeks(List<PerformanceWeek> weeks) => this(weeks: weeks);

  @override
  PerformanceSummary canRate(bool canRate) => this(canRate: canRate);

  @override
  PerformanceSummary canEnterMetrics(bool canEnterMetrics) =>
      this(canEnterMetrics: canEnterMetrics);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PerformanceSummary(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PerformanceSummary(...).copyWith(id: 12, name: "My name")
  /// ````
  PerformanceSummary call({
    Object? person = const $CopyWithPlaceholder(),
    Object? businessUnit = const $CopyWithPlaceholder(),
    Object? latestRating = const $CopyWithPlaceholder(),
    Object? ratings = const $CopyWithPlaceholder(),
    Object? weeks = const $CopyWithPlaceholder(),
    Object? canRate = const $CopyWithPlaceholder(),
    Object? canEnterMetrics = const $CopyWithPlaceholder(),
  }) {
    return PerformanceSummary(
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
      ratings: ratings == const $CopyWithPlaceholder()
          ? _value.ratings
          // ignore: cast_nullable_to_non_nullable
          : ratings as List<PerformanceRatingItem>,
      weeks: weeks == const $CopyWithPlaceholder()
          ? _value.weeks
          // ignore: cast_nullable_to_non_nullable
          : weeks as List<PerformanceWeek>,
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

extension $PerformanceSummaryCopyWith on PerformanceSummary {
  /// Returns a callable class that can be used as follows: `instanceOfPerformanceSummary.copyWith(...)` or like so:`instanceOfPerformanceSummary.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PerformanceSummaryCWProxy get copyWith =>
      _$PerformanceSummaryCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PerformanceSummary _$PerformanceSummaryFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PerformanceSummary', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'person',
          'businessUnit',
          'latestRating',
          'ratings',
          'weeks',
          'canRate',
          'canEnterMetrics',
        ],
      );
      final val = PerformanceSummary(
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
        ratings: $checkedConvert(
          'ratings',
          (v) => (v as List<dynamic>)
              .map(
                (e) =>
                    PerformanceRatingItem.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
        ),
        weeks: $checkedConvert(
          'weeks',
          (v) => (v as List<dynamic>)
              .map((e) => PerformanceWeek.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        canRate: $checkedConvert('canRate', (v) => v as bool),
        canEnterMetrics: $checkedConvert('canEnterMetrics', (v) => v as bool),
      );
      return val;
    });

Map<String, dynamic> _$PerformanceSummaryToJson(PerformanceSummary instance) =>
    <String, dynamic>{
      'person': instance.person.toJson(),
      'businessUnit': instance.businessUnit.toJson(),
      'latestRating': instance.latestRating?.toJson(),
      'ratings': instance.ratings.map((e) => e.toJson()).toList(),
      'weeks': instance.weeks.map((e) => e.toJson()).toList(),
      'canRate': instance.canRate,
      'canEnterMetrics': instance.canEnterMetrics,
    };
