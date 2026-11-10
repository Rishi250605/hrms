// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duty_item_template.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DutyItemTemplateCWProxy {
  DutyItemTemplate id(String id);

  DutyItemTemplate name(String name);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DutyItemTemplate(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DutyItemTemplate(...).copyWith(id: 12, name: "My name")
  /// ````
  DutyItemTemplate call({String id, String name});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDutyItemTemplate.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDutyItemTemplate.copyWith.fieldName(...)`
class _$DutyItemTemplateCWProxyImpl implements _$DutyItemTemplateCWProxy {
  const _$DutyItemTemplateCWProxyImpl(this._value);

  final DutyItemTemplate _value;

  @override
  DutyItemTemplate id(String id) => this(id: id);

  @override
  DutyItemTemplate name(String name) => this(name: name);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DutyItemTemplate(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DutyItemTemplate(...).copyWith(id: 12, name: "My name")
  /// ````
  DutyItemTemplate call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
  }) {
    return DutyItemTemplate(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
    );
  }
}

extension $DutyItemTemplateCopyWith on DutyItemTemplate {
  /// Returns a callable class that can be used as follows: `instanceOfDutyItemTemplate.copyWith(...)` or like so:`instanceOfDutyItemTemplate.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DutyItemTemplateCWProxy get copyWith => _$DutyItemTemplateCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DutyItemTemplate _$DutyItemTemplateFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DutyItemTemplate', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['id', 'name']);
      final val = DutyItemTemplate(
        id: $checkedConvert('id', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$DutyItemTemplateToJson(DutyItemTemplate instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};
