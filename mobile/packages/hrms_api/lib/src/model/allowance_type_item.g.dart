// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allowance_type_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AllowanceTypeItemCWProxy {
  AllowanceTypeItem id(String id);

  AllowanceTypeItem code(String code);

  AllowanceTypeItem name(String name);

  AllowanceTypeItem maxAmountPaise(int? maxAmountPaise);

  AllowanceTypeItem isActive(bool isActive);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AllowanceTypeItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AllowanceTypeItem(...).copyWith(id: 12, name: "My name")
  /// ````
  AllowanceTypeItem call({
    String id,
    String code,
    String name,
    int? maxAmountPaise,
    bool isActive,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAllowanceTypeItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAllowanceTypeItem.copyWith.fieldName(...)`
class _$AllowanceTypeItemCWProxyImpl implements _$AllowanceTypeItemCWProxy {
  const _$AllowanceTypeItemCWProxyImpl(this._value);

  final AllowanceTypeItem _value;

  @override
  AllowanceTypeItem id(String id) => this(id: id);

  @override
  AllowanceTypeItem code(String code) => this(code: code);

  @override
  AllowanceTypeItem name(String name) => this(name: name);

  @override
  AllowanceTypeItem maxAmountPaise(int? maxAmountPaise) =>
      this(maxAmountPaise: maxAmountPaise);

  @override
  AllowanceTypeItem isActive(bool isActive) => this(isActive: isActive);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AllowanceTypeItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AllowanceTypeItem(...).copyWith(id: 12, name: "My name")
  /// ````
  AllowanceTypeItem call({
    Object? id = const $CopyWithPlaceholder(),
    Object? code = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? maxAmountPaise = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
  }) {
    return AllowanceTypeItem(
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
      maxAmountPaise: maxAmountPaise == const $CopyWithPlaceholder()
          ? _value.maxAmountPaise
          // ignore: cast_nullable_to_non_nullable
          : maxAmountPaise as int?,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool,
    );
  }
}

extension $AllowanceTypeItemCopyWith on AllowanceTypeItem {
  /// Returns a callable class that can be used as follows: `instanceOfAllowanceTypeItem.copyWith(...)` or like so:`instanceOfAllowanceTypeItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AllowanceTypeItemCWProxy get copyWith =>
      _$AllowanceTypeItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllowanceTypeItem _$AllowanceTypeItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AllowanceTypeItem', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'code',
          'name',
          'maxAmountPaise',
          'isActive',
        ],
      );
      final val = AllowanceTypeItem(
        id: $checkedConvert('id', (v) => v as String),
        code: $checkedConvert('code', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        maxAmountPaise: $checkedConvert(
          'maxAmountPaise',
          (v) => (v as num?)?.toInt(),
        ),
        isActive: $checkedConvert('isActive', (v) => v as bool),
      );
      return val;
    });

Map<String, dynamic> _$AllowanceTypeItemToJson(AllowanceTypeItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'maxAmountPaise': instance.maxAmountPaise,
      'isActive': instance.isActive,
    };
