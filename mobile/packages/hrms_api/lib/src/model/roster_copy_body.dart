//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'roster_copy_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class RosterCopyBody {
  /// Returns a new [RosterCopyBody] instance.
  RosterCopyBody({
    required this.depotId,

    required this.fromDate,

    required this.toDate,

    this.days = 1,

    this.includeAssignments = true,
  });

  @JsonKey(name: r'depotId', required: true, includeIfNull: false)
  final String depotId;

  /// Calendar date (IST business date)
  @JsonKey(name: r'fromDate', required: true, includeIfNull: false)
  final String fromDate;

  /// Calendar date (IST business date)
  @JsonKey(name: r'toDate', required: true, includeIfNull: false)
  final String toDate;

  /// 1 = copy a day, 7 = copy a week
  // minimum: 1
  // maximum: 7
  @JsonKey(
    defaultValue: 1,
    name: r'days',
    required: false,
    includeIfNull: false,
  )
  final int? days;

  @JsonKey(
    defaultValue: true,
    name: r'includeAssignments',
    required: false,
    includeIfNull: false,
  )
  final bool? includeAssignments;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RosterCopyBody &&
          other.depotId == depotId &&
          other.fromDate == fromDate &&
          other.toDate == toDate &&
          other.days == days &&
          other.includeAssignments == includeAssignments;

  @override
  int get hashCode =>
      depotId.hashCode +
      fromDate.hashCode +
      toDate.hashCode +
      days.hashCode +
      includeAssignments.hashCode;

  factory RosterCopyBody.fromJson(Map<String, dynamic> json) =>
      _$RosterCopyBodyFromJson(json);

  Map<String, dynamic> toJson() => _$RosterCopyBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
