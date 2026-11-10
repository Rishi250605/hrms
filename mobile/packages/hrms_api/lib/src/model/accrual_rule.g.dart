// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accrual_rule.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AccrualRuleCWProxy {
  AccrualRule type(AccrualRuleTypeEnum type);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AccrualRule(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AccrualRule(...).copyWith(id: 12, name: "My name")
  /// ````
  AccrualRule call({AccrualRuleTypeEnum type});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAccrualRule.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAccrualRule.copyWith.fieldName(...)`
class _$AccrualRuleCWProxyImpl implements _$AccrualRuleCWProxy {
  const _$AccrualRuleCWProxyImpl(this._value);

  final AccrualRule _value;

  @override
  AccrualRule type(AccrualRuleTypeEnum type) => this(type: type);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AccrualRule(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AccrualRule(...).copyWith(id: 12, name: "My name")
  /// ````
  AccrualRule call({Object? type = const $CopyWithPlaceholder()}) {
    return AccrualRule(
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as AccrualRuleTypeEnum,
    );
  }
}

extension $AccrualRuleCopyWith on AccrualRule {
  /// Returns a callable class that can be used as follows: `instanceOfAccrualRule.copyWith(...)` or like so:`instanceOfAccrualRule.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AccrualRuleCWProxy get copyWith => _$AccrualRuleCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccrualRule _$AccrualRuleFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AccrualRule', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['type']);
      final val = AccrualRule(
        type: $checkedConvert(
          'type',
          (v) => $enumDecode(_$AccrualRuleTypeEnumEnumMap, v),
        ),
      );
      return val;
    });

Map<String, dynamic> _$AccrualRuleToJson(AccrualRule instance) =>
    <String, dynamic>{'type': _$AccrualRuleTypeEnumEnumMap[instance.type]!};

const _$AccrualRuleTypeEnumEnumMap = {
  AccrualRuleTypeEnum.MONTHLY: 'MONTHLY',
  AccrualRuleTypeEnum.ANNUAL: 'ANNUAL',
  AccrualRuleTypeEnum.NONE: 'NONE',
};
