// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payslip_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PayslipItemCWProxy {
  PayslipItem id(String id);

  PayslipItem employee(PayslipItemEmployee employee);

  PayslipItem businessUnit(BusinessUnitRef businessUnit);

  PayslipItem period(String period);

  PayslipItem version(int version);

  PayslipItem sizeBytes(int sizeBytes);

  PayslipItem uploadedAt(DateTime uploadedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PayslipItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PayslipItem(...).copyWith(id: 12, name: "My name")
  /// ````
  PayslipItem call({
    String id,
    PayslipItemEmployee employee,
    BusinessUnitRef businessUnit,
    String period,
    int version,
    int sizeBytes,
    DateTime uploadedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPayslipItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPayslipItem.copyWith.fieldName(...)`
class _$PayslipItemCWProxyImpl implements _$PayslipItemCWProxy {
  const _$PayslipItemCWProxyImpl(this._value);

  final PayslipItem _value;

  @override
  PayslipItem id(String id) => this(id: id);

  @override
  PayslipItem employee(PayslipItemEmployee employee) =>
      this(employee: employee);

  @override
  PayslipItem businessUnit(BusinessUnitRef businessUnit) =>
      this(businessUnit: businessUnit);

  @override
  PayslipItem period(String period) => this(period: period);

  @override
  PayslipItem version(int version) => this(version: version);

  @override
  PayslipItem sizeBytes(int sizeBytes) => this(sizeBytes: sizeBytes);

  @override
  PayslipItem uploadedAt(DateTime uploadedAt) => this(uploadedAt: uploadedAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PayslipItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PayslipItem(...).copyWith(id: 12, name: "My name")
  /// ````
  PayslipItem call({
    Object? id = const $CopyWithPlaceholder(),
    Object? employee = const $CopyWithPlaceholder(),
    Object? businessUnit = const $CopyWithPlaceholder(),
    Object? period = const $CopyWithPlaceholder(),
    Object? version = const $CopyWithPlaceholder(),
    Object? sizeBytes = const $CopyWithPlaceholder(),
    Object? uploadedAt = const $CopyWithPlaceholder(),
  }) {
    return PayslipItem(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      employee: employee == const $CopyWithPlaceholder()
          ? _value.employee
          // ignore: cast_nullable_to_non_nullable
          : employee as PayslipItemEmployee,
      businessUnit: businessUnit == const $CopyWithPlaceholder()
          ? _value.businessUnit
          // ignore: cast_nullable_to_non_nullable
          : businessUnit as BusinessUnitRef,
      period: period == const $CopyWithPlaceholder()
          ? _value.period
          // ignore: cast_nullable_to_non_nullable
          : period as String,
      version: version == const $CopyWithPlaceholder()
          ? _value.version
          // ignore: cast_nullable_to_non_nullable
          : version as int,
      sizeBytes: sizeBytes == const $CopyWithPlaceholder()
          ? _value.sizeBytes
          // ignore: cast_nullable_to_non_nullable
          : sizeBytes as int,
      uploadedAt: uploadedAt == const $CopyWithPlaceholder()
          ? _value.uploadedAt
          // ignore: cast_nullable_to_non_nullable
          : uploadedAt as DateTime,
    );
  }
}

extension $PayslipItemCopyWith on PayslipItem {
  /// Returns a callable class that can be used as follows: `instanceOfPayslipItem.copyWith(...)` or like so:`instanceOfPayslipItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PayslipItemCWProxy get copyWith => _$PayslipItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayslipItem _$PayslipItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PayslipItem', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'employee',
          'businessUnit',
          'period',
          'version',
          'sizeBytes',
          'uploadedAt',
        ],
      );
      final val = PayslipItem(
        id: $checkedConvert('id', (v) => v as String),
        employee: $checkedConvert(
          'employee',
          (v) => PayslipItemEmployee.fromJson(v as Map<String, dynamic>),
        ),
        businessUnit: $checkedConvert(
          'businessUnit',
          (v) => BusinessUnitRef.fromJson(v as Map<String, dynamic>),
        ),
        period: $checkedConvert('period', (v) => v as String),
        version: $checkedConvert('version', (v) => (v as num).toInt()),
        sizeBytes: $checkedConvert('sizeBytes', (v) => (v as num).toInt()),
        uploadedAt: $checkedConvert(
          'uploadedAt',
          (v) => DateTime.parse(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$PayslipItemToJson(PayslipItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employee': instance.employee.toJson(),
      'businessUnit': instance.businessUnit.toJson(),
      'period': instance.period,
      'version': instance.version,
      'sizeBytes': instance.sizeBytes,
      'uploadedAt': instance.uploadedAt.toIso8601String(),
    };
