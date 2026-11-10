// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_type_update_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LeaveTypeUpdateBodyCWProxy {
  LeaveTypeUpdateBody name(String? name);

  LeaveTypeUpdateBody paid(bool? paid);

  LeaveTypeUpdateBody accrualRule(AccrualRule? accrualRule);

  LeaveTypeUpdateBody carryForwardMax(num? carryForwardMax);

  LeaveTypeUpdateBody encashable(bool? encashable);

  LeaveTypeUpdateBody isActive(bool? isActive);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LeaveTypeUpdateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LeaveTypeUpdateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  LeaveTypeUpdateBody call({
    String? name,
    bool? paid,
    AccrualRule? accrualRule,
    num? carryForwardMax,
    bool? encashable,
    bool? isActive,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfLeaveTypeUpdateBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfLeaveTypeUpdateBody.copyWith.fieldName(...)`
class _$LeaveTypeUpdateBodyCWProxyImpl implements _$LeaveTypeUpdateBodyCWProxy {
  const _$LeaveTypeUpdateBodyCWProxyImpl(this._value);

  final LeaveTypeUpdateBody _value;

  @override
  LeaveTypeUpdateBody name(String? name) => this(name: name);

  @override
  LeaveTypeUpdateBody paid(bool? paid) => this(paid: paid);

  @override
  LeaveTypeUpdateBody accrualRule(AccrualRule? accrualRule) =>
      this(accrualRule: accrualRule);

  @override
  LeaveTypeUpdateBody carryForwardMax(num? carryForwardMax) =>
      this(carryForwardMax: carryForwardMax);

  @override
  LeaveTypeUpdateBody encashable(bool? encashable) =>
      this(encashable: encashable);

  @override
  LeaveTypeUpdateBody isActive(bool? isActive) => this(isActive: isActive);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LeaveTypeUpdateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LeaveTypeUpdateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  LeaveTypeUpdateBody call({
    Object? name = const $CopyWithPlaceholder(),
    Object? paid = const $CopyWithPlaceholder(),
    Object? accrualRule = const $CopyWithPlaceholder(),
    Object? carryForwardMax = const $CopyWithPlaceholder(),
    Object? encashable = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
  }) {
    return LeaveTypeUpdateBody(
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      paid: paid == const $CopyWithPlaceholder()
          ? _value.paid
          // ignore: cast_nullable_to_non_nullable
          : paid as bool?,
      accrualRule: accrualRule == const $CopyWithPlaceholder()
          ? _value.accrualRule
          // ignore: cast_nullable_to_non_nullable
          : accrualRule as AccrualRule?,
      carryForwardMax: carryForwardMax == const $CopyWithPlaceholder()
          ? _value.carryForwardMax
          // ignore: cast_nullable_to_non_nullable
          : carryForwardMax as num?,
      encashable: encashable == const $CopyWithPlaceholder()
          ? _value.encashable
          // ignore: cast_nullable_to_non_nullable
          : encashable as bool?,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool?,
    );
  }
}

extension $LeaveTypeUpdateBodyCopyWith on LeaveTypeUpdateBody {
  /// Returns a callable class that can be used as follows: `instanceOfLeaveTypeUpdateBody.copyWith(...)` or like so:`instanceOfLeaveTypeUpdateBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LeaveTypeUpdateBodyCWProxy get copyWith =>
      _$LeaveTypeUpdateBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveTypeUpdateBody _$LeaveTypeUpdateBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('LeaveTypeUpdateBody', json, ($checkedConvert) {
      final val = LeaveTypeUpdateBody(
        name: $checkedConvert('name', (v) => v as String?),
        paid: $checkedConvert('paid', (v) => v as bool?),
        accrualRule: $checkedConvert(
          'accrualRule',
          (v) => v == null
              ? null
              : AccrualRule.fromJson(v as Map<String, dynamic>),
        ),
        carryForwardMax: $checkedConvert('carryForwardMax', (v) => v as num?),
        encashable: $checkedConvert('encashable', (v) => v as bool?),
        isActive: $checkedConvert('isActive', (v) => v as bool?),
      );
      return val;
    });

Map<String, dynamic> _$LeaveTypeUpdateBodyToJson(
  LeaveTypeUpdateBody instance,
) => <String, dynamic>{
  'name': ?instance.name,
  'paid': ?instance.paid,
  'accrualRule': ?instance.accrualRule?.toJson(),
  'carryForwardMax': ?instance.carryForwardMax,
  'encashable': ?instance.encashable,
  'isActive': ?instance.isActive,
};
