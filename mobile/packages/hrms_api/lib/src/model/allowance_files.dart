//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/signed_url_response.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'allowance_files.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AllowanceFiles {
  /// Returns a new [AllowanceFiles] instance.
  AllowanceFiles({required this.voiceNote, required this.receipt});

  @JsonKey(name: r'voiceNote', required: true, includeIfNull: true)
  final SignedUrlResponse? voiceNote;

  @JsonKey(name: r'receipt', required: true, includeIfNull: true)
  final SignedUrlResponse? receipt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AllowanceFiles &&
          other.voiceNote == voiceNote &&
          other.receipt == receipt;

  @override
  int get hashCode =>
      (voiceNote == null ? 0 : voiceNote.hashCode) +
      (receipt == null ? 0 : receipt.hashCode);

  factory AllowanceFiles.fromJson(Map<String, dynamic> json) =>
      _$AllowanceFilesFromJson(json);

  Map<String, dynamic> toJson() => _$AllowanceFilesToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
