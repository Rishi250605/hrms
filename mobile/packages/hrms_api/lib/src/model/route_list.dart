//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:hrms_api/src/model/route_item.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'route_list.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class RouteList {
  /// Returns a new [RouteList] instance.
  RouteList({required this.items});

  @JsonKey(name: r'items', required: true, includeIfNull: false)
  final List<RouteItem> items;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is RouteList && other.items == items;

  @override
  int get hashCode => items.hashCode;

  factory RouteList.fromJson(Map<String, dynamic> json) =>
      _$RouteListFromJson(json);

  Map<String, dynamic> toJson() => _$RouteListToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
