// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roster_day_summary.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RosterDaySummaryCWProxy {
  RosterDaySummary duties(int duties);

  RosterDaySummary filled(int filled);

  RosterDaySummary unfilled(int unfilled);

  RosterDaySummary cancelled(int cancelled);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RosterDaySummary(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RosterDaySummary(...).copyWith(id: 12, name: "My name")
  /// ````
  RosterDaySummary call({int duties, int filled, int unfilled, int cancelled});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRosterDaySummary.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRosterDaySummary.copyWith.fieldName(...)`
class _$RosterDaySummaryCWProxyImpl implements _$RosterDaySummaryCWProxy {
  const _$RosterDaySummaryCWProxyImpl(this._value);

  final RosterDaySummary _value;

  @override
  RosterDaySummary duties(int duties) => this(duties: duties);

  @override
  RosterDaySummary filled(int filled) => this(filled: filled);

  @override
  RosterDaySummary unfilled(int unfilled) => this(unfilled: unfilled);

  @override
  RosterDaySummary cancelled(int cancelled) => this(cancelled: cancelled);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RosterDaySummary(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RosterDaySummary(...).copyWith(id: 12, name: "My name")
  /// ````
  RosterDaySummary call({
    Object? duties = const $CopyWithPlaceholder(),
    Object? filled = const $CopyWithPlaceholder(),
    Object? unfilled = const $CopyWithPlaceholder(),
    Object? cancelled = const $CopyWithPlaceholder(),
  }) {
    return RosterDaySummary(
      duties: duties == const $CopyWithPlaceholder()
          ? _value.duties
          // ignore: cast_nullable_to_non_nullable
          : duties as int,
      filled: filled == const $CopyWithPlaceholder()
          ? _value.filled
          // ignore: cast_nullable_to_non_nullable
          : filled as int,
      unfilled: unfilled == const $CopyWithPlaceholder()
          ? _value.unfilled
          // ignore: cast_nullable_to_non_nullable
          : unfilled as int,
      cancelled: cancelled == const $CopyWithPlaceholder()
          ? _value.cancelled
          // ignore: cast_nullable_to_non_nullable
          : cancelled as int,
    );
  }
}

extension $RosterDaySummaryCopyWith on RosterDaySummary {
  /// Returns a callable class that can be used as follows: `instanceOfRosterDaySummary.copyWith(...)` or like so:`instanceOfRosterDaySummary.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RosterDaySummaryCWProxy get copyWith => _$RosterDaySummaryCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RosterDaySummary _$RosterDaySummaryFromJson(Map<String, dynamic> json) =>
    $checkedCreate('RosterDaySummary', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['duties', 'filled', 'unfilled', 'cancelled'],
      );
      final val = RosterDaySummary(
        duties: $checkedConvert('duties', (v) => (v as num).toInt()),
        filled: $checkedConvert('filled', (v) => (v as num).toInt()),
        unfilled: $checkedConvert('unfilled', (v) => (v as num).toInt()),
        cancelled: $checkedConvert('cancelled', (v) => (v as num).toInt()),
      );
      return val;
    });

Map<String, dynamic> _$RosterDaySummaryToJson(RosterDaySummary instance) =>
    <String, dynamic>{
      'duties': instance.duties,
      'filled': instance.filled,
      'unfilled': instance.unfilled,
      'cancelled': instance.cancelled,
    };
