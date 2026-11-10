// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'correction_list.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CorrectionListCWProxy {
  CorrectionList items(List<CorrectionItem> items);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CorrectionList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CorrectionList(...).copyWith(id: 12, name: "My name")
  /// ````
  CorrectionList call({List<CorrectionItem> items});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCorrectionList.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCorrectionList.copyWith.fieldName(...)`
class _$CorrectionListCWProxyImpl implements _$CorrectionListCWProxy {
  const _$CorrectionListCWProxyImpl(this._value);

  final CorrectionList _value;

  @override
  CorrectionList items(List<CorrectionItem> items) => this(items: items);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CorrectionList(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CorrectionList(...).copyWith(id: 12, name: "My name")
  /// ````
  CorrectionList call({Object? items = const $CopyWithPlaceholder()}) {
    return CorrectionList(
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<CorrectionItem>,
    );
  }
}

extension $CorrectionListCopyWith on CorrectionList {
  /// Returns a callable class that can be used as follows: `instanceOfCorrectionList.copyWith(...)` or like so:`instanceOfCorrectionList.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CorrectionListCWProxy get copyWith => _$CorrectionListCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CorrectionList _$CorrectionListFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CorrectionList', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['items']);
      final val = CorrectionList(
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map((e) => CorrectionItem.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$CorrectionListToJson(CorrectionList instance) =>
    <String, dynamic>{'items': instance.items.map((e) => e.toJson()).toList()};
