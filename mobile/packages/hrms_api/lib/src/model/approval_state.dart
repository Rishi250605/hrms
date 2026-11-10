//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum ApprovalState {
  @JsonValue(r'PENDING_APPROVAL')
  PENDING_APPROVAL(r'PENDING_APPROVAL'),
  @JsonValue(r'APPROVED')
  APPROVED(r'APPROVED'),
  @JsonValue(r'REJECTED')
  REJECTED(r'REJECTED');

  const ApprovalState(this.value);

  final String value;

  @override
  String toString() => value;
}
