// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_policy_list.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LeavePolicyListCWProxy {
  LeavePolicyList items(List<LeavePolicyItem> items);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LeavePolicyList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LeavePolicyList(...).copyWith(id: 12, name: "My name")
  /// ````
  LeavePolicyList call({List<LeavePolicyItem> items});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfLeavePolicyList.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfLeavePolicyList.copyWith.fieldName(...)`
class _$LeavePolicyListCWProxyImpl implements _$LeavePolicyListCWProxy {
  const _$LeavePolicyListCWProxyImpl(this._value);

  final LeavePolicyList _value;

  @override
  LeavePolicyList items(List<LeavePolicyItem> items) => this(items: items);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LeavePolicyList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LeavePolicyList(...).copyWith(id: 12, name: "My name")
  /// ````
  LeavePolicyList call({Object? items = const $CopyWithPlaceholder()}) {
    return LeavePolicyList(
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<LeavePolicyItem>,
    );
  }
}

extension $LeavePolicyListCopyWith on LeavePolicyList {
  /// Returns a callable class that can be used as follows: `instanceOfLeavePolicyList.copyWith(...)` or like so:`instanceOfLeavePolicyList.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LeavePolicyListCWProxy get copyWith => _$LeavePolicyListCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeavePolicyList _$LeavePolicyListFromJson(Map<String, dynamic> json) =>
    $checkedCreate('LeavePolicyList', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['items']);
      final val = LeavePolicyList(
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map((e) => LeavePolicyItem.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$LeavePolicyListToJson(LeavePolicyList instance) =>
    <String, dynamic>{'items': instance.items.map((e) => e.toJson()).toList()};
