//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/bulk_approve_result_skipped_inner.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bulk_approve_result.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BulkApproveResult {
  /// Returns a new [BulkApproveResult] instance.
  BulkApproveResult({required this.approved, required this.skipped});

  @JsonKey(name: r'approved', required: true, includeIfNull: false)
  final List<String> approved;

  @JsonKey(name: r'skipped', required: true, includeIfNull: false)
  final List<BulkApproveResultSkippedInner> skipped;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BulkApproveResult &&
          other.approved == approved &&
          other.skipped == skipped;

  @override
  int get hashCode => approved.hashCode + skipped.hashCode;

  factory BulkApproveResult.fromJson(Map<String, dynamic> json) =>
      _$BulkApproveResultFromJson(json);

  Map<String, dynamic> toJson() => _$BulkApproveResultToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
