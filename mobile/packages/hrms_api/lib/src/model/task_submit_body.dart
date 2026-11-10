//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task_submit_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class TaskSubmitBody {
  /// Returns a new [TaskSubmitBody] instance.
  TaskSubmitBody({required this.status, this.reason, this.comment});

  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final TaskSubmitBodyStatusEnum status;

  /// Required for NOT_DONE
  @JsonKey(name: r'reason', required: false, includeIfNull: false)
  final String? reason;

  @JsonKey(name: r'comment', required: false, includeIfNull: false)
  final String? comment;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskSubmitBody &&
          other.status == status &&
          other.reason == reason &&
          other.comment == comment;

  @override
  int get hashCode => status.hashCode + reason.hashCode + comment.hashCode;

  factory TaskSubmitBody.fromJson(Map<String, dynamic> json) =>
      _$TaskSubmitBodyFromJson(json);

  Map<String, dynamic> toJson() => _$TaskSubmitBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum TaskSubmitBodyStatusEnum {
  @JsonValue(r'COMPLETED')
  COMPLETED(r'COMPLETED'),
  @JsonValue(r'NOT_DONE')
  NOT_DONE(r'NOT_DONE');

  const TaskSubmitBodyStatusEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
