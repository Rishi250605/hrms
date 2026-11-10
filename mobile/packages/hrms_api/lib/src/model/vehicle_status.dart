//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum VehicleStatus {
  @JsonValue(r'ACTIVE')
  ACTIVE(r'ACTIVE'),
  @JsonValue(r'IN_WORKSHOP')
  IN_WORKSHOP(r'IN_WORKSHOP'),
  @JsonValue(r'RETIRED')
  RETIRED(r'RETIRED');

  const VehicleStatus(this.value);

  final String value;

  @override
  String toString() => value;
}
