//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/employee_category.dart';
import 'package:hrms_api/src/model/depot_summary.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'document_employee.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DocumentEmployee {
  /// Returns a new [DocumentEmployee] instance.
  DocumentEmployee({
    required this.id,

    required this.empCode,

    required this.fullName,

    required this.category,

    required this.depot,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'empCode', required: true, includeIfNull: false)
  final String empCode;

  @JsonKey(name: r'fullName', required: true, includeIfNull: false)
  final String fullName;

  @JsonKey(name: r'category', required: true, includeIfNull: false)
  final EmployeeCategory category;

  @JsonKey(name: r'depot', required: true, includeIfNull: true)
  final DepotSummary? depot;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DocumentEmployee &&
          other.id == id &&
          other.empCode == empCode &&
          other.fullName == fullName &&
          other.category == category &&
          other.depot == depot;

  @override
  int get hashCode =>
      id.hashCode +
      empCode.hashCode +
      fullName.hashCode +
      category.hashCode +
      (depot == null ? 0 : depot.hashCode);

  factory DocumentEmployee.fromJson(Map<String, dynamic> json) =>
      _$DocumentEmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentEmployeeToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
