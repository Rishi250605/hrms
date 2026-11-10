//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum EmploymentType {
  @JsonValue(r'PERMANENT')
  PERMANENT(r'PERMANENT'),
  @JsonValue(r'FIXED_TERM')
  FIXED_TERM(r'FIXED_TERM'),
  @JsonValue(r'CONTRACT')
  CONTRACT(r'CONTRACT');

  const EmploymentType(this.value);

  final String value;

  @override
  String toString() => value;
}
