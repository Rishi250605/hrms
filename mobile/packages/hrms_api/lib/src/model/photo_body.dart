//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'photo_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PhotoBody {
  /// Returns a new [PhotoBody] instance.
  PhotoBody({required this.fileKey});

  /// Key from POST /uploads/presign (purpose PHOTO)
  @JsonKey(name: r'fileKey', required: true, includeIfNull: false)
  final String fileKey;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is PhotoBody && other.fileKey == fileKey;

  @override
  int get hashCode => fileKey.hashCode;

  factory PhotoBody.fromJson(Map<String, dynamic> json) =>
      _$PhotoBodyFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
