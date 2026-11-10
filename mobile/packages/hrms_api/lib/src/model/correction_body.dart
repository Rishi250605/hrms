//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/attendance_status.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'correction_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CorrectionBody {
  /// Returns a new [CorrectionBody] instance.
  CorrectionBody({
    required this.employeeId,

    required this.date,

    required this.status,

    this.note,

    required this.reason,
  });

  /// Yourself, or (RM) one of your drivers / loadmen
  @JsonKey(name: r'employeeId', required: true, includeIfNull: false)
  final String employeeId;

  /// Calendar date (IST business date)
  @JsonKey(name: r'date', required: true, includeIfNull: false)
  final String date;

  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final AttendanceStatus status;

  @JsonKey(name: r'note', required: false, includeIfNull: false)
  final String? note;

  @JsonKey(name: r'reason', required: true, includeIfNull: false)
  final String reason;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CorrectionBody &&
          other.employeeId == employeeId &&
          other.date == date &&
          other.status == status &&
          other.note == note &&
          other.reason == reason;

  @override
  int get hashCode =>
      employeeId.hashCode +
      date.hashCode +
      status.hashCode +
      note.hashCode +
      reason.hashCode;

  factory CorrectionBody.fromJson(Map<String, dynamic> json) =>
      _$CorrectionBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CorrectionBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
