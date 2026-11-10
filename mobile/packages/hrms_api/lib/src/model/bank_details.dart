//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bank_details.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BankDetails {
  /// Returns a new [BankDetails] instance.
  BankDetails({required this.accountMasked, required this.ifsc});

  @JsonKey(name: r'accountMasked', required: true, includeIfNull: true)
  final String? accountMasked;

  @JsonKey(name: r'ifsc', required: true, includeIfNull: true)
  final String? ifsc;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BankDetails &&
          other.accountMasked == accountMasked &&
          other.ifsc == ifsc;

  @override
  int get hashCode =>
      (accountMasked == null ? 0 : accountMasked.hashCode) +
      (ifsc == null ? 0 : ifsc.hashCode);

  factory BankDetails.fromJson(Map<String, dynamic> json) =>
      _$BankDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$BankDetailsToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
