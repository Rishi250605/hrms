// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The signed-in manager, or null.

@ProviderFor(currentUser)
final currentUserProvider = CurrentUserProvider._();

/// The signed-in manager, or null.

final class CurrentUserProvider extends $FunctionalProvider<CurrentUser?, CurrentUser?, CurrentUser?> with $Provider<CurrentUser?> {
  /// The signed-in manager, or null.
  CurrentUserProvider._()
    : super(from: null, argument: null, retry: null, name: r'currentUserProvider', isAutoDispose: true, dependencies: null, $allTransitiveDependencies: null);

  @override
  String debugGetCreateSourceHash() => _$currentUserHash();

  @$internal
  @override
  $ProviderElement<CurrentUser?> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  CurrentUser? create(Ref ref) {
    return currentUser(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CurrentUser? value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<CurrentUser?>(value));
  }
}

String _$currentUserHash() => r'81a24fcbb7197f5ee14227634d7feb0fb31ba85b';

/// Business units the user can switch between: their memberships, or every active BU for the director.

@ProviderFor(businessUnitChoices)
final businessUnitChoicesProvider = BusinessUnitChoicesProvider._();

/// Business units the user can switch between: their memberships, or every active BU for the director.

final class BusinessUnitChoicesProvider extends $FunctionalProvider<AsyncValue<List<BuRef>>, List<BuRef>, FutureOr<List<BuRef>>>
    with $FutureModifier<List<BuRef>>, $FutureProvider<List<BuRef>> {
  /// Business units the user can switch between: their memberships, or every active BU for the director.
  BusinessUnitChoicesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'businessUnitChoicesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$businessUnitChoicesHash();

  @$internal
  @override
  $FutureProviderElement<List<BuRef>> $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<BuRef>> create(Ref ref) {
    return businessUnitChoices(ref);
  }
}

String _$businessUnitChoicesHash() => r'ece0f96381452bdb65d2273d1ea9c8acce7454bd';

/// The business unit the screens are filtered to (PHASE-2-FEATURES §2.4). `null` = all of mine.
/// Remembered per user on the device.

@ProviderFor(SelectedBusinessUnit)
final selectedBusinessUnitProvider = SelectedBusinessUnitProvider._();

/// The business unit the screens are filtered to (PHASE-2-FEATURES §2.4). `null` = all of mine.
/// Remembered per user on the device.
final class SelectedBusinessUnitProvider extends $NotifierProvider<SelectedBusinessUnit, String?> {
  /// The business unit the screens are filtered to (PHASE-2-FEATURES §2.4). `null` = all of mine.
  /// Remembered per user on the device.
  SelectedBusinessUnitProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedBusinessUnitProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedBusinessUnitHash();

  @$internal
  @override
  SelectedBusinessUnit create() => SelectedBusinessUnit();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<String?>(value));
  }
}

String _$selectedBusinessUnitHash() => r'88e61e0aff5c24852ca4db92c928b9390bfde34e';

/// The business unit the screens are filtered to (PHASE-2-FEATURES §2.4). `null` = all of mine.
/// Remembered per user on the device.

abstract class _$SelectedBusinessUnit extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element = ref.element as $ClassProviderElement<AnyNotifier<String?, String?>, String?, Object?, Object?>;
    return element.handleCreate(ref, build);
  }
}

/// Depot the manager is working on (roster, fleet). Defaults to the first depot of the selected BU.

@ProviderFor(SelectedDepot)
final selectedDepotProvider = SelectedDepotProvider._();

/// Depot the manager is working on (roster, fleet). Defaults to the first depot of the selected BU.
final class SelectedDepotProvider extends $NotifierProvider<SelectedDepot, String?> {
  /// Depot the manager is working on (roster, fleet). Defaults to the first depot of the selected BU.
  SelectedDepotProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedDepotProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedDepotHash();

  @$internal
  @override
  SelectedDepot create() => SelectedDepot();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<String?>(value));
  }
}

String _$selectedDepotHash() => r'3d30ae28be63f0a1455b67b64967ae1f49100373';

/// Depot the manager is working on (roster, fleet). Defaults to the first depot of the selected BU.

abstract class _$SelectedDepot extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element = ref.element as $ClassProviderElement<AnyNotifier<String?, String?>, String?, Object?, Object?>;
    return element.handleCreate(ref, build);
  }
}
