// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payslip_page.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PayslipPageCWProxy {
  PayslipPage items(List<PayslipItem> items);

  PayslipPage nextCursor(String? nextCursor);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PayslipPage(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PayslipPage(...).copyWith(id: 12, name: "My name")
  /// ````
  PayslipPage call({List<PayslipItem> items, String? nextCursor});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPayslipPage.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPayslipPage.copyWith.fieldName(...)`
class _$PayslipPageCWProxyImpl implements _$PayslipPageCWProxy {
  const _$PayslipPageCWProxyImpl(this._value);

  final PayslipPage _value;

  @override
  PayslipPage items(List<PayslipItem> items) => this(items: items);

  @override
  PayslipPage nextCursor(String? nextCursor) => this(nextCursor: nextCursor);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PayslipPage(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PayslipPage(...).copyWith(id: 12, name: "My name")
  /// ````
  PayslipPage call({
    Object? items = const $CopyWithPlaceholder(),
    Object? nextCursor = const $CopyWithPlaceholder(),
  }) {
    return PayslipPage(
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<PayslipItem>,
      nextCursor: nextCursor == const $CopyWithPlaceholder()
          ? _value.nextCursor
          // ignore: cast_nullable_to_non_nullable
          : nextCursor as String?,
    );
  }
}

extension $PayslipPageCopyWith on PayslipPage {
  /// Returns a callable class that can be used as follows: `instanceOfPayslipPage.copyWith(...)` or like so:`instanceOfPayslipPage.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PayslipPageCWProxy get copyWith => _$PayslipPageCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayslipPage _$PayslipPageFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PayslipPage', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['items', 'nextCursor']);
      final val = PayslipPage(
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map((e) => PayslipItem.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        nextCursor: $checkedConvert('nextCursor', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$PayslipPageToJson(PayslipPage instance) =>
    <String, dynamic>{
      'items': instance.items.map((e) => e.toJson()).toList(),
      'nextCursor': instance.nextCursor,
    };
