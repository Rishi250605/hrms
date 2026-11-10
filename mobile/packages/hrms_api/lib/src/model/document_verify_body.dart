//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'document_verify_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DocumentVerifyBody {
  /// Returns a new [DocumentVerifyBody] instance.
  DocumentVerifyBody({this.expiryDate, this.note});

  /// Correct the expiry date while verifying
  @JsonKey(name: r'expiryDate', required: false, includeIfNull: false)
  final String? expiryDate;

  @JsonKey(name: r'note', required: false, includeIfNull: false)
  final String? note;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DocumentVerifyBody &&
          other.expiryDate == expiryDate &&
          other.note == note;

  @override
  int get hashCode => expiryDate.hashCode + note.hashCode;

  factory DocumentVerifyBody.fromJson(Map<String, dynamic> json) =>
      _$DocumentVerifyBodyFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentVerifyBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
