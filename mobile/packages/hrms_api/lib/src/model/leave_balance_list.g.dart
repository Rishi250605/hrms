// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_balance_list.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LeaveBalanceListCWProxy {
  LeaveBalanceList employeeId(String employeeId);

  LeaveBalanceList year(int year);

  LeaveBalanceList items(List<LeaveBalanceItem> items);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LeaveBalanceList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LeaveBalanceList(...).copyWith(id: 12, name: "My name")
  /// ````
  LeaveBalanceList call({
    String employeeId,
    int year,
    List<LeaveBalanceItem> items,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfLeaveBalanceList.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfLeaveBalanceList.copyWith.fieldName(...)`
class _$LeaveBalanceListCWProxyImpl implements _$LeaveBalanceListCWProxy {
  const _$LeaveBalanceListCWProxyImpl(this._value);

  final LeaveBalanceList _value;

  @override
  LeaveBalanceList employeeId(String employeeId) =>
      this(employeeId: employeeId);

  @override
  LeaveBalanceList year(int year) => this(year: year);

  @override
  LeaveBalanceList items(List<LeaveBalanceItem> items) => this(items: items);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LeaveBalanceList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LeaveBalanceList(...).copyWith(id: 12, name: "My name")
  /// ````
  LeaveBalanceList call({
    Object? employeeId = const $CopyWithPlaceholder(),
    Object? year = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
  }) {
    return LeaveBalanceList(
      employeeId: employeeId == const $CopyWithPlaceholder()
          ? _value.employeeId
          // ignore: cast_nullable_to_non_nullable
          : employeeId as String,
      year: year == const $CopyWithPlaceholder()
          ? _value.year
          // ignore: cast_nullable_to_non_nullable
          : year as int,
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<LeaveBalanceItem>,
    );
  }
}

extension $LeaveBalanceListCopyWith on LeaveBalanceList {
  /// Returns a callable class that can be used as follows: `instanceOfLeaveBalanceList.copyWith(...)` or like so:`instanceOfLeaveBalanceList.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LeaveBalanceListCWProxy get copyWith => _$LeaveBalanceListCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveBalanceList _$LeaveBalanceListFromJson(Map<String, dynamic> json) =>
    $checkedCreate('LeaveBalanceList', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['employeeId', 'year', 'items']);
      final val = LeaveBalanceList(
        employeeId: $checkedConvert('employeeId', (v) => v as String),
        year: $checkedConvert('year', (v) => (v as num).toInt()),
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map((e) => LeaveBalanceItem.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$LeaveBalanceListToJson(LeaveBalanceList instance) =>
    <String, dynamic>{
      'employeeId': instance.employeeId,
      'year': instance.year,
      'items': instance.items.map((e) => e.toJson()).toList(),
    };
