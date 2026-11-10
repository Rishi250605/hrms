import 'dart:async';

import 'package:dio/dio.dart';

import '../storage/token_storage.dart';

/// Performs the refresh call and returns the new pair. Throws if the refresh token is rejected.
typedef RefreshTokens = Future<StoredTokens> Function(String refreshToken);

/// Attaches the access token to every request and transparently refreshes it once on 401.
///
/// Concurrent 401s are serialised (single-flight refresh): only the first triggers a refresh,
/// the others retry with the new token. If the refresh fails the stored tokens are cleared and
/// [onSessionExpired] is called so the app can return to the login screen.
class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor({required this.retryDio, required this.storage, required this.refreshTokens, required this.onSessionExpired});

  /// Dio used to replay a request after refresh. It must NOT have this interceptor attached:
  /// replaying through a QueuedInterceptor from inside its own onError would deadlock on a second 401.
  final Dio retryDio;
  final TokenStorage storage;
  final RefreshTokens refreshTokens;
  final void Function() onSessionExpired;

  static const _retriedKey = 'auth.retried';
  static const _skipAuthKey = 'auth.skip';

  /// Mark a request so it is sent without a token (e.g. the login endpoints).
  static Options skipAuth([Options? options]) => (options ?? Options()).copyWith(extra: {...?options?.extra, _skipAuthKey: true});

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.extra[_skipAuthKey] != true) {
      final tokens = await storage.read();
      if (tokens != null) options.headers['Authorization'] = 'Bearer ${tokens.accessToken}';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final request = err.requestOptions;
    final isUnauthorized = err.response?.statusCode == 401;
    if (!isUnauthorized || request.extra[_skipAuthKey] == true || request.extra[_retriedKey] == true) {
      return handler.next(err);
    }

    final stored = await storage.read();
    if (stored == null) return handler.next(err);

    final sentToken = (request.headers['Authorization'] as String?)?.replaceFirst('Bearer ', '');
    var current = stored;
    if (sentToken == stored.accessToken) {
      // Nobody refreshed while this request was in flight — refresh now.
      try {
        current = await refreshTokens(stored.refreshToken);
        await storage.write(current);
      } catch (_) {
        await storage.clear();
        onSessionExpired();
        return handler.next(err);
      }
    }

    try {
      final retryOptions = request.copyWith(
        headers: {...request.headers, 'Authorization': 'Bearer ${current.accessToken}'},
        extra: {...request.extra, _retriedKey: true},
      );
      final response = await retryDio.fetch<dynamic>(retryOptions);
      handler.resolve(response);
    } on DioException catch (retryError) {
      handler.next(retryError);
    }
  }
}
