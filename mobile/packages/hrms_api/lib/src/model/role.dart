//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum Role {
  @JsonValue(r'DIRECTOR')
  DIRECTOR(r'DIRECTOR'),
  @JsonValue(r'HR')
  HR(r'HR'),
  @JsonValue(r'OPERATIONAL_MANAGER')
  OPERATIONAL_MANAGER(r'OPERATIONAL_MANAGER'),
  @JsonValue(r'REGIONAL_MANAGER')
  REGIONAL_MANAGER(r'REGIONAL_MANAGER');

  const Role(this.value);

  final String value;

  @override
  String toString() => value;
}
