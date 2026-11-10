// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payslips_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(payslipsRepository)
final payslipsRepositoryProvider = PayslipsRepositoryProvider._();

final class PayslipsRepositoryProvider extends $FunctionalProvider<PayslipsRepository, PayslipsRepository, PayslipsRepository>
    with $Provider<PayslipsRepository> {
  PayslipsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'payslipsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$payslipsRepositoryHash();

  @$internal
  @override
  $ProviderElement<PayslipsRepository> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  PayslipsRepository create(Ref ref) {
    return payslipsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PayslipsRepository value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<PayslipsRepository>(value));
  }
}

String _$payslipsRepositoryHash() => r'15bfc3e7b7ef1d03b046d0eb71819093d13caa3a';
