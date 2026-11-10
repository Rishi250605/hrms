import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/api/api_providers.dart';
import '../../../../core/errors/api_failure.dart';
import '../../data/auth_repository.dart';
import '../../domain/session_state.dart';

part 'session_controller.g.dart';

/// Source of truth for "who is signed in". The router redirects on this provider.
///
/// - loading  → splash
/// - error    → splash with retry (server unreachable while restoring a session)
/// - signedOut → login
/// - signedIn  → role shell
@Riverpod(keepAlive: true)
class SessionController extends _$SessionController {
  @override
  Future<SessionState> build() async {
    final sub = ref.watch(sessionExpiredEventsProvider).stream.listen((_) {
      state = const AsyncData(SessionState.signedOut(expired: true));
    });
    ref.onDispose(sub.cancel);

    final repo = ref.watch(authRepositoryProvider);
    if (!await repo.hasStoredSession()) return const SessionState.signedOut();
    return _loadUser(repo);
  }

  Future<SessionState> _loadUser(AuthRepository repo) async {
    try {
      return SessionState.signedIn(await repo.fetchCurrentUser());
    } on ApiFailure catch (f) {
      if (f.statusCode == 401 || f.statusCode == 403) {
        // Token refresh already failed inside the interceptor (or the user was deactivated).
        await repo.clearLocalSession();
        return const SessionState.signedOut(expired: true);
      }
      rethrow; // network or server error: splash shows retry
    }
  }

  /// Called after a successful OTP verification (tokens are already stored).
  Future<void> completeSignIn() async {
    final repo = ref.read(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _loadUser(repo));
  }

  /// Re-fetches `/me` (e.g. pull-to-refresh on the profile after a scope change).
  /// Keeps the current state while loading so the user is not bounced to the splash screen.
  Future<void> reloadUser() async {
    final repo = ref.read(authRepositoryProvider);
    final next = await AsyncValue.guard(() => _loadUser(repo));
    if (ref.mounted) state = next;
  }

  Future<void> logout() async {
    await ref.read(authRepositoryProvider).logout();
    state = const AsyncData(SessionState.signedOut());
  }
}
