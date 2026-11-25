// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'org_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(orgRepository)
final orgRepositoryProvider = OrgRepositoryProvider._();

final class OrgRepositoryProvider
    extends $FunctionalProvider<OrgRepository, OrgRepository, OrgRepository>
    with $Provider<OrgRepository> {
  OrgRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'orgRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$orgRepositoryHash();

  @$internal
  @override
  $ProviderElement<OrgRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  OrgRepository create(Ref ref) {
    return orgRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OrgRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OrgRepository>(value),
    );
  }
}

String _$orgRepositoryHash() => r'894ac708da5f7849366d20a99efd876880754259';

/// Depots of the selected business unit (all of mine when none is selected).

@ProviderFor(depots)
final depotsProvider = DepotsProvider._();

/// Depots of the selected business unit (all of mine when none is selected).

final class DepotsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<DepotItem>>,
          List<DepotItem>,
          FutureOr<List<DepotItem>>
        >
    with $FutureModifier<List<DepotItem>>, $FutureProvider<List<DepotItem>> {
  /// Depots of the selected business unit (all of mine when none is selected).
  DepotsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'depotsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$depotsHash();

  @$internal
  @override
  $FutureProviderElement<List<DepotItem>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<DepotItem>> create(Ref ref) {
    return depots(ref);
  }
}

String _$depotsHash() => r'bcfdff3289a1135c1fbf6ee12149d5d4fac5d130';

/// Every depot of my business units (no BU filter), e.g. for picking a new user's base depot.

@ProviderFor(allDepots)
final allDepotsProvider = AllDepotsProvider._();

/// Every depot of my business units (no BU filter), e.g. for picking a new user's base depot.

final class AllDepotsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<DepotItem>>,
          List<DepotItem>,
          FutureOr<List<DepotItem>>
        >
    with $FutureModifier<List<DepotItem>>, $FutureProvider<List<DepotItem>> {
  /// Every depot of my business units (no BU filter), e.g. for picking a new user's base depot.
  AllDepotsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allDepotsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allDepotsHash();

  @$internal
  @override
  $FutureProviderElement<List<DepotItem>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<DepotItem>> create(Ref ref) {
    return allDepots(ref);
  }
}

String _$allDepotsHash() => r'4c147a80197c843c522bc52088e64b33ffe238c9';

@ProviderFor(regions)
final regionsProvider = RegionsProvider._();

final class RegionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<RegionItem>>,
          List<RegionItem>,
          FutureOr<List<RegionItem>>
        >
    with $FutureModifier<List<RegionItem>>, $FutureProvider<List<RegionItem>> {
  RegionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'regionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$regionsHash();

  @$internal
  @override
  $FutureProviderElement<List<RegionItem>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<RegionItem>> create(Ref ref) {
    return regions(ref);
  }
}

String _$regionsHash() => r'6b30c9b630fbefd7908f9bffc945fbea4da48c96';
