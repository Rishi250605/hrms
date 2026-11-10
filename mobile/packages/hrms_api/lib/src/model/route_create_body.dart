//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'route_create_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class RouteCreateBody {
  /// Returns a new [RouteCreateBody] instance.
  RouteCreateBody({
    required this.code,

    required this.name,

    required this.origin,

    required this.destination,

    this.distanceKm,

    required this.standardMinutes,

    required this.depotId,
  });

  @JsonKey(name: r'code', required: true, includeIfNull: false)
  final String code;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'origin', required: true, includeIfNull: false)
  final String origin;

  @JsonKey(name: r'destination', required: true, includeIfNull: false)
  final String destination;

  // minimum: 0
  // maximum: 5000
  @JsonKey(name: r'distanceKm', required: false, includeIfNull: false)
  final num? distanceKm;

  // minimum: 0
  // maximum: 2880
  @JsonKey(name: r'standardMinutes', required: true, includeIfNull: false)
  final int standardMinutes;

  @JsonKey(name: r'depotId', required: true, includeIfNull: false)
  final String depotId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RouteCreateBody &&
          other.code == code &&
          other.name == name &&
          other.origin == origin &&
          other.destination == destination &&
          other.distanceKm == distanceKm &&
          other.standardMinutes == standardMinutes &&
          other.depotId == depotId;

  @override
  int get hashCode =>
      code.hashCode +
      name.hashCode +
      origin.hashCode +
      destination.hashCode +
      distanceKm.hashCode +
      standardMinutes.hashCode +
      depotId.hashCode;

  factory RouteCreateBody.fromJson(Map<String, dynamic> json) =>
      _$RouteCreateBodyFromJson(json);

  Map<String, dynamic> toJson() => _$RouteCreateBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
