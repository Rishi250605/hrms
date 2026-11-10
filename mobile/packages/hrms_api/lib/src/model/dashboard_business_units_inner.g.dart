// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_business_units_inner.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DashboardBusinessUnitsInnerCWProxy {
  DashboardBusinessUnitsInner businessUnit(BusinessUnitRef businessUnit);

  DashboardBusinessUnitsInner today(DashboardBusinessUnitsInnerToday today);

  DashboardBusinessUnitsInner pendingApprovals(
    DashboardBusinessUnitsInnerPendingApprovals pendingApprovals,
  );

  DashboardBusinessUnitsInner allowancesThisMonth(
    DashboardBusinessUnitsInnerAllowancesThisMonth allowancesThisMonth,
  );

  DashboardBusinessUnitsInner tasksToday(
    List<DashboardBusinessUnitsInnerTasksTodayInner> tasksToday,
  );

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DashboardBusinessUnitsInner(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DashboardBusinessUnitsInner(...).copyWith(id: 12, name: "My name")
  /// ````
  DashboardBusinessUnitsInner call({
    BusinessUnitRef businessUnit,
    DashboardBusinessUnitsInnerToday today,
    DashboardBusinessUnitsInnerPendingApprovals pendingApprovals,
    DashboardBusinessUnitsInnerAllowancesThisMonth allowancesThisMonth,
    List<DashboardBusinessUnitsInnerTasksTodayInner> tasksToday,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDashboardBusinessUnitsInner.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDashboardBusinessUnitsInner.copyWith.fieldName(...)`
class _$DashboardBusinessUnitsInnerCWProxyImpl
    implements _$DashboardBusinessUnitsInnerCWProxy {
  const _$DashboardBusinessUnitsInnerCWProxyImpl(this._value);

  final DashboardBusinessUnitsInner _value;

  @override
  DashboardBusinessUnitsInner businessUnit(BusinessUnitRef businessUnit) =>
      this(businessUnit: businessUnit);

  @override
  DashboardBusinessUnitsInner today(DashboardBusinessUnitsInnerToday today) =>
      this(today: today);

  @override
  DashboardBusinessUnitsInner pendingApprovals(
    DashboardBusinessUnitsInnerPendingApprovals pendingApprovals,
  ) => this(pendingApprovals: pendingApprovals);

  @override
  DashboardBusinessUnitsInner allowancesThisMonth(
    DashboardBusinessUnitsInnerAllowancesThisMonth allowancesThisMonth,
  ) => this(allowancesThisMonth: allowancesThisMonth);

  @override
  DashboardBusinessUnitsInner tasksToday(
    List<DashboardBusinessUnitsInnerTasksTodayInner> tasksToday,
  ) => this(tasksToday: tasksToday);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DashboardBusinessUnitsInner(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DashboardBusinessUnitsInner(...).copyWith(id: 12, name: "My name")
  /// ````
  DashboardBusinessUnitsInner call({
    Object? businessUnit = const $CopyWithPlaceholder(),
    Object? today = const $CopyWithPlaceholder(),
    Object? pendingApprovals = const $CopyWithPlaceholder(),
    Object? allowancesThisMonth = const $CopyWithPlaceholder(),
    Object? tasksToday = const $CopyWithPlaceholder(),
  }) {
    return DashboardBusinessUnitsInner(
      businessUnit: businessUnit == const $CopyWithPlaceholder()
          ? _value.businessUnit
          // ignore: cast_nullable_to_non_nullable
          : businessUnit as BusinessUnitRef,
      today: today == const $CopyWithPlaceholder()
          ? _value.today
          // ignore: cast_nullable_to_non_nullable
          : today as DashboardBusinessUnitsInnerToday,
      pendingApprovals: pendingApprovals == const $CopyWithPlaceholder()
          ? _value.pendingApprovals
          // ignore: cast_nullable_to_non_nullable
          : pendingApprovals as DashboardBusinessUnitsInnerPendingApprovals,
      allowancesThisMonth: allowancesThisMonth == const $CopyWithPlaceholder()
          ? _value.allowancesThisMonth
          // ignore: cast_nullable_to_non_nullable
          : allowancesThisMonth
                as DashboardBusinessUnitsInnerAllowancesThisMonth,
      tasksToday: tasksToday == const $CopyWithPlaceholder()
          ? _value.tasksToday
          // ignore: cast_nullable_to_non_nullable
          : tasksToday as List<DashboardBusinessUnitsInnerTasksTodayInner>,
    );
  }
}

extension $DashboardBusinessUnitsInnerCopyWith on DashboardBusinessUnitsInner {
  /// Returns a callable class that can be used as follows: `instanceOfDashboardBusinessUnitsInner.copyWith(...)` or like so:`instanceOfDashboardBusinessUnitsInner.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DashboardBusinessUnitsInnerCWProxy get copyWith =>
      _$DashboardBusinessUnitsInnerCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardBusinessUnitsInner _$DashboardBusinessUnitsInnerFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DashboardBusinessUnitsInner', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'businessUnit',
      'today',
      'pendingApprovals',
      'allowancesThisMonth',
      'tasksToday',
    ],
  );
  final val = DashboardBusinessUnitsInner(
    businessUnit: $checkedConvert(
      'businessUnit',
      (v) => BusinessUnitRef.fromJson(v as Map<String, dynamic>),
    ),
    today: $checkedConvert(
      'today',
      (v) =>
          DashboardBusinessUnitsInnerToday.fromJson(v as Map<String, dynamic>),
    ),
    pendingApprovals: $checkedConvert(
      'pendingApprovals',
      (v) => DashboardBusinessUnitsInnerPendingApprovals.fromJson(
        v as Map<String, dynamic>,
      ),
    ),
    allowancesThisMonth: $checkedConvert(
      'allowancesThisMonth',
      (v) => DashboardBusinessUnitsInnerAllowancesThisMonth.fromJson(
        v as Map<String, dynamic>,
      ),
    ),
    tasksToday: $checkedConvert(
      'tasksToday',
      (v) => (v as List<dynamic>)
          .map(
            (e) => DashboardBusinessUnitsInnerTasksTodayInner.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$DashboardBusinessUnitsInnerToJson(
  DashboardBusinessUnitsInner instance,
) => <String, dynamic>{
  'businessUnit': instance.businessUnit.toJson(),
  'today': instance.today.toJson(),
  'pendingApprovals': instance.pendingApprovals.toJson(),
  'allowancesThisMonth': instance.allowancesThisMonth.toJson(),
  'tasksToday': instance.tasksToday.map((e) => e.toJson()).toList(),
};
