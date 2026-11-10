// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allowance_page.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AllowancePageCWProxy {
  AllowancePage items(List<AllowanceItem> items);

  AllowancePage nextCursor(String? nextCursor);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AllowancePage(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AllowancePage(...).copyWith(id: 12, name: "My name")
  /// ````
  AllowancePage call({List<AllowanceItem> items, String? nextCursor});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAllowancePage.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAllowancePage.copyWith.fieldName(...)`
class _$AllowancePageCWProxyImpl implements _$AllowancePageCWProxy {
  const _$AllowancePageCWProxyImpl(this._value);

  final AllowancePage _value;

  @override
  AllowancePage items(List<AllowanceItem> items) => this(items: items);

  @override
  AllowancePage nextCursor(String? nextCursor) => this(nextCursor: nextCursor);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AllowancePage(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AllowancePage(...).copyWith(id: 12, name: "My name")
  /// ````
  AllowancePage call({
    Object? items = const $CopyWithPlaceholder(),
    Object? nextCursor = const $CopyWithPlaceholder(),
  }) {
    return AllowancePage(
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<AllowanceItem>,
      nextCursor: nextCursor == const $CopyWithPlaceholder()
          ? _value.nextCursor
          // ignore: cast_nullable_to_non_nullable
          : nextCursor as String?,
    );
  }
}

extension $AllowancePageCopyWith on AllowancePage {
  /// Returns a callable class that can be used as follows: `instanceOfAllowancePage.copyWith(...)` or like so:`instanceOfAllowancePage.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AllowancePageCWProxy get copyWith => _$AllowancePageCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllowancePage _$AllowancePageFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AllowancePage', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['items', 'nextCursor']);
      final val = AllowancePage(
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map((e) => AllowanceItem.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        nextCursor: $checkedConvert('nextCursor', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$AllowancePageToJson(AllowancePage instance) =>
    <String, dynamic>{
      'items': instance.items.map((e) => e.toJson()).toList(),
      'nextCursor': instance.nextCursor,
    };
