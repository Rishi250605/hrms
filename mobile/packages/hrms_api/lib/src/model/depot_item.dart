//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'depot_item.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DepotItem {
  /// Returns a new [DepotItem] instance.
  DepotItem({
    required this.id,

    required this.regionId,

    required this.regionName,

    required this.businessUnitId,

    required this.businessUnitCode,

    required this.name,

    required this.code,

    required this.address,

    required this.state,

    required this.lat,

    required this.lng,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'regionId', required: true, includeIfNull: false)
  final String regionId;

  @JsonKey(name: r'regionName', required: true, includeIfNull: false)
  final String regionName;

  @JsonKey(name: r'businessUnitId', required: true, includeIfNull: false)
  final String businessUnitId;

  @JsonKey(name: r'businessUnitCode', required: true, includeIfNull: false)
  final String businessUnitCode;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'code', required: true, includeIfNull: false)
  final String code;

  @JsonKey(name: r'address', required: true, includeIfNull: true)
  final String? address;

  @JsonKey(name: r'state', required: true, includeIfNull: false)
  final String state;

  @JsonKey(name: r'lat', required: true, includeIfNull: true)
  final num? lat;

  @JsonKey(name: r'lng', required: true, includeIfNull: true)
  final num? lng;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DepotItem &&
          other.id == id &&
          other.regionId == regionId &&
          other.regionName == regionName &&
          other.businessUnitId == businessUnitId &&
          other.businessUnitCode == businessUnitCode &&
          other.name == name &&
          other.code == code &&
          other.address == address &&
          other.state == state &&
          other.lat == lat &&
          other.lng == lng;

  @override
  int get hashCode =>
      id.hashCode +
      regionId.hashCode +
      regionName.hashCode +
      businessUnitId.hashCode +
      businessUnitCode.hashCode +
      name.hashCode +
      code.hashCode +
      (address == null ? 0 : address.hashCode) +
      state.hashCode +
      (lat == null ? 0 : lat.hashCode) +
      (lng == null ? 0 : lng.hashCode);

  factory DepotItem.fromJson(Map<String, dynamic> json) =>
      _$DepotItemFromJson(json);

  Map<String, dynamic> toJson() => _$DepotItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
