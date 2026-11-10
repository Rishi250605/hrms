// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_update_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RouteUpdateBodyCWProxy {
  RouteUpdateBody name(String? name);

  RouteUpdateBody origin(String? origin);

  RouteUpdateBody destination(String? destination);

  RouteUpdateBody distanceKm(num? distanceKm);

  RouteUpdateBody standardMinutes(int? standardMinutes);

  RouteUpdateBody archived(bool? archived);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RouteUpdateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RouteUpdateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  RouteUpdateBody call({
    String? name,
    String? origin,
    String? destination,
    num? distanceKm,
    int? standardMinutes,
    bool? archived,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRouteUpdateBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRouteUpdateBody.copyWith.fieldName(...)`
class _$RouteUpdateBodyCWProxyImpl implements _$RouteUpdateBodyCWProxy {
  const _$RouteUpdateBodyCWProxyImpl(this._value);

  final RouteUpdateBody _value;

  @override
  RouteUpdateBody name(String? name) => this(name: name);

  @override
  RouteUpdateBody origin(String? origin) => this(origin: origin);

  @override
  RouteUpdateBody destination(String? destination) =>
      this(destination: destination);

  @override
  RouteUpdateBody distanceKm(num? distanceKm) => this(distanceKm: distanceKm);

  @override
  RouteUpdateBody standardMinutes(int? standardMinutes) =>
      this(standardMinutes: standardMinutes);

  @override
  RouteUpdateBody archived(bool? archived) => this(archived: archived);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RouteUpdateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RouteUpdateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  RouteUpdateBody call({
    Object? name = const $CopyWithPlaceholder(),
    Object? origin = const $CopyWithPlaceholder(),
    Object? destination = const $CopyWithPlaceholder(),
    Object? distanceKm = const $CopyWithPlaceholder(),
    Object? standardMinutes = const $CopyWithPlaceholder(),
    Object? archived = const $CopyWithPlaceholder(),
  }) {
    return RouteUpdateBody(
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      origin: origin == const $CopyWithPlaceholder()
          ? _value.origin
          // ignore: cast_nullable_to_non_nullable
          : origin as String?,
      destination: destination == const $CopyWithPlaceholder()
          ? _value.destination
          // ignore: cast_nullable_to_non_nullable
          : destination as String?,
      distanceKm: distanceKm == const $CopyWithPlaceholder()
          ? _value.distanceKm
          // ignore: cast_nullable_to_non_nullable
          : distanceKm as num?,
      standardMinutes: standardMinutes == const $CopyWithPlaceholder()
          ? _value.standardMinutes
          // ignore: cast_nullable_to_non_nullable
          : standardMinutes as int?,
      archived: archived == const $CopyWithPlaceholder()
          ? _value.archived
          // ignore: cast_nullable_to_non_nullable
          : archived as bool?,
    );
  }
}

extension $RouteUpdateBodyCopyWith on RouteUpdateBody {
  /// Returns a callable class that can be used as follows: `instanceOfRouteUpdateBody.copyWith(...)` or like so:`instanceOfRouteUpdateBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RouteUpdateBodyCWProxy get copyWith => _$RouteUpdateBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouteUpdateBody _$RouteUpdateBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('RouteUpdateBody', json, ($checkedConvert) {
      final val = RouteUpdateBody(
        name: $checkedConvert('name', (v) => v as String?),
        origin: $checkedConvert('origin', (v) => v as String?),
        destination: $checkedConvert('destination', (v) => v as String?),
        distanceKm: $checkedConvert('distanceKm', (v) => v as num?),
        standardMinutes: $checkedConvert(
          'standardMinutes',
          (v) => (v as num?)?.toInt(),
        ),
        archived: $checkedConvert('archived', (v) => v as bool?),
      );
      return val;
    });

Map<String, dynamic> _$RouteUpdateBodyToJson(RouteUpdateBody instance) =>
    <String, dynamic>{
      'name': ?instance.name,
      'origin': ?instance.origin,
      'destination': ?instance.destination,
      'distanceKm': ?instance.distanceKm,
      'standardMinutes': ?instance.standardMinutes,
      'archived': ?instance.archived,
    };
