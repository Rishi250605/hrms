//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum AttendanceStatus {
  @JsonValue(r'PRESENT')
  PRESENT(r'PRESENT'),
  @JsonValue(r'ABSENT')
  ABSENT(r'ABSENT'),
  @JsonValue(r'HALF_DAY')
  HALF_DAY(r'HALF_DAY'),
  @JsonValue(r'ON_LEAVE')
  ON_LEAVE(r'ON_LEAVE'),
  @JsonValue(r'ON_DUTY')
  ON_DUTY(r'ON_DUTY'),
  @JsonValue(r'WEEKLY_OFF')
  WEEKLY_OFF(r'WEEKLY_OFF'),
  @JsonValue(r'HOLIDAY')
  HOLIDAY(r'HOLIDAY');

  const AttendanceStatus(this.value);

  final String value;

  @override
  String toString() => value;
}
