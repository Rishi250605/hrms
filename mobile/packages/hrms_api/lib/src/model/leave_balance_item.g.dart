// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_balance_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LeaveBalanceItemCWProxy {
  LeaveBalanceItem leaveTypeId(String leaveTypeId);

  LeaveBalanceItem leaveTypeCode(String leaveTypeCode);

  LeaveBalanceItem leaveTypeName(String leaveTypeName);

  LeaveBalanceItem year(int year);

  LeaveBalanceItem tracksBalance(bool tracksBalance);

  LeaveBalanceItem annualQuota(num? annualQuota);

  LeaveBalanceItem opening(num opening);

  LeaveBalanceItem accrued(num accrued);

  LeaveBalanceItem used(num used);

  LeaveBalanceItem encashed(num encashed);

  LeaveBalanceItem closing(num closing);

  LeaveBalanceItem pending(num pending);

  LeaveBalanceItem available(num available);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LeaveBalanceItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LeaveBalanceItem(...).copyWith(id: 12, name: "My name")
  /// ````
  LeaveBalanceItem call({
    String leaveTypeId,
    String leaveTypeCode,
    String leaveTypeName,
    int year,
    bool tracksBalance,
    num? annualQuota,
    num opening,
    num accrued,
    num used,
    num encashed,
    num closing,
    num pending,
    num available,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfLeaveBalanceItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfLeaveBalanceItem.copyWith.fieldName(...)`
class _$LeaveBalanceItemCWProxyImpl implements _$LeaveBalanceItemCWProxy {
  const _$LeaveBalanceItemCWProxyImpl(this._value);

  final LeaveBalanceItem _value;

  @override
  LeaveBalanceItem leaveTypeId(String leaveTypeId) =>
      this(leaveTypeId: leaveTypeId);

  @override
  LeaveBalanceItem leaveTypeCode(String leaveTypeCode) =>
      this(leaveTypeCode: leaveTypeCode);

  @override
  LeaveBalanceItem leaveTypeName(String leaveTypeName) =>
      this(leaveTypeName: leaveTypeName);

  @override
  LeaveBalanceItem year(int year) => this(year: year);

  @override
  LeaveBalanceItem tracksBalance(bool tracksBalance) =>
      this(tracksBalance: tracksBalance);

  @override
  LeaveBalanceItem annualQuota(num? annualQuota) =>
      this(annualQuota: annualQuota);

  @override
  LeaveBalanceItem opening(num opening) => this(opening: opening);

  @override
  LeaveBalanceItem accrued(num accrued) => this(accrued: accrued);

  @override
  LeaveBalanceItem used(num used) => this(used: used);

  @override
  LeaveBalanceItem encashed(num encashed) => this(encashed: encashed);

  @override
  LeaveBalanceItem closing(num closing) => this(closing: closing);

  @override
  LeaveBalanceItem pending(num pending) => this(pending: pending);

  @override
  LeaveBalanceItem available(num available) => this(available: available);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LeaveBalanceItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LeaveBalanceItem(...).copyWith(id: 12, name: "My name")
  /// ````
  LeaveBalanceItem call({
    Object? leaveTypeId = const $CopyWithPlaceholder(),
    Object? leaveTypeCode = const $CopyWithPlaceholder(),
    Object? leaveTypeName = const $CopyWithPlaceholder(),
    Object? year = const $CopyWithPlaceholder(),
    Object? tracksBalance = const $CopyWithPlaceholder(),
    Object? annualQuota = const $CopyWithPlaceholder(),
    Object? opening = const $CopyWithPlaceholder(),
    Object? accrued = const $CopyWithPlaceholder(),
    Object? used = const $CopyWithPlaceholder(),
    Object? encashed = const $CopyWithPlaceholder(),
    Object? closing = const $CopyWithPlaceholder(),
    Object? pending = const $CopyWithPlaceholder(),
    Object? available = const $CopyWithPlaceholder(),
  }) {
    return LeaveBalanceItem(
      leaveTypeId: leaveTypeId == const $CopyWithPlaceholder()
          ? _value.leaveTypeId
          // ignore: cast_nullable_to_non_nullable
          : leaveTypeId as String,
      leaveTypeCode: leaveTypeCode == const $CopyWithPlaceholder()
          ? _value.leaveTypeCode
          // ignore: cast_nullable_to_non_nullable
          : leaveTypeCode as String,
      leaveTypeName: leaveTypeName == const $CopyWithPlaceholder()
          ? _value.leaveTypeName
          // ignore: cast_nullable_to_non_nullable
          : leaveTypeName as String,
      year: year == const $CopyWithPlaceholder()
          ? _value.year
          // ignore: cast_nullable_to_non_nullable
          : year as int,
      tracksBalance: tracksBalance == const $CopyWithPlaceholder()
          ? _value.tracksBalance
          // ignore: cast_nullable_to_non_nullable
          : tracksBalance as bool,
      annualQuota: annualQuota == const $CopyWithPlaceholder()
          ? _value.annualQuota
          // ignore: cast_nullable_to_non_nullable
          : annualQuota as num?,
      opening: opening == const $CopyWithPlaceholder()
          ? _value.opening
          // ignore: cast_nullable_to_non_nullable
          : opening as num,
      accrued: accrued == const $CopyWithPlaceholder()
          ? _value.accrued
          // ignore: cast_nullable_to_non_nullable
          : accrued as num,
      used: used == const $CopyWithPlaceholder()
          ? _value.used
          // ignore: cast_nullable_to_non_nullable
          : used as num,
      encashed: encashed == const $CopyWithPlaceholder()
          ? _value.encashed
          // ignore: cast_nullable_to_non_nullable
          : encashed as num,
      closing: closing == const $CopyWithPlaceholder()
          ? _value.closing
          // ignore: cast_nullable_to_non_nullable
          : closing as num,
      pending: pending == const $CopyWithPlaceholder()
          ? _value.pending
          // ignore: cast_nullable_to_non_nullable
          : pending as num,
      available: available == const $CopyWithPlaceholder()
          ? _value.available
          // ignore: cast_nullable_to_non_nullable
          : available as num,
    );
  }
}

extension $LeaveBalanceItemCopyWith on LeaveBalanceItem {
  /// Returns a callable class that can be used as follows: `instanceOfLeaveBalanceItem.copyWith(...)` or like so:`instanceOfLeaveBalanceItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LeaveBalanceItemCWProxy get copyWith => _$LeaveBalanceItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveBalanceItem _$LeaveBalanceItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate('LeaveBalanceItem', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'leaveTypeId',
          'leaveTypeCode',
          'leaveTypeName',
          'year',
          'tracksBalance',
          'annualQuota',
          'opening',
          'accrued',
          'used',
          'encashed',
          'closing',
          'pending',
          'available',
        ],
      );
      final val = LeaveBalanceItem(
        leaveTypeId: $checkedConvert('leaveTypeId', (v) => v as String),
        leaveTypeCode: $checkedConvert('leaveTypeCode', (v) => v as String),
        leaveTypeName: $checkedConvert('leaveTypeName', (v) => v as String),
        year: $checkedConvert('year', (v) => (v as num).toInt()),
        tracksBalance: $checkedConvert('tracksBalance', (v) => v as bool),
        annualQuota: $checkedConvert('annualQuota', (v) => v as num?),
        opening: $checkedConvert('opening', (v) => v as num),
        accrued: $checkedConvert('accrued', (v) => v as num),
        used: $checkedConvert('used', (v) => v as num),
        encashed: $checkedConvert('encashed', (v) => v as num),
        closing: $checkedConvert('closing', (v) => v as num),
        pending: $checkedConvert('pending', (v) => v as num),
        available: $checkedConvert('available', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$LeaveBalanceItemToJson(LeaveBalanceItem instance) =>
    <String, dynamic>{
      'leaveTypeId': instance.leaveTypeId,
      'leaveTypeCode': instance.leaveTypeCode,
      'leaveTypeName': instance.leaveTypeName,
      'year': instance.year,
      'tracksBalance': instance.tracksBalance,
      'annualQuota': instance.annualQuota,
      'opening': instance.opening,
      'accrued': instance.accrued,
      'used': instance.used,
      'encashed': instance.encashed,
      'closing': instance.closing,
      'pending': instance.pending,
      'available': instance.available,
    };
