//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'performance_rating_create_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PerformanceRatingCreateBody {
  /// Returns a new [PerformanceRatingCreateBody] instance.
  PerformanceRatingCreateBody({required this.rating, this.comment});

  // minimum: 1
  // maximum: 5
  @JsonKey(name: r'rating', required: true, includeIfNull: false)
  final int rating;

  @JsonKey(name: r'comment', required: false, includeIfNull: false)
  final String? comment;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PerformanceRatingCreateBody &&
          other.rating == rating &&
          other.comment == comment;

  @override
  int get hashCode => rating.hashCode + comment.hashCode;

  factory PerformanceRatingCreateBody.fromJson(Map<String, dynamic> json) =>
      _$PerformanceRatingCreateBodyFromJson(json);

  Map<String, dynamic> toJson() => _$PerformanceRatingCreateBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
