//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/bulk_result_item_error.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bulk_result_item.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BulkResultItem {
  /// Returns a new [BulkResultItem] instance.
  BulkResultItem({
    required this.clientMutationId,

    required this.employeeId,

    required this.date,

    required this.outcome,

    required this.error,
  });

  @JsonKey(name: r'clientMutationId', required: true, includeIfNull: false)
  final String clientMutationId;

  @JsonKey(name: r'employeeId', required: true, includeIfNull: false)
  final String employeeId;

  /// Calendar date (IST business date)
  @JsonKey(name: r'date', required: true, includeIfNull: false)
  final String date;

  @JsonKey(name: r'outcome', required: true, includeIfNull: false)
  final BulkResultItemOutcomeEnum outcome;

  @JsonKey(name: r'error', required: true, includeIfNull: true)
  final BulkResultItemError? error;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BulkResultItem &&
          other.clientMutationId == clientMutationId &&
          other.employeeId == employeeId &&
          other.date == date &&
          other.outcome == outcome &&
          other.error == error;

  @override
  int get hashCode =>
      clientMutationId.hashCode +
      employeeId.hashCode +
      date.hashCode +
      outcome.hashCode +
      (error == null ? 0 : error.hashCode);

  factory BulkResultItem.fromJson(Map<String, dynamic> json) =>
      _$BulkResultItemFromJson(json);

  Map<String, dynamic> toJson() => _$BulkResultItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum BulkResultItemOutcomeEnum {
  @JsonValue(r'APPLIED')
  APPLIED(r'APPLIED'),
  @JsonValue(r'DUPLICATE')
  DUPLICATE(r'DUPLICATE'),
  @JsonValue(r'REJECTED')
  REJECTED(r'REJECTED');

  const BulkResultItemOutcomeEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
