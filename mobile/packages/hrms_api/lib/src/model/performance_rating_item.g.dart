// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performance_rating_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PerformanceRatingItemCWProxy {
  PerformanceRatingItem id(String id);

  PerformanceRatingItem rating(int rating);

  PerformanceRatingItem comment(String? comment);

  PerformanceRatingItem ratedBy(PersonRef ratedBy);

  PerformanceRatingItem createdAt(DateTime createdAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PerformanceRatingItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PerformanceRatingItem(...).copyWith(id: 12, name: "My name")
  /// ````
  PerformanceRatingItem call({
    String id,
    int rating,
    String? comment,
    PersonRef ratedBy,
    DateTime createdAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPerformanceRatingItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPerformanceRatingItem.copyWith.fieldName(...)`
class _$PerformanceRatingItemCWProxyImpl
    implements _$PerformanceRatingItemCWProxy {
  const _$PerformanceRatingItemCWProxyImpl(this._value);

  final PerformanceRatingItem _value;

  @override
  PerformanceRatingItem id(String id) => this(id: id);

  @override
  PerformanceRatingItem rating(int rating) => this(rating: rating);

  @override
  PerformanceRatingItem comment(String? comment) => this(comment: comment);

  @override
  PerformanceRatingItem ratedBy(PersonRef ratedBy) => this(ratedBy: ratedBy);

  @override
  PerformanceRatingItem createdAt(DateTime createdAt) =>
      this(createdAt: createdAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PerformanceRatingItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PerformanceRatingItem(...).copyWith(id: 12, name: "My name")
  /// ````
  PerformanceRatingItem call({
    Object? id = const $CopyWithPlaceholder(),
    Object? rating = const $CopyWithPlaceholder(),
    Object? comment = const $CopyWithPlaceholder(),
    Object? ratedBy = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
  }) {
    return PerformanceRatingItem(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      rating: rating == const $CopyWithPlaceholder()
          ? _value.rating
          // ignore: cast_nullable_to_non_nullable
          : rating as int,
      comment: comment == const $CopyWithPlaceholder()
          ? _value.comment
          // ignore: cast_nullable_to_non_nullable
          : comment as String?,
      ratedBy: ratedBy == const $CopyWithPlaceholder()
          ? _value.ratedBy
          // ignore: cast_nullable_to_non_nullable
          : ratedBy as PersonRef,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
    );
  }
}

extension $PerformanceRatingItemCopyWith on PerformanceRatingItem {
  /// Returns a callable class that can be used as follows: `instanceOfPerformanceRatingItem.copyWith(...)` or like so:`instanceOfPerformanceRatingItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PerformanceRatingItemCWProxy get copyWith =>
      _$PerformanceRatingItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PerformanceRatingItem _$PerformanceRatingItemFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('PerformanceRatingItem', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'rating', 'comment', 'ratedBy', 'createdAt'],
  );
  final val = PerformanceRatingItem(
    id: $checkedConvert('id', (v) => v as String),
    rating: $checkedConvert('rating', (v) => (v as num).toInt()),
    comment: $checkedConvert('comment', (v) => v as String?),
    ratedBy: $checkedConvert(
      'ratedBy',
      (v) => PersonRef.fromJson(v as Map<String, dynamic>),
    ),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
  );
  return val;
});

Map<String, dynamic> _$PerformanceRatingItemToJson(
  PerformanceRatingItem instance,
) => <String, dynamic>{
  'id': instance.id,
  'rating': instance.rating,
  'comment': instance.comment,
  'ratedBy': instance.ratedBy.toJson(),
  'createdAt': instance.createdAt.toIso8601String(),
};
