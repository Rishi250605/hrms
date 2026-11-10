//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/payslip_version_list_items_inner.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payslip_version_list.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PayslipVersionList {
  /// Returns a new [PayslipVersionList] instance.
  PayslipVersionList({required this.items});

  @JsonKey(name: r'items', required: true, includeIfNull: false)
  final List<PayslipVersionListItemsInner> items;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PayslipVersionList && other.items == items;

  @override
  int get hashCode => items.hashCode;

  factory PayslipVersionList.fromJson(Map<String, dynamic> json) =>
      _$PayslipVersionListFromJson(json);

  Map<String, dynamic> toJson() => _$PayslipVersionListToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
