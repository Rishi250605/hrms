// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allowance_approve_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AllowanceApproveBodyCWProxy {
  AllowanceApproveBody approvedAmountPaise(int? approvedAmountPaise);

  AllowanceApproveBody comment(String? comment);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AllowanceApproveBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AllowanceApproveBody(...).copyWith(id: 12, name: "My name")
  /// ````
  AllowanceApproveBody call({int? approvedAmountPaise, String? comment});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAllowanceApproveBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAllowanceApproveBody.copyWith.fieldName(...)`
class _$AllowanceApproveBodyCWProxyImpl
    implements _$AllowanceApproveBodyCWProxy {
  const _$AllowanceApproveBodyCWProxyImpl(this._value);

  final AllowanceApproveBody _value;

  @override
  AllowanceApproveBody approvedAmountPaise(int? approvedAmountPaise) =>
      this(approvedAmountPaise: approvedAmountPaise);

  @override
  AllowanceApproveBody comment(String? comment) => this(comment: comment);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AllowanceApproveBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AllowanceApproveBody(...).copyWith(id: 12, name: "My name")
  /// ````
  AllowanceApproveBody call({
    Object? approvedAmountPaise = const $CopyWithPlaceholder(),
    Object? comment = const $CopyWithPlaceholder(),
  }) {
    return AllowanceApproveBody(
      approvedAmountPaise: approvedAmountPaise == const $CopyWithPlaceholder()
          ? _value.approvedAmountPaise
          // ignore: cast_nullable_to_non_nullable
          : approvedAmountPaise as int?,
      comment: comment == const $CopyWithPlaceholder()
          ? _value.comment
          // ignore: cast_nullable_to_non_nullable
          : comment as String?,
    );
  }
}

extension $AllowanceApproveBodyCopyWith on AllowanceApproveBody {
  /// Returns a callable class that can be used as follows: `instanceOfAllowanceApproveBody.copyWith(...)` or like so:`instanceOfAllowanceApproveBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AllowanceApproveBodyCWProxy get copyWith =>
      _$AllowanceApproveBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllowanceApproveBody _$AllowanceApproveBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AllowanceApproveBody', json, ($checkedConvert) {
  final val = AllowanceApproveBody(
    approvedAmountPaise: $checkedConvert(
      'approvedAmountPaise',
      (v) => (v as num?)?.toInt(),
    ),
    comment: $checkedConvert('comment', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$AllowanceApproveBodyToJson(
  AllowanceApproveBody instance,
) => <String, dynamic>{
  'approvedAmountPaise': ?instance.approvedAmountPaise,
  'comment': ?instance.comment,
};
