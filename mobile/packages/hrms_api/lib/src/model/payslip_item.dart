//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/business_unit_ref.dart';
import 'package:hrms_api/src/model/payslip_item_employee.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payslip_item.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PayslipItem {
  /// Returns a new [PayslipItem] instance.
  PayslipItem({
    required this.id,

    required this.employee,

    required this.businessUnit,

    required this.period,

    required this.version,

    required this.sizeBytes,

    required this.uploadedAt,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'employee', required: true, includeIfNull: false)
  final PayslipItemEmployee employee;

  @JsonKey(name: r'businessUnit', required: true, includeIfNull: false)
  final BusinessUnitRef businessUnit;

  @JsonKey(name: r'period', required: true, includeIfNull: false)
  final String period;

  @JsonKey(name: r'version', required: true, includeIfNull: false)
  final int version;

  @JsonKey(name: r'sizeBytes', required: true, includeIfNull: false)
  final int sizeBytes;

  @JsonKey(name: r'uploadedAt', required: true, includeIfNull: false)
  final DateTime uploadedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PayslipItem &&
          other.id == id &&
          other.employee == employee &&
          other.businessUnit == businessUnit &&
          other.period == period &&
          other.version == version &&
          other.sizeBytes == sizeBytes &&
          other.uploadedAt == uploadedAt;

  @override
  int get hashCode =>
      id.hashCode +
      employee.hashCode +
      businessUnit.hashCode +
      period.hashCode +
      version.hashCode +
      sizeBytes.hashCode +
      uploadedAt.hashCode;

  factory PayslipItem.fromJson(Map<String, dynamic> json) =>
      _$PayslipItemFromJson(json);

  Map<String, dynamic> toJson() => _$PayslipItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
