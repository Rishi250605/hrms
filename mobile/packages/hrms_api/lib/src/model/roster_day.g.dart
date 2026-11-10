// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roster_day.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RosterDayCWProxy {
  RosterDay date(String date);

  RosterDay depot(DepotSummary depot);

  RosterDay summary(RosterDaySummary summary);

  RosterDay duties(List<DutyItem> duties);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RosterDay(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RosterDay(...).copyWith(id: 12, name: "My name")
  /// ````
  RosterDay call({
    String date,
    DepotSummary depot,
    RosterDaySummary summary,
    List<DutyItem> duties,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRosterDay.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRosterDay.copyWith.fieldName(...)`
class _$RosterDayCWProxyImpl implements _$RosterDayCWProxy {
  const _$RosterDayCWProxyImpl(this._value);

  final RosterDay _value;

  @override
  RosterDay date(String date) => this(date: date);

  @override
  RosterDay depot(DepotSummary depot) => this(depot: depot);

  @override
  RosterDay summary(RosterDaySummary summary) => this(summary: summary);

  @override
  RosterDay duties(List<DutyItem> duties) => this(duties: duties);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RosterDay(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RosterDay(...).copyWith(id: 12, name: "My name")
  /// ````
  RosterDay call({
    Object? date = const $CopyWithPlaceholder(),
    Object? depot = const $CopyWithPlaceholder(),
    Object? summary = const $CopyWithPlaceholder(),
    Object? duties = const $CopyWithPlaceholder(),
  }) {
    return RosterDay(
      date: date == const $CopyWithPlaceholder()
          ? _value.date
          // ignore: cast_nullable_to_non_nullable
          : date as String,
      depot: depot == const $CopyWithPlaceholder()
          ? _value.depot
          // ignore: cast_nullable_to_non_nullable
          : depot as DepotSummary,
      summary: summary == const $CopyWithPlaceholder()
          ? _value.summary
          // ignore: cast_nullable_to_non_nullable
          : summary as RosterDaySummary,
      duties: duties == const $CopyWithPlaceholder()
          ? _value.duties
          // ignore: cast_nullable_to_non_nullable
          : duties as List<DutyItem>,
    );
  }
}

extension $RosterDayCopyWith on RosterDay {
  /// Returns a callable class that can be used as follows: `instanceOfRosterDay.copyWith(...)` or like so:`instanceOfRosterDay.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RosterDayCWProxy get copyWith => _$RosterDayCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RosterDay _$RosterDayFromJson(Map<String, dynamic> json) =>
    $checkedCreate('RosterDay', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['date', 'depot', 'summary', 'duties'],
      );
      final val = RosterDay(
        date: $checkedConvert('date', (v) => v as String),
        depot: $checkedConvert(
          'depot',
          (v) => DepotSummary.fromJson(v as Map<String, dynamic>),
        ),
        summary: $checkedConvert(
          'summary',
          (v) => RosterDaySummary.fromJson(v as Map<String, dynamic>),
        ),
        duties: $checkedConvert(
          'duties',
          (v) => (v as List<dynamic>)
              .map((e) => DutyItem.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$RosterDayToJson(RosterDay instance) => <String, dynamic>{
  'date': instance.date,
  'depot': instance.depot.toJson(),
  'summary': instance.summary.toJson(),
  'duties': instance.duties.map((e) => e.toJson()).toList(),
};
