//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum ComplianceState {
  @JsonValue(r'VALID')
  VALID(r'VALID'),
  @JsonValue(r'EXPIRING')
  EXPIRING(r'EXPIRING'),
  @JsonValue(r'UNVERIFIED')
  UNVERIFIED(r'UNVERIFIED'),
  @JsonValue(r'EXPIRED')
  EXPIRED(r'EXPIRED'),
  @JsonValue(r'REJECTED')
  REJECTED(r'REJECTED'),
  @JsonValue(r'MISSING')
  MISSING(r'MISSING');

  const ComplianceState(this.value);

  final String value;

  @override
  String toString() => value;
}
