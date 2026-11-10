//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'self_mark_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class SelfMarkBody {
  /// Returns a new [SelfMarkBody] instance.
  SelfMarkBody({required this.date, required this.status, this.note});

  /// Calendar date (IST business date)
  @JsonKey(name: r'date', required: true, includeIfNull: false)
  final String date;

  /// Leave comes from an approved leave request
  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final SelfMarkBodyStatusEnum status;

  @JsonKey(name: r'note', required: false, includeIfNull: false)
  final String? note;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SelfMarkBody &&
          other.date == date &&
          other.status == status &&
          other.note == note;

  @override
  int get hashCode => date.hashCode + status.hashCode + note.hashCode;

  factory SelfMarkBody.fromJson(Map<String, dynamic> json) =>
      _$SelfMarkBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SelfMarkBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

/// Leave comes from an approved leave request
enum SelfMarkBodyStatusEnum {
  @JsonValue(r'PRESENT')
  PRESENT(r'PRESENT'),
  @JsonValue(r'ABSENT')
  ABSENT(r'ABSENT'),
  @JsonValue(r'HALF_DAY')
  HALF_DAY(r'HALF_DAY'),
  @JsonValue(r'ON_DUTY')
  ON_DUTY(r'ON_DUTY'),
  @JsonValue(r'WEEKLY_OFF')
  WEEKLY_OFF(r'WEEKLY_OFF'),
  @JsonValue(r'HOLIDAY')
  HOLIDAY(r'HOLIDAY');

  const SelfMarkBodyStatusEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
