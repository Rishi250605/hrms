//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/depot_summary.dart';
import 'package:hrms_api/src/model/vehicle_status.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vehicle_item.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class VehicleItem {
  /// Returns a new [VehicleItem] instance.
  VehicleItem({
    required this.id,

    required this.regNo,

    required this.type,

    required this.capacity,

    required this.status,

    required this.depot,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'regNo', required: true, includeIfNull: false)
  final String regNo;

  @JsonKey(name: r'type', required: true, includeIfNull: false)
  final String type;

  @JsonKey(name: r'capacity', required: true, includeIfNull: true)
  final int? capacity;

  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final VehicleStatus status;

  @JsonKey(name: r'depot', required: true, includeIfNull: false)
  final DepotSummary depot;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VehicleItem &&
          other.id == id &&
          other.regNo == regNo &&
          other.type == type &&
          other.capacity == capacity &&
          other.status == status &&
          other.depot == depot;

  @override
  int get hashCode =>
      id.hashCode +
      regNo.hashCode +
      type.hashCode +
      (capacity == null ? 0 : capacity.hashCode) +
      status.hashCode +
      depot.hashCode;

  factory VehicleItem.fromJson(Map<String, dynamic> json) =>
      _$VehicleItemFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
