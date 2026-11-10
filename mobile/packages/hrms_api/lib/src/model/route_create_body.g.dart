// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_create_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RouteCreateBodyCWProxy {
  RouteCreateBody code(String code);

  RouteCreateBody name(String name);

  RouteCreateBody origin(String origin);

  RouteCreateBody destination(String destination);

  RouteCreateBody distanceKm(num? distanceKm);

  RouteCreateBody standardMinutes(int standardMinutes);

  RouteCreateBody depotId(String depotId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RouteCreateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RouteCreateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  RouteCreateBody call({
    String code,
    String name,
    String origin,
    String destination,
    num? distanceKm,
    int standardMinutes,
    String depotId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRouteCreateBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRouteCreateBody.copyWith.fieldName(...)`
class _$RouteCreateBodyCWProxyImpl implements _$RouteCreateBodyCWProxy {
  const _$RouteCreateBodyCWProxyImpl(this._value);

  final RouteCreateBody _value;

  @override
  RouteCreateBody code(String code) => this(code: code);

  @override
  RouteCreateBody name(String name) => this(name: name);

  @override
  RouteCreateBody origin(String origin) => this(origin: origin);

  @override
  RouteCreateBody destination(String destination) =>
      this(destination: destination);

  @override
  RouteCreateBody distanceKm(num? distanceKm) => this(distanceKm: distanceKm);

  @override
  RouteCreateBody standardMinutes(int standardMinutes) =>
      this(standardMinutes: standardMinutes);

  @override
  RouteCreateBody depotId(String depotId) => this(depotId: depotId);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RouteCreateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RouteCreateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  RouteCreateBody call({
    Object? code = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? origin = const $CopyWithPlaceholder(),
    Object? destination = const $CopyWithPlaceholder(),
    Object? distanceKm = const $CopyWithPlaceholder(),
    Object? standardMinutes = const $CopyWithPlaceholder(),
    Object? depotId = const $CopyWithPlaceholder(),
  }) {
    return RouteCreateBody(
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
      depotId: depotId == const $CopyWithPlaceholder()
          ? _value.depotId
          // ignore: cast_nullable_to_non_nullable
          : depotId as String,
    );
  }
}

extension $RouteCreateBodyCopyWith on RouteCreateBody {
  /// Returns a callable class that can be used as follows: `instanceOfRouteCreateBody.copyWith(...)` or like so:`instanceOfRouteCreateBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RouteCreateBodyCWProxy get copyWith => _$RouteCreateBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouteCreateBody _$RouteCreateBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('RouteCreateBody', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'code',
          'name',
          'origin',
          'destination',
          'standardMinutes',
          'depotId',
        ],
      );
      final val = RouteCreateBody(
        code: $checkedConvert('code', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        origin: $checkedConvert('origin', (v) => v as String),
        destination: $checkedConvert('destination', (v) => v as String),
        distanceKm: $checkedConvert('distanceKm', (v) => v as num?),
        standardMinutes: $checkedConvert(
          'standardMinutes',
          (v) => (v as num).toInt(),
        ),
        depotId: $checkedConvert('depotId', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$RouteCreateBodyToJson(RouteCreateBody instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'origin': instance.origin,
      'destination': instance.destination,
      'distanceKm': ?instance.distanceKm,
      'standardMinutes': instance.standardMinutes,
      'depotId': instance.depotId,
    };
