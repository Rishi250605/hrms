//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bulk_approve_result_skipped_inner.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BulkApproveResultSkippedInner {
  /// Returns a new [BulkApproveResultSkippedInner] instance.
  BulkApproveResultSkippedInner({required this.id, required this.reason});

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'reason', required: true, includeIfNull: false)
  final String reason;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BulkApproveResultSkippedInner &&
          other.id == id &&
          other.reason == reason;

  @override
  int get hashCode => id.hashCode + reason.hashCode;

  factory BulkApproveResultSkippedInner.fromJson(Map<String, dynamic> json) =>
      _$BulkApproveResultSkippedInnerFromJson(json);

  Map<String, dynamic> toJson() => _$BulkApproveResultSkippedInnerToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
