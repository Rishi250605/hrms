//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum EmployeeStatus {
  @JsonValue(r'ACTIVE')
  ACTIVE(r'ACTIVE'),
  @JsonValue(r'ON_NOTICE')
  ON_NOTICE(r'ON_NOTICE'),
  @JsonValue(r'EXITED')
  EXITED(r'EXITED'),
  @JsonValue(r'SUSPENDED')
  SUSPENDED(r'SUSPENDED');

  const EmployeeStatus(this.value);

  final String value;

  @override
  String toString() => value;
}
