//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'batch_approve_result.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BatchApproveResult {
  /// Returns a new [BatchApproveResult] instance.
  BatchApproveResult({required this.approved, required this.skipped});

  @JsonKey(name: r'approved', required: true, includeIfNull: false)
  final List<String> approved;

  @JsonKey(name: r'skipped', required: true, includeIfNull: false)
  final List<String> skipped;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BatchApproveResult &&
          other.approved == approved &&
          other.skipped == skipped;

  @override
  int get hashCode => approved.hashCode + skipped.hashCode;

  factory BatchApproveResult.fromJson(Map<String, dynamic> json) =>
      _$BatchApproveResultFromJson(json);

  Map<String, dynamic> toJson() => _$BatchApproveResultToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
