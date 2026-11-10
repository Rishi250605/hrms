// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roster_copy_result.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RosterCopyResultCWProxy {
  RosterCopyResult createdDuties(int createdDuties);

  RosterCopyResult existingDuties(int existingDuties);

  RosterCopyResult copiedAssignments(int copiedAssignments);

  RosterCopyResult skipped(List<RosterCopyResultSkippedInner> skipped);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RosterCopyResult(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RosterCopyResult(...).copyWith(id: 12, name: "My name")
  /// ````
  RosterCopyResult call({
    int createdDuties,
    int existingDuties,
    int copiedAssignments,
    List<RosterCopyResultSkippedInner> skipped,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRosterCopyResult.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRosterCopyResult.copyWith.fieldName(...)`
class _$RosterCopyResultCWProxyImpl implements _$RosterCopyResultCWProxy {
  const _$RosterCopyResultCWProxyImpl(this._value);

  final RosterCopyResult _value;

  @override
  RosterCopyResult createdDuties(int createdDuties) =>
      this(createdDuties: createdDuties);

  @override
  RosterCopyResult existingDuties(int existingDuties) =>
      this(existingDuties: existingDuties);

  @override
  RosterCopyResult copiedAssignments(int copiedAssignments) =>
      this(copiedAssignments: copiedAssignments);

  @override
  RosterCopyResult skipped(List<RosterCopyResultSkippedInner> skipped) =>
      this(skipped: skipped);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RosterCopyResult(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RosterCopyResult(...).copyWith(id: 12, name: "My name")
  /// ````
  RosterCopyResult call({
    Object? createdDuties = const $CopyWithPlaceholder(),
    Object? existingDuties = const $CopyWithPlaceholder(),
    Object? copiedAssignments = const $CopyWithPlaceholder(),
    Object? skipped = const $CopyWithPlaceholder(),
  }) {
    return RosterCopyResult(
      createdDuties: createdDuties == const $CopyWithPlaceholder()
          ? _value.createdDuties
          // ignore: cast_nullable_to_non_nullable
          : createdDuties as int,
      existingDuties: existingDuties == const $CopyWithPlaceholder()
          ? _value.existingDuties
          // ignore: cast_nullable_to_non_nullable
          : existingDuties as int,
      copiedAssignments: copiedAssignments == const $CopyWithPlaceholder()
          ? _value.copiedAssignments
          // ignore: cast_nullable_to_non_nullable
          : copiedAssignments as int,
      skipped: skipped == const $CopyWithPlaceholder()
          ? _value.skipped
          // ignore: cast_nullable_to_non_nullable
          : skipped as List<RosterCopyResultSkippedInner>,
    );
  }
}

extension $RosterCopyResultCopyWith on RosterCopyResult {
  /// Returns a callable class that can be used as follows: `instanceOfRosterCopyResult.copyWith(...)` or like so:`instanceOfRosterCopyResult.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RosterCopyResultCWProxy get copyWith => _$RosterCopyResultCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RosterCopyResult _$RosterCopyResultFromJson(Map<String, dynamic> json) =>
    $checkedCreate('RosterCopyResult', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'createdDuties',
          'existingDuties',
          'copiedAssignments',
          'skipped',
        ],
      );
      final val = RosterCopyResult(
        createdDuties: $checkedConvert(
          'createdDuties',
          (v) => (v as num).toInt(),
        ),
        existingDuties: $checkedConvert(
          'existingDuties',
          (v) => (v as num).toInt(),
        ),
        copiedAssignments: $checkedConvert(
          'copiedAssignments',
          (v) => (v as num).toInt(),
        ),
        skipped: $checkedConvert(
          'skipped',
          (v) => (v as List<dynamic>)
              .map(
                (e) => RosterCopyResultSkippedInner.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$RosterCopyResultToJson(RosterCopyResult instance) =>
    <String, dynamic>{
      'createdDuties': instance.createdDuties,
      'existingDuties': instance.existingDuties,
      'copiedAssignments': instance.copiedAssignments,
      'skipped': instance.skipped.map((e) => e.toJson()).toList(),
    };
