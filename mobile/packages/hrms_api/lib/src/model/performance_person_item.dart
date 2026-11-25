//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/business_unit_ref.dart';
import 'package:hrms_api/src/model/person_ref.dart';
import 'package:hrms_api/src/model/performance_rating_item.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'performance_person_item.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PerformancePersonItem {
  /// Returns a new [PerformancePersonItem] instance.
  PerformancePersonItem({
    required this.person,

    required this.businessUnit,

    required this.latestRating,

    required this.lastWeekStart,

    required this.canRate,

    required this.canEnterMetrics,
  });

  @JsonKey(name: r'person', required: true, includeIfNull: false)
  final PersonRef person;

  @JsonKey(name: r'businessUnit', required: true, includeIfNull: false)
  final BusinessUnitRef businessUnit;

  @JsonKey(name: r'latestRating', required: true, includeIfNull: true)
  final PerformanceRatingItem? latestRating;

  /// Latest week with values entered
  @JsonKey(name: r'lastWeekStart', required: true, includeIfNull: true)
  final String? lastWeekStart;

  @JsonKey(name: r'canRate', required: true, includeIfNull: false)
  final bool canRate;

  @JsonKey(name: r'canEnterMetrics', required: true, includeIfNull: false)
  final bool canEnterMetrics;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PerformancePersonItem &&
          other.person == person &&
          other.businessUnit == businessUnit &&
          other.latestRating == latestRating &&
          other.lastWeekStart == lastWeekStart &&
          other.canRate == canRate &&
          other.canEnterMetrics == canEnterMetrics;

  @override
  int get hashCode =>
      person.hashCode +
      businessUnit.hashCode +
      (latestRating == null ? 0 : latestRating.hashCode) +
      (lastWeekStart == null ? 0 : lastWeekStart.hashCode) +
      canRate.hashCode +
      canEnterMetrics.hashCode;

  factory PerformancePersonItem.fromJson(Map<String, dynamic> json) =>
      _$PerformancePersonItemFromJson(json);

  Map<String, dynamic> toJson() => _$PerformancePersonItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
