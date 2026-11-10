// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roster_employee.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RosterEmployeeCWProxy {
  RosterEmployee id(String id);

  RosterEmployee empCode(String empCode);

  RosterEmployee fullName(String fullName);

  RosterEmployee category(EmployeeCategory category);

  RosterEmployee phone(String phone);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RosterEmployee(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RosterEmployee(...).copyWith(id: 12, name: "My name")
  /// ````
  RosterEmployee call({
    String id,
    String empCode,
    String fullName,
    EmployeeCategory category,
    String phone,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRosterEmployee.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRosterEmployee.copyWith.fieldName(...)`
class _$RosterEmployeeCWProxyImpl implements _$RosterEmployeeCWProxy {
  const _$RosterEmployeeCWProxyImpl(this._value);

  final RosterEmployee _value;

  @override
  RosterEmployee id(String id) => this(id: id);

  @override
  RosterEmployee empCode(String empCode) => this(empCode: empCode);

  @override
  RosterEmployee fullName(String fullName) => this(fullName: fullName);

  @override
  RosterEmployee category(EmployeeCategory category) =>
      this(category: category);

  @override
  RosterEmployee phone(String phone) => this(phone: phone);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RosterEmployee(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RosterEmployee(...).copyWith(id: 12, name: "My name")
  /// ````
  RosterEmployee call({
    Object? id = const $CopyWithPlaceholder(),
    Object? empCode = const $CopyWithPlaceholder(),
    Object? fullName = const $CopyWithPlaceholder(),
    Object? category = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
  }) {
    return RosterEmployee(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      empCode: empCode == const $CopyWithPlaceholder()
          ? _value.empCode
          // ignore: cast_nullable_to_non_nullable
          : empCode as String,
      fullName: fullName == const $CopyWithPlaceholder()
          ? _value.fullName
          // ignore: cast_nullable_to_non_nullable
          : fullName as String,
      category: category == const $CopyWithPlaceholder()
          ? _value.category
          // ignore: cast_nullable_to_non_nullable
          : category as EmployeeCategory,
      phone: phone == const $CopyWithPlaceholder()
          ? _value.phone
          // ignore: cast_nullable_to_non_nullable
          : phone as String,
    );
  }
}

extension $RosterEmployeeCopyWith on RosterEmployee {
  /// Returns a callable class that can be used as follows: `instanceOfRosterEmployee.copyWith(...)` or like so:`instanceOfRosterEmployee.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RosterEmployeeCWProxy get copyWith => _$RosterEmployeeCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RosterEmployee _$RosterEmployeeFromJson(Map<String, dynamic> json) =>
    $checkedCreate('RosterEmployee', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['id', 'empCode', 'fullName', 'category', 'phone'],
      );
      final val = RosterEmployee(
        id: $checkedConvert('id', (v) => v as String),
        empCode: $checkedConvert('empCode', (v) => v as String),
        fullName: $checkedConvert('fullName', (v) => v as String),
        category: $checkedConvert(
          'category',
          (v) => $enumDecode(_$EmployeeCategoryEnumMap, v),
        ),
        phone: $checkedConvert('phone', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$RosterEmployeeToJson(RosterEmployee instance) =>
    <String, dynamic>{
      'id': instance.id,
      'empCode': instance.empCode,
      'fullName': instance.fullName,
      'category': _$EmployeeCategoryEnumMap[instance.category]!,
      'phone': instance.phone,
    };

const _$EmployeeCategoryEnumMap = {
  EmployeeCategory.DRIVER: 'DRIVER',
  EmployeeCategory.LOADMAN: 'LOADMAN',
  EmployeeCategory.CONDUCTOR: 'CONDUCTOR',
  EmployeeCategory.HELPER: 'HELPER',
  EmployeeCategory.MECHANIC: 'MECHANIC',
  EmployeeCategory.DEPOT_STAFF: 'DEPOT_STAFF',
  EmployeeCategory.OFFICE: 'OFFICE',
};
