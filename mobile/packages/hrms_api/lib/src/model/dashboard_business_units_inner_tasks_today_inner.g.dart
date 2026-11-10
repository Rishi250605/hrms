// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_business_units_inner_tasks_today_inner.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DashboardBusinessUnitsInnerTasksTodayInnerCWProxy {
  DashboardBusinessUnitsInnerTasksTodayInner om(PersonRef om);

  DashboardBusinessUnitsInnerTasksTodayInner total(int total);

  DashboardBusinessUnitsInnerTasksTodayInner completed(int completed);

  DashboardBusinessUnitsInnerTasksTodayInner notDone(int notDone);

  DashboardBusinessUnitsInnerTasksTodayInner pending(int pending);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DashboardBusinessUnitsInnerTasksTodayInner(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DashboardBusinessUnitsInnerTasksTodayInner(...).copyWith(id: 12, name: "My name")
  /// ````
  DashboardBusinessUnitsInnerTasksTodayInner call({
    PersonRef om,
    int total,
    int completed,
    int notDone,
    int pending,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDashboardBusinessUnitsInnerTasksTodayInner.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDashboardBusinessUnitsInnerTasksTodayInner.copyWith.fieldName(...)`
class _$DashboardBusinessUnitsInnerTasksTodayInnerCWProxyImpl
    implements _$DashboardBusinessUnitsInnerTasksTodayInnerCWProxy {
  const _$DashboardBusinessUnitsInnerTasksTodayInnerCWProxyImpl(this._value);

  final DashboardBusinessUnitsInnerTasksTodayInner _value;

  @override
  DashboardBusinessUnitsInnerTasksTodayInner om(PersonRef om) => this(om: om);

  @override
  DashboardBusinessUnitsInnerTasksTodayInner total(int total) =>
      this(total: total);

  @override
  DashboardBusinessUnitsInnerTasksTodayInner completed(int completed) =>
      this(completed: completed);

  @override
  DashboardBusinessUnitsInnerTasksTodayInner notDone(int notDone) =>
      this(notDone: notDone);

  @override
  DashboardBusinessUnitsInnerTasksTodayInner pending(int pending) =>
      this(pending: pending);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DashboardBusinessUnitsInnerTasksTodayInner(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DashboardBusinessUnitsInnerTasksTodayInner(...).copyWith(id: 12, name: "My name")
  /// ````
  DashboardBusinessUnitsInnerTasksTodayInner call({
    Object? om = const $CopyWithPlaceholder(),
    Object? total = const $CopyWithPlaceholder(),
    Object? completed = const $CopyWithPlaceholder(),
    Object? notDone = const $CopyWithPlaceholder(),
    Object? pending = const $CopyWithPlaceholder(),
  }) {
    return DashboardBusinessUnitsInnerTasksTodayInner(
      om: om == const $CopyWithPlaceholder()
          ? _value.om
          // ignore: cast_nullable_to_non_nullable
          : om as PersonRef,
      total: total == const $CopyWithPlaceholder()
          ? _value.total
          // ignore: cast_nullable_to_non_nullable
          : total as int,
      completed: completed == const $CopyWithPlaceholder()
          ? _value.completed
          // ignore: cast_nullable_to_non_nullable
          : completed as int,
      notDone: notDone == const $CopyWithPlaceholder()
          ? _value.notDone
          // ignore: cast_nullable_to_non_nullable
          : notDone as int,
      pending: pending == const $CopyWithPlaceholder()
          ? _value.pending
          // ignore: cast_nullable_to_non_nullable
          : pending as int,
    );
  }
}

extension $DashboardBusinessUnitsInnerTasksTodayInnerCopyWith
    on DashboardBusinessUnitsInnerTasksTodayInner {
  /// Returns a callable class that can be used as follows: `instanceOfDashboardBusinessUnitsInnerTasksTodayInner.copyWith(...)` or like so:`instanceOfDashboardBusinessUnitsInnerTasksTodayInner.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DashboardBusinessUnitsInnerTasksTodayInnerCWProxy get copyWith =>
      _$DashboardBusinessUnitsInnerTasksTodayInnerCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardBusinessUnitsInnerTasksTodayInner
_$DashboardBusinessUnitsInnerTasksTodayInnerFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DashboardBusinessUnitsInnerTasksTodayInner', json, (
  $checkedConvert,
) {
  $checkKeys(
    json,
    requiredKeys: const ['om', 'total', 'completed', 'notDone', 'pending'],
  );
  final val = DashboardBusinessUnitsInnerTasksTodayInner(
    om: $checkedConvert(
      'om',
      (v) => PersonRef.fromJson(v as Map<String, dynamic>),
    ),
    total: $checkedConvert('total', (v) => (v as num).toInt()),
    completed: $checkedConvert('completed', (v) => (v as num).toInt()),
    notDone: $checkedConvert('notDone', (v) => (v as num).toInt()),
    pending: $checkedConvert('pending', (v) => (v as num).toInt()),
  );
  return val;
});

Map<String, dynamic> _$DashboardBusinessUnitsInnerTasksTodayInnerToJson(
  DashboardBusinessUnitsInnerTasksTodayInner instance,
) => <String, dynamic>{
  'om': instance.om.toJson(),
  'total': instance.total,
  'completed': instance.completed,
  'notDone': instance.notDone,
  'pending': instance.pending,
};
