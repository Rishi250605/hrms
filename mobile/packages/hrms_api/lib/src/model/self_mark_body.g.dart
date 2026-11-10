// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'self_mark_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SelfMarkBodyCWProxy {
  SelfMarkBody date(String date);

  SelfMarkBody status(SelfMarkBodyStatusEnum status);

  SelfMarkBody note(String? note);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SelfMarkBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SelfMarkBody(...).copyWith(id: 12, name: "My name")
  /// ````
  SelfMarkBody call({String date, SelfMarkBodyStatusEnum status, String? note});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSelfMarkBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSelfMarkBody.copyWith.fieldName(...)`
class _$SelfMarkBodyCWProxyImpl implements _$SelfMarkBodyCWProxy {
  const _$SelfMarkBodyCWProxyImpl(this._value);

  final SelfMarkBody _value;

  @override
  SelfMarkBody date(String date) => this(date: date);

  @override
  SelfMarkBody status(SelfMarkBodyStatusEnum status) => this(status: status);

  @override
  SelfMarkBody note(String? note) => this(note: note);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SelfMarkBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SelfMarkBody(...).copyWith(id: 12, name: "My name")
  /// ````
  SelfMarkBody call({
    Object? date = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? note = const $CopyWithPlaceholder(),
  }) {
    return SelfMarkBody(
      date: date == const $CopyWithPlaceholder()
          ? _value.date
          // ignore: cast_nullable_to_non_nullable
          : date as String,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as SelfMarkBodyStatusEnum,
      note: note == const $CopyWithPlaceholder()
          ? _value.note
          // ignore: cast_nullable_to_non_nullable
          : note as String?,
    );
  }
}

extension $SelfMarkBodyCopyWith on SelfMarkBody {
  /// Returns a callable class that can be used as follows: `instanceOfSelfMarkBody.copyWith(...)` or like so:`instanceOfSelfMarkBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SelfMarkBodyCWProxy get copyWith => _$SelfMarkBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SelfMarkBody _$SelfMarkBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SelfMarkBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['date', 'status']);
      final val = SelfMarkBody(
        date: $checkedConvert('date', (v) => v as String),
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(_$SelfMarkBodyStatusEnumEnumMap, v),
        ),
        note: $checkedConvert('note', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$SelfMarkBodyToJson(SelfMarkBody instance) =>
    <String, dynamic>{
      'date': instance.date,
      'status': _$SelfMarkBodyStatusEnumEnumMap[instance.status]!,
      'note': ?instance.note,
    };

const _$SelfMarkBodyStatusEnumEnumMap = {
  SelfMarkBodyStatusEnum.PRESENT: 'PRESENT',
  SelfMarkBodyStatusEnum.ABSENT: 'ABSENT',
  SelfMarkBodyStatusEnum.HALF_DAY: 'HALF_DAY',
  SelfMarkBodyStatusEnum.ON_DUTY: 'ON_DUTY',
  SelfMarkBodyStatusEnum.WEEKLY_OFF: 'WEEKLY_OFF',
  SelfMarkBodyStatusEnum.HOLIDAY: 'HOLIDAY',
};
