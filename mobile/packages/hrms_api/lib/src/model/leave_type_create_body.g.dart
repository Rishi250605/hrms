// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_type_create_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LeaveTypeCreateBodyCWProxy {
  LeaveTypeCreateBody code(String code);

  LeaveTypeCreateBody name(String name);

  LeaveTypeCreateBody paid(bool paid);

  LeaveTypeCreateBody accrualRule(AccrualRule accrualRule);

  LeaveTypeCreateBody carryForwardMax(num? carryForwardMax);

  LeaveTypeCreateBody encashable(bool? encashable);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LeaveTypeCreateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LeaveTypeCreateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  LeaveTypeCreateBody call({
    String code,
    String name,
    bool paid,
    AccrualRule accrualRule,
    num? carryForwardMax,
    bool? encashable,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfLeaveTypeCreateBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfLeaveTypeCreateBody.copyWith.fieldName(...)`
class _$LeaveTypeCreateBodyCWProxyImpl implements _$LeaveTypeCreateBodyCWProxy {
  const _$LeaveTypeCreateBodyCWProxyImpl(this._value);

  final LeaveTypeCreateBody _value;

  @override
  LeaveTypeCreateBody code(String code) => this(code: code);

  @override
  LeaveTypeCreateBody name(String name) => this(name: name);

  @override
  LeaveTypeCreateBody paid(bool paid) => this(paid: paid);

  @override
  LeaveTypeCreateBody accrualRule(AccrualRule accrualRule) =>
      this(accrualRule: accrualRule);

  @override
  LeaveTypeCreateBody carryForwardMax(num? carryForwardMax) =>
      this(carryForwardMax: carryForwardMax);

  @override
  LeaveTypeCreateBody encashable(bool? encashable) =>
      this(encashable: encashable);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LeaveTypeCreateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LeaveTypeCreateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  LeaveTypeCreateBody call({
    Object? code = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? paid = const $CopyWithPlaceholder(),
    Object? accrualRule = const $CopyWithPlaceholder(),
    Object? carryForwardMax = const $CopyWithPlaceholder(),
    Object? encashable = const $CopyWithPlaceholder(),
  }) {
    return LeaveTypeCreateBody(
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
          : carryForwardMax as num?,
      encashable: encashable == const $CopyWithPlaceholder()
          ? _value.encashable
          // ignore: cast_nullable_to_non_nullable
          : encashable as bool?,
    );
  }
}

extension $LeaveTypeCreateBodyCopyWith on LeaveTypeCreateBody {
  /// Returns a callable class that can be used as follows: `instanceOfLeaveTypeCreateBody.copyWith(...)` or like so:`instanceOfLeaveTypeCreateBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LeaveTypeCreateBodyCWProxy get copyWith =>
      _$LeaveTypeCreateBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveTypeCreateBody _$LeaveTypeCreateBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('LeaveTypeCreateBody', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['code', 'name', 'paid', 'accrualRule']);
  final val = LeaveTypeCreateBody(
    code: $checkedConvert('code', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    paid: $checkedConvert('paid', (v) => v as bool),
    accrualRule: $checkedConvert(
      'accrualRule',
      (v) => AccrualRule.fromJson(v as Map<String, dynamic>),
    ),
    carryForwardMax: $checkedConvert('carryForwardMax', (v) => v as num? ?? 0),
    encashable: $checkedConvert('encashable', (v) => v as bool? ?? false),
  );
  return val;
});

Map<String, dynamic> _$LeaveTypeCreateBodyToJson(
  LeaveTypeCreateBody instance,
) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'paid': instance.paid,
  'accrualRule': instance.accrualRule.toJson(),
  'carryForwardMax': ?instance.carryForwardMax,
  'encashable': ?instance.encashable,
};
