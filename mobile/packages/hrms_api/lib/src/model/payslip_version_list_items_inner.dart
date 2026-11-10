//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payslip_version_list_items_inner.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PayslipVersionListItemsInner {
  /// Returns a new [PayslipVersionListItemsInner] instance.
  PayslipVersionListItemsInner({
    required this.version,

    required this.sizeBytes,

    required this.originalName,

    required this.uploadedByName,

    required this.uploadedAt,
  });

  @JsonKey(name: r'version', required: true, includeIfNull: false)
  final int version;

  @JsonKey(name: r'sizeBytes', required: true, includeIfNull: false)
  final int sizeBytes;

  @JsonKey(name: r'originalName', required: true, includeIfNull: false)
  final String originalName;

  @JsonKey(name: r'uploadedByName', required: true, includeIfNull: true)
  final String? uploadedByName;

  @JsonKey(name: r'uploadedAt', required: true, includeIfNull: false)
  final DateTime uploadedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PayslipVersionListItemsInner &&
          other.version == version &&
          other.sizeBytes == sizeBytes &&
          other.originalName == originalName &&
          other.uploadedByName == uploadedByName &&
          other.uploadedAt == uploadedAt;

  @override
  int get hashCode =>
      version.hashCode +
      sizeBytes.hashCode +
      originalName.hashCode +
      (uploadedByName == null ? 0 : uploadedByName.hashCode) +
      uploadedAt.hashCode;

  factory PayslipVersionListItemsInner.fromJson(Map<String, dynamic> json) =>
      _$PayslipVersionListItemsInnerFromJson(json);

  Map<String, dynamic> toJson() => _$PayslipVersionListItemsInnerToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
