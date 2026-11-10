// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'region_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RegionItemCWProxy {
  RegionItem id(String id);

  RegionItem name(String name);

  RegionItem code(String code);

  RegionItem depotCount(int depotCount);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RegionItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RegionItem(...).copyWith(id: 12, name: "My name")
  /// ````
  RegionItem call({String id, String name, String code, int depotCount});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRegionItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRegionItem.copyWith.fieldName(...)`
class _$RegionItemCWProxyImpl implements _$RegionItemCWProxy {
  const _$RegionItemCWProxyImpl(this._value);

  final RegionItem _value;

  @override
  RegionItem id(String id) => this(id: id);

  @override
  RegionItem name(String name) => this(name: name);

  @override
  RegionItem code(String code) => this(code: code);

  @override
  RegionItem depotCount(int depotCount) => this(depotCount: depotCount);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RegionItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RegionItem(...).copyWith(id: 12, name: "My name")
  /// ````
  RegionItem call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? code = const $CopyWithPlaceholder(),
    Object? depotCount = const $CopyWithPlaceholder(),
  }) {
    return RegionItem(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      code: code == const $CopyWithPlaceholder()
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String,
      depotCount: depotCount == const $CopyWithPlaceholder()
          ? _value.depotCount
          // ignore: cast_nullable_to_non_nullable
          : depotCount as int,
    );
  }
}

extension $RegionItemCopyWith on RegionItem {
  /// Returns a callable class that can be used as follows: `instanceOfRegionItem.copyWith(...)` or like so:`instanceOfRegionItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RegionItemCWProxy get copyWith => _$RegionItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegionItem _$RegionItemFromJson(Map<String, dynamic> json) => $checkedCreate(
  'RegionItem',
  json,
  ($checkedConvert) {
    $checkKeys(json, requiredKeys: const ['id', 'name', 'code', 'depotCount']);
    final val = RegionItem(
      id: $checkedConvert('id', (v) => v as String),
      name: $checkedConvert('name', (v) => v as String),
      code: $checkedConvert('code', (v) => v as String),
      depotCount: $checkedConvert('depotCount', (v) => (v as num).toInt()),
    );
    return val;
  },
);

Map<String, dynamic> _$RegionItemToJson(RegionItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'depotCount': instance.depotCount,
    };
