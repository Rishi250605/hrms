//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum AttendanceSource {
  @JsonValue(r'MANAGER')
  MANAGER(r'MANAGER'),
  @JsonValue(r'SELF')
  SELF(r'SELF'),
  @JsonValue(r'SYSTEM')
  SYSTEM(r'SYSTEM'),
  @JsonValue(r'BIOMETRIC')
  BIOMETRIC(r'BIOMETRIC'),
  @JsonValue(r'TELEMATICS')
  TELEMATICS(r'TELEMATICS'),
  @JsonValue(r'IMPORT')
  IMPORT(r'IMPORT');

  const AttendanceSource(this.value);

  final String value;

  @override
  String toString() => value;
}
