// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_request_item_leave_type.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LeaveRequestItemLeaveTypeCWProxy {
  LeaveRequestItemLeaveType id(String id);

  LeaveRequestItemLeaveType code(String code);

  LeaveRequestItemLeaveType name(String name);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LeaveRequestItemLeaveType(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LeaveRequestItemLeaveType(...).copyWith(id: 12, name: "My name")
  /// ````
  LeaveRequestItemLeaveType call({String id, String code, String name});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfLeaveRequestItemLeaveType.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfLeaveRequestItemLeaveType.copyWith.fieldName(...)`
class _$LeaveRequestItemLeaveTypeCWProxyImpl
    implements _$LeaveRequestItemLeaveTypeCWProxy {
  const _$LeaveRequestItemLeaveTypeCWProxyImpl(this._value);

  final LeaveRequestItemLeaveType _value;

  @override
  LeaveRequestItemLeaveType id(String id) => this(id: id);

  @override
  LeaveRequestItemLeaveType code(String code) => this(code: code);

  @override
  LeaveRequestItemLeaveType name(String name) => this(name: name);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LeaveRequestItemLeaveType(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LeaveRequestItemLeaveType(...).copyWith(id: 12, name: "My name")
  /// ````
  LeaveRequestItemLeaveType call({
    Object? id = const $CopyWithPlaceholder(),
    Object? code = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
  }) {
    return LeaveRequestItemLeaveType(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      code: code == const $CopyWithPlaceholder()
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
    );
  }
}

extension $LeaveRequestItemLeaveTypeCopyWith on LeaveRequestItemLeaveType {
  /// Returns a callable class that can be used as follows: `instanceOfLeaveRequestItemLeaveType.copyWith(...)` or like so:`instanceOfLeaveRequestItemLeaveType.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LeaveRequestItemLeaveTypeCWProxy get copyWith =>
      _$LeaveRequestItemLeaveTypeCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveRequestItemLeaveType _$LeaveRequestItemLeaveTypeFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('LeaveRequestItemLeaveType', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['id', 'code', 'name']);
  final val = LeaveRequestItemLeaveType(
    id: $checkedConvert('id', (v) => v as String),
    code: $checkedConvert('code', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$LeaveRequestItemLeaveTypeToJson(
  LeaveRequestItemLeaveType instance,
) => <String, dynamic>{
  'id': instance.id,
  'code': instance.code,
  'name': instance.name,
};
