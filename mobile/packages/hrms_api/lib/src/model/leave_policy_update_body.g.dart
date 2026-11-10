// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_policy_update_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LeavePolicyUpdateBodyCWProxy {
  LeavePolicyUpdateBody annualQuota(num annualQuota);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LeavePolicyUpdateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LeavePolicyUpdateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  LeavePolicyUpdateBody call({num annualQuota});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfLeavePolicyUpdateBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfLeavePolicyUpdateBody.copyWith.fieldName(...)`
class _$LeavePolicyUpdateBodyCWProxyImpl
    implements _$LeavePolicyUpdateBodyCWProxy {
  const _$LeavePolicyUpdateBodyCWProxyImpl(this._value);

  final LeavePolicyUpdateBody _value;

  @override
  LeavePolicyUpdateBody annualQuota(num annualQuota) =>
      this(annualQuota: annualQuota);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LeavePolicyUpdateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LeavePolicyUpdateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  LeavePolicyUpdateBody call({
    Object? annualQuota = const $CopyWithPlaceholder(),
  }) {
    return LeavePolicyUpdateBody(
      annualQuota: annualQuota == const $CopyWithPlaceholder()
          ? _value.annualQuota
          // ignore: cast_nullable_to_non_nullable
          : annualQuota as num,
    );
  }
}

extension $LeavePolicyUpdateBodyCopyWith on LeavePolicyUpdateBody {
  /// Returns a callable class that can be used as follows: `instanceOfLeavePolicyUpdateBody.copyWith(...)` or like so:`instanceOfLeavePolicyUpdateBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LeavePolicyUpdateBodyCWProxy get copyWith =>
      _$LeavePolicyUpdateBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeavePolicyUpdateBody _$LeavePolicyUpdateBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('LeavePolicyUpdateBody', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['annualQuota']);
  final val = LeavePolicyUpdateBody(
    annualQuota: $checkedConvert('annualQuota', (v) => v as num),
  );
  return val;
});

Map<String, dynamic> _$LeavePolicyUpdateBodyToJson(
  LeavePolicyUpdateBody instance,
) => <String, dynamic>{'annualQuota': instance.annualQuota};
