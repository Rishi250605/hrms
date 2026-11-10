//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'roster_day_summary.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class RosterDaySummary {
  /// Returns a new [RosterDaySummary] instance.
  RosterDaySummary({
    required this.duties,

    required this.filled,

    required this.unfilled,

    required this.cancelled,
  });

  @JsonKey(name: r'duties', required: true, includeIfNull: false)
  final int duties;

  @JsonKey(name: r'filled', required: true, includeIfNull: false)
  final int filled;

  @JsonKey(name: r'unfilled', required: true, includeIfNull: false)
  final int unfilled;

  @JsonKey(name: r'cancelled', required: true, includeIfNull: false)
  final int cancelled;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RosterDaySummary &&
          other.duties == duties &&
          other.filled == filled &&
          other.unfilled == unfilled &&
          other.cancelled == cancelled;

  @override
  int get hashCode =>
      duties.hashCode +
      filled.hashCode +
      unfilled.hashCode +
      cancelled.hashCode;

  factory RosterDaySummary.fromJson(Map<String, dynamic> json) =>
      _$RosterDaySummaryFromJson(json);

  Map<String, dynamic> toJson() => _$RosterDaySummaryToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
