// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RouteItemCWProxy {
  RouteItem id(String id);

  RouteItem code(String code);

  RouteItem name(String name);

  RouteItem origin(String origin);

  RouteItem destination(String destination);

  RouteItem distanceKm(num? distanceKm);

  RouteItem standardMinutes(int standardMinutes);

  RouteItem depot(DepotSummary depot);

  RouteItem archived(bool archived);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RouteItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RouteItem(...).copyWith(id: 12, name: "My name")
  /// ````
  RouteItem call({
    String id,
    String code,
    String name,
    String origin,
    String destination,
    num? distanceKm,
    int standardMinutes,
    DepotSummary depot,
    bool archived,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRouteItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRouteItem.copyWith.fieldName(...)`
class _$RouteItemCWProxyImpl implements _$RouteItemCWProxy {
  const _$RouteItemCWProxyImpl(this._value);

  final RouteItem _value;

  @override
  RouteItem id(String id) => this(id: id);

  @override
  RouteItem code(String code) => this(code: code);

  @override
  RouteItem name(String name) => this(name: name);

  @override
  RouteItem origin(String origin) => this(origin: origin);

  @override
  RouteItem destination(String destination) => this(destination: destination);

  @override
  RouteItem distanceKm(num? distanceKm) => this(distanceKm: distanceKm);

  @override
  RouteItem standardMinutes(int standardMinutes) =>
      this(standardMinutes: standardMinutes);

  @override
  RouteItem depot(DepotSummary depot) => this(depot: depot);

  @override
  RouteItem archived(bool archived) => this(archived: archived);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RouteItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RouteItem(...).copyWith(id: 12, name: "My name")
  /// ````
  RouteItem call({
    Object? id = const $CopyWithPlaceholder(),
    Object? code = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? origin = const $CopyWithPlaceholder(),
    Object? destination = const $CopyWithPlaceholder(),
    Object? distanceKm = const $CopyWithPlaceholder(),
    Object? standardMinutes = const $CopyWithPlaceholder(),
    Object? depot = const $CopyWithPlaceholder(),
    Object? archived = const $CopyWithPlaceholder(),
  }) {
    return RouteItem(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      code: code == const $CopyWithPlaceholder()
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      origin: origin == const $CopyWithPlaceholder()
          ? _value.origin
          // ignore: cast_nullable_to_non_nullable
          : origin as String,
      destination: destination == const $CopyWithPlaceholder()
          ? _value.destination
          // ignore: cast_nullable_to_non_nullable
          : destination as String,
      distanceKm: distanceKm == const $CopyWithPlaceholder()
          ? _value.distanceKm
          // ignore: cast_nullable_to_non_nullable
          : distanceKm as num?,
      standardMinutes: standardMinutes == const $CopyWithPlaceholder()
          ? _value.standardMinutes
          // ignore: cast_nullable_to_non_nullable
          : standardMinutes as int,
      depot: depot == const $CopyWithPlaceholder()
          ? _value.depot
          // ignore: cast_nullable_to_non_nullable
          : depot as DepotSummary,
      archived: archived == const $CopyWithPlaceholder()
          ? _value.archived
          // ignore: cast_nullable_to_non_nullable
          : archived as bool,
    );
  }
}

extension $RouteItemCopyWith on RouteItem {
  /// Returns a callable class that can be used as follows: `instanceOfRouteItem.copyWith(...)` or like so:`instanceOfRouteItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RouteItemCWProxy get copyWith => _$RouteItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouteItem _$RouteItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate('RouteItem', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'code',
          'name',
          'origin',
          'destination',
          'distanceKm',
          'standardMinutes',
          'depot',
          'archived',
        ],
      );
      final val = RouteItem(
        id: $checkedConvert('id', (v) => v as String),
        code: $checkedConvert('code', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        origin: $checkedConvert('origin', (v) => v as String),
        destination: $checkedConvert('destination', (v) => v as String),
        distanceKm: $checkedConvert('distanceKm', (v) => v as num?),
        standardMinutes: $checkedConvert(
          'standardMinutes',
          (v) => (v as num).toInt(),
        ),
        depot: $checkedConvert(
          'depot',
          (v) => DepotSummary.fromJson(v as Map<String, dynamic>),
        ),
        archived: $checkedConvert('archived', (v) => v as bool),
      );
      return val;
    });

Map<String, dynamic> _$RouteItemToJson(RouteItem instance) => <String, dynamic>{
  'id': instance.id,
  'code': instance.code,
  'name': instance.name,
  'origin': instance.origin,
  'destination': instance.destination,
  'distanceKm': instance.distanceKm,
  'standardMinutes': instance.standardMinutes,
  'depot': instance.depot.toJson(),
  'archived': instance.archived,
};
