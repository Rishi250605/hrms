// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allowance_summary.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AllowanceSummaryCWProxy {
  AllowanceSummary month(String month);

  AllowanceSummary items(List<AllowanceSummaryItemsInner> items);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AllowanceSummary(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AllowanceSummary(...).copyWith(id: 12, name: "My name")
  /// ````
  AllowanceSummary call({String month, List<AllowanceSummaryItemsInner> items});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAllowanceSummary.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAllowanceSummary.copyWith.fieldName(...)`
class _$AllowanceSummaryCWProxyImpl implements _$AllowanceSummaryCWProxy {
  const _$AllowanceSummaryCWProxyImpl(this._value);

  final AllowanceSummary _value;

  @override
  AllowanceSummary month(String month) => this(month: month);

  @override
  AllowanceSummary items(List<AllowanceSummaryItemsInner> items) =>
      this(items: items);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AllowanceSummary(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AllowanceSummary(...).copyWith(id: 12, name: "My name")
  /// ````
  AllowanceSummary call({
    Object? month = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
  }) {
    return AllowanceSummary(
      month: month == const $CopyWithPlaceholder()
          ? _value.month
          // ignore: cast_nullable_to_non_nullable
          : month as String,
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<AllowanceSummaryItemsInner>,
    );
  }
}

extension $AllowanceSummaryCopyWith on AllowanceSummary {
  /// Returns a callable class that can be used as follows: `instanceOfAllowanceSummary.copyWith(...)` or like so:`instanceOfAllowanceSummary.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AllowanceSummaryCWProxy get copyWith => _$AllowanceSummaryCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllowanceSummary _$AllowanceSummaryFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AllowanceSummary', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['month', 'items']);
      final val = AllowanceSummary(
        month: $checkedConvert('month', (v) => v as String),
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map(
                (e) => AllowanceSummaryItemsInner.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$AllowanceSummaryToJson(AllowanceSummary instance) =>
    <String, dynamic>{
      'month': instance.month,
      'items': instance.items.map((e) => e.toJson()).toList(),
    };
