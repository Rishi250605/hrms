import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/api_failure.dart';
import '../../data/auth_repository.dart';
import 'session_controller.dart';

part 'login_controller.freezed.dart';
part 'login_controller.g.dart';

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState({@Default(false) bool submitting, ApiFailure? failure}) = _LoginState;
}

/// Employee code + password login (PHASE-2-FEATURES §3). Lockout and wrong-password errors come from the API.
@riverpod
class LoginController extends _$LoginController {
  @override
  LoginState build() => const LoginState();

  Future<void> login(String empCode, String password) async {
    state = state.copyWith(submitting: true, failure: null);
    try {
      await ref.read(authRepositoryProvider).login(empCode, password);
      await ref.read(sessionControllerProvider.notifier).completeSignIn();
      // On success the router navigates away when the session becomes signedIn.
      final session = ref.read(sessionControllerProvider);
      if (session.hasError && ref.mounted) {
        state = state.copyWith(submitting: false, failure: ApiFailure.fromObject(session.error!));
      }
    } on ApiFailure catch (f) {
      if (ref.mounted) state = state.copyWith(submitting: false, failure: f);
    }
  }
}
