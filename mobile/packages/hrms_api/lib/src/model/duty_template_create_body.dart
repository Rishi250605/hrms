//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'duty_template_create_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DutyTemplateCreateBody {
  /// Returns a new [DutyTemplateCreateBody] instance.
  DutyTemplateCreateBody({
    required this.depotId,

    required this.name,

    required this.startTime,

    required this.endTime,

    this.crossesMidnight,

    this.routeId,
  });

  @JsonKey(name: r'depotId', required: true, includeIfNull: false)
  final String depotId;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'startTime', required: true, includeIfNull: false)
  final String startTime;

  @JsonKey(name: r'endTime', required: true, includeIfNull: false)
  final String endTime;

  /// Defaults to true when endTime <= startTime
  @JsonKey(name: r'crossesMidnight', required: false, includeIfNull: false)
  final bool? crossesMidnight;

  @JsonKey(name: r'routeId', required: false, includeIfNull: false)
  final String? routeId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DutyTemplateCreateBody &&
          other.depotId == depotId &&
          other.name == name &&
          other.startTime == startTime &&
          other.endTime == endTime &&
          other.crossesMidnight == crossesMidnight &&
          other.routeId == routeId;

  @override
  int get hashCode =>
      depotId.hashCode +
      name.hashCode +
      startTime.hashCode +
      endTime.hashCode +
      crossesMidnight.hashCode +
      routeId.hashCode;

  factory DutyTemplateCreateBody.fromJson(Map<String, dynamic> json) =>
      _$DutyTemplateCreateBodyFromJson(json);

  Map<String, dynamic> toJson() => _$DutyTemplateCreateBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
