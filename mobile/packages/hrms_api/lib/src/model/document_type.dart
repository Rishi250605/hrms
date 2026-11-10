//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum DocumentType {
  @JsonValue(r'DRIVING_LICENCE')
  DRIVING_LICENCE(r'DRIVING_LICENCE'),
  @JsonValue(r'PSV_BADGE')
  PSV_BADGE(r'PSV_BADGE'),
  @JsonValue(r'MEDICAL_FITNESS')
  MEDICAL_FITNESS(r'MEDICAL_FITNESS'),
  @JsonValue(r'POLICE_VERIFICATION')
  POLICE_VERIFICATION(r'POLICE_VERIFICATION'),
  @JsonValue(r'AADHAAR')
  AADHAAR(r'AADHAAR'),
  @JsonValue(r'PAN')
  PAN(r'PAN'),
  @JsonValue(r'TRAINING_CERT')
  TRAINING_CERT(r'TRAINING_CERT'),
  @JsonValue(r'OTHER')
  OTHER(r'OTHER');

  const DocumentType(this.value);

  final String value;

  @override
  String toString() => value;
}
