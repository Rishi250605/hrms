// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_create_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AssignmentCreateBodyCWProxy {
  AssignmentCreateBody employeeId(String employeeId);

  AssignmentCreateBody role(AssignmentRole role);

  AssignmentCreateBody isSpare(bool? isSpare);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AssignmentCreateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AssignmentCreateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  AssignmentCreateBody call({
    String employeeId,
    AssignmentRole role,
    bool? isSpare,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAssignmentCreateBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAssignmentCreateBody.copyWith.fieldName(...)`
class _$AssignmentCreateBodyCWProxyImpl
    implements _$AssignmentCreateBodyCWProxy {
  const _$AssignmentCreateBodyCWProxyImpl(this._value);

  final AssignmentCreateBody _value;

  @override
  AssignmentCreateBody employeeId(String employeeId) =>
      this(employeeId: employeeId);

  @override
  AssignmentCreateBody role(AssignmentRole role) => this(role: role);

  @override
  AssignmentCreateBody isSpare(bool? isSpare) => this(isSpare: isSpare);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AssignmentCreateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AssignmentCreateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  AssignmentCreateBody call({
    Object? employeeId = const $CopyWithPlaceholder(),
    Object? role = const $CopyWithPlaceholder(),
    Object? isSpare = const $CopyWithPlaceholder(),
  }) {
    return AssignmentCreateBody(
      employeeId: employeeId == const $CopyWithPlaceholder()
          ? _value.employeeId
          // ignore: cast_nullable_to_non_nullable
          : employeeId as String,
      role: role == const $CopyWithPlaceholder()
          ? _value.role
          // ignore: cast_nullable_to_non_nullable
          : role as AssignmentRole,
      isSpare: isSpare == const $CopyWithPlaceholder()
          ? _value.isSpare
          // ignore: cast_nullable_to_non_nullable
          : isSpare as bool?,
    );
  }
}

extension $AssignmentCreateBodyCopyWith on AssignmentCreateBody {
  /// Returns a callable class that can be used as follows: `instanceOfAssignmentCreateBody.copyWith(...)` or like so:`instanceOfAssignmentCreateBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AssignmentCreateBodyCWProxy get copyWith =>
      _$AssignmentCreateBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssignmentCreateBody _$AssignmentCreateBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AssignmentCreateBody', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['employeeId', 'role']);
  final val = AssignmentCreateBody(
    employeeId: $checkedConvert('employeeId', (v) => v as String),
    role: $checkedConvert(
      'role',
      (v) => $enumDecode(_$AssignmentRoleEnumMap, v),
    ),
    isSpare: $checkedConvert('isSpare', (v) => v as bool? ?? false),
  );
  return val;
});

Map<String, dynamic> _$AssignmentCreateBodyToJson(
  AssignmentCreateBody instance,
) => <String, dynamic>{
  'employeeId': instance.employeeId,
  'role': _$AssignmentRoleEnumMap[instance.role]!,
  'isSpare': ?instance.isSpare,
};

const _$AssignmentRoleEnumMap = {
  AssignmentRole.DRIVER: 'DRIVER',
  AssignmentRole.CO_DRIVER: 'CO_DRIVER',
  AssignmentRole.CONDUCTOR: 'CONDUCTOR',
  AssignmentRole.HELPER: 'HELPER',
};
