//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task_reopen_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class TaskReopenBody {
  /// Returns a new [TaskReopenBody] instance.
  TaskReopenBody({required this.comment});

  @JsonKey(name: r'comment', required: true, includeIfNull: false)
  final String comment;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskReopenBody && other.comment == comment;

  @override
  int get hashCode => comment.hashCode;

  factory TaskReopenBody.fromJson(Map<String, dynamic> json) =>
      _$TaskReopenBodyFromJson(json);

  Map<String, dynamic> toJson() => _$TaskReopenBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
