// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_units_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BusinessUnitsBodyCWProxy {
  BusinessUnitsBody businessUnitIds(List<String> businessUnitIds);

  BusinessUnitsBody primaryBusinessUnitId(String primaryBusinessUnitId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BusinessUnitsBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BusinessUnitsBody(...).copyWith(id: 12, name: "My name")
  /// ````
  BusinessUnitsBody call({
    List<String> businessUnitIds,
    String primaryBusinessUnitId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBusinessUnitsBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBusinessUnitsBody.copyWith.fieldName(...)`
class _$BusinessUnitsBodyCWProxyImpl implements _$BusinessUnitsBodyCWProxy {
  const _$BusinessUnitsBodyCWProxyImpl(this._value);

  final BusinessUnitsBody _value;

  @override
  BusinessUnitsBody businessUnitIds(List<String> businessUnitIds) =>
      this(businessUnitIds: businessUnitIds);

  @override
  BusinessUnitsBody primaryBusinessUnitId(String primaryBusinessUnitId) =>
      this(primaryBusinessUnitId: primaryBusinessUnitId);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BusinessUnitsBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BusinessUnitsBody(...).copyWith(id: 12, name: "My name")
  /// ````
  BusinessUnitsBody call({
    Object? businessUnitIds = const $CopyWithPlaceholder(),
    Object? primaryBusinessUnitId = const $CopyWithPlaceholder(),
  }) {
    return BusinessUnitsBody(
      businessUnitIds: businessUnitIds == const $CopyWithPlaceholder()
          ? _value.businessUnitIds
          // ignore: cast_nullable_to_non_nullable
          : businessUnitIds as List<String>,
      primaryBusinessUnitId:
          primaryBusinessUnitId == const $CopyWithPlaceholder()
          ? _value.primaryBusinessUnitId
          // ignore: cast_nullable_to_non_nullable
          : primaryBusinessUnitId as String,
    );
  }
}

extension $BusinessUnitsBodyCopyWith on BusinessUnitsBody {
  /// Returns a callable class that can be used as follows: `instanceOfBusinessUnitsBody.copyWith(...)` or like so:`instanceOfBusinessUnitsBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BusinessUnitsBodyCWProxy get copyWith =>
      _$BusinessUnitsBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessUnitsBody _$BusinessUnitsBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('BusinessUnitsBody', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['businessUnitIds', 'primaryBusinessUnitId'],
      );
      final val = BusinessUnitsBody(
        businessUnitIds: $checkedConvert(
          'businessUnitIds',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
        primaryBusinessUnitId: $checkedConvert(
          'primaryBusinessUnitId',
          (v) => v as String,
        ),
      );
      return val;
    });

Map<String, dynamic> _$BusinessUnitsBodyToJson(BusinessUnitsBody instance) =>
    <String, dynamic>{
      'businessUnitIds': instance.businessUnitIds,
      'primaryBusinessUnitId': instance.primaryBusinessUnitId,
    };
