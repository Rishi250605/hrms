//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/bulk_result_item.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bulk_attendance_result.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BulkAttendanceResult {
  /// Returns a new [BulkAttendanceResult] instance.
  BulkAttendanceResult({
    required this.applied,

    required this.duplicates,

    required this.rejected,

    required this.results,
  });

  @JsonKey(name: r'applied', required: true, includeIfNull: false)
  final int applied;

  @JsonKey(name: r'duplicates', required: true, includeIfNull: false)
  final int duplicates;

  @JsonKey(name: r'rejected', required: true, includeIfNull: false)
  final int rejected;

  @JsonKey(name: r'results', required: true, includeIfNull: false)
  final List<BulkResultItem> results;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BulkAttendanceResult &&
          other.applied == applied &&
          other.duplicates == duplicates &&
          other.rejected == rejected &&
          other.results == results;

  @override
  int get hashCode =>
      applied.hashCode +
      duplicates.hashCode +
      rejected.hashCode +
      results.hashCode;

  factory BulkAttendanceResult.fromJson(Map<String, dynamic> json) =>
      _$BulkAttendanceResultFromJson(json);

  Map<String, dynamic> toJson() => _$BulkAttendanceResultToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
