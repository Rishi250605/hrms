import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hrms_app/core/api/auth_interceptor.dart';
import 'package:hrms_app/core/storage/token_storage.dart';

/// Fake server: valid access token is [validToken]; anything else gets 401.
class _FakeServer implements HttpClientAdapter {
  String validToken = 'new-access';
  final seenTokens = <String?>[];

  @override
  Future<ResponseBody> fetch(RequestOptions options, Stream<Uint8List>? requestStream, Future<void>? cancelFuture) async {
    final auth = options.headers['Authorization'] as String?;
    seenTokens.add(auth);
    await Future<void>.delayed(const Duration(milliseconds: 5));
    if (auth == 'Bearer $validToken') {
      return _json(200, {'ok': true, 'path': options.path});
    }
    return _json(401, {
      'error': {'code': 'INVALID_TOKEN', 'message': 'expired'},
    });
  }

  ResponseBody _json(int status, Object body) => ResponseBody.fromString(
    jsonEncode(body),
    status,
    headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType],
    },
  );

  @override
  void close({bool force = false}) {}
}

void main() {
  late _FakeServer server;
  late InMemoryTokenStorage storage;
  late int refreshCalls;
  late int expiredCalls;
  late bool refreshFails;
  late Dio dio;

  setUp(() {
    server = _FakeServer();
    storage = InMemoryTokenStorage(const StoredTokens(accessToken: 'old-access', refreshToken: 'refresh-1'));
    refreshCalls = 0;
    expiredCalls = 0;
    refreshFails = false;

    final options = BaseOptions(baseUrl: 'http://api.test/api/v1');
    final retryDio = Dio(options)..httpClientAdapter = server;
    dio = Dio(options)..httpClientAdapter = server;
    dio.interceptors.add(
      AuthInterceptor(
        retryDio: retryDio,
        storage: storage,
        refreshTokens: (refreshToken) async {
          refreshCalls++;
          await Future<void>.delayed(const Duration(milliseconds: 10));
          if (refreshFails) throw Exception('refresh rejected');
          return const StoredTokens(accessToken: 'new-access', refreshToken: 'refresh-2');
        },
        onSessionExpired: () => expiredCalls++,
      ),
    );
  });

  test('attaches the stored access token', () async {
    server.validToken = 'old-access';
    final res = await dio.get<Map<String, dynamic>>('/me');
    expect(res.statusCode, 200);
    expect(server.seenTokens.single, 'Bearer old-access');
    expect(refreshCalls, 0);
  });

  test('refreshes once on 401 and retries with the new token', () async {
    final res = await dio.get<Map<String, dynamic>>('/me');
    expect(res.statusCode, 200);
    expect(refreshCalls, 1);
    expect(server.seenTokens, ['Bearer old-access', 'Bearer new-access']);
    final stored = await storage.read();
    expect(stored!.accessToken, 'new-access');
    expect(stored.refreshToken, 'refresh-2');
  });

  test('concurrent 401s trigger a single refresh', () async {
    final results = await Future.wait([
      dio.get<Map<String, dynamic>>('/a'),
      dio.get<Map<String, dynamic>>('/b'),
      dio.get<Map<String, dynamic>>('/c'),
    ]);
    expect(results.map((r) => r.statusCode), everyElement(200));
    expect(refreshCalls, 1);
  });

  test('when refresh fails, tokens are cleared and the session-expired callback fires', () async {
    refreshFails = true;
    await expectLater(
      dio.get<Map<String, dynamic>>('/me'),
      throwsA(isA<DioException>().having((e) => e.response?.statusCode, 'status', 401)),
    );
    expect(await storage.read(), isNull);
    expect(expiredCalls, 1);
  });

  test('skipAuth requests carry no token and are never refreshed', () async {
    await expectLater(
      dio.post<Map<String, dynamic>>('/auth/otp/verify', options: AuthInterceptor.skipAuth()),
      throwsA(isA<DioException>()),
    );
    expect(server.seenTokens.single, isNull);
    expect(refreshCalls, 0);
  });

  test('a retried request that fails again is not refreshed a second time', () async {
    server.validToken = 'something-else';
    await expectLater(dio.get<Map<String, dynamic>>('/me'), throwsA(isA<DioException>()));
    expect(refreshCalls, 1);
  });
}
