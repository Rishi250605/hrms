// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spare_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SpareItemCWProxy {
  SpareItem employee(RosterEmployee employee);

  SpareItem designation(String? designation);

  SpareItem compliance(ComplianceOverall compliance);

  SpareItem dutyMinutesLast7Days(int dutyMinutesLast7Days);

  SpareItem dutiesOnDate(int dutiesOnDate);

  SpareItem warnings(List<RosterWarning> warnings);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SpareItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SpareItem(...).copyWith(id: 12, name: "My name")
  /// ````
  SpareItem call({
    RosterEmployee employee,
    String? designation,
    ComplianceOverall compliance,
    int dutyMinutesLast7Days,
    int dutiesOnDate,
    List<RosterWarning> warnings,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSpareItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSpareItem.copyWith.fieldName(...)`
class _$SpareItemCWProxyImpl implements _$SpareItemCWProxy {
  const _$SpareItemCWProxyImpl(this._value);

  final SpareItem _value;

  @override
  SpareItem employee(RosterEmployee employee) => this(employee: employee);

  @override
  SpareItem designation(String? designation) => this(designation: designation);

  @override
  SpareItem compliance(ComplianceOverall compliance) =>
      this(compliance: compliance);

  @override
  SpareItem dutyMinutesLast7Days(int dutyMinutesLast7Days) =>
      this(dutyMinutesLast7Days: dutyMinutesLast7Days);

  @override
  SpareItem dutiesOnDate(int dutiesOnDate) => this(dutiesOnDate: dutiesOnDate);

  @override
  SpareItem warnings(List<RosterWarning> warnings) => this(warnings: warnings);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SpareItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SpareItem(...).copyWith(id: 12, name: "My name")
  /// ````
  SpareItem call({
    Object? employee = const $CopyWithPlaceholder(),
    Object? designation = const $CopyWithPlaceholder(),
    Object? compliance = const $CopyWithPlaceholder(),
    Object? dutyMinutesLast7Days = const $CopyWithPlaceholder(),
    Object? dutiesOnDate = const $CopyWithPlaceholder(),
    Object? warnings = const $CopyWithPlaceholder(),
  }) {
    return SpareItem(
      employee: employee == const $CopyWithPlaceholder()
          ? _value.employee
          // ignore: cast_nullable_to_non_nullable
          : employee as RosterEmployee,
      designation: designation == const $CopyWithPlaceholder()
          ? _value.designation
          // ignore: cast_nullable_to_non_nullable
          : designation as String?,
      compliance: compliance == const $CopyWithPlaceholder()
          ? _value.compliance
          // ignore: cast_nullable_to_non_nullable
          : compliance as ComplianceOverall,
      dutyMinutesLast7Days: dutyMinutesLast7Days == const $CopyWithPlaceholder()
          ? _value.dutyMinutesLast7Days
          // ignore: cast_nullable_to_non_nullable
          : dutyMinutesLast7Days as int,
      dutiesOnDate: dutiesOnDate == const $CopyWithPlaceholder()
          ? _value.dutiesOnDate
          // ignore: cast_nullable_to_non_nullable
          : dutiesOnDate as int,
      warnings: warnings == const $CopyWithPlaceholder()
          ? _value.warnings
          // ignore: cast_nullable_to_non_nullable
          : warnings as List<RosterWarning>,
    );
  }
}

extension $SpareItemCopyWith on SpareItem {
  /// Returns a callable class that can be used as follows: `instanceOfSpareItem.copyWith(...)` or like so:`instanceOfSpareItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SpareItemCWProxy get copyWith => _$SpareItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpareItem _$SpareItemFromJson(Map<String, dynamic> json) => $checkedCreate(
  'SpareItem',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'employee',
        'designation',
        'compliance',
        'dutyMinutesLast7Days',
        'dutiesOnDate',
        'warnings',
      ],
    );
    final val = SpareItem(
      employee: $checkedConvert(
        'employee',
        (v) => RosterEmployee.fromJson(v as Map<String, dynamic>),
      ),
      designation: $checkedConvert('designation', (v) => v as String?),
      compliance: $checkedConvert(
        'compliance',
        (v) => $enumDecode(_$ComplianceOverallEnumMap, v),
      ),
      dutyMinutesLast7Days: $checkedConvert(
        'dutyMinutesLast7Days',
        (v) => (v as num).toInt(),
      ),
      dutiesOnDate: $checkedConvert('dutiesOnDate', (v) => (v as num).toInt()),
      warnings: $checkedConvert(
        'warnings',
        (v) => (v as List<dynamic>)
            .map((e) => RosterWarning.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
    );
    return val;
  },
);

Map<String, dynamic> _$SpareItemToJson(SpareItem instance) => <String, dynamic>{
  'employee': instance.employee.toJson(),
  'designation': instance.designation,
  'compliance': _$ComplianceOverallEnumMap[instance.compliance]!,
  'dutyMinutesLast7Days': instance.dutyMinutesLast7Days,
  'dutiesOnDate': instance.dutiesOnDate,
  'warnings': instance.warnings.map((e) => e.toJson()).toList(),
};

const _$ComplianceOverallEnumMap = {
  ComplianceOverall.OK: 'OK',
  ComplianceOverall.EXPIRING: 'EXPIRING',
  ComplianceOverall.PENDING_VERIFICATION: 'PENDING_VERIFICATION',
  ComplianceOverall.EXPIRED: 'EXPIRED',
  ComplianceOverall.MISSING: 'MISSING',
};
