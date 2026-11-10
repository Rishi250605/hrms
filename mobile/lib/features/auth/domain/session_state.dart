import 'package:freezed_annotation/freezed_annotation.dart';

import 'current_user.dart';

part 'session_state.freezed.dart';

@freezed
sealed class SessionState with _$SessionState {
  /// No valid session. [expired] is true when the session ended because the refresh token was rejected.
  const factory SessionState.signedOut({@Default(false) bool expired}) = SignedOut;

  const factory SessionState.signedIn(CurrentUser user) = SignedIn;
}
