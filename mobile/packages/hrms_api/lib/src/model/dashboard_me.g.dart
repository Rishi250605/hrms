// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_me.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DashboardMeCWProxy {
  DashboardMe pendingApprovals(DashboardMePendingApprovals pendingApprovals);

  DashboardMe tasksOpen(int tasksOpen);

  DashboardMe tasksOverdue(int tasksOverdue);

  DashboardMe myAttendanceToday(
    DashboardMeMyAttendanceToday? myAttendanceToday,
  );

  DashboardMe unreadNotifications(int unreadNotifications);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DashboardMe(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DashboardMe(...).copyWith(id: 12, name: "My name")
  /// ````
  DashboardMe call({
    DashboardMePendingApprovals pendingApprovals,
    int tasksOpen,
    int tasksOverdue,
    DashboardMeMyAttendanceToday? myAttendanceToday,
    int unreadNotifications,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDashboardMe.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDashboardMe.copyWith.fieldName(...)`
class _$DashboardMeCWProxyImpl implements _$DashboardMeCWProxy {
  const _$DashboardMeCWProxyImpl(this._value);

  final DashboardMe _value;

  @override
  DashboardMe pendingApprovals(DashboardMePendingApprovals pendingApprovals) =>
      this(pendingApprovals: pendingApprovals);

  @override
  DashboardMe tasksOpen(int tasksOpen) => this(tasksOpen: tasksOpen);

  @override
  DashboardMe tasksOverdue(int tasksOverdue) =>
      this(tasksOverdue: tasksOverdue);

  @override
  DashboardMe myAttendanceToday(
    DashboardMeMyAttendanceToday? myAttendanceToday,
  ) => this(myAttendanceToday: myAttendanceToday);

  @override
  DashboardMe unreadNotifications(int unreadNotifications) =>
      this(unreadNotifications: unreadNotifications);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DashboardMe(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DashboardMe(...).copyWith(id: 12, name: "My name")
  /// ````
  DashboardMe call({
    Object? pendingApprovals = const $CopyWithPlaceholder(),
    Object? tasksOpen = const $CopyWithPlaceholder(),
    Object? tasksOverdue = const $CopyWithPlaceholder(),
    Object? myAttendanceToday = const $CopyWithPlaceholder(),
    Object? unreadNotifications = const $CopyWithPlaceholder(),
  }) {
    return DashboardMe(
      pendingApprovals: pendingApprovals == const $CopyWithPlaceholder()
          ? _value.pendingApprovals
          // ignore: cast_nullable_to_non_nullable
          : pendingApprovals as DashboardMePendingApprovals,
      tasksOpen: tasksOpen == const $CopyWithPlaceholder()
          ? _value.tasksOpen
          // ignore: cast_nullable_to_non_nullable
          : tasksOpen as int,
      tasksOverdue: tasksOverdue == const $CopyWithPlaceholder()
          ? _value.tasksOverdue
          // ignore: cast_nullable_to_non_nullable
          : tasksOverdue as int,
      myAttendanceToday: myAttendanceToday == const $CopyWithPlaceholder()
          ? _value.myAttendanceToday
          // ignore: cast_nullable_to_non_nullable
          : myAttendanceToday as DashboardMeMyAttendanceToday?,
      unreadNotifications: unreadNotifications == const $CopyWithPlaceholder()
          ? _value.unreadNotifications
          // ignore: cast_nullable_to_non_nullable
          : unreadNotifications as int,
    );
  }
}

extension $DashboardMeCopyWith on DashboardMe {
  /// Returns a callable class that can be used as follows: `instanceOfDashboardMe.copyWith(...)` or like so:`instanceOfDashboardMe.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DashboardMeCWProxy get copyWith => _$DashboardMeCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardMe _$DashboardMeFromJson(Map<String, dynamic> json) => $checkedCreate(
  'DashboardMe',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'pendingApprovals',
        'tasksOpen',
        'tasksOverdue',
        'myAttendanceToday',
        'unreadNotifications',
      ],
    );
    final val = DashboardMe(
      pendingApprovals: $checkedConvert(
        'pendingApprovals',
        (v) => DashboardMePendingApprovals.fromJson(v as Map<String, dynamic>),
      ),
      tasksOpen: $checkedConvert('tasksOpen', (v) => (v as num).toInt()),
      tasksOverdue: $checkedConvert('tasksOverdue', (v) => (v as num).toInt()),
      myAttendanceToday: $checkedConvert(
        'myAttendanceToday',
        (v) => v == null
            ? null
            : DashboardMeMyAttendanceToday.fromJson(v as Map<String, dynamic>),
      ),
      unreadNotifications: $checkedConvert(
        'unreadNotifications',
        (v) => (v as num).toInt(),
      ),
    );
    return val;
  },
);

Map<String, dynamic> _$DashboardMeToJson(DashboardMe instance) =>
    <String, dynamic>{
      'pendingApprovals': instance.pendingApprovals.toJson(),
      'tasksOpen': instance.tasksOpen,
      'tasksOverdue': instance.tasksOverdue,
      'myAttendanceToday': instance.myAttendanceToday?.toJson(),
      'unreadNotifications': instance.unreadNotifications,
    };
