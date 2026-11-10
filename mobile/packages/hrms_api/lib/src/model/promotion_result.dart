//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/employee_detail.dart';
import 'package:hrms_api/src/model/person_ref.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'promotion_result.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PromotionResult {
  /// Returns a new [PromotionResult] instance.
  PromotionResult({
    required this.employee,

    required this.reportsNeedingReassignment,
  });

  @JsonKey(name: r'employee', required: true, includeIfNull: false)
  final EmployeeDetail employee;

  /// Direct reports whose reporting line is no longer valid
  @JsonKey(
    name: r'reportsNeedingReassignment',
    required: true,
    includeIfNull: false,
  )
  final List<PersonRef> reportsNeedingReassignment;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PromotionResult &&
          other.employee == employee &&
          other.reportsNeedingReassignment == reportsNeedingReassignment;

  @override
  int get hashCode => employee.hashCode + reportsNeedingReassignment.hashCode;

  factory PromotionResult.fromJson(Map<String, dynamic> json) =>
      _$PromotionResultFromJson(json);

  Map<String, dynamic> toJson() => _$PromotionResultToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
