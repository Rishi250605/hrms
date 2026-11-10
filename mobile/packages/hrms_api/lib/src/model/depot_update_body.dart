//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'depot_update_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DepotUpdateBody {
  /// Returns a new [DepotUpdateBody] instance.
  DepotUpdateBody({
    this.regionId,

    this.businessUnitId,

    this.name,

    this.address,

    this.state,

    this.lat,

    this.lng,
  });

  @JsonKey(name: r'regionId', required: false, includeIfNull: false)
  final String? regionId;

  @JsonKey(name: r'businessUnitId', required: false, includeIfNull: false)
  final String? businessUnitId;

  @JsonKey(name: r'name', required: false, includeIfNull: false)
  final String? name;

  @JsonKey(name: r'address', required: false, includeIfNull: false)
  final String? address;

  @JsonKey(name: r'state', required: false, includeIfNull: false)
  final String? state;

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
      other is DepotUpdateBody &&
          other.regionId == regionId &&
          other.businessUnitId == businessUnitId &&
          other.name == name &&
          other.address == address &&
          other.state == state &&
          other.lat == lat &&
          other.lng == lng;

  @override
  int get hashCode =>
      regionId.hashCode +
      businessUnitId.hashCode +
      name.hashCode +
      (address == null ? 0 : address.hashCode) +
      state.hashCode +
      (lat == null ? 0 : lat.hashCode) +
      (lng == null ? 0 : lng.hashCode);

  factory DepotUpdateBody.fromJson(Map<String, dynamic> json) =>
      _$DepotUpdateBodyFromJson(json);

  Map<String, dynamic> toJson() => _$DepotUpdateBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
