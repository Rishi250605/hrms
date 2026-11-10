//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum Gender {
  @JsonValue(r'MALE')
  MALE(r'MALE'),
  @JsonValue(r'FEMALE')
  FEMALE(r'FEMALE'),
  @JsonValue(r'OTHER')
  OTHER(r'OTHER');

  const Gender(this.value);

  final String value;

  @override
  String toString() => value;
}
