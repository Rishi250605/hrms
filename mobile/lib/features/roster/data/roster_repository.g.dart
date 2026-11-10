// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roster_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(rosterRepository)
final rosterRepositoryProvider = RosterRepositoryProvider._();

final class RosterRepositoryProvider extends $FunctionalProvider<RosterRepository, RosterRepository, RosterRepository> with $Provider<RosterRepository> {
  RosterRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rosterRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rosterRepositoryHash();

  @$internal
  @override
  $ProviderElement<RosterRepository> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  RosterRepository create(Ref ref) {
    return rosterRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RosterRepository value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<RosterRepository>(value));
  }
}

String _$rosterRepositoryHash() => r'532e1e19fd15b4d400f1b9ff27fa0d7ab3a24fd3';
