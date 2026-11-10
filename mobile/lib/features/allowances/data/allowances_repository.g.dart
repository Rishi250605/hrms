// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allowances_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(allowancesRepository)
final allowancesRepositoryProvider = AllowancesRepositoryProvider._();

final class AllowancesRepositoryProvider extends $FunctionalProvider<AllowancesRepository, AllowancesRepository, AllowancesRepository>
    with $Provider<AllowancesRepository> {
  AllowancesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allowancesRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allowancesRepositoryHash();

  @$internal
  @override
  $ProviderElement<AllowancesRepository> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  AllowancesRepository create(Ref ref) {
    return allowancesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AllowancesRepository value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<AllowancesRepository>(value));
  }
}

String _$allowancesRepositoryHash() => r'a96a44f672ea55ad6e54d32726d2d21ed46fea67';
