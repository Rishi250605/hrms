//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bulk_approve_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BulkApproveBody {
  /// Returns a new [BulkApproveBody] instance.
  BulkApproveBody({required this.ids});

  @JsonKey(name: r'ids', required: true, includeIfNull: false)
  final List<String> ids;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is BulkApproveBody && other.ids == ids;

  @override
  int get hashCode => ids.hashCode;

  factory BulkApproveBody.fromJson(Map<String, dynamic> json) =>
      _$BulkApproveBodyFromJson(json);

  Map<String, dynamic> toJson() => _$BulkApproveBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
