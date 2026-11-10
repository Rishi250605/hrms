// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roster_copy_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RosterCopyBodyCWProxy {
  RosterCopyBody depotId(String depotId);

  RosterCopyBody fromDate(String fromDate);

  RosterCopyBody toDate(String toDate);

  RosterCopyBody days(int? days);

  RosterCopyBody includeAssignments(bool? includeAssignments);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RosterCopyBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RosterCopyBody(...).copyWith(id: 12, name: "My name")
  /// ````
  RosterCopyBody call({
    String depotId,
    String fromDate,
    String toDate,
    int? days,
    bool? includeAssignments,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRosterCopyBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRosterCopyBody.copyWith.fieldName(...)`
class _$RosterCopyBodyCWProxyImpl implements _$RosterCopyBodyCWProxy {
  const _$RosterCopyBodyCWProxyImpl(this._value);

  final RosterCopyBody _value;

  @override
  RosterCopyBody depotId(String depotId) => this(depotId: depotId);

  @override
  RosterCopyBody fromDate(String fromDate) => this(fromDate: fromDate);

  @override
  RosterCopyBody toDate(String toDate) => this(toDate: toDate);

  @override
  RosterCopyBody days(int? days) => this(days: days);

  @override
  RosterCopyBody includeAssignments(bool? includeAssignments) =>
      this(includeAssignments: includeAssignments);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RosterCopyBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RosterCopyBody(...).copyWith(id: 12, name: "My name")
  /// ````
  RosterCopyBody call({
    Object? depotId = const $CopyWithPlaceholder(),
    Object? fromDate = const $CopyWithPlaceholder(),
    Object? toDate = const $CopyWithPlaceholder(),
    Object? days = const $CopyWithPlaceholder(),
    Object? includeAssignments = const $CopyWithPlaceholder(),
  }) {
    return RosterCopyBody(
      depotId: depotId == const $CopyWithPlaceholder()
          ? _value.depotId
          // ignore: cast_nullable_to_non_nullable
          : depotId as String,
      fromDate: fromDate == const $CopyWithPlaceholder()
          ? _value.fromDate
          // ignore: cast_nullable_to_non_nullable
          : fromDate as String,
      toDate: toDate == const $CopyWithPlaceholder()
          ? _value.toDate
          // ignore: cast_nullable_to_non_nullable
          : toDate as String,
      days: days == const $CopyWithPlaceholder()
          ? _value.days
          // ignore: cast_nullable_to_non_nullable
          : days as int?,
      includeAssignments: includeAssignments == const $CopyWithPlaceholder()
          ? _value.includeAssignments
          // ignore: cast_nullable_to_non_nullable
          : includeAssignments as bool?,
    );
  }
}

extension $RosterCopyBodyCopyWith on RosterCopyBody {
  /// Returns a callable class that can be used as follows: `instanceOfRosterCopyBody.copyWith(...)` or like so:`instanceOfRosterCopyBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RosterCopyBodyCWProxy get copyWith => _$RosterCopyBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RosterCopyBody _$RosterCopyBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('RosterCopyBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['depotId', 'fromDate', 'toDate']);
      final val = RosterCopyBody(
        depotId: $checkedConvert('depotId', (v) => v as String),
        fromDate: $checkedConvert('fromDate', (v) => v as String),
        toDate: $checkedConvert('toDate', (v) => v as String),
        days: $checkedConvert('days', (v) => (v as num?)?.toInt() ?? 1),
        includeAssignments: $checkedConvert(
          'includeAssignments',
          (v) => v as bool? ?? true,
        ),
      );
      return val;
    });

Map<String, dynamic> _$RosterCopyBodyToJson(RosterCopyBody instance) =>
    <String, dynamic>{
      'depotId': instance.depotId,
      'fromDate': instance.fromDate,
      'toDate': instance.toDate,
      'days': ?instance.days,
      'includeAssignments': ?instance.includeAssignments,
    };
