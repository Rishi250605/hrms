// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allowances_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(allowances)
final allowancesProvider = AllowancesFamily._();

final class AllowancesProvider extends $FunctionalProvider<AsyncValue<AllowancePage>, AllowancePage, FutureOr<AllowancePage>>
    with $FutureModifier<AllowancePage>, $FutureProvider<AllowancePage> {
  AllowancesProvider._({required AllowancesFamily super.from, required String super.argument})
    : super(retry: null, name: r'allowancesProvider', isAutoDispose: true, dependencies: null, $allTransitiveDependencies: null);

  @override
  String debugGetCreateSourceHash() => _$allowancesHash();

  @override
  String toString() {
    return r'allowancesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<AllowancePage> $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<AllowancePage> create(Ref ref) {
    final argument = this.argument as String;
    return allowances(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AllowancesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$allowancesHash() => r'33bba861c97fe3844fb11d2dc3e3c719d7cf8a69';

final class AllowancesFamily extends $Family with $FunctionalFamilyOverride<FutureOr<AllowancePage>, String> {
  AllowancesFamily._() : super(retry: null, name: r'allowancesProvider', dependencies: null, $allTransitiveDependencies: null, isAutoDispose: true);

  AllowancesProvider call(String scope) => AllowancesProvider._(argument: scope, from: this);

  @override
  String toString() => r'allowancesProvider';
}

@ProviderFor(allowanceTypes)
final allowanceTypesProvider = AllowanceTypesProvider._();

final class AllowanceTypesProvider extends $FunctionalProvider<AsyncValue<List<AllowanceTypeItem>>, List<AllowanceTypeItem>, FutureOr<List<AllowanceTypeItem>>>
    with $FutureModifier<List<AllowanceTypeItem>>, $FutureProvider<List<AllowanceTypeItem>> {
  AllowanceTypesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allowanceTypesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allowanceTypesHash();

  @$internal
  @override
  $FutureProviderElement<List<AllowanceTypeItem>> $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<AllowanceTypeItem>> create(Ref ref) {
    return allowanceTypes(ref);
  }
}

String _$allowanceTypesHash() => r'702eba1aba4acabb625c8311153575e500849330';

@ProviderFor(allowanceSummary)
final allowanceSummaryProvider = AllowanceSummaryFamily._();

final class AllowanceSummaryProvider extends $FunctionalProvider<AsyncValue<AllowanceSummary>, AllowanceSummary, FutureOr<AllowanceSummary>>
    with $FutureModifier<AllowanceSummary>, $FutureProvider<AllowanceSummary> {
  AllowanceSummaryProvider._({required AllowanceSummaryFamily super.from, required String super.argument})
    : super(retry: null, name: r'allowanceSummaryProvider', isAutoDispose: true, dependencies: null, $allTransitiveDependencies: null);

  @override
  String debugGetCreateSourceHash() => _$allowanceSummaryHash();

  @override
  String toString() {
    return r'allowanceSummaryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<AllowanceSummary> $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<AllowanceSummary> create(Ref ref) {
    final argument = this.argument as String;
    return allowanceSummary(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AllowanceSummaryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$allowanceSummaryHash() => r'33d897c9894457ae5d710c160eec94f15a472f1a';

final class AllowanceSummaryFamily extends $Family with $FunctionalFamilyOverride<FutureOr<AllowanceSummary>, String> {
  AllowanceSummaryFamily._() : super(retry: null, name: r'allowanceSummaryProvider', dependencies: null, $allTransitiveDependencies: null, isAutoDispose: true);

  AllowanceSummaryProvider call(String month) => AllowanceSummaryProvider._(argument: month, from: this);

  @override
  String toString() => r'allowanceSummaryProvider';
}
