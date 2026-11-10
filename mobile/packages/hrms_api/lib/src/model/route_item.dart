//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/depot_summary.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'route_item.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class RouteItem {
  /// Returns a new [RouteItem] instance.
  RouteItem({
    required this.id,

    required this.code,

    required this.name,

    required this.origin,

    required this.destination,

    required this.distanceKm,

    required this.standardMinutes,

    required this.depot,

    required this.archived,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'code', required: true, includeIfNull: false)
  final String code;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'origin', required: true, includeIfNull: false)
  final String origin;

  @JsonKey(name: r'destination', required: true, includeIfNull: false)
  final String destination;

  @JsonKey(name: r'distanceKm', required: true, includeIfNull: true)
  final num? distanceKm;

  @JsonKey(name: r'standardMinutes', required: true, includeIfNull: false)
  final int standardMinutes;

  @JsonKey(name: r'depot', required: true, includeIfNull: false)
  final DepotSummary depot;

  @JsonKey(name: r'archived', required: true, includeIfNull: false)
  final bool archived;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RouteItem &&
          other.id == id &&
          other.code == code &&
          other.name == name &&
          other.origin == origin &&
          other.destination == destination &&
          other.distanceKm == distanceKm &&
          other.standardMinutes == standardMinutes &&
          other.depot == depot &&
          other.archived == archived;

  @override
  int get hashCode =>
      id.hashCode +
      code.hashCode +
      name.hashCode +
      origin.hashCode +
      destination.hashCode +
      (distanceKm == null ? 0 : distanceKm.hashCode) +
      standardMinutes.hashCode +
      depot.hashCode +
      archived.hashCode;

  factory RouteItem.fromJson(Map<String, dynamic> json) =>
      _$RouteItemFromJson(json);

  Map<String, dynamic> toJson() => _$RouteItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
