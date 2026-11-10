// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payslip_upload_match.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PayslipUploadMatchCWProxy {
  PayslipUploadMatch fileName(String fileName);

  PayslipUploadMatch payslipId(String payslipId);

  PayslipUploadMatch employee(PersonRef employee);

  PayslipUploadMatch version(int version);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PayslipUploadMatch(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PayslipUploadMatch(...).copyWith(id: 12, name: "My name")
  /// ````
  PayslipUploadMatch call({
    String fileName,
    String payslipId,
    PersonRef employee,
    int version,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPayslipUploadMatch.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPayslipUploadMatch.copyWith.fieldName(...)`
class _$PayslipUploadMatchCWProxyImpl implements _$PayslipUploadMatchCWProxy {
  const _$PayslipUploadMatchCWProxyImpl(this._value);

  final PayslipUploadMatch _value;

  @override
  PayslipUploadMatch fileName(String fileName) => this(fileName: fileName);

  @override
  PayslipUploadMatch payslipId(String payslipId) => this(payslipId: payslipId);

  @override
  PayslipUploadMatch employee(PersonRef employee) => this(employee: employee);

  @override
  PayslipUploadMatch version(int version) => this(version: version);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PayslipUploadMatch(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PayslipUploadMatch(...).copyWith(id: 12, name: "My name")
  /// ````
  PayslipUploadMatch call({
    Object? fileName = const $CopyWithPlaceholder(),
    Object? payslipId = const $CopyWithPlaceholder(),
    Object? employee = const $CopyWithPlaceholder(),
    Object? version = const $CopyWithPlaceholder(),
  }) {
    return PayslipUploadMatch(
      fileName: fileName == const $CopyWithPlaceholder()
          ? _value.fileName
          // ignore: cast_nullable_to_non_nullable
          : fileName as String,
      payslipId: payslipId == const $CopyWithPlaceholder()
          ? _value.payslipId
          // ignore: cast_nullable_to_non_nullable
          : payslipId as String,
      employee: employee == const $CopyWithPlaceholder()
          ? _value.employee
          // ignore: cast_nullable_to_non_nullable
          : employee as PersonRef,
      version: version == const $CopyWithPlaceholder()
          ? _value.version
          // ignore: cast_nullable_to_non_nullable
          : version as int,
    );
  }
}

extension $PayslipUploadMatchCopyWith on PayslipUploadMatch {
  /// Returns a callable class that can be used as follows: `instanceOfPayslipUploadMatch.copyWith(...)` or like so:`instanceOfPayslipUploadMatch.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PayslipUploadMatchCWProxy get copyWith =>
      _$PayslipUploadMatchCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayslipUploadMatch _$PayslipUploadMatchFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PayslipUploadMatch', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['fileName', 'payslipId', 'employee', 'version'],
      );
      final val = PayslipUploadMatch(
        fileName: $checkedConvert('fileName', (v) => v as String),
        payslipId: $checkedConvert('payslipId', (v) => v as String),
        employee: $checkedConvert(
          'employee',
          (v) => PersonRef.fromJson(v as Map<String, dynamic>),
        ),
        version: $checkedConvert('version', (v) => (v as num).toInt()),
      );
      return val;
    });

Map<String, dynamic> _$PayslipUploadMatchToJson(PayslipUploadMatch instance) =>
    <String, dynamic>{
      'fileName': instance.fileName,
      'payslipId': instance.payslipId,
      'employee': instance.employee.toJson(),
      'version': instance.version,
    };
