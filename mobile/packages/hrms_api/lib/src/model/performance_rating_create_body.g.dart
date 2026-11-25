// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performance_rating_create_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PerformanceRatingCreateBodyCWProxy {
  PerformanceRatingCreateBody rating(int rating);

  PerformanceRatingCreateBody comment(String? comment);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PerformanceRatingCreateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PerformanceRatingCreateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  PerformanceRatingCreateBody call({int rating, String? comment});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPerformanceRatingCreateBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPerformanceRatingCreateBody.copyWith.fieldName(...)`
class _$PerformanceRatingCreateBodyCWProxyImpl
    implements _$PerformanceRatingCreateBodyCWProxy {
  const _$PerformanceRatingCreateBodyCWProxyImpl(this._value);

  final PerformanceRatingCreateBody _value;

  @override
  PerformanceRatingCreateBody rating(int rating) => this(rating: rating);

  @override
  PerformanceRatingCreateBody comment(String? comment) =>
      this(comment: comment);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PerformanceRatingCreateBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PerformanceRatingCreateBody(...).copyWith(id: 12, name: "My name")
  /// ````
  PerformanceRatingCreateBody call({
    Object? rating = const $CopyWithPlaceholder(),
    Object? comment = const $CopyWithPlaceholder(),
  }) {
    return PerformanceRatingCreateBody(
      rating: rating == const $CopyWithPlaceholder()
          ? _value.rating
          // ignore: cast_nullable_to_non_nullable
          : rating as int,
      comment: comment == const $CopyWithPlaceholder()
          ? _value.comment
          // ignore: cast_nullable_to_non_nullable
          : comment as String?,
    );
  }
}

extension $PerformanceRatingCreateBodyCopyWith on PerformanceRatingCreateBody {
  /// Returns a callable class that can be used as follows: `instanceOfPerformanceRatingCreateBody.copyWith(...)` or like so:`instanceOfPerformanceRatingCreateBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PerformanceRatingCreateBodyCWProxy get copyWith =>
      _$PerformanceRatingCreateBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PerformanceRatingCreateBody _$PerformanceRatingCreateBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('PerformanceRatingCreateBody', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['rating']);
  final val = PerformanceRatingCreateBody(
    rating: $checkedConvert('rating', (v) => (v as num).toInt()),
    comment: $checkedConvert('comment', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$PerformanceRatingCreateBodyToJson(
  PerformanceRatingCreateBody instance,
) => <String, dynamic>{'rating': instance.rating, 'comment': ?instance.comment};
