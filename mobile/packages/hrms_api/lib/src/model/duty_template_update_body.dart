//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'duty_template_update_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DutyTemplateUpdateBody {
  /// Returns a new [DutyTemplateUpdateBody] instance.
  DutyTemplateUpdateBody({
    this.name,

    this.startTime,

    this.endTime,

    this.crossesMidnight,

    this.routeId,

    this.archived,
  });

  @JsonKey(name: r'name', required: false, includeIfNull: false)
  final String? name;

  @JsonKey(name: r'startTime', required: false, includeIfNull: false)
  final String? startTime;

  @JsonKey(name: r'endTime', required: false, includeIfNull: false)
  final String? endTime;

  @JsonKey(name: r'crossesMidnight', required: false, includeIfNull: false)
  final bool? crossesMidnight;

  @JsonKey(name: r'routeId', required: false, includeIfNull: false)
  final String? routeId;

  @JsonKey(name: r'archived', required: false, includeIfNull: false)
  final bool? archived;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DutyTemplateUpdateBody &&
          other.name == name &&
          other.startTime == startTime &&
          other.endTime == endTime &&
          other.crossesMidnight == crossesMidnight &&
          other.routeId == routeId &&
          other.archived == archived;

  @override
  int get hashCode =>
      name.hashCode +
      startTime.hashCode +
      endTime.hashCode +
      crossesMidnight.hashCode +
      (routeId == null ? 0 : routeId.hashCode) +
      archived.hashCode;

  factory DutyTemplateUpdateBody.fromJson(Map<String, dynamic> json) =>
      _$DutyTemplateUpdateBodyFromJson(json);

  Map<String, dynamic> toJson() => _$DutyTemplateUpdateBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
