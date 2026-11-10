//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bank_details_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BankDetailsBody {
  /// Returns a new [BankDetailsBody] instance.
  BankDetailsBody({required this.bankAccount, required this.ifsc});

  @JsonKey(name: r'bankAccount', required: true, includeIfNull: false)
  final String bankAccount;

  @JsonKey(name: r'ifsc', required: true, includeIfNull: false)
  final String ifsc;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BankDetailsBody &&
          other.bankAccount == bankAccount &&
          other.ifsc == ifsc;

  @override
  int get hashCode => bankAccount.hashCode + ifsc.hashCode;

  factory BankDetailsBody.fromJson(Map<String, dynamic> json) =>
      _$BankDetailsBodyFromJson(json);

  Map<String, dynamic> toJson() => _$BankDetailsBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
