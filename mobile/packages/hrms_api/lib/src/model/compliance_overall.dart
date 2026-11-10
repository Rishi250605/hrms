//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum ComplianceOverall {
  @JsonValue(r'OK')
  OK(r'OK'),
  @JsonValue(r'EXPIRING')
  EXPIRING(r'EXPIRING'),
  @JsonValue(r'PENDING_VERIFICATION')
  PENDING_VERIFICATION(r'PENDING_VERIFICATION'),
  @JsonValue(r'EXPIRED')
  EXPIRED(r'EXPIRED'),
  @JsonValue(r'MISSING')
  MISSING(r'MISSING');

  const ComplianceOverall(this.value);

  final String value;

  @override
  String toString() => value;
}
