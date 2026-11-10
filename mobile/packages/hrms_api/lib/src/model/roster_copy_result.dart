//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/roster_copy_result_skipped_inner.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'roster_copy_result.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class RosterCopyResult {
  /// Returns a new [RosterCopyResult] instance.
  RosterCopyResult({
    required this.createdDuties,

    required this.existingDuties,

    required this.copiedAssignments,

    required this.skipped,
  });

  @JsonKey(name: r'createdDuties', required: true, includeIfNull: false)
  final int createdDuties;

  /// Source duties already present on the target day (not copied twice)
  @JsonKey(name: r'existingDuties', required: true, includeIfNull: false)
  final int existingDuties;

  @JsonKey(name: r'copiedAssignments', required: true, includeIfNull: false)
  final int copiedAssignments;

  @JsonKey(name: r'skipped', required: true, includeIfNull: false)
  final List<RosterCopyResultSkippedInner> skipped;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RosterCopyResult &&
          other.createdDuties == createdDuties &&
          other.existingDuties == existingDuties &&
          other.copiedAssignments == copiedAssignments &&
          other.skipped == skipped;

  @override
  int get hashCode =>
      createdDuties.hashCode +
      existingDuties.hashCode +
      copiedAssignments.hashCode +
      skipped.hashCode;

  factory RosterCopyResult.fromJson(Map<String, dynamic> json) =>
      _$RosterCopyResultFromJson(json);

  Map<String, dynamic> toJson() => _$RosterCopyResultToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
