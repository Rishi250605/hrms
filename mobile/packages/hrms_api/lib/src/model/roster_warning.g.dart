// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roster_warning.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RosterWarningCWProxy {
  RosterWarning code(RosterWarningCodeEnum code);

  RosterWarning message(String message);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RosterWarning(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RosterWarning(...).copyWith(id: 12, name: "My name")
  /// ````
  RosterWarning call({RosterWarningCodeEnum code, String message});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRosterWarning.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRosterWarning.copyWith.fieldName(...)`
class _$RosterWarningCWProxyImpl implements _$RosterWarningCWProxy {
  const _$RosterWarningCWProxyImpl(this._value);

  final RosterWarning _value;

  @override
  RosterWarning code(RosterWarningCodeEnum code) => this(code: code);

  @override
  RosterWarning message(String message) => this(message: message);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RosterWarning(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RosterWarning(...).copyWith(id: 12, name: "My name")
  /// ````
  RosterWarning call({
    Object? code = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
  }) {
    return RosterWarning(
      code: code == const $CopyWithPlaceholder()
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as RosterWarningCodeEnum,
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
    );
  }
}

extension $RosterWarningCopyWith on RosterWarning {
  /// Returns a callable class that can be used as follows: `instanceOfRosterWarning.copyWith(...)` or like so:`instanceOfRosterWarning.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RosterWarningCWProxy get copyWith => _$RosterWarningCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RosterWarning _$RosterWarningFromJson(Map<String, dynamic> json) =>
    $checkedCreate('RosterWarning', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['code', 'message']);
      final val = RosterWarning(
        code: $checkedConvert(
          'code',
          (v) => $enumDecode(_$RosterWarningCodeEnumEnumMap, v),
        ),
        message: $checkedConvert('message', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$RosterWarningToJson(RosterWarning instance) =>
    <String, dynamic>{
      'code': _$RosterWarningCodeEnumEnumMap[instance.code]!,
      'message': instance.message,
    };

const _$RosterWarningCodeEnumEnumMap = {
  RosterWarningCodeEnum.DUTY_HOURS_EXCEEDED: 'DUTY_HOURS_EXCEEDED',
  RosterWarningCodeEnum.MIN_REST_VIOLATED: 'MIN_REST_VIOLATED',
  RosterWarningCodeEnum.NO_WEEKLY_OFF: 'NO_WEEKLY_OFF',
  RosterWarningCodeEnum.DOCUMENT_EXPIRING: 'DOCUMENT_EXPIRING',
};
