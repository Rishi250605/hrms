//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'leave_policy_update_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class LeavePolicyUpdateBody {
  /// Returns a new [LeavePolicyUpdateBody] instance.
  LeavePolicyUpdateBody({required this.annualQuota});

  // minimum: 0
  // maximum: 365
  @JsonKey(name: r'annualQuota', required: true, includeIfNull: false)
  final num annualQuota;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LeavePolicyUpdateBody && other.annualQuota == annualQuota;

  @override
  int get hashCode => annualQuota.hashCode;

  factory LeavePolicyUpdateBody.fromJson(Map<String, dynamic> json) =>
      _$LeavePolicyUpdateBodyFromJson(json);

  Map<String, dynamic> toJson() => _$LeavePolicyUpdateBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
