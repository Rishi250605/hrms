// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_list.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RouteListCWProxy {
  RouteList items(List<RouteItem> items);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RouteList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RouteList(...).copyWith(id: 12, name: "My name")
  /// ````
  RouteList call({List<RouteItem> items});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRouteList.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRouteList.copyWith.fieldName(...)`
class _$RouteListCWProxyImpl implements _$RouteListCWProxy {
  const _$RouteListCWProxyImpl(this._value);

  final RouteList _value;

  @override
  RouteList items(List<RouteItem> items) => this(items: items);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RouteList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RouteList(...).copyWith(id: 12, name: "My name")
  /// ````
  RouteList call({Object? items = const $CopyWithPlaceholder()}) {
    return RouteList(
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<RouteItem>,
    );
  }
}

extension $RouteListCopyWith on RouteList {
  /// Returns a callable class that can be used as follows: `instanceOfRouteList.copyWith(...)` or like so:`instanceOfRouteList.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RouteListCWProxy get copyWith => _$RouteListCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouteList _$RouteListFromJson(Map<String, dynamic> json) =>
    $checkedCreate('RouteList', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['items']);
      final val = RouteList(
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map((e) => RouteItem.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$RouteListToJson(RouteList instance) => <String, dynamic>{
  'items': instance.items.map((e) => e.toJson()).toList(),
};
