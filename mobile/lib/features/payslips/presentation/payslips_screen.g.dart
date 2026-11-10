// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payslips_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(payslips)
final payslipsProvider = PayslipsFamily._();

final class PayslipsProvider extends $FunctionalProvider<AsyncValue<PayslipPage>, PayslipPage, FutureOr<PayslipPage>>
    with $FutureModifier<PayslipPage>, $FutureProvider<PayslipPage> {
  PayslipsProvider._({required PayslipsFamily super.from, required (String, String) super.argument})
    : super(retry: null, name: r'payslipsProvider', isAutoDispose: true, dependencies: null, $allTransitiveDependencies: null);

  @override
  String debugGetCreateSourceHash() => _$payslipsHash();

  @override
  String toString() {
    return r'payslipsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<PayslipPage> $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<PayslipPage> create(Ref ref) {
    final argument = this.argument as (String, String);
    return payslips(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is PayslipsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$payslipsHash() => r'ccff9277fd481d5bea5a2409a9f01f1bc08ccde8';

final class PayslipsFamily extends $Family with $FunctionalFamilyOverride<FutureOr<PayslipPage>, (String, String)> {
  PayslipsFamily._() : super(retry: null, name: r'payslipsProvider', dependencies: null, $allTransitiveDependencies: null, isAutoDispose: true);

  PayslipsProvider call(String scope, String period) => PayslipsProvider._(argument: (scope, period), from: this);

  @override
  String toString() => r'payslipsProvider';
}
