// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_list.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$VehicleListCWProxy {
  VehicleList items(List<VehicleItem> items);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VehicleList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VehicleList(...).copyWith(id: 12, name: "My name")
  /// ````
  VehicleList call({List<VehicleItem> items});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfVehicleList.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfVehicleList.copyWith.fieldName(...)`
class _$VehicleListCWProxyImpl implements _$VehicleListCWProxy {
  const _$VehicleListCWProxyImpl(this._value);

  final VehicleList _value;

  @override
  VehicleList items(List<VehicleItem> items) => this(items: items);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VehicleList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VehicleList(...).copyWith(id: 12, name: "My name")
  /// ````
  VehicleList call({Object? items = const $CopyWithPlaceholder()}) {
    return VehicleList(
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<VehicleItem>,
    );
  }
}

extension $VehicleListCopyWith on VehicleList {
  /// Returns a callable class that can be used as follows: `instanceOfVehicleList.copyWith(...)` or like so:`instanceOfVehicleList.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$VehicleListCWProxy get copyWith => _$VehicleListCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleList _$VehicleListFromJson(Map<String, dynamic> json) =>
    $checkedCreate('VehicleList', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['items']);
      final val = VehicleList(
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map((e) => VehicleItem.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$VehicleListToJson(VehicleList instance) =>
    <String, dynamic>{'items': instance.items.map((e) => e.toJson()).toList()};
