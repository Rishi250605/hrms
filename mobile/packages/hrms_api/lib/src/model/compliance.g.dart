// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compliance.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ComplianceCWProxy {
  Compliance asOf(String asOf);

  Compliance overall(ComplianceOverall overall);

  Compliance rosterable(bool rosterable);

  Compliance items(List<ComplianceItem> items);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Compliance(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Compliance(...).copyWith(id: 12, name: "My name")
  /// ````
  Compliance call({
    String asOf,
    ComplianceOverall overall,
    bool rosterable,
    List<ComplianceItem> items,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCompliance.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCompliance.copyWith.fieldName(...)`
class _$ComplianceCWProxyImpl implements _$ComplianceCWProxy {
  const _$ComplianceCWProxyImpl(this._value);

  final Compliance _value;

  @override
  Compliance asOf(String asOf) => this(asOf: asOf);

  @override
  Compliance overall(ComplianceOverall overall) => this(overall: overall);

  @override
  Compliance rosterable(bool rosterable) => this(rosterable: rosterable);

  @override
  Compliance items(List<ComplianceItem> items) => this(items: items);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Compliance(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Compliance(...).copyWith(id: 12, name: "My name")
  /// ````
  Compliance call({
    Object? asOf = const $CopyWithPlaceholder(),
    Object? overall = const $CopyWithPlaceholder(),
    Object? rosterable = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
  }) {
    return Compliance(
      asOf: asOf == const $CopyWithPlaceholder()
          ? _value.asOf
          // ignore: cast_nullable_to_non_nullable
          : asOf as String,
      overall: overall == const $CopyWithPlaceholder()
          ? _value.overall
          // ignore: cast_nullable_to_non_nullable
          : overall as ComplianceOverall,
      rosterable: rosterable == const $CopyWithPlaceholder()
          ? _value.rosterable
          // ignore: cast_nullable_to_non_nullable
          : rosterable as bool,
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<ComplianceItem>,
    );
  }
}

extension $ComplianceCopyWith on Compliance {
  /// Returns a callable class that can be used as follows: `instanceOfCompliance.copyWith(...)` or like so:`instanceOfCompliance.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ComplianceCWProxy get copyWith => _$ComplianceCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Compliance _$ComplianceFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Compliance', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['asOf', 'overall', 'rosterable', 'items'],
      );
      final val = Compliance(
        asOf: $checkedConvert('asOf', (v) => v as String),
        overall: $checkedConvert(
          'overall',
          (v) => $enumDecode(_$ComplianceOverallEnumMap, v),
        ),
        rosterable: $checkedConvert('rosterable', (v) => v as bool),
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map((e) => ComplianceItem.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$ComplianceToJson(Compliance instance) =>
    <String, dynamic>{
      'asOf': instance.asOf,
      'overall': _$ComplianceOverallEnumMap[instance.overall]!,
      'rosterable': instance.rosterable,
      'items': instance.items.map((e) => e.toJson()).toList(),
    };

const _$ComplianceOverallEnumMap = {
  ComplianceOverall.OK: 'OK',
  ComplianceOverall.EXPIRING: 'EXPIRING',
  ComplianceOverall.PENDING_VERIFICATION: 'PENDING_VERIFICATION',
  ComplianceOverall.EXPIRED: 'EXPIRED',
  ComplianceOverall.MISSING: 'MISSING',
};
