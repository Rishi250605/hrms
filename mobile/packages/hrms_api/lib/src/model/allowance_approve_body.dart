//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'allowance_approve_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AllowanceApproveBody {
  /// Returns a new [AllowanceApproveBody] instance.
  AllowanceApproveBody({this.approvedAmountPaise, this.comment});

  /// Approve a different amount (a comment is then required)
  // minimum: 0
  @JsonKey(name: r'approvedAmountPaise', required: false, includeIfNull: false)
  final int? approvedAmountPaise;

  @JsonKey(name: r'comment', required: false, includeIfNull: false)
  final String? comment;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AllowanceApproveBody &&
          other.approvedAmountPaise == approvedAmountPaise &&
          other.comment == comment;

  @override
  int get hashCode => approvedAmountPaise.hashCode + comment.hashCode;

  factory AllowanceApproveBody.fromJson(Map<String, dynamic> json) =>
      _$AllowanceApproveBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AllowanceApproveBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
