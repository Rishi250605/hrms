//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum EmployeeCategory {
  @JsonValue(r'DRIVER')
  DRIVER(r'DRIVER'),
  @JsonValue(r'LOADMAN')
  LOADMAN(r'LOADMAN'),
  @JsonValue(r'CONDUCTOR')
  CONDUCTOR(r'CONDUCTOR'),
  @JsonValue(r'HELPER')
  HELPER(r'HELPER'),
  @JsonValue(r'MECHANIC')
  MECHANIC(r'MECHANIC'),
  @JsonValue(r'DEPOT_STAFF')
  DEPOT_STAFF(r'DEPOT_STAFF'),
  @JsonValue(r'OFFICE')
  OFFICE(r'OFFICE');

  const EmployeeCategory(this.value);

  final String value;

  @override
  String toString() => value;
}
