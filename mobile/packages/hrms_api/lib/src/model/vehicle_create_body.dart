//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vehicle_create_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class VehicleCreateBody {
  /// Returns a new [VehicleCreateBody] instance.
  VehicleCreateBody({
    required this.regNo,

    required this.type,

    this.capacity,

    required this.depotId,
  });

  @JsonKey(name: r'regNo', required: true, includeIfNull: false)
  final String regNo;

  @JsonKey(name: r'type', required: true, includeIfNull: false)
  final String type;

  // minimum: 0
  // maximum: 200
  @JsonKey(name: r'capacity', required: false, includeIfNull: false)
  final int? capacity;

  @JsonKey(name: r'depotId', required: true, includeIfNull: false)
  final String depotId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VehicleCreateBody &&
          other.regNo == regNo &&
          other.type == type &&
          other.capacity == capacity &&
          other.depotId == depotId;

  @override
  int get hashCode =>
      regNo.hashCode + type.hashCode + capacity.hashCode + depotId.hashCode;

  factory VehicleCreateBody.fromJson(Map<String, dynamic> json) =>
      _$VehicleCreateBodyFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleCreateBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
