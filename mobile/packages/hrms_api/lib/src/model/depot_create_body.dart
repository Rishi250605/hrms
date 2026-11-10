//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'depot_create_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DepotCreateBody {
  /// Returns a new [DepotCreateBody] instance.
  DepotCreateBody({
    required this.regionId,

    required this.businessUnitId,

    required this.name,

    required this.code,

    this.address,

    required this.state,

    this.lat,

    this.lng,
  });

  @JsonKey(name: r'regionId', required: true, includeIfNull: false)
  final String regionId;

  @JsonKey(name: r'businessUnitId', required: true, includeIfNull: false)
  final String businessUnitId;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'code', required: true, includeIfNull: false)
  final String code;

  @JsonKey(name: r'address', required: false, includeIfNull: false)
  final String? address;

  @JsonKey(name: r'state', required: true, includeIfNull: false)
  final String state;

  // minimum: -90
  // maximum: 90
  @JsonKey(name: r'lat', required: false, includeIfNull: false)
  final num? lat;

  // minimum: -180
  // maximum: 180
  @JsonKey(name: r'lng', required: false, includeIfNull: false)
  final num? lng;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DepotCreateBody &&
          other.regionId == regionId &&
          other.businessUnitId == businessUnitId &&
          other.name == name &&
          other.code == code &&
          other.address == address &&
          other.state == state &&
          other.lat == lat &&
          other.lng == lng;

  @override
  int get hashCode =>
      regionId.hashCode +
      businessUnitId.hashCode +
      name.hashCode +
      code.hashCode +
      address.hashCode +
      state.hashCode +
      lat.hashCode +
      lng.hashCode;

  factory DepotCreateBody.fromJson(Map<String, dynamic> json) =>
      _$DepotCreateBodyFromJson(json);

  Map<String, dynamic> toJson() => _$DepotCreateBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
