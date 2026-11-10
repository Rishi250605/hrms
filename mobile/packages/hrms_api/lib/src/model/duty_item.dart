//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/assignment_item.dart';
import 'package:hrms_api/src/model/leave_request_item_leave_type.dart';
import 'package:hrms_api/src/model/duty_item_template.dart';
import 'package:hrms_api/src/model/duty_item_vehicle.dart';
import 'package:hrms_api/src/model/duty_status.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'duty_item.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DutyItem {
  /// Returns a new [DutyItem] instance.
  DutyItem({
    required this.id,

    required this.depotId,

    required this.dutyDate,

    required this.status,

    required this.scheduledStart,

    required this.scheduledEnd,

    required this.startTime,

    required this.endTime,

    required this.crossesMidnight,

    required this.durationMinutes,

    required this.route,

    required this.vehicle,

    required this.template,

    required this.notes,

    required this.filled,

    required this.assignments,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'depotId', required: true, includeIfNull: false)
  final String depotId;

  /// Calendar date (IST business date)
  @JsonKey(name: r'dutyDate', required: true, includeIfNull: false)
  final String dutyDate;

  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final DutyStatus status;

  @JsonKey(name: r'scheduledStart', required: true, includeIfNull: false)
  final DateTime scheduledStart;

  @JsonKey(name: r'scheduledEnd', required: true, includeIfNull: false)
  final DateTime scheduledEnd;

  @JsonKey(name: r'startTime', required: true, includeIfNull: false)
  final String startTime;

  @JsonKey(name: r'endTime', required: true, includeIfNull: false)
  final String endTime;

  @JsonKey(name: r'crossesMidnight', required: true, includeIfNull: false)
  final bool crossesMidnight;

  @JsonKey(name: r'durationMinutes', required: true, includeIfNull: false)
  final int durationMinutes;

  @JsonKey(name: r'route', required: true, includeIfNull: true)
  final LeaveRequestItemLeaveType? route;

  @JsonKey(name: r'vehicle', required: true, includeIfNull: true)
  final DutyItemVehicle? vehicle;

  @JsonKey(name: r'template', required: true, includeIfNull: true)
  final DutyItemTemplate? template;

  @JsonKey(name: r'notes', required: true, includeIfNull: true)
  final String? notes;

  @JsonKey(name: r'filled', required: true, includeIfNull: false)
  final bool filled;

  @JsonKey(name: r'assignments', required: true, includeIfNull: false)
  final List<AssignmentItem> assignments;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DutyItem &&
          other.id == id &&
          other.depotId == depotId &&
          other.dutyDate == dutyDate &&
          other.status == status &&
          other.scheduledStart == scheduledStart &&
          other.scheduledEnd == scheduledEnd &&
          other.startTime == startTime &&
          other.endTime == endTime &&
          other.crossesMidnight == crossesMidnight &&
          other.durationMinutes == durationMinutes &&
          other.route == route &&
          other.vehicle == vehicle &&
          other.template == template &&
          other.notes == notes &&
          other.filled == filled &&
          other.assignments == assignments;

  @override
  int get hashCode =>
      id.hashCode +
      depotId.hashCode +
      dutyDate.hashCode +
      status.hashCode +
      scheduledStart.hashCode +
      scheduledEnd.hashCode +
      startTime.hashCode +
      endTime.hashCode +
      crossesMidnight.hashCode +
      durationMinutes.hashCode +
      (route == null ? 0 : route.hashCode) +
      (vehicle == null ? 0 : vehicle.hashCode) +
      (template == null ? 0 : template.hashCode) +
      (notes == null ? 0 : notes.hashCode) +
      filled.hashCode +
      assignments.hashCode;

  factory DutyItem.fromJson(Map<String, dynamic> json) =>
      _$DutyItemFromJson(json);

  Map<String, dynamic> toJson() => _$DutyItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
