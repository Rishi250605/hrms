// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PromotionBodyCWProxy {
  PromotionBody role(PromotionBodyRoleEnum role);

  PromotionBody reportingToEmployeeId(String reportingToEmployeeId);

  PromotionBody effectiveFrom(String effectiveFrom);

  PromotionBody designation(String? designation);

  PromotionBody reason(String reason);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PromotionBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PromotionBody(...).copyWith(id: 12, name: "My name")
  /// ````
  PromotionBody call({
    PromotionBodyRoleEnum role,
    String reportingToEmployeeId,
    String effectiveFrom,
    String? designation,
    String reason,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPromotionBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPromotionBody.copyWith.fieldName(...)`
class _$PromotionBodyCWProxyImpl implements _$PromotionBodyCWProxy {
  const _$PromotionBodyCWProxyImpl(this._value);

  final PromotionBody _value;

  @override
  PromotionBody role(PromotionBodyRoleEnum role) => this(role: role);

  @override
  PromotionBody reportingToEmployeeId(String reportingToEmployeeId) =>
      this(reportingToEmployeeId: reportingToEmployeeId);

  @override
  PromotionBody effectiveFrom(String effectiveFrom) =>
      this(effectiveFrom: effectiveFrom);

  @override
  PromotionBody designation(String? designation) =>
      this(designation: designation);

  @override
  PromotionBody reason(String reason) => this(reason: reason);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PromotionBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PromotionBody(...).copyWith(id: 12, name: "My name")
  /// ````
  PromotionBody call({
    Object? role = const $CopyWithPlaceholder(),
    Object? reportingToEmployeeId = const $CopyWithPlaceholder(),
    Object? effectiveFrom = const $CopyWithPlaceholder(),
    Object? designation = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
  }) {
    return PromotionBody(
      role: role == const $CopyWithPlaceholder()
          ? _value.role
          // ignore: cast_nullable_to_non_nullable
          : role as PromotionBodyRoleEnum,
      reportingToEmployeeId:
          reportingToEmployeeId == const $CopyWithPlaceholder()
          ? _value.reportingToEmployeeId
          // ignore: cast_nullable_to_non_nullable
          : reportingToEmployeeId as String,
      effectiveFrom: effectiveFrom == const $CopyWithPlaceholder()
          ? _value.effectiveFrom
          // ignore: cast_nullable_to_non_nullable
          : effectiveFrom as String,
      designation: designation == const $CopyWithPlaceholder()
          ? _value.designation
          // ignore: cast_nullable_to_non_nullable
          : designation as String?,
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String,
    );
  }
}

extension $PromotionBodyCopyWith on PromotionBody {
  /// Returns a callable class that can be used as follows: `instanceOfPromotionBody.copyWith(...)` or like so:`instanceOfPromotionBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PromotionBodyCWProxy get copyWith => _$PromotionBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromotionBody _$PromotionBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PromotionBody', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'role',
          'reportingToEmployeeId',
          'effectiveFrom',
          'reason',
        ],
      );
      final val = PromotionBody(
        role: $checkedConvert(
          'role',
          (v) => $enumDecode(_$PromotionBodyRoleEnumEnumMap, v),
        ),
        reportingToEmployeeId: $checkedConvert(
          'reportingToEmployeeId',
          (v) => v as String,
        ),
        effectiveFrom: $checkedConvert('effectiveFrom', (v) => v as String),
        designation: $checkedConvert('designation', (v) => v as String?),
        reason: $checkedConvert('reason', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$PromotionBodyToJson(PromotionBody instance) =>
    <String, dynamic>{
      'role': _$PromotionBodyRoleEnumEnumMap[instance.role]!,
      'reportingToEmployeeId': instance.reportingToEmployeeId,
      'effectiveFrom': instance.effectiveFrom,
      'designation': ?instance.designation,
      'reason': instance.reason,
    };

const _$PromotionBodyRoleEnumEnumMap = {
  PromotionBodyRoleEnum.HR: 'HR',
  PromotionBodyRoleEnum.OPERATIONAL_MANAGER: 'OPERATIONAL_MANAGER',
  PromotionBodyRoleEnum.REGIONAL_MANAGER: 'REGIONAL_MANAGER',
};
