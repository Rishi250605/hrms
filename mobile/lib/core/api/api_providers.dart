import 'dart:async';

import 'package:dio/dio.dart';
import 'package:hrms_api/hrms_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/app_config.dart';
import '../storage/token_storage.dart';
import 'auth_interceptor.dart';

part 'api_providers.g.dart';

@Riverpod(keepAlive: true)
AppConfig appConfig(Ref ref) => AppConfig.fromEnvironment();

@Riverpod(keepAlive: true)
TokenStorage tokenStorage(Ref ref) => SecureTokenStorage();

/// Emits when the session can no longer be refreshed (refresh token rejected).
/// The session controller listens and sends the user back to login.
@Riverpod(keepAlive: true)
StreamController<void> sessionExpiredEvents(Ref ref) {
  final controller = StreamController<void>.broadcast();
  ref.onDispose(controller.close);
  return controller;
}

BaseOptions _baseOptions(AppConfig config) => BaseOptions(
  baseUrl: config.apiBaseUrl,
  connectTimeout: const Duration(seconds: 10),
  receiveTimeout: const Duration(seconds: 30),
  contentType: Headers.jsonContentType,
);

/// Dio without the auth interceptor: used for token refresh and for replaying requests after refresh.
@Riverpod(keepAlive: true)
Dio bareDio(Ref ref) => Dio(_baseOptions(ref.watch(appConfigProvider)));

/// The Dio every repository uses (through [hrmsApiProvider]). Adds the bearer token and refreshes it on 401.
@Riverpod(keepAlive: true)
Dio apiDio(Ref ref) {
  final config = ref.watch(appConfigProvider);
  final storage = ref.watch(tokenStorageProvider);
  final bare = ref.watch(bareDioProvider);
  final expired = ref.watch(sessionExpiredEventsProvider);

  final dio = Dio(_baseOptions(config));
  dio.interceptors.add(
    AuthInterceptor(
      retryDio: bare,
      storage: storage,
      refreshTokens: (refreshToken) async {
        final api = HrmsApi(dio: bare, interceptors: const []).getAuthApi();
        final res = await api.refreshToken(refreshBody: RefreshBody(refreshToken: refreshToken));
        final pair = res.data!;
        return StoredTokens(accessToken: pair.accessToken, refreshToken: pair.refreshToken);
      },
      onSessionExpired: () {
        if (!expired.isClosed) expired.add(null);
      },
    ),
  );
  return dio;
}

/// Generated OpenAPI client. Screens never use Dio directly: providers → repositories → this client.
@Riverpod(keepAlive: true)
HrmsApi hrmsApi(Ref ref) => HrmsApi(dio: ref.watch(apiDioProvider), interceptors: const []);
