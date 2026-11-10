// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payslip_version_list.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PayslipVersionListCWProxy {
  PayslipVersionList items(List<PayslipVersionListItemsInner> items);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PayslipVersionList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PayslipVersionList(...).copyWith(id: 12, name: "My name")
  /// ````
  PayslipVersionList call({List<PayslipVersionListItemsInner> items});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPayslipVersionList.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPayslipVersionList.copyWith.fieldName(...)`
class _$PayslipVersionListCWProxyImpl implements _$PayslipVersionListCWProxy {
  const _$PayslipVersionListCWProxyImpl(this._value);

  final PayslipVersionList _value;

  @override
  PayslipVersionList items(List<PayslipVersionListItemsInner> items) =>
      this(items: items);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PayslipVersionList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PayslipVersionList(...).copyWith(id: 12, name: "My name")
  /// ````
  PayslipVersionList call({Object? items = const $CopyWithPlaceholder()}) {
    return PayslipVersionList(
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<PayslipVersionListItemsInner>,
    );
  }
}

extension $PayslipVersionListCopyWith on PayslipVersionList {
  /// Returns a callable class that can be used as follows: `instanceOfPayslipVersionList.copyWith(...)` or like so:`instanceOfPayslipVersionList.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PayslipVersionListCWProxy get copyWith =>
      _$PayslipVersionListCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayslipVersionList _$PayslipVersionListFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PayslipVersionList', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['items']);
      final val = PayslipVersionList(
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map(
                (e) => PayslipVersionListItemsInner.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$PayslipVersionListToJson(PayslipVersionList instance) =>
    <String, dynamic>{'items': instance.items.map((e) => e.toJson()).toList()};
