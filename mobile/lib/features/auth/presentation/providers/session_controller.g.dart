// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Source of truth for "who is signed in". The router redirects on this provider.
///
/// - loading  → splash
/// - error    → splash with retry (server unreachable while restoring a session)
/// - signedOut → login
/// - signedIn  → role shell

@ProviderFor(SessionController)
final sessionControllerProvider = SessionControllerProvider._();

/// Source of truth for "who is signed in". The router redirects on this provider.
///
/// - loading  → splash
/// - error    → splash with retry (server unreachable while restoring a session)
/// - signedOut → login
/// - signedIn  → role shell
final class SessionControllerProvider extends $AsyncNotifierProvider<SessionController, SessionState> {
  /// Source of truth for "who is signed in". The router redirects on this provider.
  ///
  /// - loading  → splash
  /// - error    → splash with retry (server unreachable while restoring a session)
  /// - signedOut → login
  /// - signedIn  → role shell
  SessionControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sessionControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sessionControllerHash();

  @$internal
  @override
  SessionController create() => SessionController();
}

String _$sessionControllerHash() => r'12a4484baf4c32e916a2e0e28ad1479b3a637b29';

/// Source of truth for "who is signed in". The router redirects on this provider.
///
/// - loading  → splash
/// - error    → splash with retry (server unreachable while restoring a session)
/// - signedOut → login
/// - signedIn  → role shell

abstract class _$SessionController extends $AsyncNotifier<SessionState> {
  FutureOr<SessionState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<SessionState>, SessionState>;
    final element = ref.element as $ClassProviderElement<AnyNotifier<AsyncValue<SessionState>, SessionState>, AsyncValue<SessionState>, Object?, Object?>;
    return element.handleCreate(ref, build);
  }
}
