// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Employee code + password login (PHASE-2-FEATURES §3). Lockout and wrong-password errors come from the API.

@ProviderFor(LoginController)
final loginControllerProvider = LoginControllerProvider._();

/// Employee code + password login (PHASE-2-FEATURES §3). Lockout and wrong-password errors come from the API.
final class LoginControllerProvider extends $NotifierProvider<LoginController, LoginState> {
  /// Employee code + password login (PHASE-2-FEATURES §3). Lockout and wrong-password errors come from the API.
  LoginControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'loginControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$loginControllerHash();

  @$internal
  @override
  LoginController create() => LoginController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LoginState value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<LoginState>(value));
  }
}

String _$loginControllerHash() => r'b14a9d2a7ffba685c381980656c2c50ee177f98f';

/// Employee code + password login (PHASE-2-FEATURES §3). Lockout and wrong-password errors come from the API.

abstract class _$LoginController extends $Notifier<LoginState> {
  LoginState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<LoginState, LoginState>;
    final element = ref.element as $ClassProviderElement<AnyNotifier<LoginState, LoginState>, LoginState, Object?, Object?>;
    return element.handleCreate(ref, build);
  }
}
