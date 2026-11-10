//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/vehicle_status.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vehicle_update_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class VehicleUpdateBody {
  /// Returns a new [VehicleUpdateBody] instance.
  VehicleUpdateBody({this.type, this.capacity, this.depotId, this.status});

  @JsonKey(name: r'type', required: false, includeIfNull: false)
  final String? type;

  // minimum: 0
  // maximum: 200
  @JsonKey(name: r'capacity', required: false, includeIfNull: false)
  final int? capacity;

  @JsonKey(name: r'depotId', required: false, includeIfNull: false)
  final String? depotId;

  @JsonKey(name: r'status', required: false, includeIfNull: false)
  final VehicleStatus? status;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VehicleUpdateBody &&
          other.type == type &&
          other.capacity == capacity &&
          other.depotId == depotId &&
          other.status == status;

  @override
  int get hashCode =>
      type.hashCode +
      (capacity == null ? 0 : capacity.hashCode) +
      depotId.hashCode +
      status.hashCode;

  factory VehicleUpdateBody.fromJson(Map<String, dynamic> json) =>
      _$VehicleUpdateBodyFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleUpdateBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
