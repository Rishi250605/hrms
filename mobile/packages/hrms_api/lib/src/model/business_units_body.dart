//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'business_units_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BusinessUnitsBody {
  /// Returns a new [BusinessUnitsBody] instance.
  BusinessUnitsBody({
    required this.businessUnitIds,

    required this.primaryBusinessUnitId,
  });

  @JsonKey(name: r'businessUnitIds', required: true, includeIfNull: false)
  final List<String> businessUnitIds;

  @JsonKey(name: r'primaryBusinessUnitId', required: true, includeIfNull: false)
  final String primaryBusinessUnitId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BusinessUnitsBody &&
          other.businessUnitIds == businessUnitIds &&
          other.primaryBusinessUnitId == primaryBusinessUnitId;

  @override
  int get hashCode => businessUnitIds.hashCode + primaryBusinessUnitId.hashCode;

  factory BusinessUnitsBody.fromJson(Map<String, dynamic> json) =>
      _$BusinessUnitsBodyFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessUnitsBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
