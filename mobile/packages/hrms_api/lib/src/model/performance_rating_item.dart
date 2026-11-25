//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/person_ref.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'performance_rating_item.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PerformanceRatingItem {
  /// Returns a new [PerformanceRatingItem] instance.
  PerformanceRatingItem({
    required this.id,

    required this.rating,

    required this.comment,

    required this.ratedBy,

    required this.createdAt,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  // minimum: 1
  // maximum: 5
  @JsonKey(name: r'rating', required: true, includeIfNull: false)
  final int rating;

  @JsonKey(name: r'comment', required: true, includeIfNull: true)
  final String? comment;

  @JsonKey(name: r'ratedBy', required: true, includeIfNull: false)
  final PersonRef ratedBy;

  @JsonKey(name: r'createdAt', required: true, includeIfNull: false)
  final DateTime createdAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PerformanceRatingItem &&
          other.id == id &&
          other.rating == rating &&
          other.comment == comment &&
          other.ratedBy == ratedBy &&
          other.createdAt == createdAt;

  @override
  int get hashCode =>
      id.hashCode +
      rating.hashCode +
      (comment == null ? 0 : comment.hashCode) +
      ratedBy.hashCode +
      createdAt.hashCode;

  factory PerformanceRatingItem.fromJson(Map<String, dynamic> json) =>
      _$PerformanceRatingItemFromJson(json);

  Map<String, dynamic> toJson() => _$PerformanceRatingItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
