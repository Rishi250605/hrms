// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DashboardCWProxy {
  Dashboard date(String date);

  Dashboard month(String month);

  Dashboard businessUnits(List<DashboardBusinessUnitsInner> businessUnits);

  Dashboard me(DashboardMe me);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Dashboard(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Dashboard(...).copyWith(id: 12, name: "My name")
  /// ````
  Dashboard call({
    String date,
    String month,
    List<DashboardBusinessUnitsInner> businessUnits,
    DashboardMe me,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDashboard.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDashboard.copyWith.fieldName(...)`
class _$DashboardCWProxyImpl implements _$DashboardCWProxy {
  const _$DashboardCWProxyImpl(this._value);

  final Dashboard _value;

  @override
  Dashboard date(String date) => this(date: date);

  @override
  Dashboard month(String month) => this(month: month);

  @override
  Dashboard businessUnits(List<DashboardBusinessUnitsInner> businessUnits) =>
      this(businessUnits: businessUnits);

  @override
  Dashboard me(DashboardMe me) => this(me: me);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Dashboard(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Dashboard(...).copyWith(id: 12, name: "My name")
  /// ````
  Dashboard call({
    Object? date = const $CopyWithPlaceholder(),
    Object? month = const $CopyWithPlaceholder(),
    Object? businessUnits = const $CopyWithPlaceholder(),
    Object? me = const $CopyWithPlaceholder(),
  }) {
    return Dashboard(
      date: date == const $CopyWithPlaceholder()
          ? _value.date
          // ignore: cast_nullable_to_non_nullable
          : date as String,
      month: month == const $CopyWithPlaceholder()
          ? _value.month
          // ignore: cast_nullable_to_non_nullable
          : month as String,
      businessUnits: businessUnits == const $CopyWithPlaceholder()
          ? _value.businessUnits
          // ignore: cast_nullable_to_non_nullable
          : businessUnits as List<DashboardBusinessUnitsInner>,
      me: me == const $CopyWithPlaceholder()
          ? _value.me
          // ignore: cast_nullable_to_non_nullable
          : me as DashboardMe,
    );
  }
}

extension $DashboardCopyWith on Dashboard {
  /// Returns a callable class that can be used as follows: `instanceOfDashboard.copyWith(...)` or like so:`instanceOfDashboard.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DashboardCWProxy get copyWith => _$DashboardCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dashboard _$DashboardFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Dashboard', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['date', 'month', 'businessUnits', 'me'],
      );
      final val = Dashboard(
        date: $checkedConvert('date', (v) => v as String),
        month: $checkedConvert('month', (v) => v as String),
        businessUnits: $checkedConvert(
          'businessUnits',
          (v) => (v as List<dynamic>)
              .map(
                (e) => DashboardBusinessUnitsInner.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList(),
        ),
        me: $checkedConvert(
          'me',
          (v) => DashboardMe.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$DashboardToJson(Dashboard instance) => <String, dynamic>{
  'date': instance.date,
  'month': instance.month,
  'businessUnits': instance.businessUnits.map((e) => e.toJson()).toList(),
  'me': instance.me.toJson(),
};
