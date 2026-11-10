//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum DutyStatus {
  @JsonValue(r'PLANNED')
  PLANNED(r'PLANNED'),
  @JsonValue(r'CONFIRMED')
  CONFIRMED(r'CONFIRMED'),
  @JsonValue(r'COMPLETED')
  COMPLETED(r'COMPLETED'),
  @JsonValue(r'CANCELLED')
  CANCELLED(r'CANCELLED');

  const DutyStatus(this.value);

  final String value;

  @override
  String toString() => value;
}
