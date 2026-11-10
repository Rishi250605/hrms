// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'depot_summary.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DepotSummaryCWProxy {
  DepotSummary id(String id);

  DepotSummary code(String code);

  DepotSummary name(String name);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DepotSummary(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DepotSummary(...).copyWith(id: 12, name: "My name")
  /// ````
  DepotSummary call({String id, String code, String name});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDepotSummary.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDepotSummary.copyWith.fieldName(...)`
class _$DepotSummaryCWProxyImpl implements _$DepotSummaryCWProxy {
  const _$DepotSummaryCWProxyImpl(this._value);

  final DepotSummary _value;

  @override
  DepotSummary id(String id) => this(id: id);

  @override
  DepotSummary code(String code) => this(code: code);

  @override
  DepotSummary name(String name) => this(name: name);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DepotSummary(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DepotSummary(...).copyWith(id: 12, name: "My name")
  /// ````
  DepotSummary call({
    Object? id = const $CopyWithPlaceholder(),
    Object? code = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
  }) {
    return DepotSummary(
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
    );
  }
}

extension $DepotSummaryCopyWith on DepotSummary {
  /// Returns a callable class that can be used as follows: `instanceOfDepotSummary.copyWith(...)` or like so:`instanceOfDepotSummary.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DepotSummaryCWProxy get copyWith => _$DepotSummaryCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepotSummary _$DepotSummaryFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DepotSummary', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['id', 'code', 'name']);
      final val = DepotSummary(
        id: $checkedConvert('id', (v) => v as String),
        code: $checkedConvert('code', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$DepotSummaryToJson(DepotSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
    };
