//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'duty_create_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DutyCreateBody {
  /// Returns a new [DutyCreateBody] instance.
  DutyCreateBody({
    required this.depotId,

    required this.dutyDate,

    this.templateId,

    this.startTime,

    this.endTime,

    this.crossesMidnight,

    this.routeId,

    this.vehicleId,

    this.notes,
  });

  @JsonKey(name: r'depotId', required: true, includeIfNull: false)
  final String depotId;

  /// Calendar date (IST business date)
  @JsonKey(name: r'dutyDate', required: true, includeIfNull: false)
  final String dutyDate;

  /// Takes times (and the default route) from the template
  @JsonKey(name: r'templateId', required: false, includeIfNull: false)
  final String? templateId;

  @JsonKey(name: r'startTime', required: false, includeIfNull: false)
  final String? startTime;

  @JsonKey(name: r'endTime', required: false, includeIfNull: false)
  final String? endTime;

  @JsonKey(name: r'crossesMidnight', required: false, includeIfNull: false)
  final bool? crossesMidnight;

  @JsonKey(name: r'routeId', required: false, includeIfNull: false)
  final String? routeId;

  @JsonKey(name: r'vehicleId', required: false, includeIfNull: false)
  final String? vehicleId;

  @JsonKey(name: r'notes', required: false, includeIfNull: false)
  final String? notes;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DutyCreateBody &&
          other.depotId == depotId &&
          other.dutyDate == dutyDate &&
          other.templateId == templateId &&
          other.startTime == startTime &&
          other.endTime == endTime &&
          other.crossesMidnight == crossesMidnight &&
          other.routeId == routeId &&
          other.vehicleId == vehicleId &&
          other.notes == notes;

  @override
  int get hashCode =>
      depotId.hashCode +
      dutyDate.hashCode +
      templateId.hashCode +
      startTime.hashCode +
      endTime.hashCode +
      crossesMidnight.hashCode +
      routeId.hashCode +
      vehicleId.hashCode +
      notes.hashCode;

  factory DutyCreateBody.fromJson(Map<String, dynamic> json) =>
      _$DutyCreateBodyFromJson(json);

  Map<String, dynamic> toJson() => _$DutyCreateBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
