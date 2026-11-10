// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AssignmentItemCWProxy {
  AssignmentItem id(String id);

  AssignmentItem dutyId(String dutyId);

  AssignmentItem role(AssignmentRole role);

  AssignmentItem isSpare(bool isSpare);

  AssignmentItem warnings(List<RosterWarning> warnings);

  AssignmentItem employee(RosterEmployee employee);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AssignmentItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AssignmentItem(...).copyWith(id: 12, name: "My name")
  /// ````
  AssignmentItem call({
    String id,
    String dutyId,
    AssignmentRole role,
    bool isSpare,
    List<RosterWarning> warnings,
    RosterEmployee employee,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAssignmentItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAssignmentItem.copyWith.fieldName(...)`
class _$AssignmentItemCWProxyImpl implements _$AssignmentItemCWProxy {
  const _$AssignmentItemCWProxyImpl(this._value);

  final AssignmentItem _value;

  @override
  AssignmentItem id(String id) => this(id: id);

  @override
  AssignmentItem dutyId(String dutyId) => this(dutyId: dutyId);

  @override
  AssignmentItem role(AssignmentRole role) => this(role: role);

  @override
  AssignmentItem isSpare(bool isSpare) => this(isSpare: isSpare);

  @override
  AssignmentItem warnings(List<RosterWarning> warnings) =>
      this(warnings: warnings);

  @override
  AssignmentItem employee(RosterEmployee employee) => this(employee: employee);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AssignmentItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AssignmentItem(...).copyWith(id: 12, name: "My name")
  /// ````
  AssignmentItem call({
    Object? id = const $CopyWithPlaceholder(),
    Object? dutyId = const $CopyWithPlaceholder(),
    Object? role = const $CopyWithPlaceholder(),
    Object? isSpare = const $CopyWithPlaceholder(),
    Object? warnings = const $CopyWithPlaceholder(),
    Object? employee = const $CopyWithPlaceholder(),
  }) {
    return AssignmentItem(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      dutyId: dutyId == const $CopyWithPlaceholder()
          ? _value.dutyId
          // ignore: cast_nullable_to_non_nullable
          : dutyId as String,
      role: role == const $CopyWithPlaceholder()
          ? _value.role
          // ignore: cast_nullable_to_non_nullable
          : role as AssignmentRole,
      isSpare: isSpare == const $CopyWithPlaceholder()
          ? _value.isSpare
          // ignore: cast_nullable_to_non_nullable
          : isSpare as bool,
      warnings: warnings == const $CopyWithPlaceholder()
          ? _value.warnings
          // ignore: cast_nullable_to_non_nullable
          : warnings as List<RosterWarning>,
      employee: employee == const $CopyWithPlaceholder()
          ? _value.employee
          // ignore: cast_nullable_to_non_nullable
          : employee as RosterEmployee,
    );
  }
}

extension $AssignmentItemCopyWith on AssignmentItem {
  /// Returns a callable class that can be used as follows: `instanceOfAssignmentItem.copyWith(...)` or like so:`instanceOfAssignmentItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AssignmentItemCWProxy get copyWith => _$AssignmentItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssignmentItem _$AssignmentItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AssignmentItem', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'dutyId',
          'role',
          'isSpare',
          'warnings',
          'employee',
        ],
      );
      final val = AssignmentItem(
        id: $checkedConvert('id', (v) => v as String),
        dutyId: $checkedConvert('dutyId', (v) => v as String),
        role: $checkedConvert(
          'role',
          (v) => $enumDecode(_$AssignmentRoleEnumMap, v),
        ),
        isSpare: $checkedConvert('isSpare', (v) => v as bool),
        warnings: $checkedConvert(
          'warnings',
          (v) => (v as List<dynamic>)
              .map((e) => RosterWarning.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        employee: $checkedConvert(
          'employee',
          (v) => RosterEmployee.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$AssignmentItemToJson(AssignmentItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dutyId': instance.dutyId,
      'role': _$AssignmentRoleEnumMap[instance.role]!,
      'isSpare': instance.isSpare,
      'warnings': instance.warnings.map((e) => e.toJson()).toList(),
      'employee': instance.employee.toJson(),
    };

const _$AssignmentRoleEnumMap = {
  AssignmentRole.DRIVER: 'DRIVER',
  AssignmentRole.CO_DRIVER: 'CO_DRIVER',
  AssignmentRole.CONDUCTOR: 'CONDUCTOR',
  AssignmentRole.HELPER: 'HELPER',
};
