//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum DocumentStatus {
  @JsonValue(r'PENDING_VERIFICATION')
  PENDING_VERIFICATION(r'PENDING_VERIFICATION'),
  @JsonValue(r'VERIFIED')
  VERIFIED(r'VERIFIED'),
  @JsonValue(r'REJECTED')
  REJECTED(r'REJECTED'),
  @JsonValue(r'EXPIRED')
  EXPIRED(r'EXPIRED');

  const DocumentStatus(this.value);

  final String value;

  @override
  String toString() => value;
}
