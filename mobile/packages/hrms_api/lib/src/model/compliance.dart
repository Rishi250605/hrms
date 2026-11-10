//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/compliance_overall.dart';
import 'package:hrms_api/src/model/compliance_item.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'compliance.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Compliance {
  /// Returns a new [Compliance] instance.
  Compliance({
    required this.asOf,

    required this.overall,

    required this.rosterable,

    required this.items,
  });

  /// Calendar date (IST business date)
  @JsonKey(name: r'asOf', required: true, includeIfNull: false)
  final String asOf;

  @JsonKey(name: r'overall', required: true, includeIfNull: false)
  final ComplianceOverall overall;

  @JsonKey(name: r'rosterable', required: true, includeIfNull: false)
  final bool rosterable;

  @JsonKey(name: r'items', required: true, includeIfNull: false)
  final List<ComplianceItem> items;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Compliance &&
          other.asOf == asOf &&
          other.overall == overall &&
          other.rosterable == rosterable &&
          other.items == items;

  @override
  int get hashCode =>
      asOf.hashCode + overall.hashCode + rosterable.hashCode + items.hashCode;

  factory Compliance.fromJson(Map<String, dynamic> json) =>
      _$ComplianceFromJson(json);

  Map<String, dynamic> toJson() => _$ComplianceToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
