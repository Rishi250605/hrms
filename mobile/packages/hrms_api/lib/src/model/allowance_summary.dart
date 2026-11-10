//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/allowance_summary_items_inner.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'allowance_summary.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AllowanceSummary {
  /// Returns a new [AllowanceSummary] instance.
  AllowanceSummary({required this.month, required this.items});

  @JsonKey(name: r'month', required: true, includeIfNull: false)
  final String month;

  @JsonKey(name: r'items', required: true, includeIfNull: false)
  final List<AllowanceSummaryItemsInner> items;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AllowanceSummary && other.month == month && other.items == items;

  @override
  int get hashCode => month.hashCode + items.hashCode;

  factory AllowanceSummary.fromJson(Map<String, dynamic> json) =>
      _$AllowanceSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$AllowanceSummaryToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
