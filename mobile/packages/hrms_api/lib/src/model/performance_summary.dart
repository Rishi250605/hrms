//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/business_unit_ref.dart';
import 'package:hrms_api/src/model/person_ref.dart';
import 'package:hrms_api/src/model/performance_rating_item.dart';
import 'package:hrms_api/src/model/performance_week.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'performance_summary.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PerformanceSummary {
  /// Returns a new [PerformanceSummary] instance.
  PerformanceSummary({
    required this.person,

    required this.businessUnit,

    required this.latestRating,

    required this.ratings,

    required this.weeks,

    required this.canRate,

    required this.canEnterMetrics,
  });

  @JsonKey(name: r'person', required: true, includeIfNull: false)
  final PersonRef person;

  @JsonKey(name: r'businessUnit', required: true, includeIfNull: false)
  final BusinessUnitRef businessUnit;

  @JsonKey(name: r'latestRating', required: true, includeIfNull: true)
  final PerformanceRatingItem? latestRating;

  /// Rating history, newest first (last 50)
  @JsonKey(name: r'ratings', required: true, includeIfNull: false)
  final List<PerformanceRatingItem> ratings;

  /// Weeks with at least one value, newest first
  @JsonKey(name: r'weeks', required: true, includeIfNull: false)
  final List<PerformanceWeek> weeks;

  @JsonKey(name: r'canRate', required: true, includeIfNull: false)
  final bool canRate;

  @JsonKey(name: r'canEnterMetrics', required: true, includeIfNull: false)
  final bool canEnterMetrics;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PerformanceSummary &&
          other.person == person &&
          other.businessUnit == businessUnit &&
          other.latestRating == latestRating &&
          other.ratings == ratings &&
          other.weeks == weeks &&
          other.canRate == canRate &&
          other.canEnterMetrics == canEnterMetrics;

  @override
  int get hashCode =>
      person.hashCode +
      businessUnit.hashCode +
      (latestRating == null ? 0 : latestRating.hashCode) +
      ratings.hashCode +
      weeks.hashCode +
      canRate.hashCode +
      canEnterMetrics.hashCode;

  factory PerformanceSummary.fromJson(Map<String, dynamic> json) =>
      _$PerformanceSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$PerformanceSummaryToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
