// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bulk_attendance_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BulkAttendanceBodyCWProxy {
  BulkAttendanceBody marks(List<BulkMark> marks);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BulkAttendanceBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BulkAttendanceBody(...).copyWith(id: 12, name: "My name")
  /// ````
  BulkAttendanceBody call({List<BulkMark> marks});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBulkAttendanceBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBulkAttendanceBody.copyWith.fieldName(...)`
class _$BulkAttendanceBodyCWProxyImpl implements _$BulkAttendanceBodyCWProxy {
  const _$BulkAttendanceBodyCWProxyImpl(this._value);

  final BulkAttendanceBody _value;

  @override
  BulkAttendanceBody marks(List<BulkMark> marks) => this(marks: marks);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BulkAttendanceBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BulkAttendanceBody(...).copyWith(id: 12, name: "My name")
  /// ````
  BulkAttendanceBody call({Object? marks = const $CopyWithPlaceholder()}) {
    return BulkAttendanceBody(
      marks: marks == const $CopyWithPlaceholder()
          ? _value.marks
          // ignore: cast_nullable_to_non_nullable
          : marks as List<BulkMark>,
    );
  }
}

extension $BulkAttendanceBodyCopyWith on BulkAttendanceBody {
  /// Returns a callable class that can be used as follows: `instanceOfBulkAttendanceBody.copyWith(...)` or like so:`instanceOfBulkAttendanceBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BulkAttendanceBodyCWProxy get copyWith =>
      _$BulkAttendanceBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BulkAttendanceBody _$BulkAttendanceBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('BulkAttendanceBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['marks']);
      final val = BulkAttendanceBody(
        marks: $checkedConvert(
          'marks',
          (v) => (v as List<dynamic>)
              .map((e) => BulkMark.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$BulkAttendanceBodyToJson(BulkAttendanceBody instance) =>
    <String, dynamic>{'marks': instance.marks.map((e) => e.toJson()).toList()};
