//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/duty_status.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'duty_update_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DutyUpdateBody {
  /// Returns a new [DutyUpdateBody] instance.
  DutyUpdateBody({
    this.startTime,

    this.endTime,

    this.crossesMidnight,

    this.routeId,

    this.vehicleId,

    this.status,

    this.notes,
  });

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

  @JsonKey(name: r'status', required: false, includeIfNull: false)
  final DutyStatus? status;

  @JsonKey(name: r'notes', required: false, includeIfNull: false)
  final String? notes;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DutyUpdateBody &&
          other.startTime == startTime &&
          other.endTime == endTime &&
          other.crossesMidnight == crossesMidnight &&
          other.routeId == routeId &&
          other.vehicleId == vehicleId &&
          other.status == status &&
          other.notes == notes;

  @override
  int get hashCode =>
      startTime.hashCode +
      endTime.hashCode +
      crossesMidnight.hashCode +
      (routeId == null ? 0 : routeId.hashCode) +
      (vehicleId == null ? 0 : vehicleId.hashCode) +
      status.hashCode +
      (notes == null ? 0 : notes.hashCode);

  factory DutyUpdateBody.fromJson(Map<String, dynamic> json) =>
      _$DutyUpdateBodyFromJson(json);

  Map<String, dynamic> toJson() => _$DutyUpdateBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
