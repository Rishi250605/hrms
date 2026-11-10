//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'route_update_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class RouteUpdateBody {
  /// Returns a new [RouteUpdateBody] instance.
  RouteUpdateBody({
    this.name,

    this.origin,

    this.destination,

    this.distanceKm,

    this.standardMinutes,

    this.archived,
  });

  @JsonKey(name: r'name', required: false, includeIfNull: false)
  final String? name;

  @JsonKey(name: r'origin', required: false, includeIfNull: false)
  final String? origin;

  @JsonKey(name: r'destination', required: false, includeIfNull: false)
  final String? destination;

  // minimum: 0
  // maximum: 5000
  @JsonKey(name: r'distanceKm', required: false, includeIfNull: false)
  final num? distanceKm;

  // minimum: 0
  // maximum: 2880
  @JsonKey(name: r'standardMinutes', required: false, includeIfNull: false)
  final int? standardMinutes;

  @JsonKey(name: r'archived', required: false, includeIfNull: false)
  final bool? archived;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RouteUpdateBody &&
          other.name == name &&
          other.origin == origin &&
          other.destination == destination &&
          other.distanceKm == distanceKm &&
          other.standardMinutes == standardMinutes &&
          other.archived == archived;

  @override
  int get hashCode =>
      name.hashCode +
      origin.hashCode +
      destination.hashCode +
      (distanceKm == null ? 0 : distanceKm.hashCode) +
      standardMinutes.hashCode +
      archived.hashCode;

  factory RouteUpdateBody.fromJson(Map<String, dynamic> json) =>
      _$RouteUpdateBodyFromJson(json);

  Map<String, dynamic> toJson() => _$RouteUpdateBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
