// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_attendance_row_leave.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TeamAttendanceRowLeaveCWProxy {
  TeamAttendanceRowLeave leaveRequestId(String leaveRequestId);

  TeamAttendanceRowLeave kind(TeamAttendanceRowLeaveKindEnum kind);

  TeamAttendanceRowLeave code(String? code);

  TeamAttendanceRowLeave half(bool half);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TeamAttendanceRowLeave(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TeamAttendanceRowLeave(...).copyWith(id: 12, name: "My name")
  /// ````
  TeamAttendanceRowLeave call({
    String leaveRequestId,
    TeamAttendanceRowLeaveKindEnum kind,
    String? code,
    bool half,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTeamAttendanceRowLeave.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTeamAttendanceRowLeave.copyWith.fieldName(...)`
class _$TeamAttendanceRowLeaveCWProxyImpl
    implements _$TeamAttendanceRowLeaveCWProxy {
  const _$TeamAttendanceRowLeaveCWProxyImpl(this._value);

  final TeamAttendanceRowLeave _value;

  @override
  TeamAttendanceRowLeave leaveRequestId(String leaveRequestId) =>
      this(leaveRequestId: leaveRequestId);

  @override
  TeamAttendanceRowLeave kind(TeamAttendanceRowLeaveKindEnum kind) =>
      this(kind: kind);

  @override
  TeamAttendanceRowLeave code(String? code) => this(code: code);

  @override
  TeamAttendanceRowLeave half(bool half) => this(half: half);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TeamAttendanceRowLeave(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TeamAttendanceRowLeave(...).copyWith(id: 12, name: "My name")
  /// ````
  TeamAttendanceRowLeave call({
    Object? leaveRequestId = const $CopyWithPlaceholder(),
    Object? kind = const $CopyWithPlaceholder(),
    Object? code = const $CopyWithPlaceholder(),
    Object? half = const $CopyWithPlaceholder(),
  }) {
    return TeamAttendanceRowLeave(
      leaveRequestId: leaveRequestId == const $CopyWithPlaceholder()
          ? _value.leaveRequestId
          // ignore: cast_nullable_to_non_nullable
          : leaveRequestId as String,
      kind: kind == const $CopyWithPlaceholder()
          ? _value.kind
          // ignore: cast_nullable_to_non_nullable
          : kind as TeamAttendanceRowLeaveKindEnum,
      code: code == const $CopyWithPlaceholder()
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String?,
      half: half == const $CopyWithPlaceholder()
          ? _value.half
          // ignore: cast_nullable_to_non_nullable
          : half as bool,
    );
  }
}

extension $TeamAttendanceRowLeaveCopyWith on TeamAttendanceRowLeave {
  /// Returns a callable class that can be used as follows: `instanceOfTeamAttendanceRowLeave.copyWith(...)` or like so:`instanceOfTeamAttendanceRowLeave.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TeamAttendanceRowLeaveCWProxy get copyWith =>
      _$TeamAttendanceRowLeaveCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamAttendanceRowLeave _$TeamAttendanceRowLeaveFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('TeamAttendanceRowLeave', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['leaveRequestId', 'kind', 'code', 'half'],
  );
  final val = TeamAttendanceRowLeave(
    leaveRequestId: $checkedConvert('leaveRequestId', (v) => v as String),
    kind: $checkedConvert(
      'kind',
      (v) => $enumDecode(_$TeamAttendanceRowLeaveKindEnumEnumMap, v),
    ),
    code: $checkedConvert('code', (v) => v as String?),
    half: $checkedConvert('half', (v) => v as bool),
  );
  return val;
});

Map<String, dynamic> _$TeamAttendanceRowLeaveToJson(
  TeamAttendanceRowLeave instance,
) => <String, dynamic>{
  'leaveRequestId': instance.leaveRequestId,
  'kind': _$TeamAttendanceRowLeaveKindEnumEnumMap[instance.kind]!,
  'code': instance.code,
  'half': instance.half,
};

const _$TeamAttendanceRowLeaveKindEnumEnumMap = {
  TeamAttendanceRowLeaveKindEnum.LEAVE: 'LEAVE',
  TeamAttendanceRowLeaveKindEnum.OD: 'OD',
};
