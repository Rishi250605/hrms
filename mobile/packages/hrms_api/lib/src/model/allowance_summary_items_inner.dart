//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/business_unit_ref.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'allowance_summary_items_inner.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AllowanceSummaryItemsInner {
  /// Returns a new [AllowanceSummaryItemsInner] instance.
  AllowanceSummaryItemsInner({
    required this.businessUnit,

    required this.requests,

    required this.pending,

    required this.requestedPaise,

    required this.approvedPaise,
  });

  @JsonKey(name: r'businessUnit', required: true, includeIfNull: false)
  final BusinessUnitRef businessUnit;

  @JsonKey(name: r'requests', required: true, includeIfNull: false)
  final int requests;

  @JsonKey(name: r'pending', required: true, includeIfNull: false)
  final int pending;

  @JsonKey(name: r'requestedPaise', required: true, includeIfNull: false)
  final int requestedPaise;

  @JsonKey(name: r'approvedPaise', required: true, includeIfNull: false)
  final int approvedPaise;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AllowanceSummaryItemsInner &&
          other.businessUnit == businessUnit &&
          other.requests == requests &&
          other.pending == pending &&
          other.requestedPaise == requestedPaise &&
          other.approvedPaise == approvedPaise;

  @override
  int get hashCode =>
      businessUnit.hashCode +
      requests.hashCode +
      pending.hashCode +
      requestedPaise.hashCode +
      approvedPaise.hashCode;

  factory AllowanceSummaryItemsInner.fromJson(Map<String, dynamic> json) =>
      _$AllowanceSummaryItemsInnerFromJson(json);

  Map<String, dynamic> toJson() => _$AllowanceSummaryItemsInnerToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
