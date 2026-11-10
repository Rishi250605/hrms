// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allowance_create_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AllowanceCreateBodyCWProxy {
  AllowanceCreateBody beneficiaryEmployeeIds(
    List<String>? beneficiaryEmployeeIds,
  );

  AllowanceCreateBody allowanceTypeId(String allowanceTypeId);

  AllowanceCreateBody amountPaise(int amountPaise);

  AllowanceCreateBody fromDate(String fromDate);

  AllowanceCreateBody toDate(String? toDate);

  AllowanceCreateBody comment(String? comment);

  AllowanceCreateBody voiceNoteKey(String? voiceNoteKey);

  AllowanceCreateBody receiptKey(String? receiptKey);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AllowanceCreateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AllowanceCreateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  AllowanceCreateBody call({
    List<String>? beneficiaryEmployeeIds,
    String allowanceTypeId,
    int amountPaise,
    String fromDate,
    String? toDate,
    String? comment,
    String? voiceNoteKey,
    String? receiptKey,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAllowanceCreateBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAllowanceCreateBody.copyWith.fieldName(...)`
class _$AllowanceCreateBodyCWProxyImpl implements _$AllowanceCreateBodyCWProxy {
  const _$AllowanceCreateBodyCWProxyImpl(this._value);

  final AllowanceCreateBody _value;

  @override
  AllowanceCreateBody beneficiaryEmployeeIds(
    List<String>? beneficiaryEmployeeIds,
  ) => this(beneficiaryEmployeeIds: beneficiaryEmployeeIds);

  @override
  AllowanceCreateBody allowanceTypeId(String allowanceTypeId) =>
      this(allowanceTypeId: allowanceTypeId);

  @override
  AllowanceCreateBody amountPaise(int amountPaise) =>
      this(amountPaise: amountPaise);

  @override
  AllowanceCreateBody fromDate(String fromDate) => this(fromDate: fromDate);

  @override
  AllowanceCreateBody toDate(String? toDate) => this(toDate: toDate);

  @override
  AllowanceCreateBody comment(String? comment) => this(comment: comment);

  @override
  AllowanceCreateBody voiceNoteKey(String? voiceNoteKey) =>
      this(voiceNoteKey: voiceNoteKey);

  @override
  AllowanceCreateBody receiptKey(String? receiptKey) =>
      this(receiptKey: receiptKey);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AllowanceCreateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AllowanceCreateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  AllowanceCreateBody call({
    Object? beneficiaryEmployeeIds = const $CopyWithPlaceholder(),
    Object? allowanceTypeId = const $CopyWithPlaceholder(),
    Object? amountPaise = const $CopyWithPlaceholder(),
    Object? fromDate = const $CopyWithPlaceholder(),
    Object? toDate = const $CopyWithPlaceholder(),
    Object? comment = const $CopyWithPlaceholder(),
    Object? voiceNoteKey = const $CopyWithPlaceholder(),
    Object? receiptKey = const $CopyWithPlaceholder(),
  }) {
    return AllowanceCreateBody(
      beneficiaryEmployeeIds:
          beneficiaryEmployeeIds == const $CopyWithPlaceholder()
          ? _value.beneficiaryEmployeeIds
          // ignore: cast_nullable_to_non_nullable
          : beneficiaryEmployeeIds as List<String>?,
      allowanceTypeId: allowanceTypeId == const $CopyWithPlaceholder()
          ? _value.allowanceTypeId
          // ignore: cast_nullable_to_non_nullable
          : allowanceTypeId as String,
      amountPaise: amountPaise == const $CopyWithPlaceholder()
          ? _value.amountPaise
          // ignore: cast_nullable_to_non_nullable
          : amountPaise as int,
      fromDate: fromDate == const $CopyWithPlaceholder()
          ? _value.fromDate
          // ignore: cast_nullable_to_non_nullable
          : fromDate as String,
      toDate: toDate == const $CopyWithPlaceholder()
          ? _value.toDate
          // ignore: cast_nullable_to_non_nullable
          : toDate as String?,
      comment: comment == const $CopyWithPlaceholder()
          ? _value.comment
          // ignore: cast_nullable_to_non_nullable
          : comment as String?,
      voiceNoteKey: voiceNoteKey == const $CopyWithPlaceholder()
          ? _value.voiceNoteKey
          // ignore: cast_nullable_to_non_nullable
          : voiceNoteKey as String?,
      receiptKey: receiptKey == const $CopyWithPlaceholder()
          ? _value.receiptKey
          // ignore: cast_nullable_to_non_nullable
          : receiptKey as String?,
    );
  }
}

extension $AllowanceCreateBodyCopyWith on AllowanceCreateBody {
  /// Returns a callable class that can be used as follows: `instanceOfAllowanceCreateBody.copyWith(...)` or like so:`instanceOfAllowanceCreateBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AllowanceCreateBodyCWProxy get copyWith =>
      _$AllowanceCreateBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllowanceCreateBody _$AllowanceCreateBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AllowanceCreateBody', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['allowanceTypeId', 'amountPaise', 'fromDate'],
      );
      final val = AllowanceCreateBody(
        beneficiaryEmployeeIds: $checkedConvert(
          'beneficiaryEmployeeIds',
          (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
        ),
        allowanceTypeId: $checkedConvert('allowanceTypeId', (v) => v as String),
        amountPaise: $checkedConvert('amountPaise', (v) => (v as num).toInt()),
        fromDate: $checkedConvert('fromDate', (v) => v as String),
        toDate: $checkedConvert('toDate', (v) => v as String?),
        comment: $checkedConvert('comment', (v) => v as String?),
        voiceNoteKey: $checkedConvert('voiceNoteKey', (v) => v as String?),
        receiptKey: $checkedConvert('receiptKey', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$AllowanceCreateBodyToJson(
  AllowanceCreateBody instance,
) => <String, dynamic>{
  'beneficiaryEmployeeIds': ?instance.beneficiaryEmployeeIds,
  'allowanceTypeId': instance.allowanceTypeId,
  'amountPaise': instance.amountPaise,
  'fromDate': instance.fromDate,
  'toDate': ?instance.toDate,
  'comment': ?instance.comment,
  'voiceNoteKey': ?instance.voiceNoteKey,
  'receiptKey': ?instance.receiptKey,
};
