// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_business_units_inner_allowances_this_month.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DashboardBusinessUnitsInnerAllowancesThisMonthCWProxy {
  DashboardBusinessUnitsInnerAllowancesThisMonth requestedPaise(
    int requestedPaise,
  );

  DashboardBusinessUnitsInnerAllowancesThisMonth approvedPaise(
    int approvedPaise,
  );

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DashboardBusinessUnitsInnerAllowancesThisMonth(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DashboardBusinessUnitsInnerAllowancesThisMonth(...).copyWith(id: 12, name: "My name")
  /// ````
  DashboardBusinessUnitsInnerAllowancesThisMonth call({
    int requestedPaise,
    int approvedPaise,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDashboardBusinessUnitsInnerAllowancesThisMonth.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDashboardBusinessUnitsInnerAllowancesThisMonth.copyWith.fieldName(...)`
class _$DashboardBusinessUnitsInnerAllowancesThisMonthCWProxyImpl
    implements _$DashboardBusinessUnitsInnerAllowancesThisMonthCWProxy {
  const _$DashboardBusinessUnitsInnerAllowancesThisMonthCWProxyImpl(
    this._value,
  );

  final DashboardBusinessUnitsInnerAllowancesThisMonth _value;

  @override
  DashboardBusinessUnitsInnerAllowancesThisMonth requestedPaise(
    int requestedPaise,
  ) => this(requestedPaise: requestedPaise);

  @override
  DashboardBusinessUnitsInnerAllowancesThisMonth approvedPaise(
    int approvedPaise,
  ) => this(approvedPaise: approvedPaise);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DashboardBusinessUnitsInnerAllowancesThisMonth(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DashboardBusinessUnitsInnerAllowancesThisMonth(...).copyWith(id: 12, name: "My name")
  /// ````
  DashboardBusinessUnitsInnerAllowancesThisMonth call({
    Object? requestedPaise = const $CopyWithPlaceholder(),
    Object? approvedPaise = const $CopyWithPlaceholder(),
  }) {
    return DashboardBusinessUnitsInnerAllowancesThisMonth(
      requestedPaise: requestedPaise == const $CopyWithPlaceholder()
          ? _value.requestedPaise
          // ignore: cast_nullable_to_non_nullable
          : requestedPaise as int,
      approvedPaise: approvedPaise == const $CopyWithPlaceholder()
          ? _value.approvedPaise
          // ignore: cast_nullable_to_non_nullable
          : approvedPaise as int,
    );
  }
}

extension $DashboardBusinessUnitsInnerAllowancesThisMonthCopyWith
    on DashboardBusinessUnitsInnerAllowancesThisMonth {
  /// Returns a callable class that can be used as follows: `instanceOfDashboardBusinessUnitsInnerAllowancesThisMonth.copyWith(...)` or like so:`instanceOfDashboardBusinessUnitsInnerAllowancesThisMonth.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DashboardBusinessUnitsInnerAllowancesThisMonthCWProxy get copyWith =>
      _$DashboardBusinessUnitsInnerAllowancesThisMonthCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardBusinessUnitsInnerAllowancesThisMonth
_$DashboardBusinessUnitsInnerAllowancesThisMonthFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DashboardBusinessUnitsInnerAllowancesThisMonth', json, (
  $checkedConvert,
) {
  $checkKeys(json, requiredKeys: const ['requestedPaise', 'approvedPaise']);
  final val = DashboardBusinessUnitsInnerAllowancesThisMonth(
    requestedPaise: $checkedConvert(
      'requestedPaise',
      (v) => (v as num).toInt(),
    ),
    approvedPaise: $checkedConvert('approvedPaise', (v) => (v as num).toInt()),
  );
  return val;
});

Map<String, dynamic> _$DashboardBusinessUnitsInnerAllowancesThisMonthToJson(
  DashboardBusinessUnitsInnerAllowancesThisMonth instance,
) => <String, dynamic>{
  'requestedPaise': instance.requestedPaise,
  'approvedPaise': instance.approvedPaise,
};
