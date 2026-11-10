//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'duty_item_vehicle.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DutyItemVehicle {
  /// Returns a new [DutyItemVehicle] instance.
  DutyItemVehicle({required this.id, required this.regNo, required this.type});

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'regNo', required: true, includeIfNull: false)
  final String regNo;

  @JsonKey(name: r'type', required: true, includeIfNull: false)
  final String type;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DutyItemVehicle &&
          other.id == id &&
          other.regNo == regNo &&
          other.type == type;

  @override
  int get hashCode => id.hashCode + regNo.hashCode + type.hashCode;

  factory DutyItemVehicle.fromJson(Map<String, dynamic> json) =>
      _$DutyItemVehicleFromJson(json);

  Map<String, dynamic> toJson() => _$DutyItemVehicleToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
