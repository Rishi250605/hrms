//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum TaskStatus {
  @JsonValue(r'PENDING')
  PENDING(r'PENDING'),
  @JsonValue(r'COMPLETED')
  COMPLETED(r'COMPLETED'),
  @JsonValue(r'NOT_DONE')
  NOT_DONE(r'NOT_DONE');

  const TaskStatus(this.value);

  final String value;

  @override
  String toString() => value;
}
