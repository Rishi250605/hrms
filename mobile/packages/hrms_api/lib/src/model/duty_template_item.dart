//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/leave_request_item_leave_type.dart';
import 'package:hrms_api/src/model/depot_summary.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'duty_template_item.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DutyTemplateItem {
  /// Returns a new [DutyTemplateItem] instance.
  DutyTemplateItem({
    required this.id,

    required this.name,

    required this.startTime,

    required this.endTime,

    required this.crossesMidnight,

    required this.route,

    required this.depot,

    required this.archived,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'startTime', required: true, includeIfNull: false)
  final String startTime;

  @JsonKey(name: r'endTime', required: true, includeIfNull: false)
  final String endTime;

  @JsonKey(name: r'crossesMidnight', required: true, includeIfNull: false)
  final bool crossesMidnight;

  @JsonKey(name: r'route', required: true, includeIfNull: true)
  final LeaveRequestItemLeaveType? route;

  @JsonKey(name: r'depot', required: true, includeIfNull: false)
  final DepotSummary depot;

  @JsonKey(name: r'archived', required: true, includeIfNull: false)
  final bool archived;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DutyTemplateItem &&
          other.id == id &&
          other.name == name &&
          other.startTime == startTime &&
          other.endTime == endTime &&
          other.crossesMidnight == crossesMidnight &&
          other.route == route &&
          other.depot == depot &&
          other.archived == archived;

  @override
  int get hashCode =>
      id.hashCode +
      name.hashCode +
      startTime.hashCode +
      endTime.hashCode +
      crossesMidnight.hashCode +
      (route == null ? 0 : route.hashCode) +
      depot.hashCode +
      archived.hashCode;

  factory DutyTemplateItem.fromJson(Map<String, dynamic> json) =>
      _$DutyTemplateItemFromJson(json);

  Map<String, dynamic> toJson() => _$DutyTemplateItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
