// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_page.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$EmployeePageCWProxy {
  EmployeePage items(List<EmployeeListItem> items);

  EmployeePage nextCursor(String? nextCursor);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `EmployeePage(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// EmployeePage(...).copyWith(id: 12, name: "My name")
  /// ````
  EmployeePage call({List<EmployeeListItem> items, String? nextCursor});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfEmployeePage.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfEmployeePage.copyWith.fieldName(...)`
class _$EmployeePageCWProxyImpl implements _$EmployeePageCWProxy {
  const _$EmployeePageCWProxyImpl(this._value);

  final EmployeePage _value;

  @override
  EmployeePage items(List<EmployeeListItem> items) => this(items: items);

  @override
  EmployeePage nextCursor(String? nextCursor) => this(nextCursor: nextCursor);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `EmployeePage(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// EmployeePage(...).copyWith(id: 12, name: "My name")
  /// ````
  EmployeePage call({
    Object? items = const $CopyWithPlaceholder(),
    Object? nextCursor = const $CopyWithPlaceholder(),
  }) {
    return EmployeePage(
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<EmployeeListItem>,
      nextCursor: nextCursor == const $CopyWithPlaceholder()
          ? _value.nextCursor
          // ignore: cast_nullable_to_non_nullable
          : nextCursor as String?,
    );
  }
}

extension $EmployeePageCopyWith on EmployeePage {
  /// Returns a callable class that can be used as follows: `instanceOfEmployeePage.copyWith(...)` or like so:`instanceOfEmployeePage.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$EmployeePageCWProxy get copyWith => _$EmployeePageCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeePage _$EmployeePageFromJson(Map<String, dynamic> json) =>
    $checkedCreate('EmployeePage', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['items', 'nextCursor']);
      final val = EmployeePage(
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map((e) => EmployeeListItem.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        nextCursor: $checkedConvert('nextCursor', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$EmployeePageToJson(EmployeePage instance) =>
    <String, dynamic>{
      'items': instance.items.map((e) => e.toJson()).toList(),
      'nextCursor': instance.nextCursor,
    };
