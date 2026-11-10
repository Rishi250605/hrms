// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duty_template_list.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DutyTemplateListCWProxy {
  DutyTemplateList items(List<DutyTemplateItem> items);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DutyTemplateList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DutyTemplateList(...).copyWith(id: 12, name: "My name")
  /// ````
  DutyTemplateList call({List<DutyTemplateItem> items});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDutyTemplateList.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDutyTemplateList.copyWith.fieldName(...)`
class _$DutyTemplateListCWProxyImpl implements _$DutyTemplateListCWProxy {
  const _$DutyTemplateListCWProxyImpl(this._value);

  final DutyTemplateList _value;

  @override
  DutyTemplateList items(List<DutyTemplateItem> items) => this(items: items);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DutyTemplateList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DutyTemplateList(...).copyWith(id: 12, name: "My name")
  /// ````
  DutyTemplateList call({Object? items = const $CopyWithPlaceholder()}) {
    return DutyTemplateList(
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<DutyTemplateItem>,
    );
  }
}

extension $DutyTemplateListCopyWith on DutyTemplateList {
  /// Returns a callable class that can be used as follows: `instanceOfDutyTemplateList.copyWith(...)` or like so:`instanceOfDutyTemplateList.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DutyTemplateListCWProxy get copyWith => _$DutyTemplateListCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DutyTemplateList _$DutyTemplateListFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DutyTemplateList', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['items']);
      final val = DutyTemplateList(
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map((e) => DutyTemplateItem.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$DutyTemplateListToJson(DutyTemplateList instance) =>
    <String, dynamic>{'items': instance.items.map((e) => e.toJson()).toList()};
