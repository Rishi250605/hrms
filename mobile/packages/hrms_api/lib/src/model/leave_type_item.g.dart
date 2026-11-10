// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_type_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LeaveTypeItemCWProxy {
  LeaveTypeItem id(String id);

  LeaveTypeItem code(String code);

  LeaveTypeItem name(String name);

  LeaveTypeItem paid(bool paid);

  LeaveTypeItem accrualRule(AccrualRule accrualRule);

  LeaveTypeItem carryForwardMax(num carryForwardMax);

  LeaveTypeItem encashable(bool encashable);

  LeaveTypeItem isActive(bool isActive);

  LeaveTypeItem tracksBalance(bool tracksBalance);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LeaveTypeItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LeaveTypeItem(...).copyWith(id: 12, name: "My name")
  /// ````
  LeaveTypeItem call({
    String id,
    String code,
    String name,
    bool paid,
    AccrualRule accrualRule,
    num carryForwardMax,
    bool encashable,
    bool isActive,
    bool tracksBalance,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfLeaveTypeItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfLeaveTypeItem.copyWith.fieldName(...)`
class _$LeaveTypeItemCWProxyImpl implements _$LeaveTypeItemCWProxy {
  const _$LeaveTypeItemCWProxyImpl(this._value);

  final LeaveTypeItem _value;

  @override
  LeaveTypeItem id(String id) => this(id: id);

  @override
  LeaveTypeItem code(String code) => this(code: code);

  @override
  LeaveTypeItem name(String name) => this(name: name);

  @override
  LeaveTypeItem paid(bool paid) => this(paid: paid);

  @override
  LeaveTypeItem accrualRule(AccrualRule accrualRule) =>
      this(accrualRule: accrualRule);

  @override
  LeaveTypeItem carryForwardMax(num carryForwardMax) =>
      this(carryForwardMax: carryForwardMax);

  @override
  LeaveTypeItem encashable(bool encashable) => this(encashable: encashable);

  @override
  LeaveTypeItem isActive(bool isActive) => this(isActive: isActive);

  @override
  LeaveTypeItem tracksBalance(bool tracksBalance) =>
      this(tracksBalance: tracksBalance);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LeaveTypeItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LeaveTypeItem(...).copyWith(id: 12, name: "My name")
  /// ````
  LeaveTypeItem call({
    Object? id = const $CopyWithPlaceholder(),
    Object? code = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? paid = const $CopyWithPlaceholder(),
    Object? accrualRule = const $CopyWithPlaceholder(),
    Object? carryForwardMax = const $CopyWithPlaceholder(),
    Object? encashable = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? tracksBalance = const $CopyWithPlaceholder(),
  }) {
    return LeaveTypeItem(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      code: code == const $CopyWithPlaceholder()
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      paid: paid == const $CopyWithPlaceholder()
          ? _value.paid
          // ignore: cast_nullable_to_non_nullable
          : paid as bool,
      accrualRule: accrualRule == const $CopyWithPlaceholder()
          ? _value.accrualRule
          // ignore: cast_nullable_to_non_nullable
          : accrualRule as AccrualRule,
      carryForwardMax: carryForwardMax == const $CopyWithPlaceholder()
          ? _value.carryForwardMax
          // ignore: cast_nullable_to_non_nullable
          : carryForwardMax as num,
      encashable: encashable == const $CopyWithPlaceholder()
          ? _value.encashable
          // ignore: cast_nullable_to_non_nullable
          : encashable as bool,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool,
      tracksBalance: tracksBalance == const $CopyWithPlaceholder()
          ? _value.tracksBalance
          // ignore: cast_nullable_to_non_nullable
          : tracksBalance as bool,
    );
  }
}

extension $LeaveTypeItemCopyWith on LeaveTypeItem {
  /// Returns a callable class that can be used as follows: `instanceOfLeaveTypeItem.copyWith(...)` or like so:`instanceOfLeaveTypeItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LeaveTypeItemCWProxy get copyWith => _$LeaveTypeItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveTypeItem _$LeaveTypeItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate('LeaveTypeItem', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'code',
          'name',
          'paid',
          'accrualRule',
          'carryForwardMax',
          'encashable',
          'isActive',
          'tracksBalance',
        ],
      );
      final val = LeaveTypeItem(
        id: $checkedConvert('id', (v) => v as String),
        code: $checkedConvert('code', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        paid: $checkedConvert('paid', (v) => v as bool),
        accrualRule: $checkedConvert(
          'accrualRule',
          (v) => AccrualRule.fromJson(v as Map<String, dynamic>),
        ),
        carryForwardMax: $checkedConvert('carryForwardMax', (v) => v as num),
        encashable: $checkedConvert('encashable', (v) => v as bool),
        isActive: $checkedConvert('isActive', (v) => v as bool),
        tracksBalance: $checkedConvert('tracksBalance', (v) => v as bool),
      );
      return val;
    });

Map<String, dynamic> _$LeaveTypeItemToJson(LeaveTypeItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'paid': instance.paid,
      'accrualRule': instance.accrualRule.toJson(),
      'carryForwardMax': instance.carryForwardMax,
      'encashable': instance.encashable,
      'isActive': instance.isActive,
      'tracksBalance': instance.tracksBalance,
    };
