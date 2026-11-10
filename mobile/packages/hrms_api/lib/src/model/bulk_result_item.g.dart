// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bulk_result_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BulkResultItemCWProxy {
  BulkResultItem clientMutationId(String clientMutationId);

  BulkResultItem employeeId(String employeeId);

  BulkResultItem date(String date);

  BulkResultItem outcome(BulkResultItemOutcomeEnum outcome);

  BulkResultItem error(BulkResultItemError? error);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BulkResultItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BulkResultItem(...).copyWith(id: 12, name: "My name")
  /// ````
  BulkResultItem call({
    String clientMutationId,
    String employeeId,
    String date,
    BulkResultItemOutcomeEnum outcome,
    BulkResultItemError? error,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBulkResultItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBulkResultItem.copyWith.fieldName(...)`
class _$BulkResultItemCWProxyImpl implements _$BulkResultItemCWProxy {
  const _$BulkResultItemCWProxyImpl(this._value);

  final BulkResultItem _value;

  @override
  BulkResultItem clientMutationId(String clientMutationId) =>
      this(clientMutationId: clientMutationId);

  @override
  BulkResultItem employeeId(String employeeId) => this(employeeId: employeeId);

  @override
  BulkResultItem date(String date) => this(date: date);

  @override
  BulkResultItem outcome(BulkResultItemOutcomeEnum outcome) =>
      this(outcome: outcome);

  @override
  BulkResultItem error(BulkResultItemError? error) => this(error: error);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BulkResultItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BulkResultItem(...).copyWith(id: 12, name: "My name")
  /// ````
  BulkResultItem call({
    Object? clientMutationId = const $CopyWithPlaceholder(),
    Object? employeeId = const $CopyWithPlaceholder(),
    Object? date = const $CopyWithPlaceholder(),
    Object? outcome = const $CopyWithPlaceholder(),
    Object? error = const $CopyWithPlaceholder(),
  }) {
    return BulkResultItem(
      clientMutationId: clientMutationId == const $CopyWithPlaceholder()
          ? _value.clientMutationId
          // ignore: cast_nullable_to_non_nullable
          : clientMutationId as String,
      employeeId: employeeId == const $CopyWithPlaceholder()
          ? _value.employeeId
          // ignore: cast_nullable_to_non_nullable
          : employeeId as String,
      date: date == const $CopyWithPlaceholder()
          ? _value.date
          // ignore: cast_nullable_to_non_nullable
          : date as String,
      outcome: outcome == const $CopyWithPlaceholder()
          ? _value.outcome
          // ignore: cast_nullable_to_non_nullable
          : outcome as BulkResultItemOutcomeEnum,
      error: error == const $CopyWithPlaceholder()
          ? _value.error
          // ignore: cast_nullable_to_non_nullable
          : error as BulkResultItemError?,
    );
  }
}

extension $BulkResultItemCopyWith on BulkResultItem {
  /// Returns a callable class that can be used as follows: `instanceOfBulkResultItem.copyWith(...)` or like so:`instanceOfBulkResultItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BulkResultItemCWProxy get copyWith => _$BulkResultItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BulkResultItem _$BulkResultItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate('BulkResultItem', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'clientMutationId',
          'employeeId',
          'date',
          'outcome',
          'error',
        ],
      );
      final val = BulkResultItem(
        clientMutationId: $checkedConvert(
          'clientMutationId',
          (v) => v as String,
        ),
        employeeId: $checkedConvert('employeeId', (v) => v as String),
        date: $checkedConvert('date', (v) => v as String),
        outcome: $checkedConvert(
          'outcome',
          (v) => $enumDecode(_$BulkResultItemOutcomeEnumEnumMap, v),
        ),
        error: $checkedConvert(
          'error',
          (v) => v == null
              ? null
              : BulkResultItemError.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$BulkResultItemToJson(BulkResultItem instance) =>
    <String, dynamic>{
      'clientMutationId': instance.clientMutationId,
      'employeeId': instance.employeeId,
      'date': instance.date,
      'outcome': _$BulkResultItemOutcomeEnumEnumMap[instance.outcome]!,
      'error': instance.error?.toJson(),
    };

const _$BulkResultItemOutcomeEnumEnumMap = {
  BulkResultItemOutcomeEnum.APPLIED: 'APPLIED',
  BulkResultItemOutcomeEnum.DUPLICATE: 'DUPLICATE',
  BulkResultItemOutcomeEnum.REJECTED: 'REJECTED',
};
