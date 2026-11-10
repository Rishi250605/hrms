// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allowance_summary_items_inner.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AllowanceSummaryItemsInnerCWProxy {
  AllowanceSummaryItemsInner businessUnit(BusinessUnitRef businessUnit);

  AllowanceSummaryItemsInner requests(int requests);

  AllowanceSummaryItemsInner pending(int pending);

  AllowanceSummaryItemsInner requestedPaise(int requestedPaise);

  AllowanceSummaryItemsInner approvedPaise(int approvedPaise);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AllowanceSummaryItemsInner(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AllowanceSummaryItemsInner(...).copyWith(id: 12, name: "My name")
  /// ````
  AllowanceSummaryItemsInner call({
    BusinessUnitRef businessUnit,
    int requests,
    int pending,
    int requestedPaise,
    int approvedPaise,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAllowanceSummaryItemsInner.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAllowanceSummaryItemsInner.copyWith.fieldName(...)`
class _$AllowanceSummaryItemsInnerCWProxyImpl
    implements _$AllowanceSummaryItemsInnerCWProxy {
  const _$AllowanceSummaryItemsInnerCWProxyImpl(this._value);

  final AllowanceSummaryItemsInner _value;

  @override
  AllowanceSummaryItemsInner businessUnit(BusinessUnitRef businessUnit) =>
      this(businessUnit: businessUnit);

  @override
  AllowanceSummaryItemsInner requests(int requests) => this(requests: requests);

  @override
  AllowanceSummaryItemsInner pending(int pending) => this(pending: pending);

  @override
  AllowanceSummaryItemsInner requestedPaise(int requestedPaise) =>
      this(requestedPaise: requestedPaise);

  @override
  AllowanceSummaryItemsInner approvedPaise(int approvedPaise) =>
      this(approvedPaise: approvedPaise);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AllowanceSummaryItemsInner(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AllowanceSummaryItemsInner(...).copyWith(id: 12, name: "My name")
  /// ````
  AllowanceSummaryItemsInner call({
    Object? businessUnit = const $CopyWithPlaceholder(),
    Object? requests = const $CopyWithPlaceholder(),
    Object? pending = const $CopyWithPlaceholder(),
    Object? requestedPaise = const $CopyWithPlaceholder(),
    Object? approvedPaise = const $CopyWithPlaceholder(),
  }) {
    return AllowanceSummaryItemsInner(
      businessUnit: businessUnit == const $CopyWithPlaceholder()
          ? _value.businessUnit
          // ignore: cast_nullable_to_non_nullable
          : businessUnit as BusinessUnitRef,
      requests: requests == const $CopyWithPlaceholder()
          ? _value.requests
          // ignore: cast_nullable_to_non_nullable
          : requests as int,
      pending: pending == const $CopyWithPlaceholder()
          ? _value.pending
          // ignore: cast_nullable_to_non_nullable
          : pending as int,
      requestedPaise: requestedPaise == const $CopyWithPlaceholder()
          ? _value.requestedPaise
          // ignore: cast_nullable_to_non_nullable
          : requestedPaise as int,
      approvedPaise: approvedPaise == const $CopyWithPlaceholder()
          ? _value.approvedPaise
          // ignore: cast_nullable_to_non_nullable
          : approvedPaise as int,
    );
  }
}

extension $AllowanceSummaryItemsInnerCopyWith on AllowanceSummaryItemsInner {
  /// Returns a callable class that can be used as follows: `instanceOfAllowanceSummaryItemsInner.copyWith(...)` or like so:`instanceOfAllowanceSummaryItemsInner.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AllowanceSummaryItemsInnerCWProxy get copyWith =>
      _$AllowanceSummaryItemsInnerCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllowanceSummaryItemsInner _$AllowanceSummaryItemsInnerFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AllowanceSummaryItemsInner', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'businessUnit',
      'requests',
      'pending',
      'requestedPaise',
      'approvedPaise',
    ],
  );
  final val = AllowanceSummaryItemsInner(
    businessUnit: $checkedConvert(
      'businessUnit',
      (v) => BusinessUnitRef.fromJson(v as Map<String, dynamic>),
    ),
    requests: $checkedConvert('requests', (v) => (v as num).toInt()),
    pending: $checkedConvert('pending', (v) => (v as num).toInt()),
    requestedPaise: $checkedConvert(
      'requestedPaise',
      (v) => (v as num).toInt(),
    ),
    approvedPaise: $checkedConvert('approvedPaise', (v) => (v as num).toInt()),
  );
  return val;
});

Map<String, dynamic> _$AllowanceSummaryItemsInnerToJson(
  AllowanceSummaryItemsInner instance,
) => <String, dynamic>{
  'businessUnit': instance.businessUnit.toJson(),
  'requests': instance.requests,
  'pending': instance.pending,
  'requestedPaise': instance.requestedPaise,
  'approvedPaise': instance.approvedPaise,
};
