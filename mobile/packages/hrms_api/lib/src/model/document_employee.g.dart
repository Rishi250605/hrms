// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_employee.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DocumentEmployeeCWProxy {
  DocumentEmployee id(String id);

  DocumentEmployee empCode(String empCode);

  DocumentEmployee fullName(String fullName);

  DocumentEmployee category(EmployeeCategory category);

  DocumentEmployee depot(DepotSummary? depot);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DocumentEmployee(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DocumentEmployee(...).copyWith(id: 12, name: "My name")
  /// ````
  DocumentEmployee call({
    String id,
    String empCode,
    String fullName,
    EmployeeCategory category,
    DepotSummary? depot,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDocumentEmployee.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDocumentEmployee.copyWith.fieldName(...)`
class _$DocumentEmployeeCWProxyImpl implements _$DocumentEmployeeCWProxy {
  const _$DocumentEmployeeCWProxyImpl(this._value);

  final DocumentEmployee _value;

  @override
  DocumentEmployee id(String id) => this(id: id);

  @override
  DocumentEmployee empCode(String empCode) => this(empCode: empCode);

  @override
  DocumentEmployee fullName(String fullName) => this(fullName: fullName);

  @override
  DocumentEmployee category(EmployeeCategory category) =>
      this(category: category);

  @override
  DocumentEmployee depot(DepotSummary? depot) => this(depot: depot);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DocumentEmployee(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DocumentEmployee(...).copyWith(id: 12, name: "My name")
  /// ````
  DocumentEmployee call({
    Object? id = const $CopyWithPlaceholder(),
    Object? empCode = const $CopyWithPlaceholder(),
    Object? fullName = const $CopyWithPlaceholder(),
    Object? category = const $CopyWithPlaceholder(),
    Object? depot = const $CopyWithPlaceholder(),
  }) {
    return DocumentEmployee(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      empCode: empCode == const $CopyWithPlaceholder()
          ? _value.empCode
          // ignore: cast_nullable_to_non_nullable
          : empCode as String,
      fullName: fullName == const $CopyWithPlaceholder()
          ? _value.fullName
          // ignore: cast_nullable_to_non_nullable
          : fullName as String,
      category: category == const $CopyWithPlaceholder()
          ? _value.category
          // ignore: cast_nullable_to_non_nullable
          : category as EmployeeCategory,
      depot: depot == const $CopyWithPlaceholder()
          ? _value.depot
          // ignore: cast_nullable_to_non_nullable
          : depot as DepotSummary?,
    );
  }
}

extension $DocumentEmployeeCopyWith on DocumentEmployee {
  /// Returns a callable class that can be used as follows: `instanceOfDocumentEmployee.copyWith(...)` or like so:`instanceOfDocumentEmployee.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DocumentEmployeeCWProxy get copyWith => _$DocumentEmployeeCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentEmployee _$DocumentEmployeeFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DocumentEmployee', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['id', 'empCode', 'fullName', 'category', 'depot'],
      );
      final val = DocumentEmployee(
        id: $checkedConvert('id', (v) => v as String),
        empCode: $checkedConvert('empCode', (v) => v as String),
        fullName: $checkedConvert('fullName', (v) => v as String),
        category: $checkedConvert(
          'category',
          (v) => $enumDecode(_$EmployeeCategoryEnumMap, v),
        ),
        depot: $checkedConvert(
          'depot',
          (v) => v == null
              ? null
              : DepotSummary.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$DocumentEmployeeToJson(DocumentEmployee instance) =>
    <String, dynamic>{
      'id': instance.id,
      'empCode': instance.empCode,
      'fullName': instance.fullName,
      'category': _$EmployeeCategoryEnumMap[instance.category]!,
      'depot': instance.depot?.toJson(),
    };

const _$EmployeeCategoryEnumMap = {
  EmployeeCategory.DRIVER: 'DRIVER',
  EmployeeCategory.LOADMAN: 'LOADMAN',
  EmployeeCategory.CONDUCTOR: 'CONDUCTOR',
  EmployeeCategory.HELPER: 'HELPER',
  EmployeeCategory.MECHANIC: 'MECHANIC',
  EmployeeCategory.DEPOT_STAFF: 'DEPOT_STAFF',
  EmployeeCategory.OFFICE: 'OFFICE',
};
